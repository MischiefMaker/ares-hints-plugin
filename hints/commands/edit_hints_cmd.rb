module AresMUSH

  module Hints
    class EditHintsCmd
      include CommandHandler

      attr_accessor :target, :hints

      def parse_args
        self.target = trim_arg(cmd.args)
      end

      def required_args
        [ self.target ]
      end

      def handle
        AnyTargetFinder.with_any_name_or_id(self.target, client, enactor) do |model|
          hints = model.hints
          Utils.grab client, enactor, "hints/set #{self.target}=#{hints}"
        end
      end

    end
  end
end
