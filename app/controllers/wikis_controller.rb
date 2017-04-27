# delete this when done pry
require 'pry'

class WikisController < ApplicationController
  
  before_action :user_signed_in?, except: [:index, :show]
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    @user = current_user
  end
  
  def create
    @wiki = Wiki.new(wikis_params)
    @wiki.user = current_user
    
    if @wiki.save
      redirect_to @wiki, notice: "Wiki was saved successfully."
    else
      flash.now[:alert] = "Error creating Wiki, please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @users = User.all
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wikis_params)
    
    #binding.pry
    
    # need to build up collaborators list from users checked, potentially explicitely say for each collaborator.
    #remove all collaborators from Wiki, then grab list of ID's from params under :collaborator_ids & loop through for each ID create collaborator ID relationship with that Wiki
    #build method in rails, build up relationship objects.  In controller action
    #use to create records: @wiki.collaborators.build(user_id: whatever)
    
    @wiki.collaborators.each do |c|
      c.delete
    end
    
    @wiki.collaborators.each do |c|
      c.build(user_id: :collaborator_ids)
    end
      
   
    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "Error saving your Wiki, please try again."
      render :edit
    end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
    
    if @wiki.destroy
      flash[:notice] = "Wiki was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting Wiki."
      render :show
    end
  end
  
  private
  def wikis_params
    params.require(:wiki).permit(:title,:body,:private)
  end
  
end
