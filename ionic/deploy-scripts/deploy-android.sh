#!/bin/bash

# get last tag version number
current_tag=$(git describe --abbrev=0 --tags)
echo "Current tag: $current_tag"

# APP_ID can be located by selecting your app on HockeyApp's dashboard. 
APP_ID=60c8a381d5e24962b3f4c6e970fcc7fe

# The API_TOKEN is located in HockeyApp's Account Settings > API Tokens
API_TOKEN=d80290f380ff4399a8d89dacc78212e2

# APP_FILE should match the desired apk file in platforms/android/build/outputs/apk. 
APP_FILE="Ionic App"

TEAMID=60527


# push the app to HockeyApp [Additional API parameters: http://support.hockeyapp.net/kb/api/api-apps#upload-app]
response=$(curl \
  -F "status=2" \
  -F "notify=1" \
  -F "teams=$TEAMID" \
  -F "notes=Version v$current_tag" \
  -F "version=$current_tag" \
  -F "shortversion=0.1.$current_tag" \
  -F "ipa=@./platforms/android/build/outputs/apk/$APP_FILE.apk" \
  -H "X-HockeyAppToken:$API_TOKEN" \
  https://rink.hockeyapp.net/api/2/apps/$APP_ID/app_versions/upload)

# Pretty prints the JSON object
echo "$response" | python -m json.tool
linkobj=$(echo "$response" | python -m json.tool)

# Publish build information to the HipChat project room
# ROOM_ID can be found at https://cohaesus.hipchat.com/rooms
# AUTH_TOKEN can be found in the Shared-Cohaesus General Passwords folder in LastPass (hipchat auth token) 
ROOM_ID=2441414
AUTH_TOKEN=84c3fe7cf3785dc58ad1997e119136
MESSAGE="Android Build $current_tag published: $linkobj"

echo $(curl \
	-v -L -G \
	-d "room_id=$ROOM_ID&from=IonicApp"	\
	--data-urlencode "message=$MESSAGE"	\
  -d "message_format=text" \
	"https://api.hipchat.com/v1/rooms/message?auth_token=${AUTH_TOKEN}"
)