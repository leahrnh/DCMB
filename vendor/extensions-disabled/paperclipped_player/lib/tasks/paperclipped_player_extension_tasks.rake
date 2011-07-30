namespace :radiant do
  namespace :extensions do
    namespace :paperclipped_player do
      
      desc "Runs the migration of the Paperclipped Player extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          PaperclippedPlayerExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          PaperclippedPlayerExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Paperclipped Player to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from PaperclippedPlayerExtension"
        Dir[PaperclippedPlayerExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(PaperclippedPlayerExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory, :verbose => false
          cp file, RAILS_ROOT + path, :verbose => false
        end
      end  
    end
  end
end
