12.times do |i|
   Report.create(message: "test message #{i}")
end

Report.create(status: "up")

User.create(email: "test@example.com", password: '123123', is_admin: true)
