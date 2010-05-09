module ShareLayouts::ControllerExtensions

  def layout_for(area = :public)
    if defined? Site && current_site && current_site.respond_to?(:layout_for)
      current_site.layout_for(area)
    elsif area_layout = Radiant::Config["#{area}.layout"]
      area_layout
    elsif main_layout = Layout.find_by_name('Main')
      main_layout.name
    elsif any_layout = Layout.first
      any_layout.name
    end
  end

end



