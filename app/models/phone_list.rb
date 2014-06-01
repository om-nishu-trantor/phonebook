class PhoneList < ActiveRecord::Base

  validates_presence_of [:phone, :name]
  validates :phone, uniqueness: true
  validates_format_of :phone, :with => /\A[89]\d{7}\z/, :message => "number should be a valid Singaporian number"
end
