class Mac < ApplicationRecord

  belongs_to :host
  has_many :ips, dependent: :destroy

  validates :address, presence: true, uniqueness: true

  def address_string_with_vendor
    vendor = '' #Macker.lookup(address)&.name
    address_string = address
    address_string << " (#{vendor})" if vendor.present?
    address_string
  end

  def to_s
    address
  end

end