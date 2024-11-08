#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
echo "Downloading dependencies"
curl -O https://estaticos.redsara.es/comunes/autofirma/currentversion/AutoFirma_Linux_Fedora.zip
curl -L https://raw.githubusercontent.com/franute/ublue-nimbus/main/configs/scripts/autofirma.md5 > autofirma.md5
unzip AutoFirma_Linux_Fedora.zip

if md5sum -c autofirma.md5 > /dev/null; then
    echo "MD5Sum validated, installing autofirma."
    rpm-ostree install -y ./autofirma-1.8.3-1.noarch_FEDORA.rpm
else
    echo "Incorrect MD5Sum"
fi

### Cleanup ###
echo "Deleting downloaded files"
rm autofirma.md5
rm AutoFirma_Linux_Fedora.zip
rm autofirma-1.8.3-1.noarch_FEDORA.rpm