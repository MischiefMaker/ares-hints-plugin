
To have hints viewable on the web profile, you need to make the following changes:

open ares/ares-webportal/app/templates/components/profile-custom-tabs.hbs and add the following line:

    <li><a data-toggle="tab" href="#systemhints">Plot Hints</a></li>

open ares/ares-webportal/app/templates/components/profile-custom.hbs and add the following lines:

    <div id="systemhints" class="tab-pane fade">
        <h2>Plot Hints and Secrets</h2>
        {{{ansi-format text=char.custom.hints}}}
        <hr><p><i>These are unique secrets and hints, as set by staff. They can only be seen by the character.</i></p>
    </div>

Open aresmush/plugins/profile/custom_char_fields.rb and modify the get_fields_for_viewing:

    def self.get_fields_for_viewing(char, viewer)
        if (char == viewer || (viewer && viewer.is_admin?))
            return {hints: Website.format_markdown_for_html(char.hints) }
        else
            return {hints: "You are not permitted to view this character's secrets."}
        end
    end

When finished, from the MUSH, type:
    load profile
    website/deploy

Once the website has redeployed, the tab should appear on the profile.
