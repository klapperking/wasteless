# configure for search-index building and updating
AlgoliaSearch.configuration = {
  application_id: ENV.fetch('ALGOLIA_API_APP_ID'),
  api_key: ENV.fetch('ALGOLIA_API_KEY_ADMIN')
}
