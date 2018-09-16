class Photo < ApplicationRecord
	#одно фото - одному юзеру
	belongs_to :user
end
