class Contact < ActiveRecord::Base
  paginates_per 10

  validates_presence_of :name, :last_name, :phone
  validates_format_of :phone, :with => /\+\d{2}\s\d{3}\s\d{7}/
end
