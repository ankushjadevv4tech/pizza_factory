class User
  attr_accessor :username, :password

  def initialize(username, password)
    @username = username
    @password = password
  end

  # A hardcoded user (this can be changed to a real user model if needed)
  def self.find_by_username(username)
    return User.new('admin', 'password123') if username == 'admin'
    nil
  end
end
