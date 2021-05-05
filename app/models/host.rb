class Host < ApplicationRecord

  has_many :macs, dependent: :destroy

  scope :named, -> { where.not(name: [nil, '']) }

  def to_s
    name
  end

end