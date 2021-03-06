#!/bin/bash

# fail if any line fails
set -e

cd ModelCatalogueCorePlugin
npm install
bower install

./grailsw clean-all
./grailsw refresh-dependencies
./grailsw test-app unit:
./grailsw test-app integration: org.modelcatalogue.**.*
./node_modules/karma/bin/karma start --single-run --browsers Firefox

cd ..
