class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :owner, only: [:edit, :update, :destroy]
# действия контроллера 7 - CRUD   :new, 
# Create(Сздание) - new + create
# Read(Просмотр) - show + index
# Update(обновление) - edit + update
# Destroy(удаление) - destroy 
  def index # просмотр все экземпляры
    @photos = Photo.order(id: :desc).page(params[:page])
    ###
    @amount = 500
    @description = 'Description of Charge'
    ###
  end


  def show #просмотр (один экземпляр)
  end

  def new # создание новой фото current_user.photos.build
    @photo = current_user.photos.build
  end

  def edit # обновление - подгружает форму редакриторования
  end


  def create # создание-добавление новой фото в базу данных
    @photo = current_user.photos.build(photo_params)
      if @photo.save
        redirect_to @photo, notice: 'Фото создано'
      else
        render :new
      end
      ########
      amount = 500

    @customer = Stripe::Customer.create(email:  params[:stripeEmail],
                                       source: params[:stripeToken])

    @charge = Stripe::Charge.create(customer:    @customer.id,
                                    amount:      amount,
                                    description: 'Rails Stripe customer',
                                    currency:    'cad')
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
    ########
  end

  def update # обновление
      if @photo.update(photo_params)
        redirect_to @photo, notice: 'Фото обновлено'
      else
        render :edit
      end
  end

  def destroy # удаление
    @photo.destroy
      redirect_to photos_url, notice: 'Фото удалено' 
  end

  private

    def owner      
       @photo = current_user.photos.find_by(id: params[:id])
         redirect_to photos_path, notice: "У вас нет разрешения на изменение этой фотографии" if @photo.nil?
    end
    
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def photo_params
      params.require(:photo).permit(:description, :image)
    end
end
