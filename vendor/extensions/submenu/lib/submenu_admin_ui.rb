module SubmenuAdminUI

  def self.included(base)
    base.class_eval do

       attr_accessor :submenu_link
       alias_method :submenu_links, :submenu_link

       def load_default_regions_with_submenu_links
         load_default_regions_without_submenu_links
         @submenu_link = load_default_submenu_link_regions
       end

       alias_method_chain :load_default_regions, :submenu_links

     protected

       def load_default_submenu_link_regions
         returning OpenStruct.new do |submenu_link|
           submenu_link.edit = Radiant::AdminUI::RegionSet.new do |edit|
             edit.main.concat %w{edit_header edit_form}
             edit.form.concat %w{edit_name edit_url edit_user}
             edit.form_bottom.concat %w{edit_timestamp edit_buttons}
           end
           submenu_link.index = Radiant::AdminUI::RegionSet.new do |index|
             index.thead.concat %w{name_header destination_header flags_header modify_header}
             index.tbody.concat %w{name_cell destination_cell flags_cell modify_cell}
             index.bottom.concat %w{new_button}
           end
           submenu_link.remove = submenu_link.index
           submenu_link.new = submenu_link.edit
         end
       end
     end
   end

end

