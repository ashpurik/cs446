class CreateConsiders < ActiveRecord::Migration
  def change
    create_table :considers do |t|

      t.timestamps
    end
  end
end
