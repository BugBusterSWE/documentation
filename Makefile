#author: Polonio Davide <poloniodavide@gmail.com>
#license: MIT

include common/make/flags.inc

FOLDERS= internal official presentations

PATH_ZIP= out/
RELEASE_NAME= release


all: $(FOLDERS)
	echo "All documents were built successfully"

zip: $(FOLDERS)
	mkdir $(PATH_ZIP)
	mkdir $(PATH_ZIP)Interni/
	mkdir $(PATH_ZIP)Esterni/
	set -e; \
	for i in $(wildcard official/*/*.pdf); do \
		pathFile=`dirname $$i`; \
		nameFile=`basename \`dirname $$i\``; \
		if [ "$$pathFile" == "official/NormeDiProgetto" ]; then \
			cp $$i $(PATH_ZIP)Interni/$$nameFile.pdf; \
		else \
			cp $$i $(PATH_ZIP)Esterni/$$nameFile.pdf; \
		fi; \
	done; \
	$(ZIP) $(ZIPFLAGS) $(RELEASE_NAME).zip $(PATH_ZIP)*

clean:
	rm -rf $(PATH_ZIP) $(RELEASE_NAME)*
	echo "pdf builds are automatically cleaned when another make is called"

$(FOLDERS):
	set -e; \
	for i in $(sort $(dir $(wildcard $@/*/))); do \
		echo ""; \
		echo ""; \
		echo "###################################################"; \
		echo "Document: $$i"; \
		bak=$(shell pwd); \
		cd $$i; \
		if [ "$$i" != "official/Glossario/" ]; then \
			echo "****Compilation with $(CC). Flags: $(CCFLAGS)****"; \
			$(CC) -C; \
			$(CC) $(CCFLAGS); \
		else \
			echo "****This is the glossary, calling \"build.sh\" script****"; \
			bash build.sh; \
		fi; \
		cd $$bak; \
	done; \
	echo "!!! Make for $@ COMPLETE! !!!"; \
	echo ""; \
