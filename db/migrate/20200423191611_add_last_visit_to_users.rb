class AddLastVisitToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :last_visit, :datetime
  end
end
