class HostScan < ApplicationRecord

  TYPE_MAPPING = {
    ping: HostScan::Ping,
  }

  HOST_CONSIDERED_DOWN_FOR = %i(ping)

  belongs_to :range_scan, optional: true
  after_create :enqueue!

  include RailsStateMachine::Model

  state_machine do
    state :created, initial: true
    state :enqueued
    state :running
    state :finished
    state :failed

    event :enqueue do
      transitions from: :created, to: :enqueued

      after_commit do
        HostScanJob.perform_later(self)
      end
    end

    event :start do
      transitions from: :enqueued, to: :running
    end

    event :finish do
      transitions from: :running, to: :finished
    end

    event :fail do
      transitions from: :running, to: :failed
    end
  end

  def perform_scan
    if enqueued?
      start!
      address = Address.find_or_initialize_by(address: target)
      address = scan(address)
      if address.persisted? || up?
        address.update_host_by_arp
        address.save!
      end

      self.scanned_at = Time.now
      finish!
    else
      fail!
    end
  end

  def scan(address)
    raise NotImplementedError
  end

  private

end
