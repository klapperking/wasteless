import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="shopping-list"
export default class extends Controller {
  arrayIngredients = []
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
        // console.log(this.arrayIngredients[hash])
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
    // console.log(this.arrayIngredients)
  }

  submit() {
    // console.log(this.arrayIngredients);
    // console.log(event.currentTarget);
    const get_token = document.querySelector('meta[name="csrf-token"]').content
    console.log(get_token);
    const url = '/shopping-list/done'
      fetch(url, {
        method: 'POST',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'X-CSRF-Token': get_token
        },
        body: JSON.stringify(this.arrayIngredients),
      })
      .then(response => response.json())
      .then(data => {
        if (data.status == 'ok') {
          window.location.href =`/inventories/${data.id}`
        }
        else {
          console.log(data.status);
        }
      })
  }

  dropdown(event) {
    const categoryCard = event.currentTarget
    console.log(categoryCard);
    const ingredientCard = categoryCard.nextElementSibling
    ingredientCard.classList.toggle("d-none")
  }
}
