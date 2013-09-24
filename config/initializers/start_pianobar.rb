puts "Hello"
pwd = `pwd`
pwd = pwd.tr("\n","")
pwd = pwd.tr("\r","")
#puts @url

# Fifo path: /tmp/pbctl_fifo_control

pianobarinit = system("scripts/initialize_pianobar.bash \"#{pwd}\"")


