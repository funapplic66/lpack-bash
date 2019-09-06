// A function to check whether JS is working
function testclick() {
	var x = document.getElementById("testelement");
	if (x.style.display === "none") {
		x.style.display = "block";
	} else {
		x.style.display = "none";
	}
}