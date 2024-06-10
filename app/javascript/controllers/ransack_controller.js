import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ransack"
export default class extends Controller {
  connect() {
  }

  remove(event) {
    event.preventDefault();
    event.currentTarget.closest('.fields').remove()
  }
}
