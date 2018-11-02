#include <opencv2/opencv.hpp>

// This function tries to find the 5-target pattern that looks like this
//  1  2  3
//  4     5
// It puts the targets in that order, and returns them.
std::vector<cv::Point2d> orderTargets(std::vector<cv::Point2d> allTargets)
{
	std::vector<cv::Point2d> orderedTargets;
	unsigned int i1, i2, i3, i4, i5;
	unsigned int nCCC = allTargets.size();

	// Find 3 CCCs that are in a line.
	double dMin = 1e9;		// distance from a CCC to the midpt between points 1,3
	double d13 = 1;			// the distance between points 1,3
	for (unsigned int i = 0; i<nCCC; i++) {
		for (unsigned int j = i + 1; j<nCCC; j++) {
			// Get the mid point between i,j.
			cv::Point2d midPt = (allTargets[i] + allTargets[j]) * 0.5;

			// Find the CCC that is closest to this midpoint.
			for (unsigned int k = 0; k<nCCC; k++) {
				if (k == i || k == j)	continue;
				double d = norm(allTargets[k] - midPt);	// distance from midpoint

				if (d < dMin) {
					// This is the minimum found so far; save it.
					dMin = d;
					i1 = i;
					i2 = k;
					i3 = j;
					d13 = norm(allTargets[i] - allTargets[j]);
				}
			}
		}
	}
	// If the best distance from the midpoint is < 30% of the distance between
	// the two other points, then we probably have our colinear set.
	if (dMin / d13 > 0.3)	return orderedTargets;	// return an empty list

													/*
													We have found 3 colinear targets:  p1 -- p2 -- p3.
													Now find the one closest to p1; call it p4.
													*/
	dMin = 1e9;
	for (unsigned int i = 0; i<nCCC; i++) {
		if (i != i1 && i != i2 && i != i3) {
			double d = norm(allTargets[i] - allTargets[i1]);
			if (d < dMin) {
				dMin = d;
				i4 = i;
			}
		}
	}
	if (dMin > 1e7)	return orderedTargets;	// return an empty list

											/* Now find the one closest to p3; call it p5. */
	dMin = 1e9;
	for (unsigned int i = 0; i<nCCC; i++) {
		if (i != i1 && i != i2 && i != i3 && i != i4) {
			double d = norm(allTargets[i] - allTargets[i3]);
			if (d < dMin) {
				dMin = d;
				i5 = i;
			}
		}
	}
	if (dMin > 1e7)	return orderedTargets;	// return an empty list

											// Now, check to see where p4 is with respect to p1,p2,p3.  If the
											// signed area of the triangle p1-p3-p4 is negative, then we have
											// the correct order; ie
											//		1   2   3
											//		4		5
											// Otherwise we need to switch the order; ie
											//		3	2	1
											//		5		4

											// Signed area is the determinant of the 2x2 matrix [ p4-p1, p3-p1 ]
	cv::Vec2d p41 = allTargets[i4] - allTargets[i1];
	cv::Vec2d p31 = allTargets[i3] - allTargets[i1];
	double m[2][2] = { { p41[0], p31[0] },{ p41[1], p31[1] } };
	double det = m[0][0] * m[1][1] - m[0][1] * m[1][0];

	// Put the targets into the output list.
	if (det < 0) {
		orderedTargets.push_back(allTargets[i1]);
		orderedTargets.push_back(allTargets[i2]);
		orderedTargets.push_back(allTargets[i3]);
		orderedTargets.push_back(allTargets[i4]);
		orderedTargets.push_back(allTargets[i5]);
	}
	else {
		orderedTargets.push_back(allTargets[i3]);
		orderedTargets.push_back(allTargets[i2]);
		orderedTargets.push_back(allTargets[i1]);
		orderedTargets.push_back(allTargets[i5]);
		orderedTargets.push_back(allTargets[i4]);
	}

	return orderedTargets;
}
