
.DELETE_ON_ERROR:

dist.html: readability-bookmarklet.js make-html.sh
	./make-html.sh $< > $@

