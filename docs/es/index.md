<h1 align="center"> Scripst </h1>

**Scripst** es un paquete de plantillas basado en **Typst**, que ofrece un conjunto de plantillas simples y eficientes, adecuadas para documentos cotidianos, tareas, notas, trabajos académicos y otros escenarios.

<div align="center">
  <img src="https://img.shields.io/badge/version-1.1.0-limegreen.svg" alt="Version">
  <img src="https://img.shields.io/badge/license-MIT-greenyellow.svg" alt="License">
  <a href="https://an-314.github.io/scripst/">
    <img src="https://img.shields.io/badge/docs-online-lawngreen.svg" alt="Docs Online">
  </a>
</div>

## 🚀 Características

* Alta Extensibilidad: Diseño modular, fácil de extender con nuevas plantillas.
* Diseño Multilingüe: Localización para diferentes idiomas.
* Soporte para bloques de conteo personalizados: Ideal para generar teoremas, problemas y otros contadores o estilos.

## 📦 Instalación

### Instalar Typst

Asegúrate de tener Typst instalado. Puedes instalarlo utilizando los siguientes comandos:

```bash
sudo apt install typst # Debian/Ubuntu
sudo pacman -S typst # Arch Linux
winget install --id Typst.Typst # Windows
brew install typst # macOS
```

O consulta la [documentación oficial de Typst](https://github.com/typst/typst) para más información.

### Descargar la Plantilla Scripst

#### Método 1: Descargar Manualmente

1. Visita el [repositorio de Scripst en GitHub](https://github.com/An-314/scripst)
2. Haz clic en el botón `<> Código`
3. Elige `Descargar ZIP`
4. Después de extraer los archivos, coloca las plantillas en tu directorio de proyecto.

**Estructura de directorio sugerida**

```plaintext
proyecto/
├── src/
│   ├── main.typ
│   ├── components.typ
├── pic/
│   ├── image.jpg
├── main.typ
├── chap1.typ
├── chap2.typ
```

Si la plantilla se encuentra en el directorio `src/`, impórtala de esta manera:

```typst
#import "src/main.typ": *
```

#### Método 2: Usar la Gestión Local de Paquetes de Typst

Puedes descargar manualmente Scripst y guardarlo en:

```
~/.local/share/typst/packages/local/scripst/1.1.0                 # Linux
%APPDATA%\typst\packages\local\scripst\1.1.0                      # Windows
~/Library/Application Support/typst/packages/local/scripst/1.1.0  # macOS
```

O usar los siguientes comandos:

```bash
cd {directorio-datos}/typst/packages/local/scripst
git clone https://github.com/An-314/scripst 1.1.0
```

Donde `directorio-datos` hace referencia al directorio de datos de Typst, como `~/.local/share/typst` para Linux, `%APPDATA%\typst` para Windows y `~/Library/Application Support/typst` para macOS.

Luego impórtalo directamente en tu archivo Typst:

```typst
#import "@local/scripst:1.1.0": *
```

Ahora puedes usar la plantilla Scripst.

Usa `typst init` para crear rápidamente un proyecto:

```bash
typst init @local/scripst:1.1.0 nombre_proyecto
```

* * *

## 📄 Usar Scripst

### Importar la Plantilla Scripst

Importa la plantilla al inicio de tu archivo Typst:

```typst
#import "@local/scripst:1.1.0": *
```

### Crear un Documento `artículo`

```typst
#show: scripst.with(
  title: [Cómo Usar Scripst],
  info: [Esta es una plantilla de artículo],
  author: ("Autor1", "Autor2", "Autor3"),
  time: datetime.today().display(),
  abstract: [Contenido del resumen],
  keywords: ("PalabraClave1", "PalabraClave2", "PalabraClave3"),
  contents: true,
  content_depth: 2,
  matheq_depth: 2,
  lang: "es",
)
```

* * *

## 🔧 Parámetros de la Plantilla

| Parámetro | Tipo | Valor Predeterminado | Descripción                                            |
| --- | --- | --- |--------------------------------------------------------|
| `template` | `str` | `"article"` | Elige la plantilla (`"article"`, `"book"`, `"report"`) |
| `title` | `content`, `str`, `none` | `""` | Título del documento                                   |
| `info` | `content`, `str`, `none` | `""` | Subtítulo o información adicional del documento        |
| `author` | `array` | `()` | Lista de autores                                       |
| `time` | `content`, `str`, `none` | `""` | Fecha del documento                                    |
| `abstract` | `content`, `str`, `none` | `none` | Resumen del documento                                  |
| `keywords` | `array` | `()` | Palabras clave                                         |
| `preface` | `content`, `str`, `none` | `none` | Prefacio                                               |
| `font_size` | `length` | `11pt` | Tamaño de fuente                                       |
| `contents` | `bool` | `false` | Si se genera una tabla de contenidos                   |
| `content_depth` | `int` | `2` | Profundidad de la tabla de contenidos                  |
| `matheq_depth` | `int` | `2` | Profundidad de numeración de ecuaciones matemáticas    |
| `lang` | `str` | `"zh"` | Idioma (`"zh"`, `"en"`, `"es"`, etc.)                  |

* * *

## ✨ Ejemplos de Plantillas y Explicaciones

### Artículo

  
Demo de Artículo

### Libro

  
Demo de Libro _(Solo en Chino Simplificado)_

### Informe

  
Demo de Informe _(Solo en Chino Simplificado)_

## 📜 Contribuir

¡No dudes en enviar problemas o solicitudes de pull! Si tienes sugerencias para mejorar, únete a la discusión.

* **Repositorio en GitHub**: [Scripst](https://github.com/An-314/scripst)
* **Retroalimentación de Problemas**: Envía un problema para discutir

## 📌 Fuentes

Este proyecto usa las siguientes fuentes por defecto:

* Fuentes principales: [CMU Serif](https://en.wikipedia.org/wiki/Computer_Modern), [Consolas](https://en.wikipedia.org/wiki/Consolas)
* Fuentes alternativas: [Linux Libertine](https://en.wikipedia.org/wiki/Linux_Libertine)
* Fuentes chinas como SimSun, SimHei, KaiTi, etc.

Si usas estas fuentes por defecto, asegúrate de que estén correctamente instaladas. Si no, reemplázalas si es necesario en `./src/configs.typ`.

## 📦 Dependencias

Para ciertos contenidos, Scripst usa los siguientes paquetes de Typst:

* [tablem](https://typst.app/universe/package/tablem)
* [physica](https://typst.app/universe/package/physica)

## 🎯 TODO

* [ ]  Añadir plantilla `beamer`