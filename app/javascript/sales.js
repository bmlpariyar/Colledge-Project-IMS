
  document.addEventListener("DOMContentLoaded", function() {
  const saleForm = document.getElementById("sale-form"); // Assuming the form has an ID "sale-form" for example

  function updateFields() {
    const productSelect = saleForm.querySelector(".product_field");
    const quantity = saleForm.querySelector("#quantity_field");
    const discount = saleForm.querySelector("#discount_field");
    const productId = productSelect.value;
    const quantityValue = quantity.value;
    const discountValue = discount.value;
    const vatValue = parseFloat(document.getElementById("vat_field").value);
  
    if (productId !== "") {
      fetch(`/products/${productId}/getProduct`)
        .then(response => response.json())
        .then(data => {
          document.getElementById("selling_price_field").value = data.selling_price
          data = data.selling_price
          if (quantityValue !== "") {
            const qData = parseInt(quantityValue);
            const selling_price = parseFloat(data);
            const total = (qData * selling_price).toFixed(2);
            document.getElementById("total_field").value = total;
          }
          if (discountValue !== "") {
            const totalValue = parseFloat(document.getElementById("total_field").value);
            const discountAmount = (discountValue / 100) * totalValue;
            const taxableAmount = (totalValue - discountAmount).toFixed(2);
            document.getElementById("taxableamt_field").value = taxableAmount;
          }
          if (vatValue !== "") {
            const taxableAmount = parseFloat(document.getElementById("taxableamt_field").value);
            const vatAmount = (vatValue / 100) * taxableAmount;
            const netTotal = (taxableAmount + vatAmount).toFixed(2);
            document.getElementById("nettotal_field").value = netTotal;
          }
        });
    }
  }

  function handleSubmit(event) {
    event.preventDefault();
    const formData = new FormData(saleForm);
  
    fetch("/sales", {
      method: "POST",
      body: formData,
    })
      .then((response) => {
        if (response.ok) {
          // If the form submission was successful, reload the page
          location.reload();
        } else {
          return response.json().then((data) => {
            console.error("Error submitting form:", data);
  
            // Assuming you have an element with ID "error-message" to display the error message
            const errorMessageElement = document.getElementById("error-message");
            if (errorMessageElement) {
              errorMessageElement.innerHTML = "<div style='color: red'><h2>" + data.length + " error(s) prohibited this sale from being saved:</h2><ul>";
  
              data.forEach((error) => {
                errorMessageElement.innerHTML += "<li>" + error.full_message + "</li>";
              });
  
              errorMessageElement.innerHTML += "</ul></div>";
            }
          });
        }
      })
      .catch((error) => {
        console.error("Error submitting form:", error);
        // Handle the error if the form submission fails
      });
  }
  

  saleForm.addEventListener("change", function(event) {
    const target = event.target;
    if (target.matches(".product_field, #quantity_field, #discount_field")) {
      updateFields();
    }
  });

  saleForm.addEventListener("submit", handleSubmit);

  // Call updateFields initially to handle any pre-filled values on page load
  updateFields();
});

  

