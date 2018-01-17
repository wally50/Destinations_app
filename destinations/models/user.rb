class User <ActiveRecord::Base
  has_secure_password
  # this gives me 3 new methods
  # getting the password_digest
  # setting the password_digest

end
