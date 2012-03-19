Fabricator(:album) do
  name        { sequence(:album_name) { |n| "Album ##{n}" } }
  description { Faker::Lorem.paragraph }
end
