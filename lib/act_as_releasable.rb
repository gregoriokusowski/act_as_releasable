require "act_as_releasable/version"
require "act_as_releasable/models"

module ActAsReleasable
  module ClassMethods
    def act_as_releasable(options = {})
      send :include, InstanceMethods

      class_attribute :releasable_collections
      self.releasable_collections = (options[:collections] || [])

      has_one :releasable_candidate, :as => :item
      unless self.releasable_collections.empty?
        has_many :releasable_candidate_items, :as => :item
      end

    end
  end

  module InstanceMethods
    def release_version!
      ActiveRecord::Base.transaction do
        # Clean-up of the official record
        self.releasable_collections.each do |collection|
          send(collection).destroy_all
        end

        # Updating attributes
        self.attributes = (releasable_candidate.candidate_attributes || {})
        releasable_candidate_items.each do |candidate_item|
          send(candidate_item.collection_name).build candidate_item.candidate_attributes
        end

        # Destroying prototype data
        releasable_candidate.destroy if releasable_candidate.present?
        releasable_candidate_items.destroy_all

        save!
      end
    end

    def release_candidate
      clone.tap do
        self.releasable_collections.each do |collection|
          send(collection).clear
        end
        self.attributes = releasable_candidate.try(:candidate_attributes) || {}
        releasable_candidate_items.each do |candidate_item|
          send(candidate_item.collection_name).build candidate_item.candidate_attributes
        end
      end
    end

    def generate_new_candidate
      if valid?
        ActiveRecord::Base.transaction do

          # Destroying prototype data
          releasable_candidate.destroy if releasable_candidate.present?
          releasable_candidate_items.destroy_all

          # Creating new prototype data
          create_releasable_candidate! :candidate_attributes => attributes
          self.releasable_collections.each do |collection|
            send(collection).each do |collection_item|
              unless collection_item.marked_for_destruction?
                releasable_candidate_items.create! ({:candidate_attributes => collection_item.attributes, :collection_name => collection})
              end
            end
          end

        end # transaction
      end
    end

    def has_changes_to_be_approved?
      releasable_candidate.present? || !releasable_candidate_items.empty?
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
  end
end

ActiveSupport.on_load(:active_record) do
  include ActAsReleasable
end
