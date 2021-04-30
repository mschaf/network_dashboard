class Host < ApplicationRecord

  has_many :macs, dependent: :destroy

end