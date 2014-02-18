module CurrentConsider
  extend ActiveSupport::Concern

  private

    def set_consider
      @consider = Consider.find(session[:consider_id])
    rescue ActiveRecord::RecordNotFound
      @consider = Consider.create
      session[:consider_id] = @consider.id
    end
end
