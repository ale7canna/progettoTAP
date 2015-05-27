var cy;

function toggleGrafo() {
	$('#cy').toggle();
}

function disegnaGrafo(){ 
  
	cy = cytoscape({
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
	        'width': 3,
	        'target-arrow-shape': 'triangle',
	        'line-color': '#aaaaff',
	        'target-arrow-color': '#aaaaff'
	      }),
	        
	    layout: {
				    name: 'breadthfirst',
				    directed: true,
				    padding: 10
				  }
  }); // cy init
 
  cy.on('click', 'node', function(){
	var s = "<div style='padding: " + Math.ceil(this.position('x')) + "px " + Math.ceil(this.position('y')) + "px'> CiaoCiao </div>";
	//var s = "<div style='padding: 100px 200px'> CiaoCiao </div>";
	//$('#cy').append(s)
		
	var c = "Ciao Marzo";
	//c = cy.$().dc({root: 'this'}).degree;
	
	
  }); // on tap

 /* cy.$('#cat').qtip({
            content: 'Ciao Ciao',
            hide: {
                fixed: true,
                delay: 300
            }
        });	
*/
  
  
  $('a').each(function () {
        $(this).qtip({
            content: 'Ciao CIao',
            hide: {
                fixed: true,
                delay: 300
            }
        });
    });


}; // on dom ready/**


function addNodeToGraph(id, url)
{
	var eles = cy.add([
	                   { group: "nodes", data: { id: id }, position: { x: 200, y: 200 } },	                
	                 ]);
	cy.$('#'+id).style('background-image', url);
	
};

function addEdge(idSource, idTarget)
{
	cy.add( {
		group: 'edges',
		data: {source: idSource, target: idTarget}
	});
	
	
	
}

function aggiornaLayout()
{
	var layout = cy.makeLayout({
		  name: 'concentric'
		});

	//layout.run();
		
		
  var eles = cy.elements();
  for (var k = 0; k < eles.length; k++) {
	  var e = eles[k];
	  $(e).qtip(
			  {
				  content: 'Ciao Ciao',
				  position: {
					    my: 'top center',
					    at: 'bottom center'
					  },
					  style: {
					    classes: 'qtip-bootstrap',
					    tip: {
					      width: 16,
					      height: 8
					    }
					  }
				  
			  }
	  
	  );
		  
			  
		  }
}