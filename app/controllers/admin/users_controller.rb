class Admin::UsersController < ApplicationController
	before_filter :authenticate_user!
  before_filter :require_is_admin, :except => [:index , :show]
  before_filter :is_user_num_limited?, :only => [:new,:create,:update]

  layout 'admin'

  @@user_limit_num = 8

  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @makes }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    logger.info("$$$$$$$$$")
    respond_to do |format|
      if @user.save
        @users = User.all
        #redirect_to @user
        format.html { render action: "index", notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to admin_users_url, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end

  def is_user_num_limited?
    @users = User.all
    unless @users.length < @@user_limit_num
      flash[:alert] = "Reach the user maximum number: " +@@user_limit_num.to_s 
      redirect_to admin_users_path
    end
  end
end
