% uvicphysastro.cls
% Custom LaTeX class for University of Victoria Physics and Astronomy theses
% October 2026, Samuel Fielder samuelfielder (at) uvic.ca
% Version 1.1

% Thanks to Caleb Miller for the originally implemented thesis templates, and
% Jaclyn Jensen, Eleanore Todd, and Branden Aitken for their contributions in
% testing and feedback.

% -------------------------------------------------------------------
% Class Declaration
% -------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uvicphysastro}[2026-10-01 v1.1 UVic Physics and Astronomy Thesis Class]

% -------------------------------------------------------------------
% Class Options (key=value style)
%
%   degree=masters  (default) — Master of Science thesis
%   degree=phd                — Doctor of Philosophy dissertation
%
%   bibliography=none     (default) — no bibliography package loaded
%   bibliography=natbib           — load natbib; use \bibliographystyle{}
%                                   and \bibliography{} in your document.
%                                   Compatible with .bst files from AAS,
%                                   MNRAS, and other journals.
%   bibliography=biblatex         — load biblatex (backend: biber).
%                                   Use \printbibliography in your document.
%
%   bibstyle=authoryear (default) — biblatex citation style; only applies
%                                   when bibliography=biblatex.
%                                   Any biblatex style name is valid here.
%
%   spacing=onehalf (default) — 1.5x line spacing throughout
%   spacing=double            — double line spacing throughout
%
%   floatfraction=0.5 (default) — minimum fraction of a page floats must
%                                 occupy before LaTeX makes a float-only page.
%                                 Lower values (e.g. 0.01) cause figures to
%                                 get their own dedicated pages more readily.
%
%   draft=false (default) — final output
%   draft=true             — enables: line numbers, margin label keys,
%                            overfull hbox bars, compile timestamp footer,
%                            todonotes, and changebar support
%
%   listoftables=true (default)  — include the List of Tables
%   listoftables=false           — omit it (UVic requires it only if the
%                                  thesis contains tables)
%   listoffigures=true (default) — include the List of Figures
%   listoffigures=false          — omit it (UVic requires it only if the
%                                  thesis contains figures)
%
%   headings=left (default) — preliminary-page headings (Abstract, Table of
%                             Contents, lists, Acknowledgements, Dedication)
%                             are left-aligned
%   headings=centered       — they are centred (`centred' also accepted)
% -------------------------------------------------------------------
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=uvicphysastro, prefix=uvicopt@}
\DeclareStringOption[masters]{degree}
\DeclareStringOption[none]{bibliography}
\DeclareStringOption[authoryear]{bibstyle}
\DeclareStringOption[onehalf]{spacing}
\DeclareStringOption[0.5]{floatfraction}
\DeclareBoolOption[false]{draft}
\DeclareBoolOption[true]{listoftables}
\DeclareBoolOption[true]{listoffigures}
\DeclareStringOption[left]{headings}
% kvoptions requires \DeclareDefaultOption (not \DeclareOption*) for
% unrecognised options; these are passed through to the book class
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessKeyvalOptions{uvicphysastro}

% draft is this class's own option. Remove it from the global option list
% so that other packages do not also switch to their draft modes
% (hyperref would drop every link, graphicx and pdfpages every image).
\@expandtwoargs\@removeelement{draft}{\@classoptionslist}\@classoptionslist
\@expandtwoargs\@removeelement{draft=true}{\@classoptionslist}\@classoptionslist
\@expandtwoargs\@removeelement{draft=false}{\@classoptionslist}\@classoptionslist

% xcolor is loaded early by other packages (e.g. adjustbox), so its
% options must be registered before anything else loads it
\PassOptionsToPackage{dvipsnames,svgnames}{xcolor}

\LoadClass[12pt,oneside]{book}

% Font encoding and Unicode text in the PDF (UVicSpace requires
% Unicode-compliant files, i.e. text that can be searched and copied).
% - pdfLaTeX: T1 encoding for proper hyphenation of accented words.
% - XeLaTeX/LuaLaTeX: Unicode (TU-encoded OpenType Latin Modern) fonts by
%   default. Forcing T1 on them would switch to 8-bit fonts and lose the
%   Unicode text, so it is not loaded.
% Fonts that are still 8-bit Type 1 fonts (pdfLaTeX text; math fonts and
% wasysym under every engine) need a glyph-to-Unicode map, below.
\RequirePackage{iftex}
\ifPDFTeX
  \RequirePackage[T1]{fontenc}
\fi

% \uvic@tounicode loads the glyph-to-Unicode map: the standard glyph names
% (including ligatures such as "fi"), plus font-specific glyphs whose names
% are not standard. Used by pdfLaTeX (fully effective) and LuaLaTeX (math
% fonts are fixed; some wasysym symbols still copy incorrectly). XeLaTeX
% builds its maps from glyph names itself and cannot use this map.
\newcommand\uvic@tounicode{%
  \input{glyphtounicode}%
  % tipa stores schwa and eng in the "at" and "N" slots (territorial
  % acknowledgement)
  \@for\@tempa:=tipa8,tipa9,tipa10,tipa12,tipa17\do{%
    \pdfglyphtounicode{tfm:\@tempa/at}{0259}%
    \pdfglyphtounicode{tfm:\@tempa/N}{014B}%
  }%
  % wasysym astronomical symbols (\sun, \mercury, \venus, \earth, ...)
  \@for\@tempa:=wasy5,wasy6,wasy7,wasy8,wasy9,wasy10,wasyb10,wasysl10\do{%
    \@for\@tempb:=sun/2609,mercury/263F,female/2640,earth/2641,male/2642,%
        jupiter/2643,saturn/2644,uranus/2645,neptun/2646,pluto/2647,%
        rightmoon/263D,leftmoon/263E,ascnode/260A,descnode/260B,%
        conjunction/260C,opposition/260D,aries/2648,taurus/2649,%
        gemini/264A,cancer/264B,virgo/264D,libra/264E,scorpio/264F,%
        sagittarius/2650,capricorn/2651,aquarius/2652,pisces/2653,%
        inve/0259\do{%
      \expandafter\uvic@wasymap\@tempb\@nil
    }%
  }%
}
\def\uvic@wasymap#1/#2\@nil{\pdfglyphtounicode{tfm:\@tempa/#1}{#2}}
\ifPDFTeX
  \uvic@tounicode
  \pdfgentounicode=1
\fi
\ifLuaTeX
  % LuaTeX has the same mechanism under a different primitive name
  {\protected\def\pdfglyphtounicode{\pdfextension glyphtounicode}%
   \uvic@tounicode}%
  \pdfvariable gentounicode=1
\fi

% -------------------------------------------------------------------
% Option validation
% String options are lowercased, then checked against their allowed
% values so that a typo stops compilation instead of silently falling
% back to the default.
% \uvic@checkoption{<option name>}{<macro>}{<allowed values, comma list>}
% -------------------------------------------------------------------
\RequirePackage{etoolbox}
\newcommand\uvic@checkoption[3]{%
  \edef\@tempa{\noexpand\lowercase{\noexpand\def\noexpand#2{#2}}}\@tempa
  \def\@tempb{0}%
  \@for\@tempc:=#3\do{\ifdefequal{#2}{\@tempc}{\def\@tempb{1}}{}}%
  \ifnum\@tempb=0
    \ClassError{uvicphysastro}{%
      Invalid value `#2' for option `#1'.\MessageBreak
      Allowed values: #3}{%
      Check the \protect\documentclass\space options in your .tex file.}%
  \fi
}
\uvic@checkoption{degree}{\uvicopt@degree}{masters,phd}
\uvic@checkoption{bibliography}{\uvicopt@bibliography}{none,natbib,biblatex}
\uvic@checkoption{spacing}{\uvicopt@spacing}{onehalf,double}
\uvic@checkoption{headings}{\uvicopt@headings}{left,centered,centred}

% Resolve degree option into thesis-type strings
\newif\if@phd
\ifdefstring{\uvicopt@degree}{phd}{%
  \@phdtrue
  \def\uvic@thesistype{Dissertation}%
  \def\uvic@thesistypelower{dissertation}%
  \def\uvic@degreelevel{DOCTOR OF PHILOSOPHY}%
}{%
  \@phdfalse
  \def\uvic@thesistype{Thesis}%
  \def\uvic@thesistypelower{thesis}%
  \def\uvic@degreelevel{MASTER OF SCIENCE}%
}

% -------------------------------------------------------------------
% Packages and layout
% -------------------------------------------------------------------
% loading geometry to set the margins
% headheight=15pt is the minimum fancyhdr needs at 12pt; the header
% baseline stays at (top - headsep), so page numbers do not move.
% The margin-note area (0.1in gap + 0.8in notes) fits inside the 1in right
% margin and is wide enough for todonotes (which needs at least 2cm).
\RequirePackage[top=1.3in,left=1in,bottom=1in,right=1in,headsep=0.5in,headheight=15pt,
  marginparsep=0.1in,marginparwidth=0.8in]{geometry}

% Extra stretch used only for paragraphs that would otherwise run into the
% margin (e.g. lines with long unbreakable words, code or file names);
% well-set paragraphs are unaffected
\setlength{\emergencystretch}{2em}

% Line spacing controlled by spacing= class option
\RequirePackage{setspace}
\ifdefstring{\uvicopt@spacing}{double}{%
  \doublespacing%
}{%
  \onehalfspacing%
}

% Headers/footers
\RequirePackage{fancyhdr}

% -------------------------------------------------------------------
% Mathematics (ams suite)
% -------------------------------------------------------------------
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{amssymb}

% -------------------------------------------------------------------
% Section/heading fonts
% -------------------------------------------------------------------
% sectsty (2002) checks \underline and \underbar against their 2002
% definitions and warns because LaTeX has since updated them. The check
% has no effect on the output, so it is turned into a no-op (\providecommand
% leaves existing commands untouched) while sectsty loads.
\let\uvic@CheckCommand\CheckCommand
\let\CheckCommand\providecommand
\RequirePackage{sectsty}
\let\CheckCommand\uvic@CheckCommand
\allsectionsfont{\bfseries}
\chapterfont{\centering\Large}
\sectionfont{\normalsize}
\subsectionfont{\normalsize}

% -------------------------------------------------------------------
% General utility packages
% -------------------------------------------------------------------
\RequirePackage{xspace}
\RequirePackage{verbatim}
\RequirePackage{graphicx}
\RequirePackage{pdfpages}
\RequirePackage[export]{adjustbox}[2011/08/13]
% ToC / List of Figures / List of Tables customization
% tocloft must be loaded before notoccite: notoccite redefines
% \@starttoc, and tocloft silently disables itself if it finds that
\RequirePackage{tocloft}
\renewcommand\cfttabpresnum{Table\ }
\renewcommand\cftfigpresnum{Figure\ }
% Space reserved for "Figure 10.10" / "Table 10.10" plus a gap before the
% title (both lists use the same width so they line up identically)
\setlength\cfttabnumwidth{1.05in}
\setlength\cftfignumwidth{1.05in}
\RequirePackage{notoccite}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{varioref}
\RequirePackage{url}
\RequirePackage{xurl} % lets long URLs break at any character instead of running into the margin
% xcolor: dvipsnames and svgnames are registered via \PassOptionsToPackage
% near the top of this file (other packages load xcolor earlier)
\RequirePackage{xcolor}
% Schwa (ə) and eng (ŋ) for the territorial acknowledgement.
% pdfLaTeX: tipa provides them ([safe] stops it redefining \s, \!, \*, \|
% and \:). XeLaTeX/LuaLaTeX: the Unicode characters, which the default
% Latin Modern fonts contain.
\ifPDFTeX
  \RequirePackage[safe]{tipa}
  % tipa's fonts exist only for Computer Modern (cmr), so take the two
  % characters from cmr explicitly. Otherwise a document that switches
  % fonts (e.g. \usepackage{lmodern}) gets a "Font shape T3/lmr/m/n
  % undefined" warning and the same cmr characters by substitution.
  \newcommand\uvic@schwa{{\fontfamily{cmr}\selectfont\textschwa}}
  \newcommand\uvic@eng{{\fontfamily{cmr}\selectfont\textipa{\ng}}}
\else
  \newcommand\uvic@schwa{\char"0259\relax}
  \newcommand\uvic@eng{\char"014B\relax}
\fi
% nointegrals avoids wasysym overwriting integral symbols already defined by amsmath
\RequirePackage[nointegrals]{wasysym} % astronomical and miscellaneous symbols

% -------------------------------------------------------------------
% Table of Contents helpers
% -------------------------------------------------------------------
\newcommand\TOCadd[1]{%
  \newpage
  \phantomsection
  \addcontentsline{toc}{chapter}{#1}%
}

% -------------------------------------------------------------------
% Preliminary-page headings (headings= class option)
% UVic requires the headings of the preliminary pages to be consistent.
% The Table of Contents and list titles (set by tocloft) and the
% \prelimheading pages (Abstract, Acknowledgements, Dedication) share one
% font, alignment and vertical spacing, so all of them match.
% -------------------------------------------------------------------
\ifdefstring{\uvicopt@headings}{left}{%
  \newcommand\uvic@prelimtitlefont{\noindent\large\bfseries}%
  \newcommand\uvic@afterprelimtitle{}%
}{%
  % \hfill on both sides centres the title; \centering cannot be used
  % because tocloft ends the title's group before the paragraph ends.
  % \null keeps TeX from discarding the closing \hfill at the end of the
  % paragraph.
  \newcommand\uvic@prelimtitlefont{\noindent\hfill\large\bfseries}%
  \newcommand\uvic@afterprelimtitle{\hfill\null}%
}
\newlength\uvic@beforeprelimtitle
\newlength\uvic@afterprelimtitleskip
\setlength\uvic@beforeprelimtitle{0pt}
\setlength\uvic@afterprelimtitleskip{20pt}
\renewcommand\cfttoctitlefont{\uvic@prelimtitlefont}
\renewcommand\cftlottitlefont{\uvic@prelimtitlefont}
\renewcommand\cftloftitlefont{\uvic@prelimtitlefont}
\renewcommand\cftaftertoctitle{\uvic@afterprelimtitle}
\renewcommand\cftafterlottitle{\uvic@afterprelimtitle}
\renewcommand\cftafterloftitle{\uvic@afterprelimtitle}
\setlength\cftbeforetoctitleskip{\uvic@beforeprelimtitle}
\setlength\cftbeforelottitleskip{\uvic@beforeprelimtitle}
\setlength\cftbeforeloftitleskip{\uvic@beforeprelimtitle}
\setlength\cftaftertoctitleskip{\uvic@afterprelimtitleskip}
\setlength\cftafterlottitleskip{\uvic@afterprelimtitleskip}
\setlength\cftafterloftitleskip{\uvic@afterprelimtitleskip}

% \prelimheading{Title} starts a preliminary page (Abstract,
% Acknowledgements, Dedication, ...): new page, Table of Contents entry,
% and a heading matching the Table of Contents title (same construction
% as tocloft's titles)
\newcommand\prelimheading[1]{%
  \TOCadd{#1}%
  \vspace*{\uvic@beforeprelimtitle}%
  {\interlinepenalty\@M
    {\uvic@prelimtitlefont #1}{\uvic@afterprelimtitle}%
    \par\nobreak
    \vskip\uvic@afterprelimtitleskip
    \@afterheading}%
}

% -------------------------------------------------------------------
% Float customization
% -------------------------------------------------------------------
\renewcommand{\floatpagefraction}{\uvicopt@floatfraction}

% -------------------------------------------------------------------
% Miscellaneous helpers
% -------------------------------------------------------------------
\newcommand\tpbreak{\\[\baselineskip]} % titlepage line break

% -------------------------------------------------------------------
% Astronomy macros
% Sourced from aastex.cls (AAS journal class).
% Journal names expand to their standard abbreviations. Students who
% prefer full journal names should use literal strings in their .bib
% file rather than these macros.
% -------------------------------------------------------------------

% Journal name helper — applies roman family to journal abbreviations
\let\jnl@style=\rmfamily
\def\ref@jnl#1{{\jnl@style#1}}

% Journal abbreviations
\newcommand\aj{\ref@jnl{AJ}}%                        Astronomical Journal
\newcommand\araa{\ref@jnl{ARA\&A}}%                  Annual Review of Astron and Astrophys
\newcommand\apj{\ref@jnl{ApJ}}%                      Astrophysical Journal
\newcommand\apjl{\ref@jnl{ApJ}}%                     Astrophysical Journal, Letters
\newcommand\apjs{\ref@jnl{ApJS}}%                    Astrophysical Journal, Supplement
\newcommand\ao{\ref@jnl{Appl.~Opt.}}%                Applied Optics
\newcommand\apss{\ref@jnl{Ap\&SS}}%                  Astrophysics and Space Science
\newcommand\aap{\ref@jnl{A\&A}}%                     Astronomy and Astrophysics
\newcommand\aapr{\ref@jnl{A\&A~Rev.}}%               Astronomy and Astrophysics Reviews
\newcommand\aaps{\ref@jnl{A\&AS}}%                   Astronomy and Astrophysics, Supplement
\newcommand\azh{\ref@jnl{AZh}}%                      Astronomicheskii Zhurnal
\newcommand\baas{\ref@jnl{BAAS}}%                    Bulletin of the AAS
\newcommand\jrasc{\ref@jnl{JRASC}}%                  Journal of the RAS of Canada
\newcommand\memras{\ref@jnl{MmRAS}}%                 Memoirs of the RAS
\newcommand\mnras{\ref@jnl{MNRAS}}%                  Monthly Notices of the RAS
\newcommand\pra{\ref@jnl{Phys.~Rev.~A}}%             Physical Review A
\newcommand\prb{\ref@jnl{Phys.~Rev.~B}}%             Physical Review B
\newcommand\prc{\ref@jnl{Phys.~Rev.~C}}%             Physical Review C
\newcommand\prd{\ref@jnl{Phys.~Rev.~D}}%             Physical Review D
\newcommand\pre{\ref@jnl{Phys.~Rev.~E}}%             Physical Review E
\newcommand\prl{\ref@jnl{Phys.~Rev.~Lett.}}%         Physical Review Letters
\newcommand\pasp{\ref@jnl{PASP}}%                    Publications of the ASP
\newcommand\pasj{\ref@jnl{PASJ}}%                    Publications of the ASJ
\newcommand\qjras{\ref@jnl{QJRAS}}%                  Quarterly Journal of the RAS
\newcommand\skytel{\ref@jnl{S\&T}}%                  Sky and Telescope
\newcommand\solphys{\ref@jnl{Sol.~Phys.}}%           Solar Physics
\newcommand\sovast{\ref@jnl{Soviet~Ast.}}%           Soviet Astronomy
\newcommand\ssr{\ref@jnl{Space~Sci.~Rev.}}%          Space Science Reviews
\newcommand\zap{\ref@jnl{ZAp}}%                      Zeitschrift fuer Astrophysik
\newcommand\nat{\ref@jnl{Nature}}%                   Nature
\newcommand\iaucirc{\ref@jnl{IAU~Circ.}}%            IAU Circulars
\newcommand\aplett{\ref@jnl{Astrophys.~Lett.}}%      Astrophysics Letters
\newcommand\apspr{\ref@jnl{Astrophys.~Space~Phys.~Res.}}% Astrophysics Space Physics Research
\newcommand\bain{\ref@jnl{Bull.~Astron.~Inst.~Netherlands}}% Bul. Astr. Inst. Netherlands
\newcommand\fcp{\ref@jnl{Fund.~Cosmic~Phys.}}%       Fundamental Cosmic Physics
\newcommand\gca{\ref@jnl{Geochim.~Cosmochim.~Acta}}% Geochimica Cosmochimica Acta
\newcommand\grl{\ref@jnl{Geophys.~Res.~Lett.}}%      Geophysics Research Letters
\newcommand\jcp{\ref@jnl{J.~Chem.~Phys.}}%           Journal of Chemical Physics
\newcommand\jgr{\ref@jnl{J.~Geophys.~Res.}}%         Journal of Geophysics Research
\newcommand\jqsrt{\ref@jnl{J.~Quant.~Spec.~Radiat.~Transf.}}% J. Quantitative Spectroscopy
\newcommand\memsai{\ref@jnl{Mem.~Soc.~Astron.~Italiana}}% Mem. Societa Astronomica Italiana
\newcommand\nphysa{\ref@jnl{Nucl.~Phys.~A}}%         Nuclear Physics A
\newcommand\physrep{\ref@jnl{Phys.~Rep.}}%           Physics Reports
\newcommand\physscr{\ref@jnl{Phys.~Scr}}%            Physica Scripta
\newcommand\planss{\ref@jnl{Planet.~Space~Sci.}}%    Planetary Space Science
\newcommand\procspie{\ref@jnl{Proc.~SPIE}}%          Proceedings of the SPIE
% Further journals that NASA ADS writes as macros in its BibTeX exports
% (ADS journal macro list; abbreviations as in ADS's aas_macros.sty or
% AASTeX 7 where ADS's file has none)
\newcommand\aas{\ref@jnl{AAS Meeting Abstracts}}%    AAS Meeting Abstracts
\newcommand\actaa{\ref@jnl{Acta Astron.}}%           Acta Astronomica
\newcommand\bac{\ref@jnl{Bull.~astr. Inst. Czechosl.}}% Bull. Astr. Inst. Czechoslovakia
\newcommand\caa{\ref@jnl{Chinese Astron. Astrophys.}}% Chinese Astronomy and Astrophysics
\newcommand\cjaa{\ref@jnl{Chinese J. Astron. Astrophys.}}% Chinese J. Astronomy and Astrophysics
\newcommand\dps{\ref@jnl{AAS/Division for Planetary Sciences Meeting Abstracts}}%
\newcommand\icarus{\ref@jnl{Icarus}}%                Icarus
\newcommand\jaavso{\ref@jnl{JAAVSO}}%                J. American Association of Variable Star Observers
\newcommand\jcap{\ref@jnl{J.~Cosmology Astropart. Phys.}}% J. Cosmology and Astroparticle Physics
\newcommand\maps{\ref@jnl{M\&PS}}%                   Meteoritics and Planetary Science
\newcommand\na{\ref@jnl{New~A}}%                     New Astronomy
\newcommand\nar{\ref@jnl{New~A~Rev.}}%               New Astronomy Review
\newcommand\pasa{\ref@jnl{PASA}}%                    Publications of the Astron. Soc. of Australia
\newcommand\psj{\ref@jnl{PSJ}}%                      Planetary Science Journal
\newcommand\rmxaa{\ref@jnl{Rev.~Mexicana Astron. Astrofis.}}% Revista Mexicana de Astronomia y Astrofisica
% ADS writes "less/greater than about" in exported paper titles as these
% two macros (e.g. title = "{... at {$\lessequivlnt$} 2}"). Defined at the
% start of the document, and only if the preamble has not defined them,
% so a student's own definitions take precedence.
\AtBeginDocument{%
  \providecommand\lessequivlnt{\lesssim}%
  \providecommand\greaterequivlnt{\gtrsim}%
}
% Aliases for backwards compatibility
\let\astap=\aap
\let\apjlett=\apjl
\let\apjsupp=\apjs
\let\applopt=\ao

% Phantom spacing — useful for aligning numbers in tables
\newcommand\phn{\phantom{0}}%
\newcommand\phd{\phantom{.}}%
\newcommand\phs{\phantom{$-$}}%
\newcommand\phm[1]{\phantom{#1}}%

% Math comparison aliases
\let\la=\lesssim
\let\ga=\gtrsim

% Angle and time notation
\newcommand\arcdeg{\mbox{$^\circ$}}%
\newcommand\arcmin{\mbox{$^\prime$}}%
\newcommand\arcsec{\mbox{$^{\prime\prime}$}}%
\newcommand\degr{\arcdeg}%
\newcommand\fd{\mbox{$.\!\!^{\mathrm d}$}}%   fractional day
\newcommand\fh{\mbox{$.\!\!^{\mathrm h}$}}%   fractional hour
\newcommand\fm{\mbox{$.\!\!^{\mathrm m}$}}%   fractional minute
\newcommand\fs{\mbox{$.\!\!^{\mathrm s}$}}%   fractional second
\newcommand\fdg{\mbox{$.\!\!^\circ$}}%        fractional degree
\newcommand\farcm@mss{\mbox{$.\mkern-4mu^\prime$}}%
\let\farcm\farcm@mss
\newcommand\farcs@mss{\mbox{$.\!\!^{\prime\prime}$}}%
\let\farcs\farcs@mss
\newcommand\fp{\mbox{$.\!\!^{\scriptscriptstyle\mathrm p}$}}% fractional parallax
\newcommand\micron{\mbox{$\mu$m}}%

% Slant fractions
\newcommand\case[2]{\mbox{$\frac{#1}{#2}$}}%
\newcommand\slantfrac{\case}%
\newcommand\onehalf{\slantfrac{1}{2}}%
\newcommand\onethird{\slantfrac{1}{3}}%
\newcommand\twothirds{\slantfrac{2}{3}}%
\newcommand\onequarter{\slantfrac{1}{4}}%
\newcommand\threequarters{\slantfrac{3}{4}}%

% Photometric band systems
\newcommand\ubvr{\mbox{$U\!BV\!R$}}%
\newcommand\ub{\mbox{$U\!-\!B$}}%
\newcommand\bv{\mbox{$B\!-\!V$}}%
\newcommand\vr{\mbox{$V\!-\!R$}}%
\newcommand\ur{\mbox{$U\!-\!R$}}%

% Ion notation: \ion{Fe}{II} → Fe II (small caps roman numeral)
\newcommand\ion[2]{#1$\;${\small\rmfamily\@Roman{#2}}\relax}%

% -------------------------------------------------------------------
% Thesis metadata
% Set these in your preamble with the commands below.
% -------------------------------------------------------------------
\def\uvic@title{Thesis Title}
\def\uvic@author{Author Name}
\def\uvic@degrees{}
\def\uvic@department{Department of Physics and Astronomy}
\def\uvic@committee{}
\def\uvic@year{\the\year}
\def\uvic@copyright{%
  All rights reserved. This \uvic@thesistypelower\ may not be reproduced in
  whole or in part, by photocopy or other means, without the permission of
  the author.}

\newcommand{\thesistitle}[1]{\def\uvic@title{#1}}
% \thesisauthor is your legal name; UVic requires it to be identical
% everywhere it appears (title page top and bottom, committee page)
\newcommand{\thesisauthor}[1]{\def\uvic@author{#1}}
% \thesisdegrees (optional) lists previously awarded credentials only,
% one per line, e.g.:
%   \thesisdegrees{B.Sc., University of Victoria, 2020}
% Omit it entirely to show no credentials.
\newcommand{\thesisdegrees}[1]{\def\uvic@degrees{#1}}
\newcommand{\thesisyear}[1]{\def\uvic@year{#1}}
% \thesisdepartment (optional) replaces the department line, e.g. for
% joint programs: \thesisdepartment{Departments of Physics and Astronomy
% and Computer Science}. Do not include the leading "in the".
\newcommand{\thesisdepartment}[1]{\def\uvic@department{#1}}
% \thesiscopyright (optional) replaces the "All rights reserved..."
% statement, e.g. with a Creative Commons licence statement.
\newcommand{\thesiscopyright}[1]{\def\uvic@copyright{#1}}
% \thesiscommittee is built from \panelist commands, e.g.:
%   \thesiscommittee{%
%     \panelist{Dr. A}{Supervisor}{Department of Physics and Astronomy}%
%     \panelist{Dr. B}{Departmental Member}{Department of Physics and Astronomy}}
% Do not list the external examiner or the exam chair.
\newcommand{\thesiscommittee}[1]{\def\uvic@committee{#1}}

% Helper for listing committee members, laid out as on the UVic sample
% pages: "Name, Role" with the department on the line below
\newcommand\panelist[3]{\noindent #1, #2\\\noindent #3\tpbreak}

% Author name followed by any prior credentials (title and committee pages)
\newcommand\uvic@nameanddegrees{%
  \uvic@author
  \ifdefempty{\uvic@degrees}{}{\\\uvic@degrees}%
}

% -------------------------------------------------------------------
% Bibliography — natbib (loaded before hyperref)
% -------------------------------------------------------------------
% natbib is loaded here so that hyperref can patch its cite commands.
% The bibliography is always listed in the Table of Contents (UVic
% requires it); \bibsection is natbib's heading for the bibliography.
\ifdefstring{\uvicopt@bibliography}{natbib}{%
  \RequirePackage{natbib}%
  \renewcommand\bibsection{%
    \chapter*{\bibname}%
    \@mkboth{\MakeUppercase{\bibname}}{\MakeUppercase{\bibname}}%
    \phantomsection
    \addcontentsline{toc}{chapter}{\bibname}%
  }%
}{}
% Without a bibliography package, add the Table of Contents entry to the
% standard thebibliography environment instead
\ifdefstring{\uvicopt@bibliography}{none}{%
  \patchcmd{\thebibliography}{\chapter*{\bibname}}%
    {\chapter*{\bibname}\phantomsection\addcontentsline{toc}{chapter}{\bibname}}%
    {}{\ClassWarning{uvicphysastro}{Could not add the bibliography to the
      Table of Contents}}%
}{}

% -------------------------------------------------------------------
% Hyperlinks — loaded last so it wraps all other cross-referencing
% -------------------------------------------------------------------
\RequirePackage{hyperref}
\hypersetup{
  colorlinks,
  linkcolor=blue,
  linktocpage=true,
  citecolor=blue,
  urlcolor=olive
}
% Embed title and author in the PDF metadata (used by UVicSpace and
% library catalogues); deferred so the preamble metadata commands apply
\AtBeginDocument{%
  \hypersetup{pdftitle={\uvic@title}, pdfauthor={\uvic@author}}%
}

% -------------------------------------------------------------------
% Bibliography — biblatex (loaded after hyperref)
% -------------------------------------------------------------------
\ifdefstring{\uvicopt@bibliography}{biblatex}{%
  \RequirePackage[backend=biber, style=\uvicopt@bibstyle]{biblatex}%
  % \printbibliography is always listed in the Table of Contents
  \defbibheading{bibliography}[\bibname]{\printbibheading[heading=bibintoc,title={#1}]}%
}{}

% -------------------------------------------------------------------
% Draft mode packages and footer
% -------------------------------------------------------------------
\ifuvicopt@draft
  \RequirePackage[mathlines]{lineno} % line numbers; mathlines attempts
  %                                    to number lines inside math environments
  \RequirePackage{showkeys}          % prints \label and \ref keys in margins
  \RequirePackage{changebar}         % \cbstart...\cbend marks revised passages
  \RequirePackage{datetime2}         % provides \DTMnow for compile timestamp
  \setlength{\overfullrule}{5pt}     % black bar flags overfull hboxes
  \AtBeginDocument{\linenumbers}     % activate line numbers at document start
  \newcommand{\uvic@draft@footer}{%
    \small\textit{Draft --- \today\ \DTMcurrenttime}%
  }
  \RequirePackage{todonotes}         % \todo{} renders coloured margin notes
\else
  \newcommand{\uvic@draft@footer}{}  % empty in final mode
  \RequirePackage[disable]{todonotes}% \todo{} silently ignored in final mode
\fi

% -------------------------------------------------------------------
% \makefrontmatter
% Call this right after \begin{document}. It produces all preliminary
% pages, in UVic's required order, from the thesis details and from
% the files: frontmatter/abstract.tex          (required)
%                   frontmatter/abbreviations.tex     (optional; create it to add
%                                                      a list of abbreviations,
%                                                      acronyms, symbols, ...)
%                   frontmatter/acknowledgements.tex  (optional; delete to omit)
%                   frontmatter/dedications.tex       (optional; delete to omit)
% -------------------------------------------------------------------
\newcommand{\makefrontmatter}{%
  % Roman numeral page numbering for front matter
  \newpage
  \thispagestyle{empty}
  \pagestyle{fancy}
  \fancyhf{}
  \fancyhead[R]{\thepage}
  \fancyfoot[C]{\uvic@draft@footer}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \pagenumbering{roman}
  \fancypagestyle{plain}{%
    \fancyhf{}%
    \fancyhead[R]{\thepage}%
    \fancyfoot[C]{\uvic@draft@footer}%
    \renewcommand{\headrulewidth}{0pt}%
    \renewcommand{\footrulewidth}{0pt}%
  }%
  %
  % ---- Title page ----
  \pagebreak
  {%
    \centering
    \uvic@title
    \tpbreak
    by
    \tpbreak
    \uvic@nameanddegrees
    \tpbreak
    A \uvic@thesistype\ Submitted in Partial Fulfillment of the\\
    Requirements for the Degree of
    \tpbreak
    \uvic@degreelevel
    \tpbreak
    in the \uvic@department\\
    \vfill
    \begin{center}
      \copyright\ \uvic@author, \uvic@year \linebreak
      \phantom{\copyright} University of Victoria
    \end{center}
    \uvic@copyright
    \vspace{1.5\baselineskip}
    \par
    % Territorial acknowledgement, wording and markup as provided by UVic
    % (\textschwa and \textipa{\ng} replaced by \uvic@schwa and \uvic@eng
    % so that it works with every TeX engine)
    {\centering
    We acknowledge and respect the
    L\uvic@schwa $\stackrel{\textrm{,}}{\textrm{k}}$\textsuperscript{w}\uvic@schwa
    \uvic@eng\uvic@schwa n (Songhees and X\textsuperscript{w}seps\uvic@schwa
    m/Esquimalt) Peoples on whose territory the university stands, and the
    L\uvic@schwa $\stackrel{\textrm{,}}{\textrm{k}}$\textsuperscript{w}\uvic@schwa
    \uvic@eng\uvic@schwa n and \b WS\'ANE\'C Peoples whose historical
    relationships with the land continue to this day.
    \par}
  }%
  \pagebreak
  %
  % ---- Supervisory Committee page ----
  \newpage
  \TOCadd{Supervisory Committee}
  {%
    \centering
    \uvic@title
    \tpbreak
    by
    \tpbreak
    \uvic@nameanddegrees
    \tpbreak
  }%
  \vfill
  \noindent\textbf{Supervisory Committee}
  \tpbreak
  \uvic@committee
  \vfill
  \pagebreak
  %
  % ---- User-content front matter ----
  \input{frontmatter/abstract}%
  %
  % ---- Tables of Contents / Figures / Tables ----
  \renewcommand{\contentsname}{Table of Contents}%
  \TOCadd{Table of Contents}\tableofcontents
  \ifuvicopt@listoftables
    \renewcommand{\listtablename}{List of Tables}%
    \TOCadd{List of Tables}\listoftables
  \fi
  \ifuvicopt@listoffigures
    \setcounter{lofdepth}{2}%
    \renewcommand{\listfigurename}{List of Figures}%
    \TOCadd{List of Figures}\listoffigures
  \fi
  %
  % Further lists (abbreviations, acronyms, symbols, glossary) are optional
  % and come after the List of Figures; included only if the file exists
  \IfFileExists{frontmatter/abbreviations.tex}{\input{frontmatter/abbreviations}}{}%
  %
  % Acknowledgements and dedication are optional (UVic): delete the file
  % to leave the page out
  \IfFileExists{frontmatter/acknowledgements.tex}{\input{frontmatter/acknowledgements}}{}%
  \IfFileExists{frontmatter/dedications.tex}{\input{frontmatter/dedications}}{}%
  %
  % Switch to arabic page numbering for main body
  \newpage
  \pagestyle{fancy}
  \fancyhf{}
  \fancyhead[R]{\thepage}
  \fancyfoot[C]{\uvic@draft@footer}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \pagenumbering{arabic}
  % Chapter opening pages are set to \thispagestyle{plain} by the book
  % class automatically; page 1 (first chapter) suppresses its number.
  \fancypagestyle{plain}{%
    \fancyhf{}%
    \fancyhead[R]{\ifnum\thepage=1\relax\else\thepage\fi}%
    \fancyfoot[C]{\uvic@draft@footer}%
    \renewcommand{\headrulewidth}{0pt}%
    \renewcommand{\footrulewidth}{0pt}%
  }%
}
