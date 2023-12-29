#!/bin/sh
set -e

echo "Activating feature 'hello'"

echo "The effective dev container remoteUser is '$_REMOTE_USER'"
echo "The effective dev container remoteUser's home directory is '$_REMOTE_USER_HOME'"

echo "The effective dev container containerUser is '$_CONTAINER_USER'"
echo "The effective dev container containerUser's home directory is '$_CONTAINER_USER_HOME'"

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        apt_get_update
        apt-get -y install --no-install-recommends "$@"
    fi
}

check_packages wget unzip

wget ${IVY_ENGINE_DOWNLOAD_URL} -O /tmp/ivy.zip --no-verbose
unzip /tmp/ivy.zip -d ${IVY_HOME}
rm -f /tmp/ivy.zip
    
    
mkdir ${IVY_HOME}/applications
mkdir ${IVY_HOME}/configuration/applications && \
chown -R vscode:0 ${IVY_HOME} && \
chmod -R g=u ${IVY_HOME}
