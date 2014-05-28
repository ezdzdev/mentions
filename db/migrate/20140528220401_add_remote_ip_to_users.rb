class AddRemoteIpToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rip, :string
  end
end
