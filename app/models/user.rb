class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :role_users, dependent: :destroy
  has_many :roles, through: :role_users, dependent: :destroy

  VALID_EMAIL_REGEX= /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i

  validates :email , presence: true, uniqueness: { case_sensetive:false },
            format: { with:VALID_EMAIL_REGEX, multiline:true }
  validates :password, presence: true, length: { minimum: 6 }
  #below also validates presense of true or false
  validates :broker, exclusion: [nil]
  validates :buyer, inclusion: { in: [true,false] }
  #create a method to ensure that both broker and buyer fields are not set to false
  validate :broker_and_buyer_fields_cannot_be_false, on: [:create, :update]

  def broker_and_buyer_fields_cannot_be_false
    if !broker? && !buyer?
      errors.add(:broker, "and buyer fields cannot both be false.")
    end
  end

  #get the role/s from form and use it to query in Role Table so that the role_id/s
  #can be taken and passed when RoleUser entries (user with multiple roles)
  #are also created when user is created
  def role_names=(role)
    roles = Role.where("name IN (?)", role)
    self.roles << roles
  end
end
