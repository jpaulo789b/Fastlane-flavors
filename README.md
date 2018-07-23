fastlane flavors deploy documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`
# Configure
Replace fastlane folder and 

Modify file `Fastfile`
```
sign_apk(
              alias: "<YOUR ALIAS KEY>",
              storepass: "<STORE PASS>",
              keystore_path: "<KEY PATH>",
              tsa: "http://timestamp.comodoca.com/rfc316",
              apk_path_signed: options[:apk_path_signed],
              keypass: "<KEY PASS>",
            )
```
Modify file `Appfile`
```
json_key_file "<google-api-file-key-path>"
```
# Available Actions
## Android
### android deploy
```
fastlane android deploy
```
jarsinger your flavor
### android sign_apk_lane
```
fastlane android sign_apk_lane
```

### android upload_production
```
fastlane android upload_production
```


----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
