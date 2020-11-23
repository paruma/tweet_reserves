class ApplicationController < ActionController::Base

    # 参考: [Bootstrapに対応したflashメッセージを実装する　【Day 2/30 2nd】｜K\.Tawara｜note](https://note.com/kentarotawara/n/nec80138f1a05)
    add_flash_types :success, :info, :warning, :danger
end
