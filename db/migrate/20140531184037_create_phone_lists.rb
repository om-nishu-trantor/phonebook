class CreatePhoneLists < ActiveRecord::Migration
  def change
    create_table :phone_lists do |t|
      t.string :name
      t.integer :phone

      t.timestamps
    end
  end
end
