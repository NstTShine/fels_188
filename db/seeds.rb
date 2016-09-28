User.create!(name: "Example User", email: "example@abc.org",
  phone_number: "0986030060", password: "banhxe",
  password_confirmation: "banhxe", is_admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@abc.org"
  password = "banhxe2"
  User.create!(name: name, email: email, phone_number: "0979797979",
    password: password, password_confirmation: password)
end
