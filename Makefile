#author: Polonio Davide <poloniodavide@gmail.com>
#license: MIT

include common/make/flags.inc

FOLDERS= internal official presentations


all: $(FOLDERS)
	echo "All documents were build successfully"

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