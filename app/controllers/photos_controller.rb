class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy, :to_work, :to_cancel, :to_pay, :ready_image]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :owner, only: [:edit, :update, :destroy]

  def index
    @photos = current_user.photos.order(id: :desc).page(params[:page])
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
  end

  def ready_image 
    if @photo.token 
      send_file '/publik/system/photos/ready_image/to.jpg',
                type: 'image/jpeg',
                disposition: 'attachment'
    end
  end

  def to_work
    @photo.to_work! if !@photo.work?
    redirect_to @photo
  end

  def to_cancel
    @photo.to_cancel! if !@photo.cancel?
    redirect_to @photo
  end

  def to_pay
    @customer = Stripe::Customer.create(email: params[:stripeEmail],
                                        source: params[:stripeToken])
    return redirect_to @photo if !@customer.present?
    @charge = Stripe::Charge.create(customer: @customer.id,
                                    amount: (@photo.price * 100).to_i,
                                    description: 'Rails Stripe customer',
                                    currency: 'rub')
    @photo.to_pay!
    redirect_to @photo
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to @photo
  end

  def update
    if @photo.update(photo_params)
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
      params.require(:photo).permit(:description, :image, :update, :price, :aasm_state, :ready_image)
    end
end