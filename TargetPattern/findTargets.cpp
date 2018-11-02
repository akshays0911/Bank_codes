#include <opencv2/opencv.hpp>

// Parameters for finding CCC targets.
#define DPIXEL	3.0				// max distance between centroids

// Find all CCC targets on the image.  Return a vector (list) of their locations.
std::vector<cv::Point2d> findTargets(cv::Mat Image)
{
	std::vector<cv::Point2d> targets;

	cv::Mat imageThresh;

	// Do Otsu global thresholding - is faster than adaptive thresholding.
	cv::threshold(Image,
		imageThresh,		// output thresholded image
		0,					// threshold value
		255,				// output value
		cv::THRESH_OTSU | cv::THRESH_BINARY_INV);		// threshold_type - invert

														//// Do adaptive threshold ... this compares each pixel to a local 
														//// mean of the neighborhood.  The result is a binary image, where 
														//// dark areas of the original image are now white (1's).
														//adaptiveThreshold(Image,
														//	imageThresh,				// output thresholded image
														//	255,					// output value where condition met
														//	cv::ADAPTIVE_THRESH_GAUSSIAN_C,	// local neighborhood
														//	cv::THRESH_BINARY_INV,		// threshold_type - invert
														//	91,					// blockSize (any large number)
														//	0);					// a constant to subtract from mean

														// Apply morphological operations to get rid of small (noise) regions.
	cv::Mat structuringElmt = cv::getStructuringElement(cv::MORPH_ELLIPSE, cv::Size(3, 3));
	cv::Mat imageOpen;
	morphologyEx(imageThresh, imageOpen, cv::MORPH_OPEN, structuringElmt);
	cv::Mat imageClose;
	morphologyEx(imageOpen, imageClose, cv::MORPH_CLOSE, structuringElmt);

	// Now find contours.
	std::vector<std::vector<cv::Point>> contours;
	std::vector<cv::Vec4i> hierarchy;
	cv::findContours(
		imageClose,				// input image (is destroyed)
		contours,				// output vector of contours
		hierarchy,				// hierarchical representation
		cv::RETR_CCOMP,			// retrieve all contours 
		cv::CHAIN_APPROX_NONE);	// all pixels of each contours

								// Analyze components and find CCCs.
	for (unsigned int i1 = 0; i1 < (int)contours.size(); i1++) {
		int i2 = hierarchy[i1][2];
		if (i2 < 0)	continue;			// See if it has a child inside

										// Compute centroids of inner and outer regions.
		cv::Moments mu1 = cv::moments(contours[i1]);
		cv::Point2d x1(mu1.m10 / mu1.m00, mu1.m01 / mu1.m00);
		cv::Moments mu2 = cv::moments(contours[i2]);
		cv::Point2d x2(mu2.m10 / mu2.m00, mu2.m01 / mu2.m00);

		// Check if centroids coincide.
		if (norm(x1 - x2) > DPIXEL)	continue;

		// Check the "circularity" ratio of the outer region, which is 
		// the ratio of area to perimeter squared:  R = 4*pi*A/P^2.
		// R is 1 for a circle, and pi/4 for a square.
		double P1 = arcLength(contours[i1], true);
		double A1 = contourArea(contours[i1]);
		if (4 * 3.1415*A1 / (P1*P1) < 3.1415 / 4)
			// Let's say that we want our region to be at least as round as a square.
			continue;

		// This must be a valid target; add it to the output list.
		targets.push_back(x1);
	}

	return targets;
}
