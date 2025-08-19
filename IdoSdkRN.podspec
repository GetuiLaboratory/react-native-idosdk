require 'json'
pjson = JSON.parse(File.read('package.json'))

Pod::Spec.new do |s|

  s.name            = "IdoSdkRN"
  s.version         = pjson["version"]
  s.homepage        = "https://github.com/GetuiLaboratory/react-native-idosdk"
  s.summary         = pjson["description"]
  s.license         = pjson["license"]
  s.author          = { "ak" => "343342719@qq.com" }
  
  s.ios.deployment_target = '12.0'

  s.source          = { :git => "https://github.com/GetuiLaboratory/react-native-idosdk.git" }
  s.source_files    = 'ios/RCTGetuiIdoModule/RCTGetuiIdoModule/*.{h,m}'
  s.preserve_paths  = "*.js"
  s.frameworks      = 'SystemConfiguration', 'CFNetwork','CoreTelephony','CoreLocation','AVFoundation','Security','AdSupport'
  s.weak_frameworks = 'UserNotifications','AppTrackingTransparency','Network'
  s.libraries       = 'z','sqlite3.0','c++','resolv'
  s.requires_arc = true
  s.swift_versions = ['5']

  s.dependency 'React'
  s.dependency 'GCIDOSDK'

end
