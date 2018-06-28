require 'net/https'
require 'json'

module Api

###
# A3RT の文書要約 API を呼び出す API Client
class GooTextApi < ApiClient

  # ご自身のapikeyに書き換えてください
  CLIENT_ID = "726daac5ded1009721d8714ca3e1e3817c9640f2edba7026d82ddc5cb5ffa065"

  ##
  # 時刻情報正規化APIの実行
  # @param sentence 解析対象のテキスト
  #  - chrono : 時刻情報正規化API
  #  - entity : 固有表現抽出API
  # @result 正規化前後の情報を格納したリスト
  #   [[ "明日", "2018-06-29" ],[ "１０日後", "2018-07-10" ]]
  def chrono(sentence) 
    result = exec(sentence, "chrono")
    result["datetime_list"]
  end

  ##
  # gooラボAPIの実行
  # @param sentence 解析対象のテキスト
  # @param api_type 呼び出すAPIの種類
  # @result 処理結果を格納したHash
  def exec(sentence, api_type) 

    request_data = {'app_id' => CLIENT_ID, "sentence" => sentence}.to_json
    header = {'Content-type' => 'application/json'}
    
    https = Net::HTTP.new('labs.goo.ne.jp', 443)
    https.use_ssl=true
    responce = https.post("/api/#{api_type}", request_data, header)
    JSON.parse(responce.body)
  end



end #end of class
end #end of module