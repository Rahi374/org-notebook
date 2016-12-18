# org-notebook

A package to ease the use of org-mode as a notebook

### Introduction

I use org-mode to take notes in class. I find it better than all those other note-taking apps like OneNote. The problem is that it was a relatively large hassle to open up an image editor and quickly draw up a diagram an input it into the org file. So I decided to make a series of functions to ease said process, and in the meantime make a package to also manage the notebook.

### Requirements

The is for Emacs, so obviously Emacs. I only tested it on 24.

Also org and ido.

### Installation

I'm hoping to get this onto MELPA.

For now, a manual installation will have to do.

Git clone this repo, copy org-notebook.el to one of your Emacs load-path, and then `(require 'org-notebook)` in your `.emacs` or `init.el`.

For more information on this process, see: [[https://www.emacswiki.org/emacs/InstallingPackages]]

### Getting Started

Bind a key combination to `org-notebook-insert-image`.

Then when you're in your org notebook file and you want to quickly draw up a diagram and insert it, run that key combo, and it'll fire up kolourpaint and you can draw your thing, save it in the default directory, and the link will already be put in the org file. (you will need a `img/` directory if you don't already have one)

Or run `org-notebook-new-notebook` from `M-x` to create a new notebook, complete with the org file and the `img/` directory!

### Configuration

Customize the variable `org-notebook-drawing-program` to use a different program to draw your diagrams, such as inkscape or gimp.

Customize `org-notebook-image-type` to use a different image type besides png.

Customize `org-notebook-language` to use a different language for your org notebook.

### Future plans

So far my next idea is to support multiple org files in one notebook.

### Changelog

1.0 - Initial version, includes insert-image and new-notebook.

### Contributors

Paul Elder

### License

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
