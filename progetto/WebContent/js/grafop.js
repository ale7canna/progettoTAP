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
				    name: 'concentric',
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


}; 


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
	
	
	
};

function aggiornaLayout()
{
	var layout = cy.makeLayout({
		  name: 'concentric'
		});

	layout.run();
	
			// a) Degree centrality
	var dcn = cy.elements().dcn(); 		// b) Degree centrality normalized
	var bc  = cy.elements().bc(); 		// c) Betweeness centrality
	
	var ccn = cy.elements().ccn(); 		// e) Closeness centrality normalized
	
  cy.nodes().forEach(function( ele ){
	  var dc  = cy.elements().dc({root: '#'+ele.id()}).degree; 
	  var cc  = cy.elements().cc({root: '#'+ele.id()}); 		// d) Closeness centrality 

	  var content = "Degree centrality: " + dc.toFixed(2).toString() + "<BR>" +
	  				"Degree centrality normalized: " + dcn.degree('#'+ele.id()).toFixed(2).toString() + "<BR>" +
	  				"Betweeness centrality: " + bc.betweenness('#'+ele.id()).toFixed(2).toString() + "<BR>" +
	  				"Closeness centrality: " + cc.toFixed(2).toString() + "<BR>" +
	  				"Closeness centrality normalized: " + ccn.closeness('#'+ele.id()).toFixed(2).toString();
	  
	  cy.$('#'+ele.id()).qtip({
		  content: content,
		  position: {
		    my: 'top center',
		    at: 'bottom center'
		  },
		  style: {
		    classes: 'qtip-bootstrap',
		    width: 325,
		    tip: {
		      width: 16,
		      height: 8
		    }
		  },
		  hide: {
              fixed: true,
              delay: 300
          }
  });
  });
  alert("FATTO");
  
};