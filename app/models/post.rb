require "oembed"
OEmbed::Providers.register_all

class Post < ApplicationRecord
    has_many :post_tags, dependent: :destroy
    has_many :tags, :through => :post_tags

    def embed()
        url = self.url
        begin 
          if url
            embed_json = OEmbed::Providers.get(url)
            if embed_json
              return embed_json.html.html_safe
            end
          end
        rescue => error
          puts error
          return nil
        end
    end
end
