var zoomFactor = 4;
var zIndex = 1;
var cy;
var idUserName = [[]];


function toggleGrafo() {
	$('#cy').toggle();
}

function disegnaGrafo(){ 
  
	cy = cytoscape({
	  container: document.getElementById('cy'),
  
	  style: cytoscape.stylesheet()
	  	.selector('node') // ELEMENTO NODO
	  		.css({
			        'height': 200,
			        'width': 200,
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
	        'height': 70,
	        'target-arrow-shape': 'triangle',
	        'line-color': '#aaaaff',
	        'target-arrow-color': '#aaaaff'
	      }),
	        
	    layout: {
				    name: 'concentric',
				    directed: false,
				    padding: 10
				  }
  }); // cy init


  cy.on('mouseover', 'node', function() {
	  this.style('width', this.width() * zoomFactor);
	  this.style('height', this.height() * zoomFactor);
	  this.style('z-index', zIndex++);
	
  });
  
  cy.on('mouseout', 'node', function() {
	  this.style('width', this.width() / zoomFactor);
	  this.style('height', this.height() / zoomFactor);
  });
  
}; 


function addNodeToGraph(id, url, username, link)
{
	var eles = cy.add([
	                   { group: "nodes", data: { id: id }, position: { x: 200, y: 200 } },	                
	                 ]);
	cy.$('#'+id).style('background-image', url);
	idUserName[id] = [username, link];
	
	
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
	
	
	var id = 1;
	
	cy.nodes().forEach(function( ele ){
		  var dc  = cy.elements().dc({root: '#'+ele.id()}).degree; 	// a) Degree Centrality
		  var cc  = cy.elements().cc({root: '#'+ele.id()}); 		// d) Closeness centrality 
	
		  var content = "<a target='_blank' href='" + idUserName[ele.id()][1] + "'><p class='qtip-name'>" + idUserName[ele.id()][0] + "</p></a>" + 
			  			"Degree centrality: " + dc.toFixed(2).toString() + "<BR>" +
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
			    classes: 'qtip-bootstrap myQtip',
			    
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

		
		  
		  id = id + 1;
	  });

	
};

function ridimensionaGrafo()
{
	cy.resize();
	
	var layout = cy.makeLayout({
		  name: 'concentric'
		});

	layout.run();
}