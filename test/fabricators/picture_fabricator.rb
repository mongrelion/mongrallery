include ActionDispatch::TestProcess

Fabricator(:picture) do
  pic     { fixture_file_upload File.join Rails.root, 'test', 'support', 'files', 'rails.png' }
  caption { Faker::Lorem.paragraph }
  album!
end
