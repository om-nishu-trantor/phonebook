class AddIndexToPhoneInPhoneList < ActiveRecord::Migration
  def change
    add_index :phone_lists, :phone, { name: 'phone_num_ix', unique: true }
  end
end
