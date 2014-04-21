#-*- coding: utf-8 -8

require 'net/http'
require 'uri'
require 'nokogiri'

Plugin.create(:harunahadaijoubu) do
    def haruna(service)
      Net::HTTP.start('shindanmaker.com') do |http|
        haruan_shindan = 344032
        haruna_string = "榛名"
        res = http.post("/#{haruan_shindan}", "u=#{haruna_string}")
        doc = Nokogiri::HTML::parse(res.body)
        txt = doc.xpath('//textarea').first.inner_text
        service.update(:message => txt)
      end
    end
    # 次回のよるほー時間を取得
    def harunatime
      now = Time.new
      result = Time.local(now.year, now.month, now.day, 0, 3)
      while result < now
        result += 86400 end
      result end
    puts "haruna"
    puts harunatime
    Reserver.new(harunatime){
      haruna(Service.primary)
      puts "haruna Called"
    }

  end




