// app/assets/javascripts/purchase.js

document.addEventListener("DOMContentLoaded", function() {
  const supplierSelect = document.querySelector("#purchase_supplier_id");
  const productSelect = document.querySelector("#purchase_product_id");

  supplierSelect.addEventListener("change", function() {
    const supplierId = supplierSelect.value;
    if (supplierId !== "") {
      fetch(`/suppliers/${supplierId}/products`)
        .then(response => response.json())
        .then(data => {
          productSelect.innerHTML = ""; // Clear previous options
          if (data.length > 0) {
            data.forEach(product => {
              const option = document.createElement("option");
              option.value = product.id;
              option.text = product.name;
              productSelect.appendChild(option);
            });
          } else {
            const option = document.createElement("option");
            option.text = "No products available";
            productSelect.appendChild(option);
          }
        });
    } else {
      productSelect.innerHTML = ""; // Clear product options if no supplier is selected
      const option = document.createElement("option");
      option.text = "Please Select Product";
      productSelect.appendChild(option);
    }
  });
});

