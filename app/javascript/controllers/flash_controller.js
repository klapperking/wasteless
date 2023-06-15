import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ["generic"]

  async connect() {
    await setTimeout(() => {
      // this.genericTarget.style.transition= "opacity 2s ease";
      // this.genericTarget.style.opacity="0"
    }, 2000);
    // this.genericTarget.class.add("d-none")
  }
}
