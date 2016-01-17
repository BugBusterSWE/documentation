#!/bin/bash

# Simple UCManager.
# @author Polonio Davide poloniodavide@gmail.com

###CONFIGURARION VARIABLE###
VERBOSE=1
DEBUG=1
VERSION=0.0.1
PROGRAM="emacs -nw"
###ENDO CONFIGURATION###

function msg() {
	 #filter for messages
	 if [ $1 == "e" ]
	 then
	     # "!!!" red and blinking
	     echo -e "\e[5m\e[31m !!!\e[0m\e[25m $2"
	 fi

	 if [ $1 == "v" -a $VERBOSE -eq 1 ]
	 then
	     echo -e "\e[92m ***\e[0m $2"
	 fi

	 if [ $1 == "d" -a $DEBUG -eq 1 ]
	 then
	     echo -e "\e[33m @@@\e[0m $2"
	 fi  
}

function show_help() {

    echo <<EOF
UCManager, version $VERSION

usage: UCManger.sh [options]

Options:
-a"[argument]" Append UC in the end of [argument] file.
-h Show this help and exit
-d Override debug configuration
-v Override verbose configuration

EOF
}

function add_UC() {

    #empty if no argument is provided
    local TEX_PATH=$1
    local IMG_PATH=
    local UC_ID=
    local UC_NAME=
    local ACTOR=
    local PURPOSE=
    local PRE=
    local POST=
    local FLUX=
    local EXTENSION=
    local INCLUSION=

    #this make no sense for now
    if [ -z $TEX_PATH ]
    then
	msg v "Insert a tex path"
	read new_read
	TEX_PATH=$new_read
    fi

    if [ -z $IMG_PATH ]
    then
	msg v "Insert a img path (only in res/img/)"
	read new_read
	IMG_PATH=$new_read
    fi

    if [ -z $UC_ID ]
    then
	msg v "Insert a UC Id (e.g. UC-E0)"
	read new_read
	UC_ID=$new_read
    fi

    if [ -z $UC_NAME ]
    then
	msg v "Insert a UC Name"
	read new_read
	UC_NAME=$new_read
    fi

    if [ -z $ACTOR ]
    then
	msg v "Insert a list of actors"
	read new_read
	ACTOR=$new_read
    fi

    if [ -z $PURPOSE ]
    then
	msg v "Insert a purpose. $PROGRAM will be used"
	sleep 1
        $PROGRAM /tmp/purpose_$UC_ID
	PURPOSE=$(</tmp/purpose_$UC_ID)
    fi

    
    if [ -z $PRE ]
    then
	msg v "Insert a pre. $PROGRAM will be used"
	sleep 1
        $PROGRAM /tmp/pre_$UC_ID
        PRE=$(</tmp/pre_$UC_ID)
    fi

    
    if [ -z $POST ]
    then
	msg v "Insert a post. $PROGRAM will be used"
	sleep 1
        $PROGRAM /tmp/post_$UC_ID
        POST=$(</tmp/post_$UC_ID)
    fi
    
    if [ -z $FLUX ]
    then
	msg v "Insert a flux. $PROGRAM will be used"
	sleep 1
        $PROGRAM /tmp/flux_$UC_ID
        FLUX=$(</tmp/flux_$UC_ID)
    fi
    
    if [ -z $EXTENSION ]
    then
	msg v "Insert a extension. $PROGRAM will be used"
	sleep 1
        $PROGRAM /tmp/extension_$UC_ID
        EXTENSION=$(</tmp/extension_$UC_ID)
    fi

    if [ -z $INCLUSION ]
    then
	msg v "Insert a inclusion. $PROGRAM will be used"
	sleep 1
	$PROGRAM /tmp/inclusion_$UC_ID
	INCLUSION=$(</tmp/inclusion_$UC_ID)
    fi

    echo "\subsubsection{$UC_ID}" | tee -a ../RR/AnalisiDeiRequisiti/res/sections/$TEX_PATH

    if [ -z $IMG_PATH ]
    then
	msg v "No image added"
    else
	msg v "Adding image to UC"
	
	echo " 

    \begin{figure}[H]
      \begin{center}
        \includegraphics[width=12cm]{res/img/$IMG_PATH}
      \caption{$UC_ID - $UC_NAME}
      \end{center} 
    \end{figure}" | tee -a ../RR/AnalisiDeiRequisiti/res/sections/$TEX_PATH
    fi

    echo "
    %Tabella 
    \begin{center}
      \bgroup
      \def\arraystretch{1.8}     
      \begin{longtable}{  p{3.5cm} | p{8cm} } 
        
        \hline
        \multicolumn{2}{ | c | }{ \cellcolor[gray]{0.9} \textbf{$UC_ID - $UC_NAME}} \\\\ 
        \hline
        
        \textbf{Attori Primari} & $ACTOR \\\\ 
        \textbf{Scopo e Descrizione} & $PURPOSE \\\\ 
        
        \textbf{Precondizioni}  & $PRE \\\\ 
        
        \textbf{Postcondizioni} & $POST \\\\ 
        \textbf{Flusso Principale} & $FLUX \\\\
        \textbf{Estensioni} & $EXTENSION \\\\
        \textbf{Inclusioni} & $INCLUSION
      \end{longtable}
      \egroup
    \end{center}" | tee -a ../RR/AnalisiDeiRequisiti/res/sections/$TEX_PATH

    local result=$?

    if [ $result -eq 1 ]
    then
	msg e "Si è verificato un errore."
    else
	msg v "Operazione completata"
    fi
}

#parsing arugments
ARGUMENTS=(:a: :h :d :v)

while getopts "echo ${ARGUMENTS[*]}" opt; do
    case $opt in
	a)
	    msg v "Adding Use Case in $OPTARG"
	    add_UC $OPTARG
	    ;;
	v)
	    VERBOSE=1
	    msg v "Verbose mode set to true"
	    ;;
	d)
	    msg v "Debug set to true"
	    DEBUG=1
	    ;;
	h)
	    show_help
	    ;;

	\?)
	    msg e "Invalid option: -$OPTARG"
	    show_help
	    exit 1
	    ;;
	:)
	    msg e "Option -$OPTARG requires an argument."
	    exit 1
	    ;;
    esac
done



unset ARGUMENTS
