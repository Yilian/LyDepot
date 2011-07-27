require 'digest/sha2'

class User < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  
  validates :password, :confirmation => true
  attr_accessor :password_confirmation => true
  attr_reader :password
  
  validate :password_must_be_present
  
  #验证用户，当输入正确的用户名与密码时，返回一个user对象
  class << self
    def authenticate(name, password)
      if user = find_by_name(name)
        if user.hashed_password == encrypt_password(password, user.salt)
          user
        end
      end
    end
  end
  
  #使用salt值，结合密码明文产生一个字符串，最后使用SHA2对其加密产生16进制的40个字符
  def encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "wibble" + salt)
  end
  
  #对明文进行加密，将明文转换成哈希字符串
  def password=(password)
    @password = password
    
    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end
  
  private
  def password_must_be_present
    errors.add(:password, "Missing password") unless hashed_password.present?
  end
  
  #随机产生salt值
  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end 
end
