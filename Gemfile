source :rubygems

gem 'rails'  # not actually needed, but Heroku wants it 'cause they think this is a Rails app
gem 'radiant', :git => 'https://github.com/radiant/radiant.git', :submodules => true
gem 'rdiscount','>= 1.3.5'
gem 'authlogic', '>= 2.1.2'
gem 'gravtastic', '>= 2.1.3'
gem 'sanitize'
gem 'acts_as_list'
gem 'responds_to_parent'
gem 'haml'
gem 'hassle'
gem 'imagesize', :require => 'image_size'

gem 'snail'
gem 'radiant-reader-extension', :git => 'https://github.com/aughr/radiant-reader-extension.git'
gem 'radiant-forum-extension', :git => 'https://github.com/spanner/radiant-forum-extension.git'

gem 'cucumber', '1.0.3'

group :development do
  gem 'sqlite3-ruby'
end

group :production do
  gem 'pg'
end
