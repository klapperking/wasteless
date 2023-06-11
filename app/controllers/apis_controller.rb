class ApisController < ApplicationController
  def environment_variables
    # authorize for evn-var retrieval
    authorize :api, :environment_variables?

    render json: {
      algoliaAppID: ENV.fetch('ALGOLIA_API_APP_ID'),
      algoliaSearchOnlyAPIKey: ENV.fetch('ALGOLIA_API_KEY_SEARCH')
    }
  end
end
