birthday = ['Birthday wishes', 'Happy birthday', 'Celebrate', 'Cake', 'Party', 'Best Wishes', 'Fun', 'Kisses', 'Verjaarsdag', 'Bonne Fete!' , 'Geburtstag', 'Buon Compleanno!', 'Gefeliciteerd!'] 
birthday_counts = Hash.new({ value: 0 })

SCHEDULER.every '2s' do
  random_birthday = birthday.sample
  birthday_counts[random_birthday] = { label: random_birthday, value: (birthday_counts[random_birthday][:value] + 1) % 30 }
  
  send_event('birthday', { items: birthday_counts.values })
end