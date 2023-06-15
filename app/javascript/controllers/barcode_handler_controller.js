import { Controller } from "@hotwired/stimulus"
import Quagga from 'quagga';


// Connects to data-controller="barcode-handler"
export default class extends Controller {
  static targets = ["videoInput", "add", "form", "quantity"]

  connect() {
    const url = new URL(window.location.href);
    const getParam = url.searchParams.get('scan');

    if (getParam === "true") {
      // trigger video Input (Barcode reading and lookup)
      this.videoInputTarget.click()

      // open the submit form (and fill the value)
      this.addTarget.click()
    }
  }

  async findbyBarcode() {
    // Function triggered by change-event on image input

    // attempt to locate and read barcode in image
    let detectedResult = await this.detectBarcode()
    console.log(detectedResult)
    if (!detectedResult) {
      // render flash
      const flash_html = "<div class='alert alert-warning alert-dismissible fade show m-1' role='alert' data-controller='flash' data-flash-target='generic'>Couldn't find a barcode in the image<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>"

      document.body.insertAdjacentHTML("afterend", flash_html)
      return
    }

    const barcode = detectedResult.codeResult.code
    // Demo: Fallback harcoded Gallo Spaghetti
    // let barcode = "8410069018540"
    //let integrealBarcode = "8426765496295"

    let offUrl = `https://world.openfoodfacts.org/api/v0/product/${barcode}.json`

    let ingredientInfo = await fetch(offUrl).then(response => response.json())
    let ingredientName = ingredientInfo.product.product_name
    let ingredientQuantity = ingredientInfo.product.product_quantity

    // set form target to ingredient name
    for (var i = 0; i < this.formTarget.options.length; i++) {
      var option = this.formTarget.options[i];

      // Compare the text of each option with the desired value
      if (option.text === ingredientName) {
        // Set the selected option based on its value
        this.formTarget.value = option.value;
        this.quantityTarget.value = ingredientQuantity
        break;
      }
    }
  }

  detectBarcode() {
    // wait for decoder to find a result
    return new Promise((resolve) => {
      Quagga.decodeSingle({
        decoder: {
          readers: ["ean_reader"]
        },
        locate: true,
        src: `${URL.createObjectURL(this.videoInputTarget.files[0])}`
      }, response => resolve(response))
    })
  };
}
