class AddLocationToBiocards < ActiveRecord::Migration
  def change
    add_column :biocards, :location, :string
  end
end
