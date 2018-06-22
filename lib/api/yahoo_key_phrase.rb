require 'net/http'
require 'uri'
require 'rexml/document'
require 'json'

module Api

## 
# キーフレーズ抽出を行う APIを呼び出す API Client
class YahooKeyPhrase < ApiClient

  CLIENT_ID = "dj00aiZpPUs1UDFxcnlXQTZUOSZzPWNvbnN1bWVyc2VjcmV0Jng9Mzc-"

  ##
  # 形態素解析の実行
  # @param sentence 解析対象のテキスト
  def exec(sentence) 

    # URLおよびクエリパラメタ設定
    url = URI.parse("https://jlp.yahooapis.jp/KeyphraseService/V1/extract")    
    url.query = [
      "appid=" + URI.encode(CLIENT_ID),
      "output=json",
      "sentence=" + URI.encode(sentence)
    ].join("&")

    # getリクエスト送信
    res = get_request(url, true);
  
    # エラーの場合、nilを返却
    return nil if res.code != "200"

    # JSONをパース
    result = JSON.parse(res.body).map do |key, value|
      {:keyphrase => key, :score => value}
    end

    # スコアの降順でソートしてから返す
    return (result.sort! do |a, b|
      a[:score] <=> b[:score]
    end).reverse!

  end

end #end of class
end #end of module