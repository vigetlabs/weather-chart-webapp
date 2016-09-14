# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: "Chicago" }, { name: "Copenhagen" }])
#   Mayor.create(name: "Emanuel", city: cities.first)

first = DataType.create(identifier: "0", name: "Temperature", x_res: "360", now: "0", position: "10,35,55,75,85,90", light: "70,65,61,57,55,54")
DataType.create(identifier: "1", name: "Precipitation", x_res: "360", now: "0", position: "10,35,55,75,85,90", light: "")

Setting.create(data_type_id: first.id, x_res: "360", now: "0", position: "10,35,55,75,85,90", light: "70,65,61,57,55,54")
