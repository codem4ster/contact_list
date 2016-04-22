Fabricator(:contact) do
  name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  phone { /\+\d{2} \d{3} \d{7}/.random_example }
end