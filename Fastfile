default_platform :android

platform :android do

  desc "Flavor upload Play Store"
  lane :deploy do |options|
        gradle(task: "clean")
        gradle(task: "assemble",build_type: "Release",flavor: options[:app])

    lane_context[SharedValues::GRADLE_ALL_APK_OUTPUT_PATHS].each do |scheme_name|

        Actions.lane_context[SharedValues::SIGNED_APK_PATH] = scheme_name
            lane_context[SharedValues::SIGNED_APK_PATH] = scheme_name
            sign_apk_lane({apk_path_signed:scheme_name,apk_path:scheme_name});
            begin
                upload_production({apk_path_publicar:ENV["PUBLISHTHISAPK"],pacoteID:ENV["IDAPK"]})
            rescue
                puts "error on deploy"
            end
     end
  end
    lane :sign_apk_lane do |options|
        // Jarsinger 
        sign_apk(
              alias: "<YOUR ALIAS KEY>",
              storepass: "<STORE PASS>",
              keystore_path: "<KEY PATH>",
              tsa: "http://timestamp.comodoca.com/rfc316",
              apk_path_signed: options[:apk_path_signed],
              keypass: "<KEY PASS>",
            )
       zipalign(apk_path: "#{options[:apk_path_signed]}")
    end
    lane :upload_production do | options |
        supply(
          apk: options[:apk_path_publicar],
          track: "production",
          skip_upload_metadata: true,
          skip_upload_images: true,
          skip_upload_screenshots: true ,
          package_name: options[:pacoteID])
    end

end