module ApplicationHelper
  module MassAssignment
    def initialize(attributes = {})
      self.attributes = attributes
    end

    def attributes=(attributes = {})
      self.class.attributes.keys.each do |attr|
        value = attributes.is_a?(Hash) ? attributes[attr] : (attributes.send(attr) if attributes.respond_to?(attr))
        self.send("#{attr}=", value) if self.respond_to?("#{attr}=")
      end
    end
  end
end
