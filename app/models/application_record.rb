class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  before_create :generate_token_image

  private

  def create_token_image
  	photo.token = loop do
  		token = SecureRandom.hex(10)
  		break token unless Photo.where(token: token).exists?
    
  end
end
