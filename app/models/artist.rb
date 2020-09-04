class Artist < ApplicationRecord
  has_many :records, dependent: :destroy

  validates :name, presence: true

  def to_s
    "#{name}"
  end
end
