class Hostname < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  belongs_to :ip

end

