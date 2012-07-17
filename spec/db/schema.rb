ActiveRecord::Schema.define(:version => 0) do

  create_table :releasable_candidate_items do |t|
    t.string :item_type, :null => false
    t.integer :item_id,   :null => false
    t.text :candidate_data
    t.string :collection_name
    t.timestamps
  end

  create_table :releasable_candidates do |t|
    t.string :item_type,      :null => false
    t.integer :item_id,       :null => false
    t.text :candidate_data
    t.timestamps
  end

  create_table :teams do |t|
    t.string :name
  end

  create_table :players do |t|
    t.string :name
    t.integer :skill_level
    t.integer :team_id
  end

  add_index :releasable_candidate_items, :item_id
  add_index :releasable_candidate_items, [:item_type, :item_id]
  add_index :releasable_candidates, :item_id
  add_index :releasable_candidates, [:item_type, :item_id]

end
