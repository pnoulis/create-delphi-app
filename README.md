# About
Version: 1.0.0

Create-delphi-app automates some part of the build process.

It creates a skeleton directory tree with the neccessary files
to automate the build process.

One can modify the build scipts at scripts/build-events/*
to suit their needs.

## build scripts default behavior
### debug build configuration
copies all build environment variables from the compliler into ./build/build.env.json
copies ./config into ./build/$(platform)/$(config)
### release build configuration
copies all build environment variables from the compliler into ./build/build.env.json
copies ./config into ./build/$(platform)/$(config)
copies ./build/$(platform)/$(config) into ./build/$(projectName)-$(platform)-v$(version)
Version is read from ./config/config.ini which the user must increment to reflect
an actual version bump.

# Things to do prior to building the application for the first time
## Apply the build configuration option set.
In the project viewer expand the Build Configuration dropdown.
There for both default build configurations (Debug & Release) apply the following steps:

1. Activate the build configuration
   Right click -> activate
2. Apply their respective optsets
   Project -> options -> Delphi Compiler -> Apply 
   Select the optset file at ./config/delphi-rad-studio/{debug|release}.optset
   Check "modify this configuration"
   Click Ok
   Save
3. Save Project 
4. Repeat for next build configuration

## Apply the formatter configuration
Click on Tools/options at the actions toolbar.
Click on the language/formater/profile and status dropdown.
load the formatter at config/delphi-rad-studio/formatter.config
