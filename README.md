## Project Documentation

This project builds documentation for multiple languages using `mkdocs`. The configuration files for each language are stored in the `config` directory.

### Directory Structure

```plaintext
project/
├── config/
│   ├── en/
│   │   └── mkdocs.yml
│   ├── es/
│   │   └── mkdocs.yml
│   ├── ...
├── docs/
│   ├── zh/
│   │   └── index.md
│   ├── ...
├── overrides/
│   ├── assets/
│   ├── previews/
│   ├── ...
├── generated/
│   ├── es/
│   │   └── index.html
│   ├── .../
│   ├── index.html
├── makefile
├── README.md

```

## Building Documentation
To build the documentation for all languages, run:
```bash
make all
```
This will generate the documentation in the `generated` directory.

To build documentation for a specific language, run:
```bash
make es
```
This will generate the documentation for the specified language in the `generated` directory.

To clean up the generated files, run:
```bash
make clean
```

## Adding New Languages
1. Create a new directory under config with the language code (e.g., fr for French).
2. Add the mkdocs.yml configuration file in the new directory.