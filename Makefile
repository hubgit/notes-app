.PHONY: clean lint build deploy serve dist-clean

all: build lint

clean:
	rm -rf build

# use npm run build to map paths instead?
build: clean
	cp -r app build
	node_modules/vulcanize/bin/vulcanize --inline-scripts --inline-css --strip-comments app/app.html --out-html build/app.html
	node_modules/crisper/bin/crisper --source build/app.html --html build/app.html --js build/app.js
	rm -rf build/bower_components

lint:
#	polylint --root build/ --input app.html
#	standard

deploy: build lint
	firebase deploy --public build

serve:
	firebase serve
	open http://localhost:5000/

dist-clean: clean
	rm -rf node_modules
	rm -rf app/bower_components
