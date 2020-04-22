class AddGaToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :ga, :string
  end
end
