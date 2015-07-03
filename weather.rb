#require gem to access its code
require "yahoo_weatherman"

#define method to fetch weather in user location using the Yahoo! gem
def weather(location)
    
    #instantiate client object
    client = Weatherman::Client.new(unit: 'f')
    
    temp = client.lookup_by_location(location).condition['temp']
    condition = client.lookup_by_location(location).condition['text']

    puts "The weather right now is #{condition} with a temperature of #{temp} \xC2\xB0F."
    
    
    #instantiate forecasts
    weather = client.lookup_by_location(location)
    forecasts = weather.forecasts    
    
    ##################################
    #loop through forecast hashes to print out forecast values
    ##################################
    
    puts "Here's your 5-day forecast:"
    
    #Get today's day of the week as a number
    current_day = Time.now.strftime('%w').to_i
            
    forecasts.each do |forecast|
                        
        #Get forecast's day of the week as a number
        forecast_day = forecast['date'].strftime('%w').to_i

        #compare current day with each forecast day to determine if forecast is today, tomorrow, or another day
        if current_day == forecast_day
            weekday = 'Today'
        elsif current_day + 1 == forecast_day
            weekday = 'Tomorrow'
        elsif current_day == 6 && forecast_day == 0
            weekday = 'Tomorrow'
        else
            weekday = forecast['day']
        end

        #print out forecast in terminal
        puts weekday + "\'s forecast is " + forecast.fetch('text') + " with a low of " + forecast.fetch('low').to_s + "\xC2\xB0F and a high of " + forecast.fetch('high').to_s + "\xC2\xB0F."


    end
    ##################################
                #end loop
    ##################################
    
end

#ask user for their location
puts "What's your 5-digit zip code?"
zip = gets.chomp

weather(zip)