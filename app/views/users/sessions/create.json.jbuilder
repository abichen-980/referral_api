json.message "signed in succesfully"
json.user do
  json.partial! "users/user", user: @current_user
end
