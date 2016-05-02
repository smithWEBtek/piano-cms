
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
"Scientist", 
"Someone",
"Let It Be",
"Hey Jude",
"Piano Man",
"Skyfall", 
"Amapola",
"Overjoyed",
"Stardust"
]


student_song_list = [
[1, 1], [1, 2], [1, 3],[1, 4], 
[2, 2], [2, 3], [2, 4], [2, 5],  
[3, 3], [3, 4], [3, 5], [3, 6],
[4, 4], [4, 5], [4, 6], [4, 7],
[5, 5], [5, 6], [5, 7], [5, 8], 
[6, 6], [6, 7], [6, 8], [6, 9],
[7, 1], [7, 2], [7, 3], [7, 4], 
[8, 2], [8, 3], [8, 4], [8, 5], 
[9, 3], [9, 4], [9, 5], [9, 6]
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






