class Photo < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validate :price_for_unverified

  include AASM
  aasm do
    state :unverified, initial: true     
    state :verified                     
    state :operation                    
    state :payment                    
    state :repeal                                    

    event :verify do
      transitions from: [:unverified], to: :verified
    end

    event :repealy do
      transitions from: [:unverified], to: :repeal
    end

    event :reverify do
      transitions from: [:verified], to: :unverified
    end

    event :operate do
      transitions from: [:verified], to: :operation
    end

    event :unoperate do
      transitions from: [:operation], to: :verified
    end

    event :pay do
      transitions from: [:operation], to: :payment
    end
  end

  private

  def price_for_unverified
    errors.add(:base, 'error text') if price.present? && aasm_state == 'unverified'
  end
end
