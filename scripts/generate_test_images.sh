#!/usr/bin/env bash

PROJECT_NAME=TextAttribute
SCHEMA_NAME=TextAttribute

SCRIPT_RELATIVE_PATH=$(dirname $0)
SCRIPT_ABS_PATH="$(cd ${SCRIPT_RELATIVE_PATH}; pwd)"
DERIVED_DATA_PATH=${SCRIPT_ABS_PATH}/derived
IMAGES_OUTPUT_PATH=${DERIVED_DATA_PATH}/images

XCODE_PROJECT_PATH="$(cd ${SCRIPT_ABS_PATH} && cd .. && pwd)"

echo $SCRIPT_ABS_PATH
echo $DERIVED_DATA_PATH
echo $IMAGES_OUTPUT_PATH
echo $XCODE_PROJECT_PATH


#xcodebuild -project ${XCODE_PROJECT_PATH}/${PROJECT_NAME}.xcodeproj -scheme ${SCHEMA_NAME} -derivedDataPath ${DERIVED_DATA_PATH} clean | xcpretty
#xcodebuild -project ${XCODE_PROJECT_PATH}/${PROJECT_NAME}.xcodeproj -scheme ${SCHEMA_NAME} -derivedDataPath ${DERIVED_DATA_PATH} -destination 'platform=iOS Simulator,name=iPhone 11' test | xcpretty \

LATEST_MANIFEST_FILE=`plutil -extract logs xml1 -o - ${DERIVED_DATA_PATH}/Logs/Test/LogStoreManifest.plist | xmllint --xpath 'string(//dict[1]/string[contains(text(),"xcresult")])' -`

echo ${DERIVED_DATA_PATH}/Logs/Test/${LATEST_MANIFEST_FILE}

xcparse screenshots ${DERIVED_DATA_PATH}/Logs/Test/${LATEST_MANIFEST_FILE} $IMAGES_OUTPUT_PATH