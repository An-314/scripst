#!/usr/bin/env python3
"""Build against this checkout, without installing it over a user's package.

Requires Python 3.11+ and Typst 0.15.0+. Previews also require ImageMagick.
The temporary package overlay preserves other local packages and Typst's normal
cache/download behavior. TYPST_PACKAGE_PATH, font paths and cache settings are
honored; only @preview/<this package>:<this version> is replaced for the build.
"""

import argparse
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import tomllib


ROOT = Path(__file__).resolve().parents[1]


def mount_checkout(source, destination, parts):
    """Overlay just the namespace/name/version path; link all its siblings."""
    destination.mkdir()
    name, *remaining = parts
    if source is not None and source.is_dir():
        for entry in source.iterdir():
            if entry.name != name:
                (destination / entry.name).symlink_to(
                    entry.absolute(), target_is_directory=entry.is_dir()
                )
    if remaining:
        mount_checkout(
            source / name if source is not None else None,
            destination / name,
            remaining,
        )
    else:
        (destination / name).symlink_to(ROOT, target_is_directory=True)


def run(command, capture=False):
    return subprocess.run(
        command, check=True, text=True, stdout=subprocess.PIPE if capture else None
    ).stdout


def positive_integer(value):
    number = int(value)
    if number < 1:
        raise argparse.ArgumentTypeError("must be a positive integer")
    return number


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--typst", default=os.environ.get("TYPST", "typst"))
    parser.add_argument("--magick", default=os.environ.get("MAGICK", "magick"))
    commands = parser.add_subparsers(dest="command", required=True)
    compile_parser = commands.add_parser("compile", help="compile a PDF")
    preview_parser = commands.add_parser("preview", help="render one full-page PNG")
    for command in (compile_parser, preview_parser):
        command.add_argument("input", type=Path)
        command.add_argument("output", type=Path)
    page = preview_parser.add_mutually_exclusive_group(required=True)
    page.add_argument("--page", type=positive_integer, help="physical page, starting at 1")
    page.add_argument("--marker", help="unique document label, without angle brackets")
    preview_parser.add_argument("--ppi", type=positive_integer, default=250)
    preview_parser.add_argument("--size", default="1080x>", help="ImageMagick resize geometry")
    preview_parser.add_argument("--quality", type=positive_integer, default=100)
    args = parser.parse_args()

    with (ROOT / "typst.toml").open("rb") as manifest:
        package = tomllib.load(manifest)["package"]
    # Ask Typst rather than guessing OS-specific user data directories. Do not
    # print info's full payload: it can contain unrelated environment settings.
    info = json.loads(run([args.typst, "info", "--format", "json"], capture=True))
    package_path = info["packages"].get("package-path")
    source = Path(package_path).absolute() if package_path else None
    output = args.output.absolute()
    output.parent.mkdir(parents=True, exist_ok=True)

    with tempfile.TemporaryDirectory(prefix="scripst-packages-") as package_tmp:
        overlay = Path(package_tmp) / "packages"
        mount_checkout(source, overlay, ("preview", package["name"], package["version"]))
        options = ["--root", str(ROOT), "--package-path", str(overlay)]
        # Stage beside the requested output, so replacement is atomic even when
        # the build and system temporary directories are on different volumes.
        with tempfile.TemporaryDirectory(prefix=".scripst-build-", dir=output.parent) as build_tmp:
            stage = Path(build_tmp)
            if args.command == "compile":
                result = stage / "result.pdf"
                run([args.typst, "compile", *options, str(args.input), str(result)])
            else:
                number = args.page
                if args.marker is not None:
                    marker = json.dumps(args.marker)
                    expression = (
                        f"let matches = query(label({marker})); "
                        'assert.eq(matches.len(), 1, message: "preview label must occur exactly once"); '
                        "matches.first().location().page()"
                    )
                    number = json.loads(run(
                        [args.typst, "eval", *options, "--in", str(args.input), expression],
                        capture=True,
                    ))
                    if type(number) is not int or number < 1:
                        raise ValueError(f"invalid physical page for label {args.marker!r}")
                rendered = stage / "page.png"
                result = stage / "result.png"
                run([
                    args.typst, "compile", *options, "--pages", str(number),
                    "--ppi", str(args.ppi), str(args.input), str(rendered),
                ])
                run([
                    args.magick, str(rendered), "-quality", str(args.quality),
                    "-resize", args.size, "-background", "white", "-alpha", "remove",
                    "-alpha", "off", str(result),
                ])
            os.replace(result, output)


if __name__ == "__main__":
    try:
        main()
    except subprocess.CalledProcessError as error:
        sys.exit(error.returncode)
    except (OSError, ValueError, KeyError) as error:
        sys.exit(f"build: {error}")
