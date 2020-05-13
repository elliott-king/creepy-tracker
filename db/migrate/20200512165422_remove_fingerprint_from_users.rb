class RemoveFingerprintFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :fingerprint
  end
end
