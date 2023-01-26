// Create ROIs from a label image, such as the one generated from Cellpose
// Works for 8 and 16 bit label images. 
// Open the label image and run this macro. It will generate the ROIs and add them to the ROI Manager.

// Author: Ved Sharma, The Rockefeller University, October 21, 2022

if(bitDepth() != 8)
	if(bitDepth() != 16)
		exit("Image bit depth = "+bitDepth()+".\n \nThis macro works with only 8 and 16 bit label images!");

getStatistics(area, mean, min, max);
roiManager( 'reset' ); 
for( i = 1; i < max+1; i ++ ) { 
  setThreshold( i, i ); 
  run( 'Create Selection' ); 
  if( selectionType >- 1 ) { 
    Roi.setFillColor( 'none'); 
    roiManager( 'add' ); 
  } 
}
resetThreshold(); 
roiManager( 'Show All' ); 