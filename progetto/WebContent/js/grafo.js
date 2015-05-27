function disegnaGrafo(){ 

	$('#cy').toggle();
  
	
  var cy = cytoscape({
	  container: document.getElementById('cy'),
  
	  style: cytoscape.stylesheet()
	  	.selector('node') // ELEMENTO NODO
	  		.css({
			        'height': 30,
			        'width': 30,
			        'background-fit': 'cover',
			        'border-color': '#0f0',
			        'border-width': 3,
			        'border-opacity': 0.1
			      })
	    .selector('.eating') //Mangia perché chiamato
	      .css({
			'border-width': 2,
	        'border-color': '#00f',
			'border-opacity': 1
	      })
	    .selector('.eater') //Cerchio mangiante
	      .css({
	        'border-width': 2,
			'border-color': '#f00'
	      })
	    .selector('edge')
	      .css({
	        'width': 6,
	        'target-arrow-shape': 'triangle',
	        'line-color': '#ffaaaa',
	        'target-arrow-color': '#ffaaaa'
	      })
	    .selector('#bird')
	      .css({
	        'background-image': 'https://farm8.staticflickr.com/7272/7633179468_3e19e45a0c_b.jpg'
	      })
	    .selector('#cat')
	      .css({
	        'background-image': 'https://farm2.staticflickr.com/1261/1413379559_412a540d29_b.jpg'
	      })
	    .selector('#ladybug')
	      .css({
	        'background-image': 'https://farm4.staticflickr.com/3063/2751740612_af11fb090b_b.jpg'
	      })
/*		  .selector('#aphid')
		      .css({
		        'background-image': 'https://farm9.staticflickr.com/8316/8003798443_32d01257c8_b.jpg'
		      })
		  .selector('#rose')
		      .css({
		        'background-image': 'https://farm6.staticflickr.com/5109/5817854163_eaccd688f5_b.jpg'
		      })
		  .selector('#grasshopper')
		      .css({
		        'background-image': 'https://farm7.staticflickr.com/6098/6224655456_f4c3c98589_b.jpg'
		      })
		  .selector('#plant')
		      .css({
		        'background-image': 'https://farm1.staticflickr.com/231/524893064_f49a4d1d10_z.jpg'
		      })*/
		  .selector('#wheat')
		      .css({
		        'background-image': 'https://farm3.staticflickr.com/2660/3715569167_7e978e8319_b.jpg'
		      }),
	    
	  elements: {
	    nodes: [
	      { data: { id: 'cat', label:'Nome Utente' } },
	      { data: { id: 'bird' } },
	      { data: { id: 'ladybug' } },
	      { data: { id: 'aphid' } },
	      { data: { id: 'rose' } },
	      { data: { id: 'grasshopper' } },
	      { data: { id: 'plant' } },
	      { data: { id: 'wheat' } }
		  //{ data: { id: 'mioNodo'} }
	    ],
	    edges: [
	      { data: { source: 'cat', target: 'bird' } },
	      { data: { source: 'bird', target: 'ladybug' } },
	      { data: { source: 'bird', target: 'grasshopper' } },
	      { data: { source: 'grasshopper', target: 'plant' } },
	      { data: { source: 'grasshopper', target: 'wheat' } },
	      { data: { source: 'ladybug', target: 'aphid' } },
	      { data: { source: 'aphid', target: 'rose' } }
	    ]
	  },
  
	  layout: {
	    name: 'breadthfirst',
	    directed: true,
	    padding: 10
	  }
  }); // cy init
 
  cy.on('mouseover', 'node', function(){
	var s = "<div style='padding: " + Math.ceil(this.position('x')) + "px " + Math.ceil(this.position('y')) + "px'> CiaoCiao </div>";
	//var s = "<div style='padding: 100px 200px'> CiaoCiao </div>";
	//$('#cy').append(s)
		
	$(this).qtip({
            content: 'Ciao Ciao',
            hide: {
                fixed: true,
                delay: 300
            }
        });	
		
		
	
  }); // on tap

  cy.$('#cat').qtip({
            content: 'Ciao Ciao',
            hide: {
                fixed: true,
                delay: 300
            }
        });	

  $('a').each(function () {
        $(this).qtip({
            content: 'Ciao CIao',
            hide: {
                fixed: true,
                delay: 300
            }
        });
    });
  
  cy.addNode


}; // on dom ready/**