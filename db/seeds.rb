# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  [
    {
      name: '伊藤',
      password: "0000",
      admin: true 
    },
    {
      name: 'ヤマダ',
      password: "0001",
      admin: true
    },
    {
      name: '佐藤',
      password: "0002",
      admin: false
    },
    {
      name: '野村',
      password: "0003",
      admin: false
    },
    {
      name: '加藤',
      password: "0004",
      admin: false
    },
    {
      name: 'マツダ',
      password: "0005",
      admin: false
    },
    {
      name: '橋本',
      password: "0006",
      admin: false
    },
    {
      name: '山本',
      password: "0007",
      admin: false
    }
  ]
)

License.create!(
  [
    {
      name: '社長',
      fee: 1000
    },
    {
      name: '社員',
      fee: 800
    },
    {
      name: 'バイト',
      fee: 500
    }
  ]
)
