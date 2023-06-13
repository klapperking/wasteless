import { Controller } from "@hotwired/stimulus"
import Quagga from 'quagga';

// Connects to data-controller="barcode-handler"
export default class extends Controller {
  static targets = ["videoInput"]

  connect() {
    console.log("controller connected")
  }

  findbyBarcode() {
    // Function triggered by change-event on image input

    console.log(this.videoInputTarget.files[0])
    console.log(URL.createObjectURL(this.videoInputTarget.files[0]))

    // attempt to locate and read barcode in image
    Quagga.decodeSingle({
      decoder: {
          readers: ["ean_reader"]
      },
      locate: true,
      src: `${URL.createObjectURL(this.videoInputTarget.files[0])}`
  }, function(result){
      console.log(result)
      if(result && result.codeResult) {
          console.log("result", result.codeResult.code);
      } else {
          console.log("not detected");
      }
  });
  }
}
