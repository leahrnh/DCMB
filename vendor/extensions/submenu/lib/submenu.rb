module Submenu
  
  class DuplicateLinkNameError < StandardError; end

  class Submenu
    def initialize
      @links = []
    end
    
    def has_links?
      @links.any?
    end
    
    def add(name, url, options = {})
      options.symbolize_keys!
      before = options.delete(:before)
      after = options.delete(:after)
      link_name = before || after
      if self[name]
        raise DuplicateLinkNameError.new("duplicate submenu link name `#{name}'")
      else
        if link_name
          index = @links.index(self[link_name])
          index += 1 if before.nil?
          @links.insert(index, SubmenuLink.new(name, url, options))
        else
          @links << SubmenuLink.new(name, url, options)
        end
      end
    end

    def remove(name)
      @links.delete(self[name])
    end

    def size
      @links.size
    end

    def [](index)
      if index.kind_of? Integer
        @links[index]
      else
        @links.find { |link| link.name == index }
      end
    end

    def each
      @links.each { |t| yield t }
    end

    def clear
      @links.clear
    end

    include Enumerable
  end
  
  class SubmenuLink
    attr_accessor :name, :url
    def initialize(name, url, options = {})
      @name, @url = name, url
    end
  end
  
end
  