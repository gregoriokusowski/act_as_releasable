
require 'factory_girl'
require 'active_support'
require 'active_model'
require 'active_record'

ActiveRecord::Base.configurations = YAML::load(ERB.new(IO.read(File.dirname(__FILE__) + "/db/database.yml")).result)
ActiveRecord::Base.establish_connection("sqlite3")
ActiveRecord::Migration.verbose = false
load(File.join(File.dirname(__FILE__), "db", "schema.rb"))

require 'act_as_releasable'
require 'support/models'
require 'factories/jazz_all_stars'
require 'factories/phantoms'

# Require this file using `require "spec_helper"` to ensure that it is only
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.include FactoryGirl::Syntax::Methods

  config.order = 'random'

  config.after do
    [ReleasableCandidateItem, ReleasableCandidate, Team, Player].each(&:destroy_all)
  end
end

