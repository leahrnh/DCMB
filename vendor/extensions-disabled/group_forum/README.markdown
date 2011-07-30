# Group Forum

This is a bit of glue to link reader groups to forums. In order to make access control simple and expressible in SQL, it sets up a simple `belongs_to :group` relationship in the forum and then cascades it to topics and posts.

(this is achieved by calling `is_grouped` and `gives_group_to :topics`, plus a bit of controller fiddling)

The Radius tags supporting this are pretty basic at the moment but will improve. Access control has been the first priority.

## Status

Very simple, reasonably well-tested, should just work.

## Bugs and comments

In [lighthouse](http://spanner.lighthouseapp.com/projects/26912-radiant-extensions), please, or for little things an email or github message is always welcome.

## Author and copyright

* Copyright spanner ltd 2009.
* Originally developed for MLA London's Knowledge Transfer Project
* Released under the same terms as Rails and/or Radiant.
* Contact will at spanner.org

