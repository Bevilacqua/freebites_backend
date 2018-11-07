class ApplicationController < ActionController::Base
  def validation_error(resource)
    return {
          status: '400',
          title: 'Bad Request',
          detail: resource.errors,
          code: '100'
        }
  end
end
