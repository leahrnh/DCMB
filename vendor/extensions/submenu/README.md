## Submenu

This extension adds a useful second layer of navigation to the main radiant admin interface. It's mostly meant for use by extension authors and works much like the tabs. I use it to group together the various other extensions that are relevant to readers (rather than creating a tab for each one) and to offer a better site-chooser in multi_site.

## Latest

* If you're running with our multi_site, the submenu will include a drop-down site list on any index page that lists a site-scoped model.

* I've added a shortcut mechanism so that you can put commonly-used links in the left-hand side of the submenu on a per-user (or global) basis. Advanced users can make their own bookmarks (which is all they are really) but it's more likely that the site admin will use this to make key tasks more accessible. I'm using it to eliminate link-hunting with deep admin links like 'add a blog entry' and 'upload images'.

## Status

New but simple and properly tested. Should just work.

## Installation

	git submodule add git://github.com/spanner/radiant-submenu-extension.git vendor/extensions/submenu
	rake radiant:extensions:submenu:migrate
	rake radiant:extensions:submenu:update

## Configuration

Nothing is required. Our other extensions all declare the dependency properly (with radiant 0.8.1) so it should just work, but in case you need to declare the load order, this is what I used to have:

	config.extensions = [  :share_layouts, :multi_site, :submenu, :taggable, :reader, :all ]

## Usage

In the activation method of an extension:

	admin.tabs.add('Extension')
	admin.tabs['Extension'].add_link('something', '/somewhere')
	admin.tabs['Extension'].add_link('some other thing', '/elsewhere')

## Author and copyright

* Copyright spanner ltd 2009.
* Released under the same terms as Rails and/or Radiant.
* Contact will at spanner.org
