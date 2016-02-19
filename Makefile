#author: Polonio Davide <poloniodavide@gmail.com>
#license: MIT

FOLDERS= internal official presentations


all: $(FOLDERS)
	echo "All"

$(FOLDERS):
	cd $@/; \
	make; \
	echo "Make for $@ COMPLETE!"; \
