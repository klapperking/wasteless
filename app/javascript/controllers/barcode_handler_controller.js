import { Controller } from "@hotwired/stimulus"
import Quagga from 'quagga';


// Connects to data-controller="barcode-handler"
export default class extends Controller {
  static targets = ["videoInput", "add", "form"]

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

    console.log(this.videoInputTarget.files[0])
    console.log(URL.createObjectURL(this.videoInputTarget.files[0]))

    // attempt to locate and read barcode in image
    let detectedResult = await this.detectBarcode()
    if (detectedResult) {
      let barcode = detectedResult.codeResult.code
    }

    // for now harcoded Gallo Spaghetti
    let barcode = "8410069018540"
    // let integrealBarcode = "8426765496295"

    let offUrl = `https://world.openfoodfacts.org/api/v0/product/${barcode}.json`

    let ingredientInfo = await fetch(offUrl).then(response => response.json())
    console.log(ingredientInfo)

    let ingredientName = ingredientInfo.product.product_name
    console.log(ingredientName)

    // set form target to ingredient name
    for (var i = 0; i < this.formTarget.options.length; i++) {
      var option = this.formTarget.options[i];

      // Compare the text of each option with the desired value
      if (option.text === ingredientName) {
        // Set the selected option based on its value
        this.formTarget.value = option.value;
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
