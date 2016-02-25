# Generated automatically from Makefile.in by configure.
infodir = $(prefix)/info
srcdir = .
subdir = doc
top_srcdir = ..

TEXI2DVI=texi2dvi
TEXI2PDF=texi2pdf
TEXI2HTML=texi2html
MAKEINFO=makeinfo
PDFLATEX=pdflatex
DVIPS=dvips
DVIPDFM=dvipdfm
INSTALL = /usr/bin/install -c
INSTALL_DATA = ${INSTALL} -m 644
SHELL = /bin/sh
PAPERTYPE=a4
INFO_DEPS=qaos.info
RM = rm -f

all: doc

.SUFFIXES: .texi .dvi .ps .pdf .html .xml .ltx .six .latexi .lat .dvi-x .pdf-x

.texi: .info .dvi .ps .pdf .html .xml

.texi.info:
	if test "x$(MAKEINFO)" != "xno" ; then \
	  LC_ALL=C $(MAKEINFO) -I $(srcdir) --enable-encoding -o $*.info $<; \
	fi

doc:	$(INFO_DEPS) dvi pdf html manual mods

manual: manual.six manual.tex

dvi: qaos.dvi

ps: qaos.dvi qaos.ps

pdf: qaos.dvi qaos.pdf

html: qaos.html

xml: qaos.xml

.texi.dvi :
	$(TEXI2DVI) -I $(srcdir) $*.texi
	$(RM) qaostmp.*

.dvi.ps :
	TEXPICTS=$(srcdir) $(DVIPS) -t $(PAPERTYPE) -f $< > $@

.dvi.pdf :
	$(DVIPDFM) -p $(PAPERTYPE) -o $@ $<

.texi.html :
	gsed -e '/@iflatex/,/@end iflatex/d' $< > qaostmp.texi
	$(TEXI2HTML) -I $(srcdir) qaostmp.texi
	cp qaostmp.html $*.html
	$(RM) qaostmp.*

.texi.xml :
	gsed -e '/@iflatex/,/@end iflatex/d' $< > qaostmp.texi
	$(MAKEINFO) --xml -I $(srcdir) qaostmp.texi
	$(RM) qaostmp.*

xx%.tex:
	gsed xx$* \
	    -e "s/@chapter \(.*\)/\n\n\\\\Chapter{\\1}/" \
	    -e "s/@section \(.*\)/\n\n\\\\Section{\\1}/" \
	    -e "s/@defun \([^ ]*\) \(.*\)/\\\\> \\1 ( \\2 ) F/" \
	    -e "s/@end defun//" \
	    -e "s/@defva*r \([^ ]*\) \(.*\)/\\\\> \\1 [\\2] F/" \
	    -e "s/@end defva*r//" \
	    -e "s/@itemize/\\\\beginlist/" \
	    -e "s/@end itemize/\\\\endlist/" \
	    -e "s/@item/\\\\item{--}/" \
	    -e "s/@example/\\\\beginexample/" \
	    -e "s/@end example/\\\\endexample/" \
	    -e "s/@node.*//" \
	    -e "s/\(@c\|@comment\).*//" \
	    -e "s/@/\\\\/g" \
	  > xx$*.tex
	@grep "@chapter" xx$* | \
	gawk 'BEGIN {} \
	      /^@chapter/ \
	        {sub(/@chapter[[:space:]]+/,"",$$0); \
	         uniqid = $$0; gsub(/[[:space:]]/,"",uniqid); \
	         printf("mv xx$*.tex %1$$s.tex && \
	                 chmod a+rX %1$$s.tex",tolower(uniqid)) | "sh"} \
	      END {close("sh")}'
	$(RM) xx$*

.texi.ltx: .NOTPARALLEL
	gcsplit -k $*.texi "/^@chapter/" {*}
	find . -name "xx*" -exec echo {}.tex \; | xargs $(MAKE)
	$(RM) xx*
	$(RM) $*.ltx
	touch $*.ltx
	echo "\\Package{QaoS}" >> $*.ltx
	echo "\\BeginningOfBook{QaoS}" >> $*.ltx
	echo "\\Chapters" >> $*.ltx
	grep "@chapter" $*.texi | \
	gawk 'BEGIN {} \
	        /^@chapter/ \
	          {sub(/@chapter[[:space:]]+/,"",$$0); \
	           uniqid = $$0; gsub(/[[:space:]]/,"",uniqid); \
	           printf("\\Input{%s}\n",tolower(uniqid)) >> "$*.ltx"}'
	echo "\\EndOfBook" >> $*.ltx
	chmod -R a+rX $*.ltx

manual.tex: qaos.ltx
	cp qaos.ltx manual.tex
	chmod a+rX manual.tex

.texi.six:
	grep "@chapter\|@section\|@defun\|@defva*r" $*.texi | \
	gawk 'BEGIN {cha=0; sec=0} \
	      /^@chapter/ \
	        {sub(/@chapter[[:space:]]+/,"",$$0); \
	         uniqid = $$0; gsub(/[[:space:]]/,"",uniqid); \
	         printf("C %s.tex %d. %s\n",tolower(uniqid),++cha,$$0); sec=0} \
	      /^@section/ \
	        {sub(/@section[[:space:]]+/,"",$$0); \
	         printf("S %d.%d. %s\n",cha,++sec,$$0)} \
	      /^@defun/ \
	        {printf("F %d.%d. %s\n",cha,sec,$$2)}' \
	  > $*.six
	chmod -R a+rX $*.six

manual.six: qaos.six
	cp qaos.six manual.six
	chmod a+rX manual.six

mods:
	chmod a+rX *

clean:
	$(RM) *.[cgk]idx *.aux *.cp *.cps *.dvi *.dvi-x *.fn *.ky	\
	*.kys *.latexi *.log *.orig *.pdf *.pdf-x *.pg *.rej		\
	*.tmplatexi *.toc *.tp *.vr qaos.*.bak qaos.[cgk]ind 	\
	qaos.ilg qaos.ind qaos.latexi*~* qaos.out 	\
	qaos.idx qaos.tmplatexi1 qaostmp.texi texput.log	\
	thumb*.png thumbdta.tex *.tpt *.tmp *.html *.info *.fns \
	*.vrx *.fnx *.tex *.ltx *.xml *.six *.lat xx*
	$(RM) -R auto

makeinfo:
	LC_ALL=C makeinfo --enable-encoding -o qaos.info qaos.texi

# Tell versions [3.59,3.63) of GNU make to not export all variables.
# Otherwise a system limit (for SysV at least) may be exceeded.
.NOEXPORT:
