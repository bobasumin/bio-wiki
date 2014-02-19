class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.text :summary
      t.string :name
      t.text :body
      t.integer :wiki_id

      t.timestamps
    end
  end
end
