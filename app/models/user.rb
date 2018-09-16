class User < ApplicationRecord
  # хелпер одному юзеру - все фото
  # Модули девайса, подключеные/не подключенные
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  has_many :photos
end
