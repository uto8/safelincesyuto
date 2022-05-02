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
    },
    {
      name: 'のむらゆうと',
      email: 'nomura@gmail.com',
      password: '12345678',
      is_admin: false
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
