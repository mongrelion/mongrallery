DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean
puts 'Database cleaned!'

user = User.new(
  name:                 'Homer J. Simpson',
  email:                 'homer@thesimpsons.com',
  password:              's3cr3t',
  password_confirmation: 's3cr3t'
)
user.admin = true
user.save!
puts <<-MSG
  ===================================
  * An admin user has been created. *
  * Email:    homer@thesimpsons.com *
  * Password: s3cr3t                *
  ===================================
MSG
