# UVic Astronomy LaTex Template

This thesis template has been created for astronomy students at the University of Victoria, to aid in structuring and compiling their final thesis documents.

The basis of this astronomy template is based on the PAGSA UVic Latex Thesis Template (<https://github.com/PAGSA/UVic-latex-thesis-template>), which serves as a great base for both physics and astronomy students.

The project here has been modified to adhere to current LaTex standards, simplifying the overall structure, while serving **astronomy graduate students**. Many physics-related packages and implementations have been completely trimmed out, in order to keep the overall scope of the project highly specific and lightweight. Included with this astronomy-specific template is an example PDF (compiled from the entry point, see below) giving information on each included package, along with examples on best-practices.

Many thanks to Caleb Miller who compiled the aforementioned UVic Latex Thesis Template, which served as a great base for the changes found in this repository.

## Instructions

Clone (or download) this repository, and for Overleaf users, upload all files to a new Overleaf Project.

## Project Layout

### Main Directories

- `frontmatter/` - contains the instructions for building the frontmatter of the compiled thesis/dissertation
- `macros/` - contains instructions for the thesis/dissertation style
- `content/` - optional directory structure to keep all content related information

### Main Files

- `AstroExample.tex` - the base tex file
- `AstroCitations.bib` - example `.bib` file used
- `astronomy_packages.tex` - contains astronomy-related packages the user can comment-in (or comment-out)

`AstroExample.tex` is the entry point for compilation. This example file provides useful documentation on compiling a thesis style that adheres to the UVic guidelines for thesis formatting, however, adds in useful examples on citation managament, citation styles (that mimic many typical publishers), complex table structures, and typical astronomy symbols. 

Most of the package implementation that goes above the basic structure implemented by both the `frontmatter/` (for user information) and `macros/` (for style), will be contained within `astronomy_packages.tex`, with documentation found within the `AstroExample.tex`.

`AstroCitations.bib` is also included as the bibliography file used for the `AstroExample.tex`, and includes typical citations from typical published as broad examples, along with specific citations for documentation for specific packages implemented.

## Setting up your student information

The following should be changed within the `frontmatter/` directory:

- Within `setup.tex`, set your `name`, `thesis title`, `degrees held` and `committee members`
- Change the copyright year under `titlepage.tex` to the current year
- Input any acknowledgements under `acknowledgements.tex`
- Input any dedications under `dedications.tex`
- Write the abstract of your thesis/dissertation in `abstract.tex`

Make use of the `ThesisMain.pdf` to see how each frontmatter section is compiled into the final PDF version of the thesis/dissertation.

## Packages (to optionally include)

This thesis/dissertation template outlines many packages users may want to use when writing; it is up to the users to choose which to include in their setup. This can be done by inspecting `astronomy_packages.tex` and commenting-in (or -out) the packages users would like (or wish to exclude for any reason). Users can add any additional packages into this file directly (and they will be loaded by `AstroExample.tex`), or add them into `AstroExample.tex` directly. **Note that by convention, some packages should be loaded after others. See `astronomy_packages.tex` for information regarding this**.

### Packages Included in TeXLive

- `amsmath`: <https://ctan.org/pkg/amsmath>
  - principal package in the AMS-LaTeX distribution, enables mathematical typesetting
- `amsthm`: <https://ctan.org/pkg/amsthm>
  - enables theorem setup typically used for AMS publications
- `amssymb` (technically part of amsfonts): <https://ctan.org/pkg/amsfonts>
  - defines all the symbols found in the AMS symbol fonts database
- `sectsty`: <https://ctan.org/pkg/sectsty>
  - help change the style of sectional headers in the base classes (article, book, report)
- `fancyhdr`: <https://ctan.org/pkg/fancyhdr>
  - configurability for constructing headers and footers
- `tocloft`: <https://ctan.org/pkg/tocloft>
  - provides control over the Table of Contents, List of Figures, List of Tables, etc.
- `xspace`: <https://ctan.org/pkg/xspace>
  - fixes TeX command decoder space issues
- `setspace`: <https://ctan.org/pkg/setspace>
  - provides support for setting spacing between lines in a document
- `verbatim`: <https://ctan.org/pkg/verbatim>
  - provides verbatim environments for the display of code-style content
- `graphics`: <https://ctan.org/pkg/graphics>
  - accomodates the inclusion of graphics in documents
- `graphicx`: <https://ctan.org/pkg/graphicx>
  - extension of the graphics package
- `layout`: <https://ctan.org/pkg/layout>
  - shows a summary of the layout of the current document, helpful for de-bugging formatting
- `changebar`: <https://ctan.org/pkg/changebar>
  - identifies areas of text that have changed (with configurable changebars)
- `pdfpages`: <https://ctan.org/pkg/pdfpages>
  - simplifies the inclusion of external PDF files into LaTeX documents
- `geometry`: <https://ctan.org/pkg/geometry>
  - easy and flexible customization for page layout
- `adjustbox`: <https://ctan.org/pkg/adjustbox>
  - includes macros to adjust boxed content
- `notoccite`: <https://ctan.org/pkg/notoccite>
  - supresses odd behavior with certain cite commands in the table of contents
- `caption`: <https://ctan.org/pkg/caption>
  - customize the captions in float environments
- `subcaption`: <https://ctan.org/pkg/subcaption>
  - extension of caption package for subfigures and related environments
- `varioref`: <https://ctan.org/pkg/varioref>
  - references to labels to indicate its physical page location
- `url`: <https://ctan.org/pkg/url>
  - provides a verbatim-style text environment, primarily used for URLs in text
- `natbib`: <https://ctan.org/pkg/natbib>
  - bibliography support for author-year and numbered references
- `hyperref`: <https://ctan.org/pkg/hyperref>
  - used to handle cross-referencing in LaTeX to produce hypertext links in the document, **must be loaded last to work properly**

### Packages (and supplementary files) not Included in TeXLive

Background: This LaTeX thesis template was essentially made by converting my ApJ submission into the required style given by the University of Victoria (by way of modifying the template made by Caleb Miller). Through this process, I attempted to carry-over many useful properties of the `aastex631` style that did not clash with the University's format. These were primarily the citation style and the custom `deluxetable` environments. I was unable to get 100% compatibility with the `deluxetable` environment, and as such needed to find a replacement, however, the citation style was able to be formatted to work with the thesis template. The two custom files are listed below and found in this repository:

- `aasjournal.bst`: bibliographic style file for the natbib package
- `aastex_hack.sty`: extra journal shorthands

The `aasjournal.bst` style file is used by `natbib` to compile the bibliography and citation styles used throughout the thesis. By way of using the `natbib` package, the `\citet{}` and `\citep{}` commands are available to use. If the user is exporting shorthands for the journal entries in their `.bib` file, then support is needed through the shorthands found in the `aastex_hack.sty` file. If users would like to instead use the `biblatex` package (through the `biber` backend), they may choose any of the styles given by `biblatex` directly. A more detailed (although still high-level) explanation is given in the AstroExamplePDF.

### Packages for use in Table-like Environments

The following are a set of packages used for creating complex table-like environments. More detailed information can be found in the compiled AstroExample PDF in this repository.

- xltabular: <https://ctan.org/pkg/xltabular>
- threeparttable: <https://ctan.org/pkg/threeparttable>
- booktabs: <https://ctan.org/pkg/booktabs>
- caption: <https://ctan.org/pkg/caption>
- multirow: <https://ctan.org/pkg/multirow>
- pdflscape: <https://ctan.org/pkg/pdflscape>
