# banana (333)
==================

# Initial Setup
Ensure the following are up to date:
- [homebrew] (http://brew.sh/)
- [node / npm] (https://nodejs.org/en/download/)
- [xcode] (https://developer.apple.com/xcode/download/)

Fork the project template from Github and install the following:
- `$ sudo npm install -g gulp bower cucumber cordova ionic strongloop`
- `$ sudo npm install` (to get all the dependencies)
- `$ gulp scripts`. Running this will generate your dist folder in ionic/www

To create a new project, you can follow Ionic's [installation guide] (http://ionicframework.com/docs/guide/installation.html).

## Configure Platforms

### iOS [[Instructions]] (https://cordova.apache.org/docs/en/latest/guide/platforms/ios/index.html)
- You don't need to run `$ cordova create hello com.example.hello "HelloWorld"`, since we have already created a project. 

### Android [[**Android**]] (http://cordova.apache.org/docs/en/3.4.0/guide/platforms/android/index.html#Android%20Platform%20Guide)
- Download [SDK Tools] (http://developer.android.com/sdk/index.html#Other)  
- Download [Java for OSX 2015-001] (https://support.apple.com/kb/DL1572?locale=en_US).
- Download [Java for OSX] (http://www.java.com/en/download/mac_download.jsp)
- Run the android file (found in android-sdk-macosx > tools). Install your desired Android SDK Platform(s) [ensure the SDK Platform and the System Image boxes are checked], Android SDK Tools, Android SDK Build Tools (>= v19.1.0), SDK Platform Tools and Android Support Repository (found in Extras).
- Update PATH in `~./bash_profile` to point to the android SDK. Use the following command to open the profile in the default text editor `$ touch ~/.bash_profile; open ~/.bash_profile`. Update the PATH to `export PATH=${PATH}:/Users/CohaesusEmployee/Development/android-sdk-macosx/platform-tools:/Users/CohaesusEmployee/Development/android-sdk-macosx/tools`. Save.
- Execute `$ source ~/.bash_profile` in the terminal.

## Add Platforms to Ionic
- Amend the __widget id__ in your config.xml file (must follow: _com.company.name_)
- `$ ionic platform add ios`
- `$ ionic platform add android`


## HockeyApp
### Setup
- We are using Hockeyapp to distribute builds to approved devices. 
- Request an invitation to the Cohaesus HockeyApp account / create a free [account] (https://rink.hockeyapp.net/registrations/new)
- Follow the instructions to [add your devices to your profile] (http://support.hockeyapp.net/kb/client-integration-ios-mac-os-x-tvos/adding-new-devices-to-your-provisioning-profile). 
- Create a new app from the dashboard. This can be done in one of three ways:
	1. Create New App from the HockeyApp Dashboard (select create the app manually).
	2. The Bundle Identifier must match the __widget id__ in your _config.xml_ file. 
- Collect the App ID (located by selecting the app from the dashboard) and [generate an API token] (https://rink.hockeyapp.net/manage/auth_tokens) for your app. Assign the values to the respective variables in the deploy-scripts folder.

### Distribution (important)
- Select _Manage App_ inside your newly-created app. From there, navigate to _Distribution_ and set the Download page to __private__. This ensures other devices provisioned on our Apple Developer account will not be able to download your app. You will either need to restrict each version manually via Dashboard - <Your App> - Version - Manage Version, or by amending the deploy-android.sh script using these additional [API Parameters] (http://support.hockeyapp.net/kb/api/api-apps#upload-app).  

### Deployment
#### Android (.apk)
##### Initial Deployment
- Follow [these instructions](http://ionicframework.com/docs/guide/publishing.html) to generate and sign the .apk file.
- Executing '$ keytool -genkey -v -keystore my-release-key.keystore -alias alias_name -keyalg RSA -keysize 2048 -validity 10000' will generate your keystore file in the directory you executed the command. _.gitignore_ is set to ignore keystore files stored in the ionic folder, if you choose to store it outside of the apk folder. 
- Sign your app with `$ jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore my-release-key.keystore android-release-unsigned.apk alias_name`
- Update the deploy-android.sh / deploy-tags.sh scripts in the deploy-scripts folder. When uploading to HockeyApp, make sure the APP_FILE is set to the android-release-unsigned.apk file. 

###### Publishing to Google Play Store
- To use the zipalign command `$ zipalign -v 4 android-release-unsigned.apk <App Name>.apk`, copy the zipalign file from android-sdk-macosx/build-tools and paste in android-sdk-macosx/tools. Only use the zipalign command below if you wish to publish to Google Play store. 

##### Future Deployment
- Run the deploy-Android Gulp task `$ gulp deploy-Android`

#### iOS (.ipa)
##### Initial Setup
- In the ionic directory, run `$ ionic build ios`
- Request an invitation to the 'Cohaesus Projects Ltd' Apple Developer Account.
- Navigate to Xcode > Preferences > Account.
- Import your developer profile using the cog (next to the plus symbol).
- Open Xcode. Import the .xcodeproj generated from `$ ionic build ios`.
- Select Product > Clean.
- If you experience the following error: “Missing iOS Distribution signing identity for …”, [this] (http://stackoverflow.com/questions/32821189/xcode-7-error-missing-ios-distribution-signing-identity-for) should resolve the error.

##### Future Deployment
1. Run the Deploy iOS Gulp task `$ gulp deploy-iOS`


## Emulation
### Browser (live reload)
- In your ionic folder run `$ ionic serve` from the terminal.
- The Gulp Watch task will automatically run when you use the browser emulation. When changes made to any HTML, CSS, or JavaScript files are saved, Gulp will recompile your dist files and then automatically reload the browser.

### iOS
- Mac only
- Inside your ionic folder, build the app via the terminal `$ ionic build ios`
- Emulate the build `$ ionic emulate ios`

### Android
#### via Cordova
- Make sure [Java for Mac OSX] (http://www.java.com/en/download/mac_download.jsp) and the [Android SDK] (http://developer.android.com/sdk/installing/index.html?pkg=tools) are installed.
- Configure your Android devices via Tools > Manage AVDs in the Android SDK.
- Inside your ionic folder, build the app via the terminal `$ ionic build android`
- Emulate the build `$ ionic emulate android`

#### via GenyMotion [recommended]
- Create and verify a [Genymotion] (https://www.genymotion.com) account.
- [Download] (https://www.genymotion.com/download/) and install Genymotion.
- Add your desired devices to the program. Double click a device to launch (alternatively, highlight and press Start).
- Inside your ionic folder, build the app via the terminal `$ ionic build android`
- Emulate the build (with your device open in Genymotion) `$ ionic run android `


## CSS Framework

### SASS
- SASS structure is based on [Inverted the Triangle CSS] (http://www.creativebloq.com/web-design/manage-large-css-projects-itcss-101517528) (ITCSS), courtesy of Harry Roberts.
- It is important that you load in any files your create in the correct order in the main.scss file. 
- Each folder contains a readme.md file, which explains the expected content.

### Angular-ui-Bootstrap
- We have also installed Bootstrap components written in pure AngularJS. You can view the documentation [here] (https://angular-ui.github.io/bootstrap/).

### Bootstrap CSS
- The Bootstrap CSS library is a listed dependancy of the angular-ui-bootstrap module, so you also have access to the [Bootstrap CSS library] (http://getbootstrap.com/css/).

### CSS
- We have left in a default style.css in the www folder if you do not wish to use SASS


## API
- You will need node.js, if you don't have it already,  for the backend API
- You will also the express framework for node
	- ``` $ npm install express --save ```
- You will also need loopback for creating your APIs quickly
	- ``` slc loopback ```
	- To access the gui editor for making your models type:
		- ``` slc arc ```
		- Otherwise you can use the CLI
	- You will need to install the connector for your db of choice
	- ``` npm install loopback-connector-postgresql --save ```
- You will need a Database, you can use heroku, or something local to get started
	- (we reccomend postgreSQL, as it is easier to manipulate the data structure of relational databases as you go along.)


## Testing
For Testing we are using the following:
- [gherkin](https://github.com/cucumber/cucumber/wiki/Gherkin): for BDD to write in human-readable language (especially useful for non-techies)
- [cucumber](https://github.com/cucumber/cucumber-js): takes gherkin syntax and converts it into JS
- [protractor](http://www.protractortest.org/#/): for End2End testing in Angular.js
- [mocha](https://www.npmjs.com/package/mocha): a popular assertion library in JS.

### Doing tests:
1. Write your gherkin tests in `ionic/features/*.feature`
2. then create a JS file in step_definition with the same name underscore steps.js (see example in features folder)
3. run `gulp cucumber`, you could also run `cucumber.js`
4. then copy the gherkin converted js code and paste it into the JS file you created in step_definitions, now you can add your assertions etc.

# Database
- PostgreSQL + pg (npm package) + knex (query builder)
- MongoDB + Mongoose
