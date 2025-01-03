class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]#ログインしなくてもindexとshowはいける
  before_action :if_not_admin, except: [:show, :index]

  def index
    @items = Item.all

    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)

    @item = Item.new
    


    if params[:tag_ids]
      @items = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_items = Tag.find_by(name: key).items
          @items = @items.empty? ? tag_items : @items & tag_items
        end
      end
    
    
    end

    if params[:tag]
      Tag.create(name: params[:tag])
    end
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])

    @comments = @item.comments
    @comment = Comment.new

end

  def create
    item = Item.new(item_params)
    item.user_id = current_user.id
    if item.save
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end

  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to :action => "show", :id => item.id
    else
      redirect_to :action => "new"
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to action: :index
  end


  private
  def item_params
    params.require(:item).permit(:body, :price, :title, :image, tag_ids: [], images: [])
  end
  
  def if_not_admin
    redirect_to root_path unless current_user.email == ENV['ADMIN_EMAIL']
  end

end
