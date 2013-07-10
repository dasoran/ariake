# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Event.create(name: "C84", begin_at: "2013/08/09 00:00:00", end_at: "2013/08/11 23:59:59")
Goods.create({"name" => "新刊セット", "price" => 0, "is_generic" => true})
Goods.create({"name" => "新刊", "price" => 0, "is_generic" => true})
Goods.create({"name" => "新作グッズ", "price" => 0, "is_generic" => true})

