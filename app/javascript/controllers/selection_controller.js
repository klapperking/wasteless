import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="selection"
export default class extends Controller {
  static targets = ["form", "input", "list", "add", "edit", "plus", "minus"]

  arrayIngredients = []
  connect() {
  }

  select(event) {
    const card = event.currentTarget
    const clicked = card.dataset.selected === "true"
    const ingredientId = card.dataset.ingredientId
    // console.log(clicked)
    if (clicked) {
      this.arrayIngredients = this.arrayIngredients.filter(id => id !== ingredientId)
      // console.log(typeof ingredientId)
      card.dataset.selected = "false"
    }
    else {
      card.dataset.selected = "true"
      this.arrayIngredients.push(ingredientId)
    }
    // this.element.dataset.selected = "true"
    // console.log(this.element.dataset.selected)
    // console.log(this.arrayIngredients)
  }

  submit(event) {
    const ingredientString = this.arrayIngredients.join(",")
    console.log(ingredientString)
    console.log(this.arrayIngredients)
    const url = new URLSearchParams({ ingredients: ingredientString })
    window.location.href = `/recipes?${url.toString()}`
  }

  update(event) {
    console.log(event.currentTarget)
    if (event.currentTarget.value.length > 0 && event.currentTarget.value.length < 3) {
      return
    }
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`
    fetch(url, {headers: {"Accept": "text/plain"}})
    .then(response => response.text())
    .then((data) => {
      this.listTarget.outerHTML = data
      this.persist()
    })
  }

  persist() {
    this.arrayIngredients.forEach((ingredient) => {
      const card_selected = this.listTarget.querySelector(`[data-ingredient-id="${ingredient}"]`)
      if (card_selected) {
        card_selected.dataset.selected = "true"
      }
    })
  }

  new() {
    this.plusTarget.classList.toggle("d-none")
    this.minusTarget.classList.toggle("d-none")
    this.addTarget.classList.toggle("d-none")
  }

  edit(event) {
    // console.log(this.shoppingTarget);
    const eventId = event.currentTarget.dataset.eventId
    // console.log(eventId);
    const paragraph = document.querySelector(`[data-selection-paragraph='${eventId}']`)
    // console.log(paragraph);
    const form = document.querySelector(`[data-selection-form='${eventId}']`)
    console.log(form);
    paragraph.classList.toggle("d-none")
    form.classList.toggle("d-none")

  }
}
