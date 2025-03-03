<h1 align="center">
Scripst
</h1>

**Scripst**는 **Typst**를 기반으로 한 템플릿 패키지입니다. 간결하고 효율적인 문서 템플릿을 제공하여 일상적인 문서, 과제, 노트, 논문 등 다양한 시나리오에 적합합니다.

<div align="center">
  <img src="https://img.shields.io/badge/version-1.1.0-limegreen.svg" alt="버전">
  <img src="https://img.shields.io/badge/license-MIT-greenyellow.svg" alt="라이선스">
  <a href="https://an-314.github.io/scripst/ko">
    <img src="https://img.shields.io/badge/docs-온라인-lawngreen.svg" alt="온라인 문서">
  </a>
</div>

## 🚀 기능

- 고확장성: 모듈화된 설계로 템플릿 확장이 쉬움
- 다국어 지원: 다양한 언어에 맞춘 로컬라이즈 설계
- 사용자 정의 카운터 블록 지원: 정리, 문제 등 다양한 카운터 및 스타일 생성이 쉬움

![Demo0](./previews/article-1.png)
![Demo1](./previews/article-12.png)
![Demo2](./previews/article-9.png)

## 📦 설치

### Typst 설치

Typst가 설치되어 있는지 확인하세요. 설치를 위해 다음 명령을 사용할 수 있습니다:

```bash
sudo apt install typst # Debian/Ubuntu
sudo pacman -S typst # Arch Linux
winget install --id Typst.Typst # Windows
brew install typst # macOS
```

또는 [Typst 공식 문서](https://github.com/typst/typst)를 참조하여 더 많은 정보를 확인하세요.

### Scripst 템플릿 다운로드

#### 방법 1: 수동 다운로드

1. [Scripst GitHub 저장소](https://github.com/An-314/scripst)에 방문
2. `<> Code` 버튼을 클릭
3. `Download ZIP`을 선택
4. 압축을 풀고, 템플릿 파일을 프로젝트 디렉토리에 배치

**디렉토리 구조 제안**
```plaintext
project/
├── src/
│   ├── main.typ
│   ├── components.typ
├── pic/
│   ├── image.jpg
├── main.typ
├── chap1.typ
├── chap2.typ
```

템플릿이 `src/` 디렉토리에 있을 경우, 다음 방법으로 인포트합니다:

```typst
#import "src/main.typ": *
```

#### 방법 2: Typst 로컬 패키지 관리 사용

Scripst를 수동으로 다운로드하고 다음 위치에 배치합니다:

```
~/.local/share/typst/packages/local/scripst/1.1.0                 # Linux
%APPDATA%\typst\packages\local\scripst\1.1.0                      # Windows
~/Library/Application Support/typst/packages/local/scripst/1.1.0  # macOS
```

또는 다음 명령을 실행합니다:

```bash 
cd {data-dir}/typst/packages/local/scripst
git clone https://github.com/An-314/scripst 1.1.0
```

여기서 `data-dir`은 Typst의 데이터 디렉토리를 나타냅니다. 예를 들어, Linux에서는 `~/.local/share/typst`, Windows에서는 `%APPDATA%\typst`, macOS에서는 `~/Library/Application Support/typst`입니다.

그 후, Typst 파일 내에서 직접 인포트합니다:

```typst
#import "@local/scripst:1.1.0": *
```

이제 Scripst 템플릿을 사용할 수 있습니다.

`typst init`을 사용하여 프로젝트를 신속하게 생성합니다:

```bash
typst init @local/scripst:1.1.0 project_name
```

---

## 📄 Scripst 사용

### Scripst 템플릿 인포트

Typst 파일의开头에서 템플릿을 인포트합니다:

```typst
#import "@local/scripst:1.1.0": *
```

### `article` 문서 작성

```typst
#show: scripst.with(
  title: [Scripst의 사용 방법],
  info: [이 템플릿은 기사용입니다],
  author: ("저자1", "저자2", "저자3"),
  time: datetime.today().display(),
  abstract: [요약 내용],
  keywords: ("키워드1", "키워드2", "키워드3"),
  contents: true,
  content_depth: 2,
  matheq_depth: 2,
  lang: "zh",
)
```

---

## 🔧 템플릿 파라미터

| 파라미터 | 유형 | 기본값 | 설명                                         |
| --- | --- | --- |--------------------------------------------|
| `template` | `str` | `"article"` | 템플릿 선택 (`"article"`, `"book"`, `"report"`) |
| `title` | `content`, `str`, `none` | `""` | 문서 제목                                      |
| `info` | `content`, `str`, `none` | `""` | 문서 부제목 또는 보충 정보                            |
| `author` | `array` | `()` | 저자 목록                                      |
| `time` | `content`, `str`, `none` | `""` | 문서 시간                                      |
| `abstract` | `content`, `str`, `none` | `none` | 문서 요약                                      |
| `keywords` | `array` | `()` | 키워드                                        |
| `preface` | `content`, `str`, `none` | `none` | 서문                                         |
| `font_size` | `length` | `11pt` | 폰트 크기                                      |
| `contents` | `bool` | `false` | 목차 생성 여부                                   |
| `content_depth` | `int` | `2` | 목차 깊이                                      |
| `matheq_depth` | `int` | `2` | 수식 번호 깊이                                   |
| `lang` | `str` | `"zh"` | 언어 (`"zh"`, `"en"`, `"ko"` 등)              |

---

## ✨ 템플릿 효과 예제 및 설명

### `article` 문서

![문서 1페이지](./previews/article-1.png) ![문서 2페이지](./previews/article-2.png)  
[기사 예제 (중국어 버전)](https://github.com/An-314/scripst/tree/main/docs/builds/article.pdf)\
[기사 예제 (영어 버전)](https://github.com/An-314/scripst/tree/main/docs/locale/builds/article-en.pdf)

### `book` 문서

![책 1페이지](./previews/book-1.png) ![책 2페이지](./previews/book-2.png)  
[책 예제](https://github.com/An-314/scripst/tree/main/docs/builds/book.pdf) (중국어 버전)

### `report` 문서

![보고서 1페이지](./previews/report-1.png) ![보고서 2페이지](./previews/report-2.png)  
[보고서 예제](https://github.com/An-314/scripst/tree/main/docs/builds/report.pdf) (중국어 버전)

## 📜 기여

Issue 또는 Pull Request를 통해 참여를 환영합니다! 개선 제안이 있다면,ぜひ 토론에 참여해주세요.

- **GitHub 저장소**: [Scripst](https://github.com/An-314/scripst)
- **문제 보고**: Issue를 생성하여 토론을 시작

## 📌 폰트

이 프로젝트에서는 다음 폰트를 기본으로 사용합니다:

- 주 폰트: [CMU Serif](https://en.wikipedia.org/wiki/Computer_Modern), [Consolas](https://en.wikipedia.org/wiki/Consolas)
- 대체 폰트: [Linux Libertine](https://en.wikipedia.org/wiki/Linux_Libertine)
- 그리고 SimSun, SimHei, KaiTi 등 중문 폰트

기본 폰트를 사용하기 전에 폰트가 설치되어 있는지 확인하고, 필요에 따라 `./src/configs.typ`에서 대체하세요.

## 📦 종속성

일부 내용에서 Scripst는 다음 Typst 패키지를 참조합니다:

- [tablem](https://typst.app/universe/package/tablem)
- [physica](https://typst.app/universe/package/physica)

## 🎯 TODO

- [ ] `beamer` 템플릿 추가