require 'base64'

module Proposal

  def self.included(receiver)
    receiver.belongs_to :item, :polymorphic => true
    receiver.validates_presence_of :item_id, :item_type, :candidate_data

    receiver.send :include, InstanceMethods
  end

  module InstanceMethods
    def candidate_attributes
      Marshal.load(Base64.decode64(candidate_data))
    end
    def candidate_attributes=(candidate_attributes)
      self.candidate_data = Base64.encode64(Marshal.dump(candidate_attributes))
    end
  end

end

class ReleasableCandidate < ActiveRecord::Base
  include Proposal
end

class ReleasableCandidateItem < ActiveRecord::Base
  include Proposal
  validates_presence_of :collection_name
end
