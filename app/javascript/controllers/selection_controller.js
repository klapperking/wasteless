import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="selection"
export default class extends Controller {
  arrayIngredients = []
  connect() {
  }

  select(event) {
    const card = event.currentTarget
    const clicked = card.dataset.selected === "true"
    const ingredientId = card.dataset.ingredientId
    console.log(clicked)
    if (clicked) {
      this.arrayIngredients = this.arrayIngredients.filter(id => id !== ingredientId)
      console.log(typeof ingredientId)
      card.dataset.selected = "false"
    }
    else {
      card.dataset.selected = "true"
      this.arrayIngredients.push(ingredientId)
    }
    // this.element.dataset.selected = "true"
    // console.log(this.element.dataset.selected)
    console.log(this.arrayIngredients)
  }

  submit(event) {
    const ingredientString = this.arrayIngredients.join(",")
    console.log(ingredientString)
    console.log(this.arrayIngredients)
    const url = new URLSearchParams({ ingredients: ingredientString })
    window.location.href = `/recipes?${url.toString()}`
  }
}
