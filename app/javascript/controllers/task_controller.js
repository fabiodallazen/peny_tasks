import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  submitStart (event) {
    this.element.classList.add("opacity-50");
  }

  submitEnd (event) {
    this.element.classList.remove("opacity-50");
  }
}
