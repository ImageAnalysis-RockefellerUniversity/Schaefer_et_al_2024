/****************************************************************************************************
Process files in a folder_v01.ijm (April 28, 2022)
Adapted from Process files_v02.ijm

Author: Ved P. Sharma, The Rockefeller University
		E-mail: vedsharma@gmail.com
****************************************************************************************************/
// This macro selects all the regex-defined files in a folder and 
// runs doSomethingWithFile() function, with user's custom code

folder = getDirectory("Choose a folder to process");
//filePattern = ".*_Max.*.czi";
filePattern = ".*_DAPI.tif";
//filePattern = ".*_maxP.tif";
//filePattern = ".*MaxIP_DAPI.tif";

fileList = getFileList(folder);
for (j=0; j<fileList.length; j++) // loop for going through the files in a folder
	if (matches(fileList[j], filePattern))
		doSomethingWithFile();

function doSomethingWithFile() {
//print("I'm here");
	currFilepath = folder+fileList[j];
//print(currFilepath);
//exit;

// split channels and save images
	if(false) {
//		run("Bio-Formats Importer", "open=&currFilepath autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
		open(currFilepath);
		run("Split Channels");
		if(nImages != 3)
			exit("Error: Image should have three channels!");
		saveTitle = replace(fileList[j], ".tif", "_H3K9me3");
		saveAs("Tiff", folder+saveTitle);
		close();

		saveTitle = replace(fileList[j], ".tif", "_VP1");
		saveAs("Tiff", folder+saveTitle);
		close();

		saveTitle = replace(fileList[j], ".tif", "_DAPI");
		saveAs("Tiff", folder+saveTitle);
		close();
	}

// do max projection and save image
	if(false) {
		run("Bio-Formats Importer", "open=&currFilepath autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
		run("Z Project...", "projection=[Max Intensity]");
		saveTitle = replace(fileList[j], ".czi", "_maxP");
		saveAs("Tiff", folder+saveTitle);
		close(); // close maxP image
		close(); // close original image
	}

// Subtract background
	if(true) {
		open(currFilepath);
		run("Subtract Background...", "rolling=50");
		saveTitle = replace(fileList[j], ".tif", "_bkgd");
		saveAs("Tiff", folder+saveTitle);
		close();
	}

// Run Labels_to_ROIs and Remove_boundary_ROIs macros on Cellpose label PNG file
	if(false) {
		open(currFilepath);
		roiManager("reset");
		runMacro(path\\to\\Labels_to_ROIs_v3.ijm);
		runMacro(path\\to\\Remove_boundary_ROIs_v02.ijm");
		saveTitle = replace(fileList[j], ".png", ".zip");
		roiManager("Save", folder+saveTitle);
		close();
	}

//exit;
}

