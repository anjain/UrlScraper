class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :url
      t.text :h1
      t.text :h2
      t.text :h3
      t.text :links

      t.timestamps null: false
    end
  end
end
