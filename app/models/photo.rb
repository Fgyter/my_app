class Photo < ApplicationRecord
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

	mount_uploader :image, ImageUploader
	belongs_to :user
	has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100>" }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
