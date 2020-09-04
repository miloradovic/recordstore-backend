class User < ApplicationRecord
  has_secure_password
  has_many :records

  def to_s
    "#{email}"
  end
end
