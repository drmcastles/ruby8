require_relative 'instance_counter.rb'

class Route
  include InstanceCounter

  TYPE_MISMATCH_ERROR = 'Route elements must be Station type objects!'
  DUPLICATE_ERROR = 'There is already such a station in the route!'
  DELETE_ERROR = 'Can not delete start or last stations!'

  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
    register_instance
  end

  def first_station
    stations.first
  end

  def last_station
    stations.last
  end

  def add_station(station)
    add_station_validate!(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    delete_station_validate!(station)
    stations.delete(station)
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    unless stations.all? { |station| station.is_a?(Station) }
      raise TYPE_MISMATCH_ERROR
    end
    raise DUPLICATE_ERROR if stations.first == stations.last
  end

  def delete_station_validate!(station)
    raise DELETE_ERROR if [first_station, last_station].include?(station)
  end

  def add_station_validate!(station)
    raise TYPE_MISMATCH_ERROR unless station.is_a?(Station)
    raise DUPLICATE_ERROR if stations.include?(station)
  end
end
