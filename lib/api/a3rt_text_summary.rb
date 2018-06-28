require 'net/http'
require 'uri'
require 'json'

module Api

###
# A3RT の文書要約 API を呼び出す API Client
class A3rtTextSummary < ApiClient

  # 書き換えてください
  CLIENT_ID = "SRxxoznPFO6OL4rUXrKXqHwP4AXH3Eah"

  ##
  # 文書要約 API の実行
  # @param sentence 解析対象のテキスト
  # @result 文書の要約結果 (ex: ["センテンス"])
  def exec(sentence) 

    # APIのURL
    url = URI.parse("https://api.a3rt.recruit-tech.co.jp/text_summarization/v1")

    separation = "。"

    # 文章数を取得
    line_count = get_line_count(sentence, separation)
    if line_count <= 1
      # 文章数が１以下の場合、APIでエラーとなるため、
      # 指定された sentence をそのまま要約結果とします
      return [sentence]
    end

    # リクエストパラメータを設定
    post_data = { 
      'apikey' => CLIENT_ID,      #APIキー
      'sentences' => sentence,    #要約する文章
      'linenumber' => 1,          #抽出文章数
      'separation' => separation  #文章の切れ目の文字
    }

    # postリクエスト送信
    res = post_request(url, post_data, true);
  
    # エラーの場合、nilを返却
    return nil if res.code != "200"

    # JSON文字列をパースし、要約結果を返却
    result = JSON.parse(res.body)
    return result['summary']
  end

  ###
  # 指定された sentence の文章数を取得します。
  # @param sentence   要約する文章
  # @param separation 文章の切れ目の文字
  # @return 文章数
  def get_line_count(sentence, separation)
    sentence.count(separation)
  end

end #end of class
end #end of module