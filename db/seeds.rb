user = User.new(
  email:                 'admin@example.co',
  password:              's3cr3t',
  password_confirmation: 's3cr3t'
)
user.admin = true
user.save!
puts <<-MSG
  An admin user has been created.
  Email:    #{user.email}
  Password: #{user.password}
MSG
