
student_list = [
["jane", "asdf"],
["ben", "asdf"],
["phil", "asdf"],
["bill", "asdf"],
["fred", "asdf"], 
["mary", "asdf"],
["bob", "asdf"], 
["brad", "asdf"],
["sue", "asdf"],
["admin", "asdf"]
]

song_list = [
"Human Nature", 
"The Scientist", 
"Someone Like You",
"Let It Be",
"Hey Jude",
"Piano Man",
"Skyfall", 
"Amapola",
"Overjoyed",
"Stardust"
]


student_song_list = [
[1, 1], [1, 4], [1, 2], [2, 2], [2, 5], [2, 3],
[3, 3], [3, 6], [3, 4], [4, 4], [4, 5], [5, 5], 
[5, 6], [1, 6], [2, 1], [3, 2], [9, 9], [8, 8],
[7, 8], [7, 9], [8, 6] 
]

student_list.each do |username, password|
  Student.create(username: username, password: password)
end

song_list.each do |name|
  Song.create(name: name)
end

student_song_list.each do |student_id, song_id|
  StudentSong.create(student_id: student_id, song_id: song_id)
end






