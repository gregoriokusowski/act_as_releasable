class CreateReleasableCandidateItems < ActiveRecord::Migration
  def change
    create_table :releasable_candidate_items do |t|
      t.string :item_type, :null => false
      t.integer :item_id,   :null => false
      t.text :candidate_data
      t.string :collection_name
      t.timestamps
    end
    add_index :releasable_candidate_items, :item_id
    add_index :releasable_candidate_items, [:item_type, :item_id]
  end
end
