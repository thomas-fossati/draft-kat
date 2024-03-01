.DEFAULT_GOAL := all
MAKECMDGOALS ?= $(.DEFAULT_GOAL)

SUBDIRS := kat
SUBDIRS += pat
SUBDIRS += cab

$(MAKECMDGOALS): ; for d in $(SUBDIRS) ; do $(MAKE) -C $$d $@ ; done
