require 'test_helper'

# rails test test/lib/a3rt_text_summary_test.rb 

class A3rtTextSummaryTest < ActiveSupport::TestCase

  ##
  # A3RT Text Summarization API のテスト
  test "A3RT Text Summarization API" do
    api = Api::A3rtTextSummary.new

str = <<"EOS"
日本における焼きそばは家庭料理や飲食店のメニューとして一般的である。
さらに屋外であっても鉄板一枚あれば調理可能なことや調理手順が簡単な事から、
縁日の露店、学園祭などイベントの模擬店・売店、スナックコーナーなど様々な場所で売られている。
EOS

    result = api.exec(str)
    p "** A3RT Text Summarization API 処理結果 **" 
    p result
  end

end
