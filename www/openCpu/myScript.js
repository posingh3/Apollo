$(document).ready(function() {
	$('#init').on("click",function() {
        
        //perform the request
        var req = ocpu.rpc("initialise", {}, function(output){
          $("#output").text(output.message);
        });
        
		req.fail(function(){
          alert("Server error: " + req.responseText);
        });
	})
				
	$('#predict').on("click",function() {
        
        //perform the request
        var req = ocpu.rpc("knn2", {}, function(output){
          $("#output").text(output.message);
        });
        
		req.fail(function(){
          alert("Server error: " + req.responseText);
        });
	})
				
	$('#indicator').on("click",function() {
		var req = ocpu.rpc("file", {}, function(output){
          $("#output").text(output.message);
        });
        
		req.fail(function(){
          alert("Server error: " + req.responseText);
        });
	})
				
	$('#prompt').on("click",function() {
		var req = ocpu.rpc("comment", {}, function(output){
          $("#output").text(output.message);
        });
        
		req.fail(function(){
          alert("Server error: " + req.responseText);
        });
	})
				
	$('#database').on("click",function() {
		alert("Add To Database!!!!");
	})
})
