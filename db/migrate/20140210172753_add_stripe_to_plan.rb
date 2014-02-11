class AddStripeToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :stripe_plan_id, :integer
  end
end
