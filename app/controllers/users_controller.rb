class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users/1
  # GET /users/1.json
  def show
    if !is_user_admin?
      redirect_to root_path
    end
  end

  # GET /users/new
  def new
    if !is_user_admin?
      redirect_to root_path
    end
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if !is_user_admin?
      redirect_to root_path
    end
    if @user.is_super_admin? && !is_user_super_admin?
      redirect_to root_path
    end
  end

  # POST /users
  # POST /users.json
  def create
    if !is_user_admin?
      redirect_to root_path
    end
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        UserProfile.create(user_id: @user.id)
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if !is_user_admin?
      redirect_to root_path
    end
    if @user.is_super_admin? && !is_user_super_admin?
      redirect_to root_path
    end
    respond_to do |format|
      new_params = {}
      if user_params[:password].blank?
        new_params = user_params.except(:password)
      else
        new_params = user_params
      end
      if @user.update(new_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if !is_user_admin?
      redirect_to root_path
    end
    if @user.is_super_admin? && !is_user_super_admin?
      redirect_to root_path
    end
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_tools_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:role_id, :location_id, :geofence_id, :username, :email, :password)
    end
end
