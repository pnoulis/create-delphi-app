# About
Version: 2.0.0

A script that produces a directory tree with all the neccessary 
tools to setup an automated build environment for delphi projects.

One can modify the build scipts at scripts/build-events/*
to suit their needs.

# Installation & usage
1. Clone this repository
2. Build the project
   Within the repository run the ./scripts/build.ps1
   it should produce a directory at ./build/create-delphi-app-v$(version)
3. Place the build wherever it suits you
4. Adjust your $env:path to include the build dir
5. run cda ./target/dir

# Development
Follow the installation process. For developing one should run the script at:
./scripts/run.ps1 ./path/to/target

There are also 2 visual studio custom tasks for building the project.

run -> intended for when developing which builds the project into build/run by default
build -> intended for distribution where it is build at build/

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
