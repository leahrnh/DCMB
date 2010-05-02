module AssetTypeTags
  include Radiant::Taggable
  include ActionView::Helpers::NumberHelper
  
  class TagError < StandardError; end
  
  
  def self.included(base)
  
    class << base
    
      def define_radius_tags_for_asset_type(type)

        ## tags referring to the whole asset collection

        desc %{
          Loops through all the assets of type #{type}.
          (Use r:assets:#{type.plural}:each if you want all the #{type} assets attached to the present page.)

          *Usage:* 
          <pre><code><r:assets:all_#{type.plural}:each>...</r:assets:all_#{type.plural}:each></code></pre>
        }
        tag "assets:all_#{type.plural}" do |tag|
          tag.expand
        end
        tag "assets:all_#{type.plural}:each" do |tag|          
          tag.locals.assets = Asset.send(type.plural.intern).scoped(asset_type_find_options(tag))
          tag.render('asset_list', tag.attr.dup, &tag.block)
        end

        desc %{
          Loops through all the assets **not** of type #{type}.
          (Use r:assets:#{type.plural}:each if you want all the #{type} assets attached to the present page.)

          *Usage:* 
          <pre><code><r:assets:all_non_#{type.plural}:each>...</r:assets:all_non_#{type.plural}:each></code></pre>
        }
        tag "assets:all_non_#{type.plural}" do |tag|
          tag.expand
        end
        tag "assets:all_non_#{type.plural}:each" do |tag|
          tag.locals.assets = Asset.send("all_non_#{type.plural}".intern).scoped(asset_type_find_options(tag))
          tag.render('asset_list', tag.attr.dup, &tag.block)
        end

        ## tags referring to assets attached to the present page

        desc %{
          Expands if any #{type} assets are attached to the page.
          Note the pluralization: r:assets:if_image tests whether a particular asset is an image file.
          r:assets:if_images tests whether any images are present.

          *Usage:* 
          <pre><code><r:assets:if_#{type.plural}>...</r:assets:if_#{type.plural}></code></pre>
        }
        tag "assets:if_#{type.plural}" do |tag|
          raise TagError, "page must be defined for assets:if_#{type.plural} tag" unless tag.locals.page
          assets = tag.locals.page.assets.send(type.plural.intern)
          tag.expand if assets.any?
        end

        desc %{
          Expands if no #{type} assets are attached to the page.
          Note the pluralization: r:assets:unless_image tests whether a particular asset is an image file.
          r:assets:unless_images tests whether any images are present.

          *Usage:* 
          <pre><code><r:assets:unless_#{type.plural}>...</r:assets:unless_#{type.plural}></code></pre>
        }
        tag "assets:unless_#{type.plural}" do |tag|
          raise TagError, "page must be defined for assets:unless_#{type.plural} tag" unless tag.locals.page
          assets = tag.locals.page.assets.send(type.plural.intern)
          tag.expand unless assets.any?
        end
    
        desc %{
          Expands if any non-#{type} assets are attached to the page.
          Note the pluralization: r:assets:if_non_image tests whether a particular asset is not an image file.
          r:assets:if_non_images tests whether any non-images are present.

          *Usage:* 
          <pre><code><r:assets:if_non_#{type.plural}>...</r:assets:if_non_#{type.plural}></code></pre>
        }
        tag "assets:if_non_#{type.plural}" do |tag|
          raise TagError, "page must be defined for assets:if_non_#{type.plural} tag" unless tag.locals.page
          assets = tag.locals.page.assets.send("non_#{type.plural}".intern)
          tag.expand if assets.any?
        end

        desc %{
          Expands if no non-#{type} assets are attached to the page.
          Note the pluralization: r:assets:unless_non_image tests whether a particular asset is not an image file.
          r:assets:unless_non_images tests whether any non-images are present.

          *Usage:* 
          <pre><code><r:assets:unless_non_#{type.plural}>...</r:assets:unless_non_#{type.plural}></code></pre>
        }
        tag "assets:unless_non_#{type.plural}" do |tag|
          raise TagError, "page must be defined for assets:unless_non_#{type.plural} tag" unless tag.locals.page
          assets = tag.locals.page.assets.send("non_#{type.plural}".intern)
          tag.expand unless assets.any?
        end

        desc %{
          Loops through all the attached assets of type #{type}. The usual order attributes are applied.

          *Usage:* 
          <pre><code><r:assets:#{type.plural}:each>...</r:assets:#{type.plural}:each></code></pre>
        }
        tag "assets:#{type.plural}" do |tag|
          raise TagError, "page must be defined for assets:#{type} tags" unless tag.locals.page
          tag.expand
        end
        tag "assets:#{type.plural}:each" do |tag|
          tag.locals.assets = tag.locals.page.assets.send(type.plural.intern).scoped(asset_type_find_options(tag))
          tag.render('asset_list', tag.attr.dup, &tag.block)
        end

        desc %{
          Loops through all the attached assets not of type #{type}. The usual order attributes are applied.

          *Usage:* 
          <pre><code><r:assets:non_#{type.plural}:each>...</r:assets:non_#{type.plural}:each></code></pre>
        }
        tag "assets:non_#{type.plural}" do |tag|
          raise TagError, "page must be defined for assets:non_#{type} tags" unless tag.locals.page
          tag.expand
        end
        tag "assets:#{type.plural}:each" do |tag|
          tag.locals.assets = tag.locals.page.assets.send("non_#{type.plural}".intern).scoped(asset_type_find_options(tag))
          tag.render('asset_list', tag.attr.dup, &tag.block)
        end

        desc %{
          Displays the first attached asset of type #{type}. The usual order attributes are applied.

          *Usage:* 
          <pre><code><r:assets:first_#{type}>...</r:assets:first_#{type}></code></pre>
        }
        tag "assets:first_#{type}" do |tag|
          raise TagError, "page must be defined for assets:first_#{type} tag" unless tag.locals.page
          assets = tag.locals.page.assets.send(type.plural.intern).find(:all, asset_type_find_options(tag))
          if assets.any?
            tag.locals.asset = assets.first
            tag.expand
          end
        end
    
        ## tags referring to a particular asset
    
        desc %{
          Renders the contained elements only if the asset is of the specified type.

          *Usage:* 
          <pre><code><r:assets:if_#{type}>...</r:assets:if_#{type}></code></pre>
        }
        tag "assets:if_#{type}" do |tag|
          tag.expand if tag.locals.asset.send("#{type}?".intern)
        end

        desc %{
          Renders the contained elements only if the asset is not of the specified type.

          *Usage:* 
          <pre><code><r:assets:unless_#{type}>...</r:assets:unless_#{type}></code></pre>
        }
        tag "assets:unless_#{type}" do |tag|
          tag.expand unless tag.locals.asset.send("#{type}?".intern)
        end
    
      end
    end
  end
  
  private
  
  def asset_type_find_options(tag)
    attr = tag.attr.symbolize_keys
    
    by = attr[:by] || "created_at"
    order = attr[:order] || "desc"
    
    options = {
      :order => "#{by} #{order}",
      :limit => attr[:limit] || nil,
      :offset => attr[:offset] || nil
    }
  end    
  
end