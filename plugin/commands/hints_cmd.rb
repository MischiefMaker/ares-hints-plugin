module AresMUSH
  module Hints
    class HintsCmd
      include CommandHandler

      attr_accessor :name

      def parse_args
        self.name = cmd.args ? titlecase_arg(cmd.args) : enactor_name
      end

      def check_can_view
         return nil if self.name == enactor_name
         return nil if enactor.has_permission?("view_bgs")
         return "You're not allowed to view other peoples' hints."
      end

      def handle
        ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
          template = BorderedDisplayTemplate.new model.hints, "#{model.name}'s Hints"
          client.emit template.render
          Login.mark_notices_read(enactor,:hints,nil)
	       end
      end
    end
  end
end
