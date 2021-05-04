class Host < ApplicationRecord

  has_many :macs, dependent: :destroy

  def to_s
    name
  end

end