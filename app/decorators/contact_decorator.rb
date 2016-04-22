class ContactDecorator < Draper::Decorator
  delegate :id, :name, :last_name, :phone
end