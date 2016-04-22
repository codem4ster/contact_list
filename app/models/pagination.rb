class Pagination
  include Attrio
  include ApplicationHelper::MassAssignment
  include Draper::Decoratable

  define_attributes do
    attr :total_pages, Integer
    attr :current_page, Integer
    attr :next_page, Integer
    attr :prev_page, Integer
  end
end