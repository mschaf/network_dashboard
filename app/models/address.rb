class Address < ApplicationRecord

  IPV4_REGEX = /\A(?:\d{1,3}\.){3}\d{1,3}\z/

  validates :address, presence: true, uniqueness: true
  belongs_to :host

end