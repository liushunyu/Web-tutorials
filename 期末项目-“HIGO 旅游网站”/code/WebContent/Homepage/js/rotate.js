

	window.addEventListener('load', function (){

		var carousels = document.querySelectorAll('.carousel');
		for (var i = 0; i < carousels.length; i++) {
			carousel(carousels[i]);
		}

	});


	function carousel(root) 
	{
		var figure = root.querySelector('figure'),
			nav = root.querySelector('nav'),
			images = figure.children,
			n = images.length,
			gap = root.dataset.gap || 0,
			theta = 2 * Math.PI / n,
			currImage = 3;
		var timecounter;  //图片移动定时器


		
		setupCarousel(n, parseFloat(getComputedStyle(images[0]).width));
		
		window.addEventListener('resize', function () {
			setupCarousel(n, parseFloat(getComputedStyle(images[0]).width));
		});

		setupNavigation();

		Init_time();

		function Init_time(){
			timecounter = window.setInterval(automove,3000);
		}
		//自动切换图片
		function automove(){
			currImage++;
			rotateCarousel(currImage);

		}

		//鼠标停在图片上时不再切换图片
	    figure.onmouseover = function() {
	        clearInterval(timecounter);
	    }
	    //鼠标移开后自动切换
	    figure.onmouseout = function() {
	        timecounter = setInterval(automove,2500);
	    }

		function setupCarousel(n, s) 
		{
			var apothem = s / (2 * Math.tan(Math.PI / n));

			figure.style.transformOrigin = '50% 50% ' + -apothem + 'px';

			for (var i = 0; i < n; i++) 
			{
				images[i].style.padding = gap + 'px';
			}
			for (i = 1; i < n; i++) 
			{
				images[i].style.transformOrigin = '50% 50% ' + -apothem + 'px';
				images[i].style.transform = 'rotateY(' + i * theta + 'rad)';
			}
			rotateCarousel(currImage);
		}

		function setupNavigation() 
		{
			nav.addEventListener('click', onClick, true);

			function onClick(e) {
				e.stopPropagation();

				var t = e.target;

				if (t.tagName.toUpperCase() != 'IMG') return;

				
				
				if (t.id=="1") {
					currImage=0;
				} 
				else if(t.id=="2") {
					currImage=1;
				}
				else if(t.id=="3"){
					currImage=2;
				}
				else if(t.id=="4"){
					currImage=3;
				}
				else if(t.id=="5"){
					currImage=4;
				}
				else{
					currImage=5;
				}
				clearInterval(timecounter);
				rotateCarousel(currImage);
				timecounter = setInterval(automove,2500);
			}
		}


		function rotateCarousel(imageIndex)
		{
			figure.style.transform = 'rotateY(' + imageIndex * -theta + 'rad)';
		}
	}