Fabricator(:user) do
  name                  { Faker::Name.name      }
  email                 { Faker::Internet.email }
  password              's3cr3t'
  password_confirmation 's3cr3t'
  admin                 false
end

Fabricator(:admin, from: :user) do
  admin true
end
