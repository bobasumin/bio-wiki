class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :value
      t.references :wiki
      t.references :section
      t.references :user

      t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, :wiki_id
    add_index :votes, :section_id
  end
end
