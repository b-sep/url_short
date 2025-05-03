import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="success"
export default class extends Controller {
  static targets = ['shortUrl'];

  copy(event) {
    const shortUrl = this.shortUrlTarget;

    navigator.clipboard.writeText(shortUrl.value);

    event.target.innerText = 'COPIADO';
  }
}
