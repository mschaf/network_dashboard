class Ip < ApplicationRecord

  belongs_to :mac, optional: true
  has_many :hostnames, dependent: :destroy

  validates :address, presence: true, uniqueness: true

end