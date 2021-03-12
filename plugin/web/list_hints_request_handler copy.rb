module AresMUSH
  module Profile
    class CustomCharFields
      def self.get_fields_for_viewing(char, viewer)
        if (char == viewer || (viewer && viewer.is_admin?))
	         return {hints: Website.format_markdown_for_html(char.hints) }
	      else
	         return {hints: "You are not permitted to view this character's secrets."}
	      end
      end
    end
  end
end
