class Removeusercolumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :user
  end
end
