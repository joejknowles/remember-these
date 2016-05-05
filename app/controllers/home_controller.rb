require 'open-uri'
class HomeController < ApplicationController
  def index
  end

  def search
    @username = params[:username]
    @all = all_bands
    @last_month = last_month
    @result = @all - @last_month
    render :index
  end

  def all_bands
    JSON.parse(open("http://ws.audioscrobbler.com/2.0/?method=user.gettopartists&user=#{@username}&period=overall&api_key=4b62ea447ec4381e040a1bea57bc2a57&format=json").read)['topartists']['artist'].map {|artist| artist['name'] }
  end

  def last_month
    JSON.parse(open("http://ws.audioscrobbler.com/2.0/?method=user.gettopartists&user=#{@username}&period=1month&api_key=4b62ea447ec4381e040a1bea57bc2a57&format=json").read)['topartists']['artist'].map {|artist| artist['name'] }
  end

  def last_week
    JSON.parse(open("http://ws.audioscrobbler.com/2.0/?method=user.getweeklyartistchart&user=#{@username}&api_key=4b62ea447ec4381e040a1bea57bc2a57&format=json").read)['weeklyartistchart']['artist'].map {|artist| artist['name'] }
  end

  def most_missed
    @all_bands - @last_month
  end
end
