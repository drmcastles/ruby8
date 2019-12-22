require_relative '../company_name.rb'

class Carriage
  include CompanyName

  EMPTY_NAME_ERROR = 'Carriage name can not be empty!'
  CAPACITY_ERROR = 'Capacity must be positive number!'
  RESERVE_CAPACITY_ERROR = 'Not enough space!'
  RESERVE_CAPACITY_FORMAT_ERROR = 'Enter a positive number to reserve capacity!'

  attr_reader :number, :capacity, :reserved_capacity

  def initialize(company_name, capacity)
    @company_name = company_name
    @number = 5.times.map { rand(10) }.join
    @capacity = capacity
    @reserved_capacity = 0
    validate!
  end

  def reserve_capacity(volume)
    reserve_capacity_validatie!(volume)
    @reserved_capacity += volume
  end

  def available_capacity
    @capacity - @reserved_capacity
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    raise EMPTY_NAME_ERROR if company_name.nil? || company_name.length.zero?
    raise CAPACITY_ERROR unless capacity.is_a?(Integer) && capacity.positive?
  end

  def reserve_capacity_validatie!(volume)
    unless volume.is_a?(Integer) && volume.positive?
      raise RESERVE_CAPACITY_FORMAT_ERROR
    end
    raise RESERVE_CAPACITY_ERROR if volume > available_capacity
  end
end
