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
      name: '野村優登',
      email: 'yuto@gmail.com',
      password: 'password',
      is_admin: true
    }
  ]
)

License.create!(
  [
    {
      title: '運転手当',
      fee: 1500
    },
    {
      title: '出張手当',
      fee: 2500
    },
    {
      title: '規制手当',
      fee: 3500
    },
    {
      title: '隊長手当',
      fee: 4500
    }
  ]
)
