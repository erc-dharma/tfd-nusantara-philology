# Script for exporting editions as plain text. Run it from the parent directory
# with:
#
#       bash export_plain.sh
#
# This will create a directory "plain" in the parent directory, with the
# editions. You can copy/move this directory somewhere else afterwards.

set -xe

PROJ_DOC=https://github.com/erc-dharma/project-documentation.git
SAXON=project-documentation/schema/validationTools/saxon9.jar
XSLT=project-documentation/stylesheets/criticalEditions/start-txt.xsl
OUT_DIR=plain

if git clone --depth=1 $PROJ_DOC; then
	trap "rm -rf project-documentation" EXIT
else
 	git -C project-documentation pull
fi

mkdir -p $OUT_DIR

for f in editions/*.xml; do
	g=$OUT_DIR/$(basename $f).txt
	java -jar $SAXON -s:$f -xsl:$XSLT -o:$g
done

echo DONE
