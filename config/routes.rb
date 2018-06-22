Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  ##
  # 文書校正のルーティング
  def set_up_word_kousei_routes
    get  '/work-kousei', to: 'word_kousei#index'
    # get  '/stock-graph/ap/stock-history', to: 'stock_graph#api_stock_history'
    # get  '/stock-graph/upload/history', to: 'stock_graph#import_csv'
    # post '/stock-graph/upload/history.do', to: 'stock_graph#do_import_csv'
  end

  set_up_word_kousei_routes()
end
