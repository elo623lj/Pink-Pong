var shown=false;
var cutspin=true;
var currentshow=-1;

function show(a) {
	if(a==0){
	if(shown){
		leave(false);
		shown=false;
		currentshow=-1;
		}
	}	
	else if(currentshow!==a){
	$(".popout").css("display","block");
	
	if(shown){
	leave(true,a);		
	}
	else{
	comein(a);
	}
	
	shown=true;
	currentshow=a;
	}
}

function leave(comeyes,a){
	cutspin=true;
	$({ bottom: 0 }).animate({ bottom: -700}, {
    duration: 1000,
    step: function(now) {
        $(".popoutwrap").css("bottom",now+"px");
    }
	});	
	
	$( ".popoutwrap" ).fadeTo( 1000 , 0, function() {
		if(comeyes){comein(a);}
  	});	
}

function comein(a){
	for(var i=1;i<=5;i++){
	$("#part"+i).css("display","none");
	}
	$("#part"+a).css("display","block");
	
	$({ bottom: -700 }).animate({ bottom: 0}, {
    duration: 1000,
    step: function(now) {
        $(".popoutwrap").css("bottom",now+"px");
    }
	});
	
	$( ".popoutwrap" ).fadeTo( 1500 , 1, function() {
	cutspin=false;
	spin();
  	});
		
}

$(document).ready(function () {  
	$(".video-background").css("width",$(window).width());
	$(".video-background").css("height",$(window).height()+50+"px");
});

$(document).ready( function () {
    if ($(window).width()/$(window).height() >= 560/315){
		$(".videofront").css("width",$(window).width());
		$(".videofront").css("height",$(window).width()*315/560);
	}
	else {
		$(".videofront").css("height",$(window).height());
		$(".videofront").css("width",$(window).height()*560/315);
	}
});

$(window).on("resize",function () {  
	$(".video-background").css("width",$(window).width());
	$(".video-background").css("height",$(window).height()+50+"px");
});

$(window).on("resize",function () {
    if ($(window).width()/$(window).height() >= 560/315){
		$(".videofront").css("width",$(window).width());
		$(".videofront").css("height",$(window).width()*315/560);
	}
	else {
		$(".videofront").css("height",$(window).height());
		$(".videofront").css("width",$(window).height()*560/315);
	}
});


d3.selectAll(".circle").append("svg")
                       .attr("width", 150)
                       .attr("height", 150)
					   .append("path")
                       .attr("d", describeArc(75, 75, 56, 0, 0))
					   .style("stroke","white")
 					   .style("stroke-width",2)
					   .style("fill-opacity",0);
	
$(".item p").mouseenter(showCircle);
$(".item p").mouseleave(removeCircle);

var done=false;
var cut =[true,true,true,true,true];

function showCircle(){
var text = $(this);
var index = $(".item").index($(this).parent());
if(!done){
var dest = $(this).parent().find("path");
cut[index]=false;
	
$({ degree: 30 }).animate({ degree: 359.999}, {
    duration: 1000,
    step: function(now) {
		if(!cut[index]){
        dest.attr("d", describeArc(75, 75, 58, 30, now));
		}
    }
});
	
$({ size: 13 }).animate({ size: 17}, {
    duration: 250,
    step: function(now) {
		if(!cut[index]){
        text.css("font-size", now);
		}
    }
});
	
if(!cut[index]){done=true;}
}
}


function removeCircle(){
	$(this).css("font-size", 13);
	var index = $(".item").index($(this).parent());	
	$(this).parent().find("path").attr("d", describeArc(75, 75, 56, 0, 0));   
	done = false;
	cut[index] = true;
	
}

d3.selectAll(".popoutwrap").append("svg")
                       .attr("width", 700)
                       .attr("height", 700)
					   .append("path")
                       .attr("d", describeArc(350, 350, 300, 0, 300))
					   .style("stroke","white")
 					   .style("stroke-width",8)
					   .style("fill-opacity",0);


function spin(){
	if(!cutspin){
	$({ deg: 0 }).animate({ deg: 360}, {
    duration: 2000,
    step: function(now) {
		$(".popoutwrap svg").css("transform","rotate("+now+"deg)");
		},
	complete: function(){
		if(!cutspin){spin();}
		}
});

}
}













function polarToCartesian(centerX, centerY, radius, angleInDegrees) {
  var angleInRadians = (angleInDegrees-90) * Math.PI / 180.0;

  return {
    x: centerX + (radius * Math.cos(angleInRadians)),
    y: centerY + (radius * Math.sin(angleInRadians))
  };
}

function describeArc(x, y, radius, startAngle, endAngle){

    var start = polarToCartesian(x, y, radius, endAngle);
    var end = polarToCartesian(x, y, radius, startAngle);

    var largeArcFlag = endAngle - startAngle <= 180 ? "0" : "1";

    var d = [
        "M", start.x, start.y, 
        "A", radius, radius, 0, largeArcFlag, 0, end.x, end.y
    ].join(" ");

    return d;       
}