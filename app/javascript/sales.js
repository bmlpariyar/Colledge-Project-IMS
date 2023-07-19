
  document.addEventListener("DOMContentLoaded", function() {
    const productSelect = document.querySelector(".product_field");
    const quantity = document.querySelector("#quantity_field");
    const discount = document.querySelector("#discount_field");
    

    function updateFields() {
      const productId = productSelect.value;
      const quantityValue = quantity.value;
      const discountValue = discount.value;
      const vatValue = parseFloat(document.getElementById("vat_field").value);
    
      if (productId !== "") {
        fetch(`/products/${productId}/getProduct`)
          .then(response => response.json())
          .then(data => {
            document.getElementById("cost_price_field").value = data
            
            if (quantityValue !== "") {
              const qData = parseInt(quantityValue);
              const cost_price = parseFloat(data);
              const total = (qData * cost_price).toFixed(2);
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
              console.log(typeof(taxableAmount));
              const vatAmount = (vatValue / 100) * taxableAmount;
              const netTotal = (taxableAmount + vatAmount).toFixed(2);
              document.getElementById("nettotal_field").value = netTotal;
            }
          });
      }
    }
  
    productSelect.addEventListener("change", updateFields);
    quantity.addEventListener("change", updateFields);
    discount.addEventListener("change", updateFields);
  });
  

