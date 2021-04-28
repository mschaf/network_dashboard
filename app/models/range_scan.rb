class RangeScan < ApplicationRecord

  has_many :host_scans

  validates :target_range, presence: true
  validate :validate_ip_range

  after_create :create_host_scans

  assignable_values_for :scan_type, default: 'ping' do
    HostScan::TYPE_MAPPING.keys.map(&:to_s)
  end

  private

  def validate_ip_range
    begin
      IPAddr.new(target_range)
    rescue IPAddr::InvalidAddressError
      errors[:target_range].add('invalid range')
    end
  end

  def create_host_scans
    ip_range = IPAddr.new(target_range).to_range
    ip_range.each do |ip|
      HostScan::TYPE_MAPPING.fetch(scan_type.to_sym).create!(range_scan: self, target: ip)
    end
  end

end