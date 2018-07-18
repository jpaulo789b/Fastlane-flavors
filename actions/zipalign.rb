module Fastlane
  module Actions
    module SharedValues
      ZIPALIGN_CUSTOM_VALUE = :ZIPALIGN_CUSTOM_VALUE
    end

    class ZipalignAction < Action
      def self.run(params)

       UI.user_error!("Couldn't find '*release.apk' file at path 'app/build/outputs/apk/'") unless params[:apk_path]

       error_callback = proc do |error|
         new_name = params[:apk_path].gsub('.apk', '-nao-publicar.apk')
         rename_command = ["mv -n",params[:apk_path],new_name]
         Fastlane::Actions.sh(rename_command, log: false)

         aligncmd = ["zipalign -v -f 4", new_name , " ", params[:apk_path] ]
         Fastlane::Actions.sh(aligncmd, log: true)

         return
        end
            novo_nome = params[:apk_path].gsub('-unsigned.apk', '-publicar.apk')
       zipalign = Fastlane::Actions.sh("zipalign -v 4 #{params[:apk_path]} #{novo_nome}", log: true , error_callback: error_callback)
            ENV["PUBLISHTHISAPK"] = novo_nome
            comando = "aapt dump badging apkcaminho | grep 'package:\ name='"
            comando =  comando.gsub('apkcaminho', novo_nome)
            ENV["IDAPK"] = sh(comando)
            ENV["IDAPK"] = ENV["IDAPK"].scan(/'([^']+)'/)[0][0]



       UI.message('Input apk is aligned')

     end 
      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Zipalign an apk. Input apk is renamed '*-unaligned.apk'"
      end

      def self.available_options

        apk_path_default = Dir["*.apk"].last || Dir[File.join("app", "build", "outputs", "apk", "*release.apk")].last

        [
          FastlaneCore::ConfigItem.new(key: :apk_path,
                                       env_name: "INPUT_APK_PATH",
                                       description: "Path to your APK file that you want to align",
                                       default_value: Actions.lane_context[SharedValues::GRADLE_APK_OUTPUT_PATH] || apk_path_default,
                                       optional: true)
        ]
      end

      def self.authors
        ["nomisRev"]
      end

      def self.is_supported?(platform)
        platform == :android
      end
    end
  end
end
