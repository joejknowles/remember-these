require 'open-uri'
class HomeController < ApplicationController
  def index
  end

  def search
    @username = params[:username]
    @all = all_bands
    @last_month = last_month
    @results = most_missed
    render :index
  end

  def all_bands
    JSON.parse(open("http://ws.audioscrobbler.com/2.0/?method=user.gettopartists&user=#{@username}&period=overall&api_key=4b62ea447ec4381e040a1bea57bc2a57&format=json").read)['topartists']['artist']
  end

  def last_month
    JSON.parse(open("http://ws.audioscrobbler.com/2.0/?method=user.gettopartists&user=#{@username}&period=1month&api_key=4b62ea447ec4381e040a1bea57bc2a57&format=json").read)['topartists']['artist']
  end

  def most_missed
    recent_names = @last_month.map { |m_artist| m_artist["name"] }
    @all.reject { |band| recent_names.include? band["name"]}
  end
end
