@SET BDS=C:\Program Files (x86)\Embarcadero\Studio\18.0
@SET BDSINCLUDE=C:\Program Files (x86)\Embarcadero\Studio\18.0\include
@SET BDSCOMMONDIR=C:\Users\Public\Documents\Embarcadero\Studio\18.0
@SET FrameworkDir=C:\Windows\Microsoft.NET\Framework\v3.5
@SET FrameworkVersion=v3.5
@SET FrameworkSDKDir=
@SET PATH=%FrameworkDir%;%FrameworkSDKDir%;C:\Program Files (x86)\Embarcadero\Studio\18.0\bin;C:\Program Files (x86)\Embarcadero\Studio\18.0\bin64;C:\Users\Public\Documents\Embarcadero\InterBase\redist\InterBaseXE7\IDE_spoof;%PATH%
@SET LANGDIR=EN
@SET PLATFORM=
@SET PlatformSDK=

msbuild <dproj-path> /t:Make
start <exe-path>