// app/assets/javascripts/purchase.js

document.addEventListener("DOMContentLoaded", function() {
  const supplierSelect = document.querySelector("#purchase_supplier_id");
  const productSelect = document.querySelector("#purchase_product_id");
  const quantity = document.querySelector("#purchase_quantity");
  const getTotal = document.getElementById("#total_field")


  //for product 
  supplierSelect.addEventListener("change", function() {
    const supplierId = supplierSelect.value;
    if (supplierId !== "") {
      fetch(`/suppliers/${supplierId}/products`)
        .then(response => response.json())
        .then(data => {
          productSelect.innerHTML = ""; // Clear previous options
          if (data.length > 0) {
            const option = document.createElement("option");
            option.value = 0;
            option.text = "Select Product";
            productSelect.appendChild(option);
            if (option.value == 0) {
              document.getElementById("cost_price_field").value = "";
              document.getElementById("total_field").value = "";
              document.getElementById("purchase_quantity").value = "";
            }
            data.forEach(product => {
              const option = document.createElement("option");
              option.value = product.id;
              option.text = product.name;
              productSelect.appendChild(option);
            });
          } else {
            const option = document.createElement("option");
            option.id = 0;
            option.text = "No Products ";
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

  function updateFields() {
    const productId = productSelect.value;
    const quantityValue = quantity.value;
  
    if (productId !== "") {
      fetch(`/products/${productId}/getProduct`)
        .then(response => response.json())
        .then(data => {
          document.getElementById("cost_price_field").value = data;
          
          if (quantityValue !== "") {
            const qData = parseInt(quantityValue);
            const cost_price = parseInt(data);
            const total = qData * cost_price;
    
            document.getElementById("total_field").value = total;
          }
        });
    }
  }
  
  productSelect.addEventListener("change", updateFields);
  quantity.addEventListener("change", updateFields);
});

