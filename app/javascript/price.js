function price () {
  const itemPrice = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  
  itemPrice.addEventListener("keyup", () => {
    const priceValue = parseFloat(itemPrice.value);
    const addTaxPriceValue = Math.floor(priceValue * 0.1); // 小数点以下を切り捨て
    const addProfitValue = priceValue - addTaxPriceValue;
    
    addTaxPrice.innerHTML = addTaxPriceValue;
    profit.innerHTML = addProfitValue;
  });
};

window.addEventListener('load', price);