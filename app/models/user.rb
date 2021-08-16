class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  VALID_EMAIL_REGEX= /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
  #ensure that email is present, unique and processed as if case insensitive
  validates :email , presence: true, uniqueness: { case_sensetive:false },
            format: { with:VALID_EMAIL_REGEX, multiline:true }
  validates :password, presence: true, length: { minimum: 6 }

  #METHOD 1 to do role based access/permissions
  #Add admin, broker and buyer columns as boolean
  #below also validates presense of true or false
  validates :broker, exclusion: [nil]
  validates :buyer, inclusion: { in: [true,false] }
  #use below method to ensure that both broker and buyer fields are not set to false
  validate :broker_and_buyer_fields_cannot_be_false, on: [:create, :update]

  def broker_and_buyer_fields_cannot_be_false
    if !broker? && !buyer?
      errors.add(:broker, "and buyer fields cannot both be false.")
    end
  end

  #METHOD 2:  CREATE HAS MANY THROUGH ASSOCIATION BET USER AND ROLE
  #establish association
  has_many :role_users, dependent: :destroy
  has_many :roles, through: :role_users, dependent: :destroy

  #use serialize method to save role_names as array of strings
  serialize :role_names, Array

  #get the role/s from form and use it to search in Role Table so that the role_id/s
  #can be taken and passed /used to create RoleUser entries (user with multiple roles)
  #when user is created
  def role_names=(role)
    #secure syntax that does not show the actual value/s being searched and compared to names in Role
    roles = Role.where("name IN (?)", role)
    self.roles << roles
  end
end
