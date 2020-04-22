class AddHitsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :hits, :integer, default: 0
  end
end
