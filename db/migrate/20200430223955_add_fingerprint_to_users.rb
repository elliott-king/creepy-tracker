class AddFingerprintToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :fingerprint, :string
  end
end
