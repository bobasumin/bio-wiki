class CreateBiocards < ActiveRecord::Migration
  def change
    create_table :biocards do |t|
      t.date :dob
      t.string :pob
      t.string :nationality
      t.integer :wiki_id

      t.timestamps
    end
  end
end
