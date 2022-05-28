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
    },
    {
      name: '部長',
      email: 'butyou@gmail.com',
      password: '12345678',
      is_admin: false
    },
    {
      name: '課長',
      email: 'katyou@gmail.com',
      password: '12345678',
      is_admin: false
    },
    {
      name: '係長',
      email: 'kakarityou@gmail.com',
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
    },
    {
      name: '運転手当',
      fee: 1500
    },
    {
      name: '出張手当',
      fee: 2500
    },
    {
      name: '規制手当',
      fee: 3500
    },
    {
      name: '隊長手当',
      fee: 4500
    }
  ]
)

Project.create!(
  [
    {
      name: '伝票１',
      date: '2022-05-01',
      start_time: '2000-01-01 09:45:00.000000000 +0000',
      end_time: '2000-01-01 18:45:00.000000000 +0000',
      leader_id: 2,
      address: '場所１',
      supplement: '備考１'
    },
    {
      name: '伝票２',
      date: '2022-05-01',
      start_time: '2000-01-01 09:45:00.000000000 +0000',
      end_time: '2000-01-01 18:45:00.000000000 +0000',
      leader_id: 1,
      address: '場所２',
      supplement: '備考２'
    }
  ]
)
