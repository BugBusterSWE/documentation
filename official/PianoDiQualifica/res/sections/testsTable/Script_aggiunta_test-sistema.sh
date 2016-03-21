#!/bin/sh
while true;
	do echo "codice: ";
	read _cr;
	echo desc;
	read _cd;
	echo "TS-R1D $_cr & $_cd & N.E & R1D $_cr \tabularnewline \hline" >> part3.tex;
	git add part3.tex;
	git commit -m "Add requirement R1D $_cr on issue #115";
done
