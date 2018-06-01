class Profile < ApplicationRecord
  before_save :capitalize_names

  belongs_to :user

  has_one_attached :avatar

  validates :first_name, :last_name, length: { minimum: 2, maximum: 50 }

  def capitalize_names
    first_name.capitalize!
    last_name.capitalize!
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
