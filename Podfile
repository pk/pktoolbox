platform :ios, '7.1'

pod 'Specta'
pod 'Expecta'
pod 'OCMock'

post_install do |installer|
    target = installer.project.targets.find { |t| t.to_s == "Pods-Specta" }
    if (target)
        target.build_configurations.each do |config|
            s = config.build_settings['FRAMEWORK_SEARCH_PATHS']
            s = [ '$(inherited)' ] if s == nil;
            s.push('$(PLATFORM_DIR)/Developer/Library/Frameworks')
            config.build_settings['FRAMEWORK_SEARCH_PATHS'] = s
        end
    else
        puts "WARNING: Pods-Tests-Specta target not found"
    end
end

