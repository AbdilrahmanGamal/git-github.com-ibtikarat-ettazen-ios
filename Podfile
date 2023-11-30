# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Ettizan_ios' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'FSPagerView'
  pod 'Alamofire', '~> 4.9'
  pod 'SwiftyJSON', '~> 4.0'

  pod 'SDWebImage', '~> 4.0'
  pod 'IQKeyboardManagerSwift', '6.2.1'
  pod 'MaterialComponents/TextControls+OutlinedTextFields'
  pod 'CocoaDebug', :configurations => ['Debug']
  pod 'SwiftMessages', '~> 5.0'
  pod 'SVPinView', '~> 1.0'

  # Pods for Ettizan_ios

post_install do |installer|
          installer.pods_project.targets.each do |target|
              target.build_configurations.each do |config|
              xcconfig_path = config.base_configuration_reference.real_path
              xcconfig = File.read(xcconfig_path)
              xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
              File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'

              end
          end
      end

end
