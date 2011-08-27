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

# for reader extension
gem 'snail', '~> 0.5.5'
gem 'vcard', '~> 0.1.1'
gem 'fastercsv', '~> 1.5.4'

group :development do
  gem 'sqlite3-ruby'
end

group :production do
  gem 'pg'
end
