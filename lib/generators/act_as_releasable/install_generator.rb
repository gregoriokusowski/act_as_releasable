require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record/migration'

module ActAsReleasable
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    extend ActiveRecord::Generators::Migration

    source_root File.expand_path('../templates', __FILE__)

    desc 'Generates the Releasable Candidates migrations.'

    def create_migration_file
      %w/create_releasable_candidates create_releasable_candidate_items/.each do |f|
        begin
          migration_template "#{f}.rb", "db/migrate/#{f}.rb"
        rescue Rails::Generators::Error => e
          puts e.message
        end
      end
    end
  end
end
