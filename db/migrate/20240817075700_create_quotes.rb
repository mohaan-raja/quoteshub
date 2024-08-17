class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.string :name, null: false
      t.string :author, null: false, default: "Unknown"

      t.timestamps
    end
  end
end
