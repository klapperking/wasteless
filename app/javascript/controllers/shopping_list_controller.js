import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="shopping-list"
export default class extends Controller {
  arrayIngredients = []
  static target = "ingredient"
  connect() {
  }

  select(event) {
    const checkbox = event.currentTarget
    const clicked = checkbox.dataset.selected === "true"
    const ingredientId = checkbox.dataset.ingredientId
    const ingredientQty = checkbox.dataset.ingredientQty
    // console.log(clicked)
    if (clicked) {
      checkbox.dataset.selected = "false"
      this.arrayIngredients = this.arrayIngredients
      this.arrayIngredients.forEach(hash => {
        console.log(this.arrayIngredients[hash])
        if (hash["ingredient_id"] == ingredientId) {
          // console.log(ingredientId, hash["ingredient_id"]);
          const index = this.arrayIngredients.indexOf(hash)
          this.arrayIngredients.splice(index, 1)
       }
      });
      // console.log(typeof ingredientId)
      checkbox.classList.add("fa-square");
      checkbox.classList.remove("fa-square-check");
    }
    else {
      const hash = {ingredient_id: ingredientId, ingredient_qty: ingredientQty}
      this.arrayIngredients.push(hash)
      checkbox.classList.add("fa-square-check");
      checkbox.classList.remove("fa-square");
      checkbox.dataset.selected = "true"
    }
    // this.element.dataset.selected = "true"
    // console.log(this.element.dataset.selected)
    console.log(this.arrayIngredients)
  }

  dropdown(event) {
    const categoryCard = event.currentTarget
    console.log(categoryCard);
    console.log(this.ingredientTarget)
  }
}
