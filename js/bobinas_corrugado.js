	var escalam = 0.08;
	var escalaf = 0.40;

function DibujarUso(pCanvas = "mycanvas"){
	var canvas = document.getElementById(pCanvas);

	var s = getComputedStyle(canvas);
	var w = s.width
	var h = s.height;
	
	var W = canvas.width = w.split('px')[0];
	var H = canvas.height = h.split('px')[0];

	var ctx = canvas.getContext("2d");
	
	ctx.font='18px Arial';
	ctx.textAlign = "center";
	ctx.setTransform(1, 0, 0, 1, 0, 0);
	ctx.clearRect(0,0,canvas.width, canvas.height);

	var celdas = "";

	ctx.setTransform(1, 0, 0, 1, 50, 0);
	
	ctx.strokeStyle="#777777";
	for (var i = 0 ; i<16; i++){
		ctx.beginPath();
		ctx.moveTo(i * 1000 * escalam,0);	
		ctx.lineTo(i * 1000 * escalam,320);
		ctx.stroke();
		ctx.fillText(i + 'k'  , i * 1000 * escalam ,350);
	}

	ctx.setTransform(1, 0, 0, 1, 50, 280);
	corrugado(ctx);

	ctx.setTransform(1, 0, 0, 1, 50, 50);
	abc('A',ctx);
	ctx.setTransform(1, 0, 0, 1, 50, 120);
	abc('B',ctx);
	ctx.setTransform(1, 0, 0, 1, 50, 190);
	abc('C',ctx);
}

function corrugado(pContext){
	var id="";
	var formato="";
	var metros="";
	var calidad="";

	var m= 0;
	var tableA = document.getElementById('CORRUGADO').getElementsByTagName('tr');

	pContext.strokeStyle="#000000";
    
    pContext.fillStyle = '#000000';	
    pContext.fillText('>>' ,-20, 0);

    if (tableA.length < 2) {
    	return ;
    }

	for (var i = 2; i < tableA.length; i++)
	{
		celdas =  tableA[i].getElementsByTagName('td');

		id =  celdas[0].innerHTML;
		formato =  celdas[1].innerHTML.replace(".","");
		metros =  celdas[2].innerHTML.replace(".","");
		calidad =  celdas[3].innerHTML;	

		switch (calidad.substr(0,1)){
			case "3":
				pContext.fillStyle = '#ece2c6';	
				break;
			case "5":
				pContext.fillStyle = '#f7e9a0';	
				break;
			case "L":
				pContext.fillStyle = '#f9c27d';	
				break;
			case "M":
				pContext.fillStyle = '#c38974';	
				break;
			case "B":
				pContext.fillStyle = '#f5fbf7';	
				break;
			default:
				pContext.fillStyle = '#ff3';	
		}

		pContext.globalAlpha = 0.3;
			pContext.fillRect(m,0,metros * escalam , -400);
		pContext.globalAlpha = 0.8;
			pContext.fillRect(m,0,metros * escalam , -40);
		pContext.globalAlpha = 1;

		pContext.fillStyle = '#000000';	
		pContext.beginPath();
		pContext.rect(m,0,metros * escalam ,-40);
		pContext.stroke();
		pContext.fillText(id,m + metros * escalam/2, -10);
		m = m + metros * escalam;	
	}
}

function abc(pLugar,pContext){
	var bobina="";
	var formato="";
	var metros="";
	var tipo="";

	var m= 0;
	var tableA = document.getElementById('TABLE_'+pLugar).getElementsByTagName('tr');

	pContext.strokeStyle="#000000";
    
    pContext.fillStyle = '#000000';	
    pContext.fillText(pLugar ,-20, 0);

    if (tableA.length < 2) {
    	return ;
    }

	for (var i = 2; i < tableA.length; i++)
	{
		celdas =  tableA[i].getElementsByTagName('td');

		bobina =  celdas[0].innerHTML;
		tipo =  celdas[1].innerHTML;
		formato =  celdas[2].innerHTML.replace(".","");
		metros =  celdas[3].innerHTML.replace(".","");
		switch (tipo){
			case "C":
				pContext.fillStyle = '#ece2c6';	
				break;
			case "O":
				pContext.fillStyle = '#f7e9a0';	
				break;
			case "L":
				pContext.fillStyle = '#f9c27d';	
				break;
			case "M":
				pContext.fillStyle = '#c38974';	
				break;
			case "B":
				pContext.fillStyle = '#f5fbf7';	
				break;
		}
		pContext.globalAlpha = .8;
		pContext.fillRect(m,formato*escalaf/-2,metros * escalam , formato*escalaf);
		
		pContext.globalAlpha = 1;
		pContext.fillStyle = '#000000';	
		pContext.beginPath();
		pContext.rect(m,formato*escalaf/-2,metros * escalam , formato*escalaf);
		pContext.stroke();
		pContext.fillText(bobina ,m + metros * escalam/2, 0);
		m = m + metros * escalam;	
	}
}




