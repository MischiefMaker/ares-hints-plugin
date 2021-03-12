$:.unshift File.dirname(__FILE__)

module AresMUSH
     module Hints
       include CommandHandler

    def self.plugin_dir
      File.dirname(__FILE__)
    end

    def self.shortcuts
      Global.read_config("hints", "shortcuts")
    end

    def self.get_cmd_handler(client, cmd, enactor)
      case cmd.root
      when "hints"
       case cmd.switch
       when "set"
          return SetHintsCmd
       when "edit"
         return EditHintsCmd
       when "add"
         return AddHintsCmd
       when "blank"
         return BlankHintsCmd
       when "all"
         return AllHintsCmd
       else
          return HintsCmd
       end
     end
     return nil
   end

    def self.get_event_handler(event_name)
      nil
    end

    def self.get_web_request_handler(request)
      nil
    end

  end
end
