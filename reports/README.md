---
output: 
  pdf_document:
    citation_package: natbib
    keep_tex: true
    fig_caption: true
    latex_engine: pdflatex
    template: template.tex
bibliography: master.bib
header-includes:
  -  \usepackage{hyperref}
  - \usepackage{array}   
  - \usepackage{caption}
  - \usepackage{graphicx}
  - \usepackage{siunitx}
  - \usepackage[table]{xcolor}
  - \usepackage{multirow}
  - \usepackage{hhline}
  - \usepackage{calc}
  - \usepackage{tabularx}
  - \usepackage{fontawesome}
  - \usepackage[para,online,flushleft]{threeparttable}
biblio-style: apsr
title: "CSC8631 Coursework Assignment"
author:
- name: Mariela Ayu Prasetyo (210407835)
  affiliation: Newcastle University
date: "`r format(Sys.time(), '%B %d, %Y')`"
geometry: margin=1in
fontfamily: libertine
fontsize: 12pt
# spacing: double
endnote: no
---

