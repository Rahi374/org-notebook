[![MELPA](http://melpa.org/packages/org-notebook-badge.svg)](http://melpa.org/#/org-notebook)

# org-notebook

Ease the use of org-mode as a notebook

### Introduction

I use org-mode to take notes in class. I find it better than all those other note-taking apps like OneNote. The problem is that it was a relatively large hassle to open up an image editor and quickly draw up a diagram an input it into the org file. So I decided to make a series of functions to ease said process, and in the meantime make a package to also manage the notebook.

Recently I have also added functionality to easily add HTML and LaTeX headers as a template to ease the process of exporting the org notebook to HTML or LaTeX/PDF.

### Requirements

The is for Emacs, so obviously Emacs. I only tested it on 24.

Also org and ido.

### Installation

Install from MELPA.

`M-x package-install RET org-notebook`

### Getting Started

Bind a key combination to `org-notebook-insert-image`.

Then when you're in your org notebook file and you want to quickly draw up a diagram and insert it, run that key combo, and it'll fire up kolourpaint and you can draw your thing, save it in the default directory, and the link will already be put in the org file. (you will need a `img/` directory if you don't already have one)

Or run `org-notebook-new-notebook` from `M-x` to create a new notebook, complete with the org file with the template headers and the `img/` directory!

### Configuration

  - `org-notebook-drawing-program` to use a different program to draw your diagrams, such as inkscape or gimp. The default value is "kolourpaint". Tip: If you want to just insert an image link and create the image later, you can set this value to an empty string and it won't load any drawing program.

  - `org-notebook-image-type` to use a different image type besides png.

  - `org-notebook-language` to use a different language for your org notebook (mainly important for export purposes).

  - `org-notebook-image-width` to change the width (and therefore size) of the images displayed in org mode. The default value is 600.

  - `org-notebook-headers` to set the org headers template. `TITLE`, `AUTHOR`, `mode: org`, `EMAIL`, `LANGUAGE`, and `ATTR_ORG: :width` should not be included here. This is a list of cons. The default value is empty.

Example value of `org-notebbok-headers`:
```elisp
(
  ("LATEX_CLASS_OPTIONS" "[letter,12pt]")
  ("LATEX_CLASS" "article")
  ("HTML_HEAD" "<script type=\"text/javascript\" src=\"../media/js/main.js\"></script>")
  ("HTML_HEAD" "<link rel=\"stylesheet\" type=\"text/css\" href=\"../media/css/main.css\">")
)
```

### TODO

- Support multiple org files (=pages) in one notebook.
- Allow per-subdirectory auto-customization of variables (drawing program, headers, language, and image type)
- Check svg compatability
- Make readme uniform in elisp file and markdown

### Changelog

  - 1.0 - Initial version, includes insert-image and new-notebook.
  - 1.1 - Allows templating with org headers. Also added image-width customization.
  - 1.2 - Smart-decide paint program and autocreate img/ directory on insert-image.

### Contributors

Paul Elder

### License

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
