class Address::Mac < Address

  def vendor
    Macker.lookup(address)&.name
  end

end