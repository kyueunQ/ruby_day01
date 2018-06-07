require 'sinatra'
require 'httparty'
require 'nokogiri'
require 'json'

get '/menu' do
    
    menu = ['chicken', 'pizza', 'noodle', 'rice', 'soup', 'bread', 'icecream']
    select_menu = menu.sample(3)
    '오늘의 삼시세끼 추천메뉴는 ' + select_menu.to_s + ' 입니다.' + '내일의 삼시세끼 추천메뉴는 ' + select_menu.to_s + ' 입니다.'
end


get '/lotto' do

    num = (1..45).to_a
    # num.sample(6).reverse: 내림차순
    choice = num.sample(6).sort().reverse
    '추천 로또 번호는 ' + choice.to_s + ' 입니다.'

end


get '/kospi' do
    response = HTTParty.get("http://finance.daum.net/quote/kospi.daum?nil_stock=refresh")
    # Nokogiri: HTML, XML, SAX, and Reader parse
    # Python 크롤링의 BeautifulSoup, bs(response, "html.parser")와 유사
    kospi = Nokogiri::HTML(response)
    result = kospi.css("#hyenCost > b")
    # result를 출력하면 <b>2,453.76</b>를 출력
    # 온전히 데이터만 출력하기 위해 .text로 변형
    result.text
end


get '/check_lotto' do
    url ="http://m.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=807"
    lotto = HTTParty.get(url)
    result = JSON.parse(lotto)
    
    numbers = []
    bonus = result["bnusNO"]
    
    result.each do |k, v|
        if k.include?("drwtNO")
            numbers << v
        end
    end
    my_numbers = (1..45).to_a
    my_lotto = my_numbers.sample(6).sort()
    
    count = 0
    numbers.each do |num|
        count += 1 if my_lotto.include?(num)
    end
    puts "당첨 개수는 " + count.to_s + " 입니다."
    
    
    count2 = 0
    numbers.each do 
        count2 += 1 if bonus.eql(num2)
    end
    puts "보너스 번호 당첨은 " + count2.to_s + "개" + "입니다."
    
    puts "총 당첨 갯수는 " + (count2+count).to_s + "입니다."
    
end


get '/html_file' do
    # prameter명을 name으로 지정
    # @를 통해 client도 볼 수 있게함
    @name = params[:name]
    name = "hoho"
    # send_file 대신 사용함
    erb :my_first_html
end


get '/calculate' do
    num1 = params[:num1].to_i
    num2 = params[:num2].to_i
    
    @num_sum = num1 + num2
    @num_mul = num1 * num2
    @num_minus = num1 - num2
    @num_divi = num1 / num2
    
    erb :my_calculator

end

puts "test"



