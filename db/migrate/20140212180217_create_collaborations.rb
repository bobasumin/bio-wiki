class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.belongs_to :post
      t.belongs_to :user
      t.timestamps
    end
  end
end
