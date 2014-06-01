class AddAttachmentPhoneListFileToPhoneLists < ActiveRecord::Migration
  def self.up
    change_table :phone_lists do |t|
      t.attachment :phone_list_file
    end
  end

  def self.down
    drop_attached_file :phone_lists, :phone_list_file
  end
end
