import { Controller } from "@hotwired/stimulus"
import Quagga from 'quagga';


// Connects to data-controller="barcode-handler"
export default class extends Controller {
  static targets = ["videoInput"]

  connect() {
    console.log("controller connected")
  }

  async findbyBarcode() {
    // Function triggered by change-event on image input

    console.log(this.videoInputTarget.files[0])
    console.log(URL.createObjectURL(this.videoInputTarget.files[0]))

    // attempt to locate and read barcode in image
    let detectedResult = await this.detectBarcode()
    let barcode = detectedResult.codeResult.code

    console.log(barcode)
    if (!barcode) {
      console.log("Couldn't find a barcode, please try again")
      return
    }

    let location = `https://world.openfoodfacts.org/api/v0/product/${barcode}.json`

    fetch(location).then(console.log)
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
