class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.string :visit_key
      t.date :starts_on
      t.date :ends_on

      t.timestamps null: false
    end
    add_index :visitors, [:visit_key, :ends_on]
    add_index :visitors, [:starts_on, :ends_on]
  end
end
