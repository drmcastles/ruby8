# frozen_string_literal: true

require_relative 'lib/route.rb'
require_relative 'lib/station.rb'

require_relative 'lib/trains/passenger_train.rb'
require_relative 'lib/trains/cargo_train.rb'

require_relative 'lib/carriages/cargo_carriage.rb'
require_relative 'lib/carriages/passenger_carriage.rb'

a = Station.new('a')
b = Station.new('b')
c = Station.new('c')
d = Station.new('d')
e = Station.new('e')
f = Station.new('f')
g = Station.new('g')
h = Station.new('h')

train1 = CargoTrain.new('abc-01', 'companyname')
train2 = PassengerTrain.new('abc-02', 'companyname')
train3 = CargoTrain.new('abc-03', 'companyname')
train4 = PassengerTrain.new('abc-04', 'companyname')

route1 = Route.new(a, d)
route2 = Route.new(e, h)

car1 = PassengerCarriage.new('car1', 9)
car1.reserve_capacity
car1.reserve_capacity
p car1.available_capacity; p car1.reserved_capacity
p car1
car2 = CargoCarriage.new('car2', 10)
car2.reserve_capacity(5)
car2.reserve_capacity(4)
p car2.available_capacity; p car2.reserved_capacity
p car2

a.train_in(train1)
a.train_in(train2)
a.train_in(train3)
a.train_in(train4)
# train_lambda = lambda{ |train| p "#{train.number} => #{train}" }
# my_proc = Proc.new{ |train| p "#{train.number} => #{train}" }
# #a.block_test("STRING", &my_proc)
# a.block_test(&my_proc)
# #a.block_test { |train| p "fdgdfg" }
