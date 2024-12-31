json.message "signed up succesfully."
json.user do
  json.partial! "users/user", user: @current_user
end
