// A label image with ROIs in the ROI Manager should be opened before running this macro
// It will remove all the boundary ROIs in the ROI Manager

// Author: Ved Sharma, The Rockefeller University (October 20, 2022)

imgWidth = getWidth(); // in pixels
imgHeight = getHeight(); // in pixels

setForegroundColor(0, 0, 0); // setting foreground color for filling black to removed ROIs
count=0;
n = roiManager("count");
for (i = n; i > 0; i--) {
    roiManager('select', i-1);
	Roi.getBounds(x, y, width, height); // all values in pixels
	if(x == 0 || y == 0 || x+width == imgWidth || y+height == imgHeight) {
//		run("Fill", "slice"); // fill black color to boundary ROIs
		roiManager("delete");
		count++;
	}
}
print("ROIs removed from the image boundary: "+count);


