module AresMUSH
  module Hints
    class AllHintsCmd
      include CommandHandler

      attr_accessor :name

      def parse_args
        self.name = cmd.args ? titlecase_arg(cmd.args) : enactor_name
      end

      def check_can_view
         return nil if enactor.has_permission?("view_bgs")
         return "You're not allowed to view other peoples' hints."
      end

      def handle
	   hasHints = Character.all.select { |c| c.hints != nil }.map { |c| "#{c.name}"}
	   template = BorderedListTemplate.new hasHints, "The following characters have hints set:"
	   client.emit template.render
      end
    end
  end
end
