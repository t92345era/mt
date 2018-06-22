require 'test_helper'

# rails test test/lib/yahoo_api_test.rb 

class YahooApiTest < ActiveSupport::TestCase

  ##
  # 形態素解析
  test "形態素解析テスト" do
    return
    api = Api::YahooKeitaiso.new
    result = api.exec("解析対象の文字列です")
    p "** 形態素解析テスト 処理結果 **" 
    p result
  end

  ##
  # キーフレーズ抽出
  test "キーフレーズ抽出テスト" do
    return
    api = Api::YahooKeyPhrase.new
    result = api.exec("今日スーパーに行って、にんじんを１本買った。")
    p "** キーフレーズ抽出テスト 処理結果 **" 
    p result
  end

  ##
  # 文書校正
  # @command rails test test/lib/yahoo_api_test.rb 文書校正テスト
  test "文書校正テスト" do

    api = Api::YahooKousei.new
    result = api.exec("遙か彼方に小形飛行機が見える。")

    p "** 文書校正テスト 処理結果 **" 
    p result

    assert_not_nil result, "戻り値が nilでないこと"
    assert_equal result.class, Array, "戻り値が 配列であること"


  end
 
end
