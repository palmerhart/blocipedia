class WikisController < ApplicationController
  def index
    @wiki = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end
  
  def create
    @wiki = Wiki.new(wikis_params)
    
    if @wiki.save
      redirect_to @wiki, notice: "Wiki was saved successfully."
    else
      flash.now[:alert] = "Error creating Wiki, please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wikis_params)
    
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
