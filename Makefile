.PHONY: clean lint build deploy serve

all: build

clean:
	rm -rf build

lint:
	-node_modules/polylint/bin/polylint.js --root app/ --input notes-app.html
	node_modules/standard/bin/cmd.js

build: clean lint
	cp -r app build
	node_modules/vulcanize/bin/vulcanize --inline-scripts --inline-css app/notes-app.html -o build/notes-app.html

deploy: build
	firebase deploy --public build

serve:
	firebase serve

install:
	npm install
	bower install
