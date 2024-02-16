# Start by running: npm install -g typescript && npm install

all: install/app.js install/tsGlue.js install/index.html install/style.css

# Clean.
clean:
	rm -f install/* src/tsGlue.nim tools/dts2nim.js

install/tsGlue.js: src/tsGlue.ts
	tsc

install/app.js: src/app.nim src/tsGlue.nim
	nim js -o:$@ $<

install/index.html: static/index.html
	$(if $(findstring Windows,$(OS)),robocopy,$(CP)) $< $@

install/style.css: static/style.css
	$(if $(findstring Windows,$(OS)),robocopy,$(CP)) $< $@

# Depend on dts2nim binary to force a rebuild after an upgrade
src/tsGlue.nim: src/tsGlue.ts install/tsGlue.js
	node dts2nim.js $< -o $@ -q

tools/dts2nim.js: tools/dts2nim.ts
	tsc -p tools

