class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :subtitle
      t.string :description
      t.integer :read

      t.timestamps
    end
  end
end
