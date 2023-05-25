
document.addEventListener("DOMContentLoaded", function() {
  var showModalButton = document.getElementById("showModalButton");
  var modal = document.getElementById("foodModal");
  var closeButton = document.getElementsByClassName("close")[0];

  showModalButton.addEventListener("click", function(e) {
    e.preventDefault();
    e.stopPropagation();
    modal.style.display = "block";
  });

  closeButton.addEventListener("click", function() {
    modal.style.display = "none";
  });
});