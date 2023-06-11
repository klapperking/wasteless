import { Controller } from "@hotwired/stimulus"
import algoliasearch from "algoliasearch"

// Connects to data-controller="ingredient-search"
export default class extends Controller {
  static targets = ["searchbar"];

  connect() {
    // on connect, initialize algoliasearch-client
    fetch('/api/environment_variables')
    .then(response => response.json())
    .then(data => {
      const algoliaAppID = data.algoliaAppID;
      const algoliaSearchOnlyAPIKey = data.algoliaSearchOnlyAPIKey
      this.client = algoliasearch(algoliaAppID, algoliaSearchOnlyAPIKey);
      this.index = this.client.initIndex('Ingredient');
    })
    .catch(error => {
      console.log("Couldn't retrieve API vars")
    })
  }

  searchUpdate() {

    // only trigger searching when 3 or more characters are present
    if (this.searchbarTarget.value.length < 3) {
      return null
    }

    // search for matching ingredients in IngredientIndex (see connect())
    this.index.search(this.searchbarTarget.value, { hitsPerPage: 10, page: 0 })
    .then(function searchDone(content) {
      console.log(content)
    })
    .catch(function searchFailure(err) {
      console.error(err)
    });
  };
}
