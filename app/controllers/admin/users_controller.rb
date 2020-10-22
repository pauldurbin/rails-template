class Admin::UsersController < Admin::AuthController
  def index
    render action: :index, locals: { users: users }
  end

  def new
    render action: :new, locals: { user: User.new }
  end

  def create
    User.new(permitted_params).tap do |user|
      if user.save
        redirect_to admin_users_path, notice: 'User created.'
      else
        render :new, locals: { user: user }
      end
    end
  end

  def edit
    render action: :edit, locals: { user: user }
  end

  def update
    user.attributes = permitted_params

    if user.save
      redirect_to admin_users_path, notice: 'User successfully updated.'
    else
      render :edit, locals: { user: user }
    end
  end

  def destroy
    if user.destroy
      flash[:notice] = 'User successfully removed.'
    else
      flash[:error] = 'User could not be removed at this time.'
    end
    redirect_to admin_users_path
  end

  private

  def permitted_params
    params.require(:user).permit(
      :role_ids, :email, :password, :password_confirmation
    )
  end

  def users
    @users ||= User.all
  end

  def user
    @user ||= User.find(params[:id])
  end
end
