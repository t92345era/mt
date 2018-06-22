require 'net/http'
require 'uri'
require 'rexml/document'

module Api

## 
# APIクラス
class YahooKeitaiso < ApiClient

  CLIENT_ID = "dj00aiZpPUs1UDFxcnlXQTZUOSZzPWNvbnN1bWVyc2VjcmV0Jng9Mzc-"

  ##
  # 形態素解析の実行
  # @param sentence 解析対象のテキスト
  def exec(sentence) 

    # URLおよびクエリパラメタ設定
    url = URI.parse("https://jlp.yahooapis.jp/MAService/V1/parse")    
    url.query = [
      "appid=" + URI.encode(CLIENT_ID),
      "results=ma",
      "sentence=" + URI.encode(sentence)
    ].join("&")

    # getリクエスト送信
    res = get_request(url, true);
  
    # エラーの場合、nilを返却
    return nil if res.code != "200"

    # xml解析する
    words = []
    doc = REXML::Document.new(res.body)
    # - word要素分繰り返し
    doc.elements.each("//ma_result/word_list/word") do |el|
      # - wordタグ内の各要素を読み取って、hashに格納
      words << ["surface", "reading", "pos"].inject({}) do |h, nm|
        child_el = el.get_elements(nm)[0]
        h[nm] = child_el.nil? ? nil : child_el.text 
        h
      end
    end

    return words
  end

end #end of class
end #end of module