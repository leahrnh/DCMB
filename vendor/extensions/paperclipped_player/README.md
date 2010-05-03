# Paperclipped Player

This simple extension adds to Paperclipped a general-purpose [video and audio player](http://sourceforge.net/projects/mpwplayer), a new 'playable' asset type and the radius tags you need to find out whether an asset is playable and to put the player on the page.

## Requirements

* Paperclipped (currently, the [spanner fork](https://github.com/spanner/paperclipped/tree) is required)
* Radiant 0.8.x

## Usage

	<r:assets:each>
	  <r:assets:if_playable>
	    <r:assets:player width="400" autoplay="false" allowFullScreen="true" />
	  <r:assets:if_playable>
	</r:assets:each>

## Author and copyright

* Copyright spanner ltd 2009.
* Released under the same terms as Rails and/or Radiant.
* Contact will at spanner.org

