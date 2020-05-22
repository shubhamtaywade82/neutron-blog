# frozen_string_literal: true

# userclass
class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :articles
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { minimum: 3, maximum: 25 }
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX },
                    length: { maximum: 105 }
end
