class ChefsController < ApplicationController
  before_action :set_chef, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  # before_action :require_admin, only: [:destroy]
  # only admin can delete a chef account, but user can delete their own account

  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      session[:chef_id] = @chef.id # login as just sign up
      cookies.signed[:chef_id] = @chef.id
      flash[:success] = "Welcome #{@chef.name} to My Reipces App"
      redirect_to chef_path(@chef)
    else
      render 'new'
    end
  end

  def show
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
  end

  def edit
  end

  def update
    if @chef.update(chef_params)
      flash[:success] = "#{@chef.name}'s profile was updated successfully"
      redirect_to @chef
    else
      render 'edit'
    end
  end

  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @chef.destroy
    flash[:danger] = "#{@chef.name.capitalize} was deleted successfully"
    session[:chef_id] = nil if !current_chef.admin?
    redirect_to chefs_path
  end

  private

    def set_chef
      @chef = Chef.find(params[:id])
    end

    def chef_params
      params.require(:chef).permit(:name, :email, :password, :password_confirmation)
    end

    def require_same_user         # alow admin to access
      if current_chef != @chef and !current_chef.admin?
        flash[:danger] = "You can only edit or delete your own account"
        redirect_to chefs_path
      end
    end

    # def require_admin  # only admin can delete a chef account
    #   if logged_in? and !current_chef.admin?
    #     flash[:danger] = "Only admin can perform this delete action"
    #     redirect_to root_path
    #   end
    # end
end
