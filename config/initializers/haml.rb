Haml::Template.options[:format] = :html5
Haml::Template.options[:ugly] = RAILS_ENV == 'production'

#Compass.sass_engine_options[:load_paths].unshift "#{Rails.root}/public/stylesheets/sass"
#raise Compass.sass_engine_options.inspect
