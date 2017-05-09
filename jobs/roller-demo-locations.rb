buzzwords = ['LEOPOLDSHOEHE-ASEMISSEN',
'PADERBORN',
'GRONAU',
'BRAUNSCHWEIG',
'HAMBURG',
'STUHR/GROSS MACKENSTEDT',
'MANNHEIM',
'BAUTZEN',
'SCHWELM',
'GUESTROW',
'SCHWERIN',
'GOERLITZ',
'LEIPZIG',
'FREIBURG',
'FLENSBURG'] 
buzzword_counts = Hash.new({ value: 0 })

SCHEDULER.every '2s' do
  random_buzzword = buzzwords.sample
  buzzword_counts[random_buzzword] = { label: random_buzzword, value: (buzzword_counts[random_buzzword][:value] + 1) % 30 }
  
  send_event('roller-locations', { items: buzzword_counts.values })
end
