;; tex
\author{{{_author_}}}

\documentclass[a4paper, 11pt]{article}
\usepackage[T1]{fontenc}
\usepackage[french]{babel}
\usepackage{tcolorbox}
\usepackage[margin=2cm]{geometry}
\usepackage{pgfplots}
\pgfplotsset{compat=1.18}
\usepackage{graphicx, float}
\graphicspath{{figures/}}
\usepackage{amsmath, amssymb, amsthm}
\usepackage{hyperref}

\newtcolorbox{df}[1]{colback=red!5!white, colframe=red!75!black,fonttitle=\bfseries,title={Définition : #1}}
\newtcolorbox{pp}[1]{colback=red!5!white, colframe=blue!75!black,fonttitle=\bfseries,title={Propriété : #1}}
\newtcolorbox{nt}[1]{colback=red!5!white, colframe=white!50!black,fonttitle=\bfseries,title={Note : #1}}
\newtcolorbox{ex}[1]{colback=red!5!white, colframe=yellow!75!black,fonttitle=\bfseries,title={Exemple : #1}}
\newtcolorbox{sol}[1]{colback=red!5!white, colframe=green!75!black,fonttitle=\bfseries,title={Solution : #1}}



\begin{document}
\title{{{_file_name_}}}
\maketitle

\newpage
\tableofcontents
\newpage

{{_cursor_}}

 
\end{document}
