class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :summary
      t.text :earlylife
      t.text :career
      t.text :personallife
      t.integer :birthdate
      t.boolean :public, default: true

      t.timestamps
    end
  end
end
