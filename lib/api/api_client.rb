module Api

##
# APIクライアントの基底クラス
class ApiClient

  ##
  # GETリクエストを送信し、そのレスポンスを取得する
  # @param url リクエストURL
  # @return レスポンス
  def get_request(url, use_ssl = true)

    req = Net::HTTP::Get.new(url.request_uri)

    # getリクエスト送信
    res = Net::HTTP.start(url.host, url.port, :use_ssl => use_ssl) do |http|
      http.request(req)
    end
    res
  end

end #end of class
end #end of module