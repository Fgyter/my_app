class User < ApplicationRecord
  
  # Модули девайса, подключеные/не подключенные
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  # хелпер одному юзеру - все фото
  has_many :photos
end
