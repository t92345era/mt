require 'net/http'
require 'uri'
require 'rexml/document'

module Api

## 
# Yahoo 文書校正APIを呼び出す API Client
class YahooKousei < ApiClient

  CLIENT_ID = "dj00aiZpPUs1UDFxcnlXQTZUOSZzPWNvbnN1bWVyc2VjcmV0Jng9Mzc-"

  ##
  # 文書校正APIの実行
  # @param sentence 解析対象のテキスト
  def exec(sentence) 

    # URLおよびクエリパラメタ設定
    url = URI.parse("https://jlp.yahooapis.jp/KouseiService/V1/kousei")
    url.query = [
      "appid=" + URI.encode(CLIENT_ID),
      "sentence=" + URI.encode(sentence)
    ].join("&")

    # getリクエスト送信
    res = get_request(url, true);
  
    # エラーの場合、nilを返却
    return nil if res.code != "200"

    # xml解析する
    kosei_list = []
    doc = REXML::Document.new(res.body)
    # - word要素分繰り返し
    doc.elements.each("//ResultSet/Result") do |el|
      # - Resultタグ内の各要素を読み取って、hashに格納
      kosei_list << ["StartPos", "Length", "Surface", "ShitekiWord", "ShitekiInfo"].inject({}) do |h, nm|
        child_el = el.get_elements(nm)[0]
        h[nm] = child_el.nil? ? nil : child_el.text 
        h
      end
    end

    # 結果をハッシュで返却
    return kosei_list
  end #end of exec

end #end of class
end #end of module