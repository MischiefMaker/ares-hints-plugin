module AresMUSH
  module Hints
    class SetHintsCmd
      include CommandHandler

      attr_accessor :hints, :name

      def parse_args
       args = cmd.parse_args(ArgParser.arg1_equals_arg2)
       self.name = titlecase_arg(args.arg1)
       self.hints = trim_arg(args.arg2)
      end

     def required_args
       [ self.name, self.hints ]
     end

      def check_can_set
         return nil if enactor.has_permission?("view_bgs")
         return "You're not allowed to manage hints. Type 'hints' to view your own."
      end



      def handle
          char = Character.find_one_by_name(self.name)
	  char.update(hints: self.hints)
          message = "You have new hints! Type 'hints' to view, or visit your profile page."
          client.emit_success "Hints set for #{self.name}!"
   	  Login.emit_ooc_if_logged_in char, message
          Login.notify(char, :hints, message, nil)
      end
    end
  end
end
