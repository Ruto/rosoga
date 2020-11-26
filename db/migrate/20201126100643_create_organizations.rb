class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :alias
      t.string :type
      t.string :ancestry
      t.string :category
      t.boolean :income
      t.boolean :direct_expense
      t.boolean :indirect_expense
      t.boolean :administrative_cost
      t.boolean :active
      t.integer :organization_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :organizations, [:ancestry]
  end
end
