#!/bin/bash

function compile(){

    rm main.gl* main.ist glossary.log
    pdflatex \\nonstopmode\\input main.tex >> glossary.log
    
    makeglossaries main >> glossary.log
    pdflatex \\nonstopmode\\input main.tex >> glossary.log

}

compile
