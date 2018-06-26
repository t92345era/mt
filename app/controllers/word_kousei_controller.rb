###
# 文書校正コントローラ
class WordKouseiController < ApplicationController

  ### 
  # インデックスアクション
  def index
    render "index"
  end

  ### 
  # API 文書校正
  def api_kousei

    # POSTパラメータ受け取り
    source_text = params[:source_text]

    # API呼び出し
    api = Api::YahooKousei.new
    result = api.exec(source_text)

    # JSON
    render :json => result
  end
  



end
