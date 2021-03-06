#include <iostream>
#include <opencv2/opencv.hpp>
#include <opencv2/aruco.hpp>

#include <windows.h>		// For Sleep()

// Length of one side of a square marker.
const float markerLength = 2.0;

int main(int argc, char* argv[])
{
	printf("This program detects ArUco markers.\n");
	printf("Hit the ESC key to quit.\n");

	// Camera intrinsic matrix (fill in your actual values here).
	double K_[3][3] =
	{ { 675, 0, 320 },
	{ 0, 675, 240 },
	{ 0, 0, 1 } };
	cv::Mat K = cv::Mat(3, 3, CV_64F, K_).clone();

	// Distortion coeffs (fill in your actual values here).
	double dist_[] = { 0, 0, 0, 0, 0 };
	cv::Mat distCoeffs = cv::Mat(5, 1, CV_64F, dist_).clone();

	//cv::VideoCapture cap(1);	// open the camera
	cv::VideoCapture cap("video.avi");	// or open the video file

	if (!cap.isOpened()) {		// check if we succeeded
		printf("error - can't open the camera or video; hit any key to quit\n");
		system("PAUSE");
		return EXIT_FAILURE;
	}
	// Let's just see what the image size is from this camera or file.
	double WIDTH = cap.get(CV_CAP_PROP_FRAME_WIDTH);
	double HEIGHT = cap.get(CV_CAP_PROP_FRAME_HEIGHT);
	printf("Image width=%f, height=%f\n", WIDTH, HEIGHT);

	//const cv::String fnameOut("outputVideo.avi");
	//cv::VideoWriter outputVideo(fnameOut,
	//	cv::VideoWriter::fourcc('D', 'I', 'V', 'X'),
	//	30.0,		// fps
	//	cv::Size((int)WIDTH, (int)HEIGHT),
	//	true);		// true (default): output color

	// Allocate image.
	cv::Mat image;
	cv::Ptr<cv::aruco::Dictionary> dictionary = cv::aruco::getPredefinedDictionary(cv::aruco::DICT_4X4_100);
	cv::Ptr<cv::aruco::DetectorParameters> detectorParams = cv::aruco::DetectorParameters::create();

	// Run an infinite loop until user hits the ESC key.
	while (1) {
		cap >> image;		// get image from camera
		if (image.empty())	break;

		std::vector< int > markerIds;
		std::vector< std::vector<cv::Point2f> > markerCorners, rejectedCandidates;
		cv::aruco::detectMarkers(
			image,		// input image
			dictionary,		// type of markers that will be searched for
			markerCorners,	// output vector of marker corners
			markerIds,		// detected marker IDs
			detectorParams,	// algorithm parameters
			rejectedCandidates);

		if (markerIds.size() > 0) {
			// Draw all detected markers.
			cv::aruco::drawDetectedMarkers(image, markerCorners, markerIds);

			std::vector< cv::Vec3d > rvecs, tvecs;
			cv::aruco::estimatePoseSingleMarkers(
				markerCorners,	// vector of already detected markers corners
				markerLength,	// length of the marker's side
				K,				// input 3x3 floating-point instrinsic camera matrix K
				distCoeffs,		// vector of distortion coefficients of 4, 5, 8 or 12 elements
				rvecs,			// array of output rotation vectors 
				tvecs);			// array of output translation vectors

								// Display pose for the detected marker with id=0.
			for (unsigned int i = 0; i < markerIds.size(); i++) {
				if (markerIds[i] == 0 || markerIds[i] == 1) {
					cv::Vec3d r = rvecs[i];
					cv::Vec3d t = tvecs[i];

					// Draw coordinate axes.
					cv::aruco::drawAxis(image,
						K, distCoeffs,			// camera parameters
						r, t,					// marker pose
						0.5*markerLength);		// length of the axes to be drawn

					double x = 0, y = 0, z = 0;
					if (markerIds[i] == 0) {
						x = 2.5;	y = -2.0;	z = -1.0;
					}
					else if (markerIds[i] == 1) {
						x = -2.5;	y = -2.0;	z = -5.0;
					}

					// Indicate the location of the point of interest.
					std::vector<cv::Point3d> pointsInterest;
					pointsInterest.push_back(cv::Point3d(x, y, z));
					std::vector<cv::Point2d> p;
					cv::projectPoints(pointsInterest, rvecs[i], tvecs[i], K, distCoeffs, p);
					cv::circle(image, p[0], 20, cv::Scalar(0, 255, 255), 2);
				}
			}
		}

		cv::imshow("Image", image);	// show image
									//outputVideo << image;

									// Wait for x ms (0 means wait until a keypress).
									// Returns -1 if no key is hit.
		char key = cv::waitKey(1);
		if (key == 27)		break;		// ESC is ascii 27
	}

	return EXIT_SUCCESS;
}
