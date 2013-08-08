User.all.each do |u|
  u.permission = "normal"
  u.permission = "stop" if u.is_pending
  u.permission = "admin" if u.administrator
  u.save
end

