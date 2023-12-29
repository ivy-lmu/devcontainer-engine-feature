#!/bin/sh
set -e

apt_get_update() {
  if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
    echo "Running apt-get update..."
    apt-get update -y
  fi
}

check_packages() {
  if ! dpkg -s "$@" > /dev/null 2>&1; then
    apt_get_update
    apt-get -y install --no-install-recommends "$@"
  fi
}

echo "Installing wget if needed."
check_packages wget unzip

echo "Downloading Axon Ivy Engine from '$DOWNLOADURL'"
wget ${DOWNLOADURL} -O /tmp/ivy.zip --no-verbose

echo "Unziping Axon Ivy Engine to '$ENGINEHOME'"
unzip /tmp/ivy.zip -d ${ENGINEHOME}
rm -f /tmp/ivy.zip

mkdir ${ENGINEHOME}/applications
mkdir ${ENGINEHOME}/configuration/applications && \
chown -R ${_REMOTE_USER}:0 ${ENGINEHOME} && \
chmod -R g=u ${ENGINEHOME}
