module ProductsHelper
  def product_filters(options)
    params.permit(:content,:category_id).merge(options)
  end
end
