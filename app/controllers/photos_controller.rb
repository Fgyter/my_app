class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :owner, only: [:edit, :update, :destroy]

  def index
    @photos = current_user.photos.order(id: :desc).page(params[:page])
    @amount = 500
    @description = 'Description of Charge'
    @q = Photo.ransack(params[:q])
  end   

  def show
  end

  def new 
    @photo = current_user.photos.build
  end

  def edit
  end

  def create 
    @photo = current_user.photos.build(photo_params)
      if @photo.save
        redirect_to @photo, notice: t(:photo_create)
      else
        render :new
      end
  return
    amount = 500

    @customer = Stripe::Customer.create(email:  params[:stripeEmail],
                                       source: params[:stripeToken])
    @charge = Stripe::Charge.create(customer:    @customer.id,
                                    amount:      amount,
                                    description: 'Rails Stripe customer',
                                    currency:    'cad')
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to photos_path
  end

  def update
    state = params[:state]
     if state
      if state == "work" 
        @photo.to_work!
      else 
        state == "repeal"
        @photo.repealy!
      end
      redirect_to @photo
    elsif @photo.update(photo_params)
      redirect_to @photo, notice: t(:photo_update)
    else
      render :edit
    end
  end

  def destroy
    if @photo.destroy
      redirect_to photos_path, notice: t(:photo_delete)
    end
  end

  private

    def owner      
       @photo = current_user.photos.find_by(id: params[:id])
         redirect_to photos_path, notice: t(:you_do_not_photo) if @photo.nil?
    end
    
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def photo_params
      params.require(:photo).permit(:description, :image, :update, :price, :aasm_state, :destroy)
    end
end
