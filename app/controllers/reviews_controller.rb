class ReviewsController < Spree::BaseController
  helper Spree::BaseHelper

  def index
    @product = Product.find_by_permalink params[:product_id]
    @approved_reviews = Review.approved.find_all_by_product_id(@product.id) 
  end

  def new
    @product = Product.find_by_permalink params[:product_id] 
    @review = Review.new :product => @product
    authorize! :new, @review
  end

  # save if all ok
  def create
    @product = Product.find_by_permalink params[:product_id]
    params[:review][:rating].sub!(/\s*stars/,'') unless params[:review][:rating].blank?

    @review = Review.new(params[:review])
    @review.product = @product
    @review.user = current_user if user_signed_in?
    @review.locale = I18n.locale.to_s
    
    authorize! :create, @review
    
    if @review.save
      flash[:notice] = t('review_successfully_submitted')
      redirect_to (product_path(@product))
    else
      flash[:notice] = t('review_not_submitted')
      render :action => "new" 
    end
  end
  
  def terms
  end
end
