let tab = document.querySelectorAll("table.table")[1];

let idVente = document.URL.split("?")[1].split("&")[1].split("=")[1];

/**@type {[HTMLCollection]} */
let rows = tab.querySelectorAll("tr")

for (let a = 0; a < rows.length; a++) {
    let childNode = null;
    let childElement = null;
    if (a == 0) {
        childNode = document.createElement("th");
            childNode.classList.add('contenuetable')
            childNode.setAttribute("width", "7%")
            childNode.setAttribute("align", "center")
            childNode.setAttribute("valign", "top")
        childElement = "Action"
    } else {
        childNode = document.createElement("td");
        childElement = `
            <a class="btn btn-primary pull-right" href="?but=vente/echanger.jsp&idvente=${idVente}&idproduit=${rows[a].children[0].innerText}&payement=0">
                Echanger
            </a>
            <a class="btn btn-primary pull-right" href="?but=vente/echanger.jsp&idvente=${idVente}&idproduit=${rows[a].children[0].innerText}&payement=1">
                Echanger Et Payer
            </a>
        `
    }

    let children = rows[a].children[4].innerHTML.trim();
    
    if (parseInt(children) == 0) {        
        rows[a].remove();
    }

    childNode.innerHTML  = childElement;
    rows[a].appendChild(childNode)
} 