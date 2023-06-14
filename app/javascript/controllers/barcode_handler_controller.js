import { Controller } from "@hotwired/stimulus"
import Quagga from 'quagga';


// Connects to data-controller="barcode-handler"
export default class extends Controller {
  static targets = ["videoInput", "barcode"]

  connect() {
    console.log("controller connected")
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
    let spaghettiBarcode = "8410069018540"
    // let integrealBarcode = "8426765496295"

    let offUrl = `https://world.openfoodfacts.org/api/v0/product/${spaghettiBarcode}.json`

    let ingredientInfo = await fetch(offUrl).then(response => response.json())

    console.log(ingredientInfo)

    let ingredientName = ingredientInfo.product.product_name

    console.log(ingredientName)

    this.barcodeTarget.innerHTML = `<p>${ingredientName}</p>`
    // fetch(location).then(console.log)
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
