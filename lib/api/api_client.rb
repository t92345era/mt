module Api

##
# APIクライアントの基底クラス
class ApiClient

  ###
  # GETリクエストを送信し、そのレスポンスを取得する
  # @param url リクエストURL
  # @return レスポンス
  def get_request(url, use_ssl = true)

    req = Net::HTTP::Get.new(url.request_uri)

    # getリクエスト送信
    Net::HTTP.start(url.host, url.port, :use_ssl => use_ssl) do |http|
      http.request(req)
    end
  end

  ### 
  # POSTリクエストを送信し、そのレスポンスを取得する
  def post_request(url, data, use_ssl = true) 
    req = Net::HTTP::Post.new(url.request_uri)
    req.set_form_data(data)

    # postリクエスト送信
    Net::HTTP.start(url.host, url.port, 
        :use_ssl => use_ssl, 
        :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|
      http.request(req)
    end
  end

end #end of class
end #end of module