import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="remove-field"
export default class extends Controller {

  remove(event) {
    event.preventDefault();
    event.currentTarget.closest('.fields').remove()
  }
}
