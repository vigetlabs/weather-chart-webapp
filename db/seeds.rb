# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: "Chicago" }, { name: "Copenhagen" }])
#   Mayor.create(name: "Emanuel", city: cities.first)

first = DataType.create(identifier: "0", name: "Temperature", x_res: "360", now: "3", position: "20,20,20,20,20,20", light: "40:40:40,40:40:40,40:40:40,40:40:40,40:40:40,40:40:40")
DataType.create(identifier: "1", name: "Precipitation", x_res: "360", now: "3", position: "30,30,30,30,30,30", light: "40:40:40,40:40:40,40:40:40,40:40:40,40:40:40,40:40:40")

Setting.create(data_type_id: first.id, x_res: "360", now: "2", position: "20,20,20,20,20,20", light: "40:40:40,40:40:40,40:40:40,40:40:40,40:40:40,40:40:40")
