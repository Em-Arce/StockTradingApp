module StaticPagesHelper
  def get_user_name(user_id)
        @user_name = User.find_by(id: user_id)
        @user_name.email.slice(0..@user_name.email.index('@') - 1)
  end
end
