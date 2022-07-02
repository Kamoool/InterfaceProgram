# Quick - Down - Shifter APP

QS DS Application


#Corect settings

Windows: 
Change in windows/runner/Runner.rc: VALUE "FileDescription", "QS-DS-App" "\0"
Logo: windows/runner/resources - .ico 3.0 format



MacOS:
Logo: macos/Runner/Assets.xcassets/AppIcon.appiconset
Add in: /macos/Runner/DebugProfile.entitlements    /macos/Runner/Release.entitlements:
<key>com.apple.security.device.serial</key>
<true/>