#!/bin/sh

: ${TRAVIS_REPO_SLUG="epfl-dias/${PROJECT}"}

if [ -z ${GH_TOKEN+yes} ]; then
    echo "GH_TOKEN unset, exiting..."
    exit 1
fi

if [ -z ${PROJECT+yes} ]; then
    echo "PROJECT unset, exiting..."
    exit 1
fi

# Generate the documentation
cargo doc --release --target-dir=target

cat > target/doc/index.html <<EOT
<meta http-equiv=refresh content=0;url=${PROJECT}/index.html>
EOT

# If a book folder exists, and mdbook is available, build it.
if /usr/bin/which -s mdbook && test -d book; then
    mdbook build --dest-dir ../target/doc/book book
fi

# Upload it to GitHub.
MSG=$(git log -1 --pretty=format:'doc: %ci: %h - %s')
[ -e ../ghp-import/ghp_import.py ] || git clone https://github.com/davisp/ghp-import.git ../ghp-import
../ghp-import/ghp_import.py -n -p -f \
    -m "${MSG}" \
    -r "https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git" \
    target/doc
