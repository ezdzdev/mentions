class AddIndexToTableName < ActiveRecord::Migration
  def change
    add_index :lol_pics, :pid, unique: true
    add_index :lol_pics, :url, unique: true
  end
end
