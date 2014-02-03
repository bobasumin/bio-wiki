class AddTypeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :type_id, :integer
    add_index :posts, :type_id
  end
end
