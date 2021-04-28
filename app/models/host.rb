class Host < ApplicationRecord

  has_one :mac, class_name: "Address::Mac"
  has_one :ipv4, class_name: "Address::Ipv4"

  def display_name
    human_name || hostname || ipv4&.address
  end

end