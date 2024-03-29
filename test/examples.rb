require "json"
require "dewu"

puts JSON.pretty_generate(r)

# brand: 9, Vans
# category: 31, 篮球鞋
#
# "spu_id": 2165,
# "category_id": 38,
# "category_name": "板鞋",
# "brand_id": 9,
# "brand_name": "Vans",
# "article_number": "VN0A38G6N9E",
# "other_numbers": "",
# sku_ids: 600421504,600421503
# bidding_no: 101220033457145946

r = Dewu::Service.auth_brand_list;  # brand/

r = Dewu::Service.brand_category_spus_oversea_sync(9, { category_ids: 31 });  # 9: Vans,
r = Dewu::Service.batch_article_number("VN0A38G6N9E")  # => spu/sku list

r = Dewu::Service.bidding_generic_list(3, spu_id: 2165) #
r = Dewu::Service.bidding_generic_list(3, spu_id: 1061786) #
r = Dewu::Service.bidding_generic_list(3, spu_id: 2165, sku_ids: "600421504,600421503") #
r = Dewu::Service.bidding_generic_list(3, sku_ids: "600421504,600421504") #

r = Dewu::Service.bidding_generic_detail(101220033457145946) # bidding_no
