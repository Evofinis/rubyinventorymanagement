class AddAvailabilityToItem < ActiveRecord::Migration
  def change
    add_column :items, :availability, :boolean
  end
end
