require 'spec_helper'

describe "AddPhoneRecords", :js => true do
  describe "GET phone_lists#index" do
    it "should create a new record" do
      new_record=['John', '89574125']
      visit "/phone_lists"
      click_on('Add Contact')
      fill_in('phone_list_name', :with => new_record.first)
      fill_in('phone_list_phone', :with => new_record.second)
      sleep 2
      click_on('Save Changes')
      sleep 2
      expect(page).to have_content(new_record.first)
      expect(page).to have_content(new_record.second)
    end
  end
end
