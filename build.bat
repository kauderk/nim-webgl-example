REM MakeFile

REM Start by running: npm install -g typescript && npm install

REM Build all targets
all: install\app.js install\tsGlue.js install\index.html install\style.css

REM Clean
clean:
    del /Q install\* src\tsGlue.nim tools\dts2nim.js

install\tsGlue.js: src\tsGlue.ts
    mkdir $(@D)
    tsc

install\app.js: src\app.nim src\tsGlue.nim
    mkdir $(@D)
    nim js -o:$@ $<

install\index.html: static\index.html
    mkdir $(@D)
    copy $< $@

install\style.css: static\style.css
    mkdir $(@D)
    copy $< $@

REM Depend on dts2nim binary to force a rebuild after an upgrade
src\tsGlue.nim: src\tsGlue.ts install\tsGlue.js
    node dts2nim.js $< -o $@ -q

tools\dts2nim.js: tools\dts2nim.ts
    tsc -p tools
