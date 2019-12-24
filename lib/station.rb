# frozen_string_literal: true

require_relative 'instance_counter.rb'

class Station
  include InstanceCounter

  EMPTY_NAME_ERROR = 'Station name can not be empty!'
  TRAINS_ERROR = 'There are no trains at this station!'
  DUPLICATE_ERROR = 'This station already exist!'

  attr_reader :name, :trains

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(station_name)
    @name = station_name
    @trains = []
    register_instance
    validate!
    @@stations << self
    register_instance
  end

  def trains_on_station
    trains_on_station_validate!
    trains
  end

  def trains_by_type(type)
    trains_on_station_validate!
    trains.count { |train| train.is_a?(type) }
  end

  def delete_train(train)
    trains.delete(train)
  end

  def train_in(train)
    trains << train
  end

  def each_train
    trains_on_station_validate!
    trains.each { |train| yield(train) }
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    raise EMPTY_NAME_ERROR if name.nil? || name.length.zero?
    raise DUPLICATE_ERROR if @@stations.any? { |station| station.name == name }
  end

  def trains_on_station_validate!
    raise TRAINS_ERROR if trains.empty?
  end
end
