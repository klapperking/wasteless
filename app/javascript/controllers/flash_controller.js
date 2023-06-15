import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ["generic"]

  connect() {
    // after 1 seconds start 2s fadeout
    setTimeout(() => {
      this.genericTarget.style.transition= "opacity 2s ease";
      this.genericTarget.style.opacity="0"
    }, 1000);

    // after 1+2 seconds dont display anymore
    setTimeout(() => {
      this.genericTarget.style.display="none"
    }, 3000);
  }
}
