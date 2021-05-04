OUTPUT_JAR := sqleet2020-evplus-ndk-driver.jar

SQLEET_TAG := v0.31.1

SQLEET_PATH := sqleet-$(SQLEET_TAG)

SQLEET_DOWNLOAD_URL := https://github.com/resilar/sqleet/releases/download/$(SQLEET_TAG)/sqleet-$(SQLEET_TAG)-amalgamation.zip

SQLEET_ZIP := sqleet-$(SQLEET_TAG)-amalgamation.zip

SQLEET_AMALGAMATION := sqleet-amalgamation

all: init $(SQLEET_AMALGAMATION) ndkbuild

init:
	git submodule update --init

$(SQLEET_PATH):
	curl -OL $(SQLEET_DOWNLOAD_URL)
	unzip $(SQLEET_ZIP)

$(SQLEET_AMALGAMATION): $(SQLEET_PATH)
	ln -s $(SQLEET_PATH) $(SQLEET_AMALGAMATION)

regen:
	java -cp gluegentools/antlr.jar:gluegentools/gluegen.jar com.jogamp.gluegen.GlueGen -I. -Ecom.jogamp.gluegen.JavaEmitter -CEVNDKDriver.cfg native/sqlc.h
	sed -i.orig 's/^import/\/\/import/' java/io/sqlc/EVNDKDriver.java
	sed -i.orig 's/ $$//g' native/EV*.c

ndkbuild:
	rm -rf lib libs *.jar
	javac -d .  java/io/sqlc/*.java
	ndk-build
	cp -r libs lib
	jar cf $(OUTPUT_JAR) io lib

clean:
	rm -rf java/io/sqlc/*.orig native/*.orig io obj lib libs *.jar *.zip *.jar
	rm -rf sqleet-*
