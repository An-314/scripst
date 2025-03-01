<h1 align="center"> Scripst </h1>

**Scripst** est un package de modèles basé sur **Typst**, offrant un ensemble de modèles simples et efficaces adaptés aux documents quotidiens, devoirs, notes, articles et autres scénarios.

<div align="center">

![Version](https://img.shields.io/badge/version-1.1.0-limegreen.svg) ![Licence](https://img.shields.io/badge/license-MIT-greenyellow.svg) [![Docs en ligne](https://img.shields.io/badge/docs-online-lawngreen.svg)](https://an-314.github.io/scripst/)

</div>

## 📑 Contenu

* 📑 Contenu
* 🚀 Fonctionnalités
* 📦 Installation
    * Installer Typst
    * Télécharger le modèle Scripst
        * Méthode 1 : Télécharger manuellement
        * Méthode 2 : Utiliser la gestion locale des packages Typst
* 📄 Utiliser Scripst
    * Importer le modèle Scripst
    * Créer un document `article`
* 🔧 Paramètres du modèle
* ✨ Exemples de modèles et explications
    * Article
    * Livre
    * Rapport
* 📜 Contribuer
* 📌 Polices
* 📦 Dépendances
* 🎯 TODO

* * *

## 🚀 Fonctionnalités

* Grande extensibilité : Conception modulaire, facile à étendre avec de nouveaux modèles.
* Conception multilingue : Localisation pour différentes langues.
* Support des blocs de comptage personnalisés : Idéal pour générer des théorèmes, problèmes et autres compteurs ou styles.

## 📦 Installation

### Installer Typst

Assurez-vous que Typst est installé. Vous pouvez l'installer en utilisant les commandes suivantes :

```bash
sudo apt install typst # Debian/Ubuntu
sudo pacman -S typst # Arch Linux
winget install --id Typst.Typst # Windows
brew install typst # macOS
```

Ou consultez la [documentation officielle de Typst](https://github.com/typst/typst) pour plus d'informations.

### Télécharger le modèle Scripst

#### Méthode 1 : Télécharger manuellement

1. Visitez le [dépôt GitHub de Scripst](https://github.com/An-314/scripst)
2. Cliquez sur le bouton `<> Code`
3. Choisissez `Télécharger ZIP`
4. Après extraction, placez les fichiers du modèle dans votre répertoire de projet.

**Structure du répertoire suggérée**

```plaintext
projet/
├── src/
│   ├── main.typ
│   ├── components.typ
├── pic/
│   ├── image.jpg
├── main.typ
├── chap1.typ
├── chap2.typ
```

Si le modèle est dans le répertoire `src/`, importez-le de cette manière :

```typst
#import "src/main.typ": *
```

#### Méthode 2 : Utiliser la gestion locale des packages Typst

Vous pouvez télécharger Scripst manuellement et le stocker dans :

```
~/.local/share/typst/packages/local/scripst/1.1.0                 # Linux
%APPDATA%\typst\packages\local\scripst\1.1.0                      # Windows
~/Library/Application Support/typst/packages/local/scripst/1.1.0  # macOS
```

Ou utilisez les commandes suivantes :

```bash
cd {dossier-donnees}/typst/packages/local/scripst
git clone https://github.com/An-314/scripst 1.1.0
```

Où `dossier-donnees` fait référence au répertoire de données de Typst, tel que `~/.local/share/typst` pour Linux, `%APPDATA%\typst` pour Windows et `~/Library/Application Support/typst` pour macOS.

Ensuite, importez directement dans votre fichier Typst :

```typst
#import "@local/scripst:1.1.0": *
```

Vous pouvez maintenant utiliser le modèle Scripst.

Utilisez `typst init` pour créer rapidement un projet :

```bash
typst init @local/scripst:1.1.0 nom_du_projet
```

* * *

## 📄 Utiliser Scripst

### Importer le modèle Scripst

Importez le modèle au début de votre fichier Typst :

```typst
#import "@local/scripst:1.1.0": *
```

### Créer un document `article`

```typst
#show: scripst.with(
  title: [Comment utiliser Scripst],
  info: [Ceci est un modèle d'article],
  author: ("Auteur1", "Auteur2", "Auteur3"),
  time: datetime.today().display(),
  abstract: [Contenu du résumé],
  keywords: ("MotClé1", "MotClé2", "MotClé3"),
  contents: true,
  content_depth: 2,
  matheq_depth: 2,
  lang: "fr",
)
```

* * *

## 🔧 Paramètres du modèle

| Paramètre | Type | Valeur par défaut | Description |
| --- | --- | --- | --- |
| `template` | `str` | `"article"` | Choisir le modèle (`"article"`, `"book"`, `"report"`) |
| `title` | `content`, `str`, `none` | `""` | Titre du document |
| `info` | `content`, `str`, `none` | `""` | Sous-titre ou informations supplémentaires du document |
| `author` | `array` | `()` | Liste des auteurs |
| `time` | `content`, `str`, `none` | `""` | Date du document |
| `abstract` | `content`, `str`, `none` | `none` | Résumé du document |
| `keywords` | `array` | `()` | Mots-clés |
| `preface` | `content`, `str`, `none` | `none` | Préface |
| `font_size` | `length` | `11pt` | Taille de la police |
| `contents` | `bool` | `false` | Si une table des matières doit être générée |
| `content_depth` | `int` | `2` | Profondeur de la table des matières |
| `matheq_depth` | `int` | `2` | Profondeur de la numérotation des équations mathématiques |
| `lang` | `str` | `"zh"` | Langue (`"zh"`, `"en"`, `"fr"`, etc.) |

* * *

## ✨ Exemples de modèles et explications

### Article

  
Démo d'article

### Livre

  
Démo de livre _(Uniquement en chinois simplifié)_

### Rapport

  
Démo de rapport _(Uniquement en chinois simplifié)_

## 📜 Contribuer

N'hésitez pas à soumettre des problèmes ou des demandes de fusion ! Si vous avez des suggestions d'amélioration, rejoignez la discussion.

* **Dépôt GitHub** : [Scripst](https://github.com/An-314/scripst)
* **Retour sur les problèmes** : Soumettez un problème pour discuter

## 📌 Polices

Ce projet utilise les polices suivantes par défaut :

* Polices principales : [CMU Serif](https://en.wikipedia.org/wiki/Computer_Modern), [Consolas](https://en.wikipedia.org/wiki/Consolas)
* Polices alternatives : [Linux Libertine](https://en.wikipedia.org/wiki/Linux_Libertine)
* Polices chinoises comme SimSun, SimHei, KaiTi, etc.

Si vous utilisez ces polices par défaut, assurez-vous qu'elles sont correctement installées. Sinon, remplacez-les si nécessaire dans `./src/configs.typ`.

## 📦 Dépendances

Pour certains contenus, Scripst utilise les packages Typst suivants :

* [tablem](https://typst.app/universe/package/tablem)
* [physica](https://typst.app/universe/package/physica)

## 🎯 TODO

* [ ]  Ajouter un modèle `beamer`