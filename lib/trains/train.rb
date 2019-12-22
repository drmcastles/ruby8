require_relative '../company_name.rb'
require_relative '../instance_counter.rb'

class Train
  include CompanyName
  include InstanceCounter

  EMPTY_NAME_ERROR = 'Train name can not be empty!'
  NUMBER_FORMAT_ERROR = 'Invalid train number format!( XXX-XX )'
  ACCELERATE_ERROR = 'Accelerate must be integer!'
  TYPE_MISMATCH_ERROR = 'Wrong Carrriage type!'
  SPEED_ERROR = 'You must stop to add/delete carriage!'
  CARRIAGES_SIZE_ERROR = 'No cars to delete!'
  NOT_EMPTY_CAR_ERROR = 'This car is not empty!'
  ROUTE_ERROR = 'No route specified!'
  NEXT_STATION_ERROR = 'There is no next station!'
  PREVIOUS_STATION_ERROR = 'There is no previous station!'
  NUMBER_FORMAT = /^[a-zа-я\d]{3}-?[a-zа-я\d]{2}$/i

  attr_reader :number, :speed, :route, :carriages

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, company_name)
    @number = number
    @company_name = company_name
    @speed = 0
    @current_station = nil
    @route = nil
    @carriages = []
    validate!
    register_instance
    @@trains[number] = self
  end

  def accelerate(value)
    accelerate_validate!(value)
    @speed += value
    @speed = 0 if @speed.negative?
  end

  def stop
    @speed = 0
  end

  def add_carriage(carriage)
    add_carriage_validate!(carriage)
    carriages << carriage
  end

  def delete_carriage(carriage)
    delete_carriage_validate!(carriage)
    carriages.delete(carriage)
  end

  def current_station
    route.stations[@current_station_index]
  end

  def add_route(route)
    @route = route
    @current_station_index = 0
    current_station.train_in(self)
  end

  def next_station
    route.stations[@current_station_index + 1]
  end

  def previous_station
    return unless @current_station_index.positive?

    route.stations[@current_station_index - 1]
  end

  def go_next_station
    go_next_station_validate!
    current_station.delete_train(self)
    @current_station_index += 1
    current_station.train_in(self)
  end

  def go_previous_station
    go_previous_station_validate!
    current_station.delete_train(self)
    @current_station_index -= 1
    current_station.train_in(self)
  end

  def each_carriage
    carriages.each { |car| yield(car) }
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
    raise NUMBER_FORMAT_ERROR if number.nil? || number !~ NUMBER_FORMAT
  end

  def accelerate_validate!(value)
    raise ACCELERATE_ERROR unless value.is_a? Integer
  end

  def add_carriage_validate!(carriage)
    unless carriage.is_a?(Carriage) && attachable_carriage?(carriage)
      raise TYPE_MISMATCH_ERROR
    end
    raise SPEED_ERROR unless speed.zero?
  end

  def delete_carriage_validate!(carriage)
    raise SPEED_ERROR unless speed.zero?
    raise NOT_EMPTY_CAR_ERROR if carriage.reserved_capacity.positive?
    raise CARRIAGES_SIZE_ERROR unless carriages.size.positive?
  end

  def go_next_station_validate!
    raise ROUTE_ERROR if route.nil?
    raise NEXT_STATION_ERROR if route.stations[@current_station_index + 1].nil?
  end

  def go_previous_station_validate!
    raise ROUTE_ERROR if route.nil?
    raise PREVIOUS_STATION_ERROR unless @current_station_index.positive?
  end
end
