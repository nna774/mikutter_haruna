#-*- coding: utf-8 -8

require 'net/http'
require 'uri'
require 'nokogiri'

Plugin.create(:harunahadaijoubu) do
  UserConfig[:harunahadaijoubu_timeout] ||= 10
  UserConfig[:harunahadaijoubu_name] ||= "榛名"
  UserConfig[:harunahadaijoubu_shindan] ||= "344032"
  UserConfig[:harunahadaijoubu_hour] ||= 0
  UserConfig[:harunahadaijoubu_minute] ||= 3
  
  settings "榛名の時間" do
    boolean '有効', :harunahadaijoubu_enable
    adjustment("タイムアウト(sec)", :harunahadaijoubu_timeout, 0, 60)
    input("診断番号", :harunahadaijoubu_shindan)
    input("診断する名前", :harunahadaijoubu_name)
    adjustment("発火時間(時)", :harunahadaijoubu_hour, 0, 23)
    adjustment("発火時間(分)", :harunahadaijoubu_minute, 0, 59)
  end
  def haruna(service)
    begin 
      Net::HTTP.start('shindanmaker.com') do |http|
        http.read_timeout = UserConfig[:harunahadaijoubu_timeout].to_i
        res = http.post("/#{UserConfig[:harunahadaijoubu_shindan]}", "u=#{UserConfig[:harunahadaijoubu_name]}")
        doc = Nokogiri::HTML::parse(res.body)
        txt = doc.xpath('//textarea').first.inner_text
        service.update(:message => txt)
      end
    rescue
      notice "timeout! @harunatime"
      Plugin.activity(:error, "榛名は大丈夫じゃないです。")
    end
  end

  def harunatime
    now = Time.new
    result = Time.local(now.year, now.month, now.day, UserConfig[:harunahadaijoubu_hour], UserConfig[:harunahadaijoubu_minute])
    while result < now
      result += 86400 end
    result end

  def main 
    if UserConfig[:harunahadaijoubu_enable] 
      Reserver.new(harunatime){
        haruna(Service.primary)
        sleep 1
        main
      }
    end
  end
  
  main
  
end




