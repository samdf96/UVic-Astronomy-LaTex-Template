# UVic Physics & Astronomy Thesis Template

A LaTeX template for Master's theses and PhD dissertations in the Department of Physics and Astronomy at the University of Victoria.

The template is a single document class, `uvicphysastro`, that produces the preliminary pages UVic requires (title page, supervisory committee, abstract, table of contents, lists of tables and figures, acknowledgements, dedication) in the required order and with the required page numbering. You choose a few class options and fill in your details in one file; the class does the rest!

**[thesis.pdf](thesis.pdf) is both the example thesis and the manual.** It explains every class option and shows how to handle the things astronomy theses commonly need: journal bibliography styles, references exported from NASA ADS, long and landscape tables, and astronomical notation.

## Quick start

1. Download or clone this repository. To use Overleaf, upload all of its files to a new project (keeping the folder structure), and set the main document to `thesis.tex`.
2. In `thesis.tex`, set the class options and your thesis details:

   ```latex
   \documentclass[
     degree=masters,          % masters | phd
     bibliography=natbib,     % none | natbib | biblatex
   ]{uvicphysastro}

   \thesistitle{Your Thesis Title}
   \thesisauthor{Your Legal Name}
   \thesisyear{2026}
   \thesisdegrees{B.Sc., University of Somewhere, 2024}
   \thesiscommittee{%
     \panelist{Dr. A. Supervisor}{Supervisor}{Department of Physics and Astronomy}%
     \panelist{Dr. B. Member}{Departmental Member}{Department of Physics and Astronomy}%
   }
   ```

3. Write your abstract in `frontmatter/abstract.tex`, and edit (or delete) `frontmatter/acknowledgements.tex` and `frontmatter/dedications.tex`.
4. Replace the example chapters in `content/` with your own, and update the `\include` lines in `thesis.tex`.
5. Compile with pdfLaTeX (the Overleaf default). Locally, `latexmk -pdf thesis.tex` runs LaTeX and BibTeX as many times as needed. LuaLaTeX is also fully supported.

All class options are listed in Chapter 1 of `thesis.pdf` and at the top of `uvicphysastro.cls`.

## Repository layout

| Path | Contents |
| --- | --- |
| `thesis.tex` | The main file: class options, thesis details, extra packages, and the list of chapters. |
| `uvicphysastro.cls` | The document class. You should not need to edit it. |
| `frontmatter/` | Your abstract, acknowledgements and dedication. All other preliminary pages are generated. |
| `content/` | One file per chapter. Images go in `content/figures/`; `content/examples/` holds the table code shown in the example PDF and can be deleted. |
| `references.bib` | Your bibliography database. |
| `extras/` | Bibliography styles of the AAS journals (`aasjournal.bst`) and MNRAS (`mnras.bst`). |
| `thesis.pdf` | The compiled example thesis. |

## Before you submit

UVic's formatting requirements are in the [thesis format checklist and sample pages](https://www.uvic.ca/graduatestudies/forms-policies/data/sample-samplepages.pdf) and on the [scope, structure and formatting page](https://www.uvic.ca/students/graduate/thesis-dissertation/scope-structure-and-formatting/index.php). The template follows them as of the October 2025 checklist, but meeting them is your responsibility. In particular:

- **Name your PDF `LastName_FirstName_Degree_Year.pdf`** (for example `Smith_Jane_MSc_2026.pdf`), matching the name on your title page. LaTeX names the output after the main file (`thesis.pdf`), so rename it before uploading to UVicSpace.
- Turn off draft mode: remove the `draft=true` class option (or change it to `draft=false`), and remove any to-do notes.
- Compile twice after your last change so that the page numbers in the table of contents are correct.

## Credits

This template began as a modification of the [PAGSA UVic LaTeX Thesis Template](https://github.com/PAGSA/UVic-latex-thesis-template), compiled by Caleb Miller, and was rewritten as a document class by Samuel Fielder in 2026. Thanks to Jaclyn Jensen and Eleanore Todd for testing it with their theses and for their feedback.

## Licence

The template is released under the [MIT License](LICENSE). The bibliography styles in `extras/` are included unchanged and keep their own licence, the [LaTeX Project Public License](https://www.latex-project.org/lppl/): `aasjournal.bst` is part of [AASTeX](https://ctan.org/pkg/aastex) (American Astronomical Society) and `mnras.bst` is part of the [MNRAS class](https://ctan.org/pkg/mnras) (Royal Astronomical Society).
