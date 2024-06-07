import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dynamic-fields"
export default class extends Controller {
  static targets = ["template"];

  add(event) {
    event.preventDefault();
    event.currentTarget.insertAdjacentHTML(
      "beforebegin",
      this.templateTarget.innerHTML.replace(
        /__CHILD_INDEX__/g,
        new Date().getTime().toString()
      )
    )
  }

  hide(event) {
    event.preventDefault();
    event.currentTarget.parentNode.hidden = true
  }
}
