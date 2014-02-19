class AddStatusToPets < ActiveRecord::Migration
  def change
    add_column :pets, :status, :string, default: 'Available'
  end
end
