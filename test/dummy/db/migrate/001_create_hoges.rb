class CreateHoges < ActiveRecord::Migration[5.2]
  def change
    create_table :hoges do |t|
      t.integer :integer
      t.string  :string
      t.boolean :boolean
      t.date    :date

      t.timestamps
    end
  end
end
