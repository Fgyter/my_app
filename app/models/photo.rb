class Photo < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validate :price_for_unverified
  validate :image_for_work_ready

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

  def image_for_work_ready
    errors.add(:base, I18n.t(:change_status)) if image.present? && aasm_state == 'work'
  end

  def price_for_unverified
    errors.add(:base, I18n.t(:change_status)) if price.present? && aasm_state == 'unverified'
  end
end
