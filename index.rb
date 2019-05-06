require 'sinatra'

#1. Get the user's birthday and store in a variable
=begin
def get_birthday
	puts "Tell me your birtday.  Use the format: MMDDYYYY\n*beep boop*"
	birthdate = gets
end
=end

#2. Take the user's response and calculate the birth path number
def get_birth_path_num(birthdate)
	number = birthdate[0].to_i + birthdate[1].to_i + birthdate[2].to_i + birthdate[3].to_i + birthdate[4].to_i + birthdate[5].to_i + birthdate[6].to_i + birthdate[7].to_i

	number = number.to_s
	number = number[0].to_i + number[1].to_i

	if number > 9
		number = number.to_s
		
		#3.  Assign the return value to a variable
		number = number[0].to_i + number[1].to_i
	end

	return number
end

#4.  Create a method that returns a specific message that corresponds to the birth path number.
def get_message(number)
	case number
	when 1
		@message = "  One is the leader.  The number one indicates the ability to stand alone and is a strong vibration.  Ruled by the Sun."
	when 2
		@message = "  Two is the mediator and peace-lover.  The number two indicates the desire for harmony.  It is a gentle, considerate, and sensitive vibration.  Ruled by the Moon."
	when 3
		@message = "  Three is a sociable, friendly, and outgoing vibration.  Kind, positive, and optimistic. Three's enjoy life and have a good sense of humor."
	when 4
		@message = "  This is the worker.  Practical, with a love for detail, Fours are trustworthy, hard-working, and helpful.  Ruled by Youranus."
	when 5
		@message = "  This is the freedom lover.  The number five is an intellectual vibration.  These are \"idea\" people with a love of variety and the ability to adapt to most situations.  Ruled by Mercury."
	when 6
		@message = "  This is the peace lover.  The number six is a loving, stable, and harmonious vibration.  Ruled by Venus."
	when 7
		@message = "  This is the deep thinker.  The number seven is a spiritual vibration.  These people are not very attached to material things, are introspective, and generally quiet.  Ruled by Neptune."
	when 8
		@message = "  This is the manager.  Number Eight is a strong, successful, and material vibration.  Ruled by Saturn."
	when 9
		@message = "  This is the teacher.  Number Nine is a tolerant, somewhat impractical, and sympathetic vibration.  Ruled by Mars."
	else
		@message = "  Uh oh!  Your birth path number is not 1-9!"
	end
end


get '/' do
	erb :form
end

#refactored get :birthdate and post :birthdate into a setup_index_view call
def setup_index_view
	birthdate = params[:birthdate]
	birth_path_num = get_birth_path_num(birthdate)
	@message = "Your numerology number is #{birth_path_num}.  " + get_message(birth_path_num)
	erb :index
end

get '/message/:birth_path_num' do
	birth_path_num = params[:birth_path_num].to_i
	@message = get_message(birth_path_num)
	erb :index
end

post '/' do 
	birthdate = params[:birthdate].gsub("-","")
	birth_path_num = get_birth_path_num(birthdate)
	redirect "message/#{birth_path_num}"
end

post '/' do
	setup_index_view
end


=begin
get '/:birthdate' do
	birthdate = params[:birthdate]
	birth_path_num = get_birth_path_num(birthdate)
	@message = "Your numerology number is #{birth_path_num}.  " + get_message(birth_path_num)
	erb :index
end

post '/' do
	birthdate = params[:birthdate]
	birth_path_num = get_birth_path_num(birthdate)
	@message = "Your numerology number is #{birth_path_num}.  " + get_message(birth_path_num)
	erb :index
end
=end