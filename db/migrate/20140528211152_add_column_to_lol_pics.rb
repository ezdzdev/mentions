class AddColumnToLolPics < ActiveRecord::Migration
  def change
    add_column :lol_pics, :uid, :string
  end
end
