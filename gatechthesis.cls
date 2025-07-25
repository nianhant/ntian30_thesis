% gatechthesis class - for use in preparation of Theses and Dissertations at Georgia Tech
% revised May 2020 
% revised Jan 2024

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gatechthesis}[2020/05/07 GA Tech MS/PhD Thesis Class]

% based on report class, so pass options to it
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass{report}

% package imports - add your own in preamble to the document file with \usepackage{}
\RequirePackage{graphicx}  % for images and plots
\RequirePackage[letterpaper, left=1.5in, right=1in, top=1in, bottom=1in]{geometry}
\RequirePackage{multicol} % for multicolumn environments
\RequirePackage{setspace}  % use this package to set linespacing as desired
\RequirePackage{times} % use times new roman font
\RequirePackage[explicit]{titlesec}  % title control and formatting
\RequirePackage[titles]{tocloft}  % table of contents control and formatting
\RequirePackage{ifoddpage} % logical page parity checking, used with rotating
\RequirePackage{rotating}  % for rotated, landscape images
\RequirePackage[backend=biber,sorting=none,bibstyle=ieee]{biblatex}  % reference manager
\RequirePackage[toc,page]{appendix}  % for appendices
\RequirePackage[normalem]{ulem}  % for underlining text
\RequirePackage{url} % in case explicit URL's are needed
\RequirePackage{siunitx} % several functions related to expressing units
\RequirePackage[bookmarks=true,hidelinks]{hyperref} % should be last(ish)
\RequirePackage{bookmark} % allows reformatting of pdf bookmarks
\RequirePackage{caption} % captions for figures
\RequirePackage{subcaption} % allows subfigures in a reasonable way, plays nice with caption
\RequirePackage[acronym,nogroupskip,nopostdot]{glossaries} % only for list of acronyms
\RequirePackage{doi} % and this is laster, makes easier hyperlinking for doi sources
\RequirePackage{float}

\sisetup{
    sticky-per=true,
    detect-mode=true,
    per-mode = symbol-or-fraction
}

\doublespacing  % set line spacing
\AtBeginDocument{\renewcommand{\ref}[1]{\autoref{#1}}} % for concision, but can be removed if you know what you're doing
\makeglossaries % process glossaries
\urlstyle{same} % uses the text font, not a monospace one, for URLs
\hbadness=9000 % suppress some hbox warnings
\setcounter{biburlnumpenalty}{99999} % ensure bibliography URLs don't run far outside margins)

% hyperlink coloring, or lack thereof
\hypersetup{
    colorlinks,
    linkcolor={black},
    citecolor={black}, 
    urlcolor={black}
}

\makeatletter

% formatting of chapter numbers in bookmarks
\bookmarksetup{%
    depth=1, % bookmark depth - 1 goes to section depth, 2 to subsection, etc.
    addtohook={%
    \ifnum 0=\bookmarkget{level}\relax
      \renewcommand*{\numberline}[1]{#1 | }%
    \fi
    \ifnum 0<\bookmarkget{level}\relax
      \renewcommand*{\numberline}[1]{}%
    \fi
    }
}

% so that using ref with algorithms works correctly
\newcommand{\ALC@uniqueautorefname}{Line}
\newcommand{\algorithmautorefname}{Algorithm}

% set up rotatepage environment - this will make landscape figures with awareness of page parity and whether the document is set up as single- or two-sided
\@ifclasswith{report}{twoside}{%
    \newenvironment{rotatepage}{%
        \checkoddpage\ifoddpage
            \clearpage\pagebreak[4]\global\pdfpageattr\expandafter{\the\pdfpageattr/Rotate 270}%
        \else
            \clearpage\pagebreak[4]\global\pdfpageattr\expandafter{\the\pdfpageattr/Rotate 90}%
        \fi
        }%
        {\clearpage\pagebreak[4]\global\pdfpageattr\expandafter{\the\pdfpageattr/Rotate 0}}%
    }{
    \newenvironment{rotatepage}%
        {\clearpage\pagebreak[4]\global\pdfpageattr\expandafter{\the\pdfpageattr/Rotate 90}}%
        {\clearpage\pagebreak[4]\global\pdfpageattr\expandafter{\the\pdfpageattr/Rotate 0}}%
    }

% tokens for author info
\newcommand{\approvaldate}[1]{\gdef\@approvaldate{#1}}%
\newcommand{\@approvaldate}{\@latex@warning@no@line{No \noexpand\approvaldate given}}
\newcommand{\school}[1]{\gdef\@school{#1}}%
\newcommand{\@school}{\@latex@warning@no@line{No \noexpand\school given}}
\newcommand{\department}[1]{\gdef\@department{#1}}%
\newcommand{\@department}{\@latex@warning@no@line{No \noexpand\department given}}
\newcommand{\degree}[1]{\gdef\@degree{#1}}%
\newcommand{\@degree}{\@latex@warning@no@line{No \noexpand\degree given}}
\makeatother

% frontmatter environment, only handles title formatting
\newenvironment{frontmatter}{%
    \clearpage
    \pagestyle{plain}
    \titleformat{\chapter}[display]{\normalfont\bfseries\filcenter}{\chaptertitlename\ \thechapter}{0pt}{\MakeUppercase{##1}}
}%
{%
    \clearpage
}

% thesisbody environment, handles text and other formatting 
\newenvironment{thesisbody}{%
    \clearpage
    \pagestyle{plain}
    \pagenumbering{arabic} % resumes page numbering after front matter
    \setcounter{page}{1} % set the page number appropriately
    \titleformat{\chapter}[display]{\normalfont\bfseries\filcenter}{\MakeUppercase\chaptertitlename\ \thechapter}{0pt}{\MakeUppercase{##1}}  % spacing between titles
    \titlespacing*{\chapter}
      {0pt}{0pt}{30pt}	% controls vertical margins on title
    \titleformat{\section}{\normalfont\bfseries}{\thesection}{1em}{##1}
    \titleformat{\subsection}{\normalfont}{\uline{\thesubsection}}{0em}{\uline{\mbox{\hspace{1em}}##1}}
    \titleformat{\subsubsection}{\normalfont\itshape}{\thesubsection}{1em}{##1}
}%
{
    \clearpage
}

% ------------------ Title Page ------------------
\makeatletter
% args: {month}{year}
\newcommand{\makeTitlePage}[2]{
    \pagestyle{empty}
    \pagenumbering{roman}
    \currentpdfbookmark{Title Page}{titlePage}
    \phantomsection
    \begin{center}
    \begin{singlespacing}
    \textbf{\MakeUppercase{\@title}}\\
    \vspace{10\baselineskip}
    A Dissertation\\
    Presented to\\
    The Academic Faculty\\
    \vspace{3\baselineskip}
    By\\
    \vspace{3\baselineskip}
    \@author\\
    \vspace{3\baselineskip}
    In Partial Fulfillment\\
    of the Requirements for the Degree\\
    \@degree{} in the\\
    \@school\\
    \@department\\ 
    \vspace{3\baselineskip}
    Georgia Institute of Technology\\
    \vspace{\baselineskip}
    #1 \ #2
    \vfill
    \copyright \ \@author \ #2
    \end{singlespacing}
    \end{center}
}

% ------------------ approval page environment/formatting ------------------

% If for whatever reason your approval page looks odd, comment out the lines below and use the page from the old template. But this approach *should* work.
% the following lines are solely a trick to make the approval page multicolumn environment work right (thanks LaTeX stackexchange contributors)
\let\multicolmulticols\multicols
\let\endmulticolmulticols\endmulticols
\RenewDocumentEnvironment{multicols}{mO{}}
 {%
  \ifnum#1=1
    #2%
  \else % More than 1 column
    \multicolmulticols{#1}[#2]
  \fi
 }
 {%
  \ifnum#1=1
  \else % More than 1 column
    \endmulticolmulticols
  \fi
 }
 % ------ end little trick ------

\newenvironment{approvalPage}[1]%
{%
\clearpage
\columnsep=30pt
\begin{singlespacing}
\begin{center}
\textbf{\MakeUppercase{\@title}}\\
\end{center}
\vfill
% minipages depending on number of committee members
\ifnum#1>3
    \begin{minipage}[b]{\textwidth}
    Thesis committee: \\
    \begin{multicols}{2}
\else
    \hspace{0.5\textwidth}
    \begin{minipage}[b]{0.5\textwidth}
    Thesis committee: \\
    \begin{multicols}{1}
\fi
}%
{%
\end{multicols}
\end{minipage}
\begin{flushright}
Date approved: \@approvaldate
\end{flushright}
\end{singlespacing}
}

\newcommand{\committeeMember}[3]{
    \filbreak
    #1 \\
    #2 \\
    \textit{#3} \\
    \\
}
\makeatother

% ------------------ Epigraph ------------------
\newcommand{\makeEpigraph}[2]{
\clearpage
\begin{center}
\vspace*{\fill}
#1\\
\textit{#2}
\vspace*{\fill}
\end{center}
}

% ------------------ Dedication ------------------
\newcommand{\makeDedication}[1]{
\clearpage
\begin{center}
\vspace*{\fill}
#1\\
\vspace*{\fill}
\end{center}
}

% ------------------ Acknowledgments environment/formatting ------------------
\newenvironment{acknowledgments}{
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{Acknowledgments}
    \begin{centering}
    \textbf{ACKNOWLEDGMENTS}\\
    \vspace{\baselineskip}
    \end{centering}
}{
    \clearpage
}

% ------------------ summary environment definition ------------------
\newenvironment{summary}{
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{Summary} 
    \begin{centering}
    \textbf{SUMMARY}\\
    \vspace{\baselineskip}
    \end{centering}
}{
}

% --------------- table of contents formatting and command creation ---------------
\renewcommand{\cftchapdotsep}{\cftdotsep}  % add dot separators
\renewcommand{\cftchapfont}{\bfseries}  % set title font weight
\renewcommand{\cftchappagefont}{}  % set page number font weight
\renewcommand{\cftchappresnum}{Chapter }
\renewcommand{\cftchapaftersnum}{:}
\renewcommand{\cftchapnumwidth}{5em}
\renewcommand{\cftchapafterpnum}{\vskip\baselineskip} % set correct spacing for entries in single space environment
\renewcommand{\cftsecafterpnum}{\vskip\baselineskip}  % set correct spacing for entries in single space environment
\renewcommand{\cftsubsecafterpnum}{\vskip\baselineskip} % set correct spacing for entries in single space environment
\renewcommand{\cftsubsubsecafterpnum}{\vskip\baselineskip} % set correct spacing for entries in single space environment
\newcommand{\makeTOC}{
    % format title font size and position (this also applies to list of figures and list of tables)
    \currentpdfbookmark{Table of Contents}{TOC}
    \renewcommand\contentsname{Table of Contents}
    \begin{singlespace}
    \tableofcontents
    \end{singlespace}
    \clearpage
}

% ------------------ List of Tables ------------------
\newcommand{\makeListOfTables}{
\phantomsection
\addcontentsline{toc}{chapter}{List of Tables}
\begin{singlespace}
\setlength\cftbeforetabskip{\baselineskip}  % manually set spacing between entries
\listoftables
\end{singlespace}
\clearpage
}

% ------------------ List of Figures ------------------
\newcommand{\makeListOfFigures}{
\phantomsection
\addcontentsline{toc}{chapter}{List of Figures}
\begin{singlespace}
\setlength\cftbeforefigskip{\baselineskip}  % manually set spacing between entries
\listoffigures
\end{singlespace}
\clearpage
}

% ------------------ List of Acronyms ------------------
\newcommand{\makeListOfAcronyms}{
\phantomsection
\singlespacing
\addcontentsline{toc}{chapter}{List of Acronyms}
\printacronyms[nonumberlist,title={List of Acronyms}]
\clearpage
\doublespacing
}

% ------------------ appendix environment definition ------------------
% A note on layout: in the Chicago (and by extension IEEE) style manual, appendices are first in the end matter, then bibliography or references. In APA, bibliography is first, then appendices. The thesis manual on which this template is based assumes the Chicago convention.

% remove the page number on the appendices cover and move bookmark up the page, create a group-subgroup structure for the appendices in the TOC/bookmarks
\makeatletter
\newenvironment{theappendices}{
    \bookmarksetup{depth=0,open}
    \addtocontents{toc}{\protect\setcounter{tocdepth}{1}}
    \renewcommand{\@chap@pppage}{%
        \clear@ppage
        \addappheadtotoc
        \thispagestyle{empty}%
        \if@twocolumn\onecolumn\@tempswatrue\else\@tempswafalse\fi
        \null\vfil
        \markboth{}{}%
        {\centering
        \interlinepenalty \@M
        \normalfont
        \Huge \bfseries \appendixpagename\par}%
        \if@dotoc@pp
        \fi
    }
    \bookmarksetupnext{level=part}
    \begin{appendices}
    \addtocontents{toc}{\protect\renewcommand{\protect\cftsecpresnum}{\appendixname\space}}
    \addtocontents{toc}{\protect\renewcommand{\protect\cftsecnumwidth}{5.75em}}
    \addtocontents{toc}{\protect\renewcommand{\protect\cftsecaftersnum}{:}}
    \addtocontents{toc}{%
    \begingroup
        \let\protect\l@chapter\protect\l@section
        \let\protect\l@section\protect\l@subsection
    }
}{
    \addtocontents{toc}{\endgroup}
    \end{appendices}
}
\makeatother

% ------------------ bibliography formatting and command creation ------------------

% I am only leaving these \AtEveryBibitem lines in because they were in the original template when I downloaded it. Change these at your own leisure.

% prevent certain fields in references from printing in bibliography
\AtEveryBibitem{\clearfield{issn}}
\AtEveryBibitem{\clearlist{issn}}
\AtEveryBibitem{\clearfield{language}}
\AtEveryBibitem{\clearlist{language}}
\AtEveryBibitem{\clearfield{doi}}
\AtEveryBibitem{\clearlist{doi}}
\AtEveryBibitem{\clearfield{url}}
\AtEveryBibitem{\clearlist{url}}
\AtEveryBibitem{%
\ifentrytype{online}{}
    {\clearfield{urlyear}\clearfield{urlmonth}\clearfield{urlday}}}

\newcommand{\makeBibliography}{
    \clearpage
    \bookmarksetupnext{level=part}
    \phantomsection
    \addcontentsline{toc}{chapter}{References}
    \begin{centering}
    \textbf{REFERENCES}\\
    \end{centering}
    \begin{singlespace}  % use single-line spacing for multi-line text within a single reference
    \setlength\bibitemsep{\baselineskip}  % manually set separation between items in bibliography to double space
    \printbibliography[heading=none]
    \end{singlespace}
}

% ------------------ vita environment ------------------
\newenvironment{vita}{
    \bookmarksetupnext{level=part}
    \chapter*{Vita}
    \addcontentsline{toc}{chapter}{Vita}
}{
}

% ------------- table captions -------------
% Forces all table captions to the top
\floatstyle{plaintop}
\restylefloat{table}