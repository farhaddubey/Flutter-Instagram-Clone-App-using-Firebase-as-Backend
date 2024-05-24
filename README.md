# flutter_instagram_latest

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

<!-- The grid: four columns -->
<div class="row">
  <div class="column">
    <img src="readme_photos/Screenshot_20240524-151343.jpg" alt="Nature" onclick="myFunction(this);">
  </div>
  <div class="column">
    <img src="Screenshot_20240524-151656.jpg" alt="Snow" onclick="myFunction(this);">
  </div>
  <div class="column">
    <img src="Screenshot_20240524-151737.jpg" alt="Mountains" onclick="myFunction(this);">
  </div>
</div>

<!-- The expanding image container -->
<div class="container">
  <!-- Close the image -->
  <span onclick="this.parentElement.style.display='none'" class="closebtn">&times;</span>
  <!-- Expanded image -->
  <img id="expandedImg" style="width:100%">
  <!-- Image text -->
  <div id="imgtext"></div>
</div>
<div>
function myFunction(imgs) {
  // Get the expanded image
  var expandImg = document.getElementById("expandedImg");
  // Get the image text
  var imgText = document.getElementById("imgtext");
  // Use the same src in the expanded image as the image being clicked on from the grid
  expandImg.src = imgs.src;
  // Use the value of the alt attribute of the clickable image as text inside the expanded image
  imgText.innerHTML = imgs.alt;
  // Show the container element (hidden with CSS)
  expandImg.parentElement.style.display = "block";
}
</div>
<style>
/* The grid: Four equal columns that floats next to each other */
.column {
  float: left;
  width: 25%;
  padding: 10px;
}

/* Style the images inside the grid */
.column img {
opacity: 0.8;
cursor: pointer;
}

.column img:hover {
opacity: 1;
}

/* Clear floats after the columns */
.row:after {
content: "";
display: table;
clear: both;
}

/* The expanding image container (positioning is needed to position the close button and the text) */
.container {
position: relative;
display: none;
}

/* Expanding image text */
#imgtext {
position: absolute;
bottom: 15px;
left: 15px;
color: white;
font-size: 20px;
}

/* Closable button inside the image */
.closebtn {
position: absolute;
top: 10px;
right: 15px;
color: white;
font-size: 35px;
cursor: pointer;
}
</style>


- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
#   F l u t t e r - I n s t a g r a m - C l o n e - A p p - u s i n g - F i r e b a s e - a s - B a c k e n d 
 
 