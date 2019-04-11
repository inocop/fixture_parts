class CreateFugas < ActiveRecord::Migration[5.2]
  def change
    create_table :fugas do |t|
      t.string :name

      t.timestamps
    end
  end
end
