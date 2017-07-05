class ChefsController < ApplicationController
  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Welcome #{@chef.name} to My Reipces App"
      redirect_to chef_path(@chef)
    else
      render 'new'
    end
  end

  def show
    @chef = Chef.find(params[:id])
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
  end

  def edit
    @chef = Chef.find(params[:id])
  end

  def update
    @chef = Chef.find(params[:id])
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
    @chef = Chef.find(params[:id])
    @chef.destroy
    flash[:danger] = "#{@chef.name.capitalize} was deleted successfully"
    redirect_to chefs_path
  end

  private
  def chef_params
    params.require(:chef).permit(:name, :email, :password, :password_confirmation)
  end
end
