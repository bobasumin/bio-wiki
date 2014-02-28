class AddTitleToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :title, :string
  end
end
