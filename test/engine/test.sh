#!/bin/bash

set -e

source dev-container-features-test-lib

check "engine directory exist" cd /usr/lib/axonivy-engine/bin/

reportResults
