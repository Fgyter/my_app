class Photo < ApplicationRecord
  mount_uploader :image, ImageUploader
  mount_uploader :ready_image, ReadyImageUploader

  has_secure_token :token
  belongs_to :user

  validate :price_for_unverified

  include AASM
  aasm do
    state :unverified, initial: true     
    state :verified                     
    state :work
    state :work_ready                   
    state :payment                    
    state :cancel                                    

    event :verify do
      transitions from: [:unverified], to: :verified
    end

    event :to_cancel do
      transitions from: [:unverified, :verified], to: :cancel
    end

    event :reverify do
      transitions from: [:verified], to: :unverified
    end

    event :to_work do
      transitions from: [:verified], to: :work
    end

    event :to_ready do
      transitions from: [:work], to: :work_ready
    end

    event :to_pay do
      transitions from: [:work_ready], to: :payment
    end

    event :pay_to do
      transitions from: [:payment], to: :work_ready
    end
  end

  private

  def price_for_unverified
    errors.add(:base, I18n.t(:change_status_verified)) if aasm_state != 'unverified' && price.nil?
  end
end
