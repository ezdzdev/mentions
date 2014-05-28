class CreateLolPics < ActiveRecord::Migration
  def change
    create_table :lol_pics do |t|
      t.string :pid 
      t.string :url 
      t.timestamps
    end
    add_index :lol_pics, [:pid, :url], unique: true 
  end
end
