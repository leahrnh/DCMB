namespace :radiant do
  namespace :extensions do
    namespace :group_forum do
      
      desc "Runs the migration of the Group Forum extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          GroupForumExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          GroupForumExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Group Forum to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from GroupForumExtension"
        Dir[GroupForumExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(GroupForumExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
