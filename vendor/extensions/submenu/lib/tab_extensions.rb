module TabExtensions

  def submenu
    @submenu ||= Radiant::AdminUI::Submenu.new
  end
  
  def add_link(name, url, options = {})
    self.submenu.add(name, url, options)
  end

  def remove_link(name)
    self.submenu.remove(name)
  end
  
  def has_submenu?
    self.submenu.has_links?
  end

end
