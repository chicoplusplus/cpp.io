class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.text :description
      t.integer :user_id, :null => false
      t.integer :num_votes, :default => 0

      t.timestamps
    end
  end
end
