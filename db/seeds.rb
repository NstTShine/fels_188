User.create!(name: "Example User", email: "example@abc.org",
  phone_number: "0986030060", password: "banhxe",
  password_confirmation: "banhxe", is_admin: true)

9.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@abc.org"
  password = "banhxe2"
  User.create!(name: name, email: email, phone_number: "0979797979",
    password: password, password_confirmation: password)
end

10.times do |n|
  name = "Mina-Bai #{n + 1}"
  description = "Cung hoc tieng nhat nao !!!!"
  Category.create!(name: name, description: description)
end

9.times do |n|
  category_id = n + 1;
  20.times do |i|
    content = "人間-#{i + 1}"
    Word.create!(category_id: category_id, content: content)
  end
end

150.times do |n|
  word_id = n + 1;
  content_answer1 = "Con Nguoi-#{n + 1}"
  Answer.create!(word_id: word_id, content: content_answer1, is_correct: true)
  content_answer2 = "Con Meo-#{n + 1}"
  Answer.create!(word_id: word_id, content: content_answer2, is_correct: false)
  content_answer3 = "Con Lon-#{n + 1}"
  Answer.create!(word_id: word_id, content: content_answer3, is_correct: false)
  content_answer4 = "Con Trau-#{n + 1}"
  Answer.create!(word_id: word_id, content: content_answer4, is_correct: false)
end
