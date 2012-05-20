Fabricator(:album) do
  name        { sequence(:album_name) { |n| "Album ##{n}" } }
  description { Faker::Lorem.paragraph }
end

Fabricator(:private_album, :from => :album) do
  public false
end
