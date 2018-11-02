/* Match and fuse two images using homography. */

#include <iostream>

#include <opencv2/opencv.hpp>
#include <opencv2/xfeatures2d.hpp>		// for SURF features

int main(int argc, char* argv[])
{
	// Read images (these should be in the same directory as your source code).
	cv::Mat I1 = cv::imread("img1.png");
	cv::Mat I2 = cv::imread("img3.png");

	if (I1.empty() || I2.empty()) {
		std::cout << "Hey! Can't read the images!" << std::endl;
		system("PAUSE");
		return EXIT_FAILURE;
	}
	cv::imshow("I1", I1);
	cv::imshow("I2", I2);
	cv::waitKey(0);

	// Create the SURF detector.
	cv::Ptr<cv::Feature2D> f2d = cv::xfeatures2d::SURF::create(
		1000.0,		// threshold (default = 100.0)
		4,			// number of octaves (default=4)
		2,			// number of octave layers within each octave (default=2)
		true,		// true=use 128 element descriptors, false=use 64 element
		false);		// true=don't compute orientation, false=compute orientation

	// Detect keypoints in the images using the SURF Detector.
	std::vector<cv::KeyPoint> keypoints1, keypoints2;
	f2d->detect(I1, keypoints1);
	printf("Detected %d keypoints in the first image.\n", keypoints1.size());
	f2d->detect(I2, keypoints2);
	printf("Detected %d keypoints in the second image.\n", keypoints2.size());

	// Draw keypoints on the images and display them.
	cv::Mat I1keypoints, I2keypoints;
	drawKeypoints(I1, keypoints1, I1keypoints,
		cv::Scalar(0, 0, 255), cv::DrawMatchesFlags::DEFAULT);
	cv::imshow("I1", I1keypoints);
	drawKeypoints(I2, keypoints2, I2keypoints,
		cv::Scalar(0, 0, 255), cv::DrawMatchesFlags::DEFAULT);
	cv::imshow("I2", I2keypoints);
	cv::waitKey(0);


	// Compute descriptors for the found keypoints.
	cv::Mat descriptors1, descriptors2;
	f2d->compute(I1, keypoints1, descriptors1);
	f2d->compute(I2, keypoints2, descriptors2);


	// Match descriptors between reference and new image.  For each, 
	// find the k nearest neighbors.
	cv::BFMatcher  matcher(cv::NORM_L2);
	std::vector< std::vector<cv::DMatch> > knnMatches;
	matcher.knnMatch(
		descriptors2,	// These are "query" descriptors, in the new image
		descriptors1,	// These are "training" descriptors, from ref image
		knnMatches,		// Output matches
		2);				// Value of k (we will find the best k matches)  

	// Apply ratio test: best match should be much better than 2nd best match.
	// Form a list of matches that survive this test.
	//   matches[i].trainIdx is the index of the ith match, in keypoints1
	//	 matches[i].queryIdx is the index of the ith match, in keypoints2
	const float minRatio = 1.f / 1.5f;
	std::vector<cv::DMatch> matches;		// surviving matches
	for (size_t i = 0; i<knnMatches.size(); i++) {
		const cv::DMatch& bestMatch = knnMatches[i][0];
		const cv::DMatch& betterMatch = knnMatches[i][1];

		// To avoid NaN's when match has zero distance use inverse ratio. 
		float inverseRatio = bestMatch.distance / betterMatch.distance;

		// Test for distinctiveness: pass only matches where the inverse
		// ratio of the distance between nearest matches is < than minimum.
		if (inverseRatio < minRatio)
			matches.push_back(bestMatch);
	}
	printf("Initial number of matching points: %d\n", matches.size());

	// Get reduced lists of only the matching keypoints.
	std::vector<cv::KeyPoint> kp1Match, kp2Match;
	for (unsigned int i = 0; i<matches.size(); i++) {
		int i1 = matches[i].trainIdx;
		int i2 = matches[i].queryIdx;
		kp1Match.push_back(keypoints1[i1]);
		kp2Match.push_back(keypoints2[i2]);
	}

	// Display the matching keypoints on the images.
	cv::Mat I1matches, I2matches;
	drawKeypoints(I1, kp1Match, I1matches,
		cv::Scalar(0, 255, 255), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);
	cv::imshow("I1", I1matches);
	drawKeypoints(I2, kp2Match, I2matches,
			cv::Scalar(0, 255, 255), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);
	cv::imshow("I2", I2matches);
	cv::waitKey(0);


	// Prepare data for cv::findHomography.
	// We are just converting the keypoint type to a Point2f type.
	// pts1 corresponds to kp1Match, pts2 corresponds to kp2Match.
	std::vector<cv::Point2f> pts1(matches.size());	// Points from ref image
	std::vector<cv::Point2f> pts2(matches.size());	// Points from new image
	for (size_t i = 0; i < kp1Match.size(); i++) {
		pts1[i] = kp1Match[i].pt;
		pts2[i] = kp2Match[i].pt;
	}

	// Find homography matrix and get the inliers mask.  
	// The output inliersMask[i] is true if pts1[i] actually matches pts2[2];
	// i.e., that match is an inlier.
	std::vector<unsigned char> inliersMask(pts1.size());
	cv::Mat homography = cv::findHomography(pts1, pts2,
		cv::FM_RANSAC,
		5,		// Allowed reprojection error in pixels (default=3)
		inliersMask);

	// Get reduced lists of the final inliers.
	std::vector<cv::KeyPoint> kp1Inliers, kp2Inliers;
	for (unsigned int i = 0; i<kp1Match.size(); i++) {
		if (inliersMask[i]) {
			kp1Inliers.push_back(kp1Match[i]);
			kp2Inliers.push_back(kp2Match[i]);
		}
	}
	printf("Final number of inlier points: %d\n", kp1Inliers.size());

	// Display the final inlier keypoints on the images.
	cv::Mat I1finalMatches, I2finalMatches;
	drawKeypoints(I1, kp1Inliers, I1finalMatches,
		cv::Scalar(0, 255, 255), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);
	cv::imshow("I1", I1finalMatches);
	drawKeypoints(I2, kp2Inliers, I2finalMatches,
		cv::Scalar(0, 255, 255), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);
	cv::imshow("I2", I2finalMatches);
	cv::waitKey(0);


	// Transform the first image to the second image.
	cv::Mat I1out;
	cv::warpPerspective(I1, I1out, homography, cv::Size(I1.size()));
	cv::imshow("I1 out", I1out);

	// Average the two to show our results (a better way would be to only
	// average them where both have valid values).
	cv::Mat Ifused;
	cv::addWeighted(I1out, 0.5, I2, 0.5, 0.0, Ifused);
	cv::imshow("Fused", Ifused);
	cv::waitKey(0);

	return EXIT_SUCCESS;
}
