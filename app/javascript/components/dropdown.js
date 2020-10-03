document.addEventListener("turbolinks:load", () => {

  function dropdown() {
    const dropDownLinks = document.querySelectorAll('.js-nav .dropdown a');
    const dropDownMenu = document.querySelector('.dropdown-menu');

      dropDownLinks.forEach(function(dropdown) {
        dropdown.addEventListener('click', function(e) {
        const dropdownTarget = this.nextElementSibling

        if (e.target.nextElementSibling != null) {
          // Hide the dropdown
          dropdownTarget.classList.toggle('hidden');
          // Click outside of dropdown to also close
          hideOnClickOutside(this);
          e.preventDefault();
        }
      });
    });
  }

  function hideOnClickOutside(element) {
    const outsideClickListener = function(event) {
      if (!element.contains(event.target)) {
        if (!!element && !!(element.offsetWidth || element.offsetHeight || element.getClientRects().length)) {
          element.nextElementSibling.classList.toggle('hidden');
          removeClickListener();
        }
      }
    }

    const removeClickListener = function() {
      document.removeEventListener('click', outsideClickListener);
    }

    document.addEventListener('click', outsideClickListener);
  }

function init() {
  dropdown();
}

init();
});