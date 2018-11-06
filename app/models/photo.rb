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
    state :published                    
    state :archived                    
    state :rejected                                    

    event :verify do
      transitions from: [:unverified], to: :verified
    end

    event :reject do
      transitions from: [:unverified], to: :rejected
    end

    event :reverify do
      transitions from: [:verified], to: :unverified
    end

    event :publish do
      transitions from: [:verified], to: :published
    end

    event :unpublish do
      transitions from: [:published], to: :verified
    end

    event :archive do
      transitions from: [:published, :verified, :unverified], to: :archived
    end
  end

  private

  def price_for_unverified
    errors.add(:base, 'error text')
    if price.presence?
      f.object.aasm_state
    end
  end

end
