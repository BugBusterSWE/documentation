#!/bin/bash

function compile(){

    rm main.gl* main.ist glossary.log
    pdflatex \\nonstopmode\\input main.tex >> glossary.log
    
    makeglossaries main >> glossary.log
    pdflatex \\nonstopmode\\input main.tex >> glossary.log

}

function build_xml(){

    perl ../../tools/xml-glossary/glossaryLaTeX/createLaTeX.pl res/glossary.xml res/alphabeticalOrder.xsl
}

#compile
build_xml
