class CreateReleasableCandidates < ActiveRecord::Migration
  def change
    create_table :releasable_candidates do |t|
      t.string :item_type,      :null => false
      t.integer :item_id,       :null => false
      t.text :candidate_data
      t.timestamps
    end
    add_index :releasable_candidates, :item_id
    add_index :releasable_candidates, [:item_type, :item_id]
  end
end
