class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :value
      t.references :section
      t.references :user
      t.references :wiki

      t.timestamps
    end
    add_index :votes, :wiki_id
    add_index :votes, :user_id
    add_index :votes, :section_id
  end
end
