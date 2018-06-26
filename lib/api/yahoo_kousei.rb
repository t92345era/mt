require 'net/http'
require 'uri'
require 'rexml/document'

module Api

## 
# Yahoo 文書校正APIを呼び出す API Client
class YahooKousei < ApiClient

  CLIENT_ID = "dj00aiZpPUs1UDFxcnlXQTZUOSZzPWNvbnN1bWVyc2VjcmV0Jng9Mzc-"

  ##
  # 校正支援APIの実行
  # @param sentence 解析対象のテキスト
  # @return 文書校正の指摘結果JSON
  # [
  #   {
  #     StartPos: 2,    //対象文字列開始位置（先頭からの文字数）
  #     Length:5        //対象文字列長（対象文字数）
  #     Surface: "NNN"  //対象表記
  #     ShitekiWord:    //言い換え候補文字列。複数の候補が返される際には、間に読点がはさまれます
  #     ShitekiInfo:    //指摘の詳細情報。リクエストパラメータ no_filterの説明で挙げた指摘内容のうち、どれか1つを表示します
  #   }
  #   , 
  #   ...
  # ]
  def exec(sentence) 

    # API呼び出し用の URL を作成
    url = URI.parse("https://jlp.yahooapis.jp/KouseiService/V1/kousei")
    url.query = [
      "appid=" + URI.encode(CLIENT_ID),
      "sentence=" + URI.encode(sentence)
    ].join("&")

    # getリクエスト送信
    res = get_request(url, true);
  
    # エラーの場合、nilを返却
    return nil if res.code != "200"

    # 校正支援APIからは XMLでレスポンスが返ってくるため、
    # xmlの結果を jsonに変換する
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
  end

end #end of class
end #end of module