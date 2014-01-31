# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: 'Nikunj Thakkar', institute_name: 'YuvaBeat', max_tests: 10,email: 'nikunj.0407@gmail.com', password: 'ittest_admin', password_confirmation: 'ittest_admin', is_admin: true, is_direct: true, is_guest: false, mobile_no: '9833664934')
User.create(name: 'Hiren Thakkar', institute_name: 'YuvaBeat', max_tests: 10,email: 'thakkar.hiren@gmail.com', password: 'ittest_admin', password_confirmation: 'ittest_admin', is_admin: true, is_direct: true, is_guest: false, mobile_no: '9930131583')
User.create(name: 'Shraddha Machchhar', institute_name: 'YuvaBeat', max_tests: 10,email: 'mshraddha77@gmail.com', password: 'ittest_admin', password_confirmation: 'ittest_admin', is_admin: true, is_direct: true, is_guest: false, mobile_no: '9619259256')
