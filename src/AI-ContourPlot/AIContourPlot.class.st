Class {
	#name : #AIContourPlot,
	#superclass : #RSAbstractPlot,
	#instVars : [
		'distribution',
		'center',
		'alpha',
		'firstEigenValue',
		'secondEigenvalue'
	],
	#category : #'AI-ContourPlot'
}

{ #category : #examples }
AIContourPlot class >> example [
	<example>
	| numberOfPoints color1 color2 mu1 mu2 sigma1 sigma2 dist1 dist2 data1 data2 scatterplot1 scatterplot2 contour1 contour2 chart |
	
	numberOfPoints := 100.

	color1 := Color fromString: '3288BD'.
	color2 := Color fromString: 'D53E4F'.

	mu1 := #(1 0) asPMVector.
	mu2 := #(-1.5 -1) asPMVector.

	sigma1 := PMMatrix rows: #(
		(0.5 1)
		(1 3)).
	
	sigma2 := PMMatrix rows: #(
		(1 0.8)
		(0.8 1)).

	dist1 := PMMultivariateNormalDistribution
		meanVector: mu1
		covarianceMatrix: sigma1.
	
	dist2 := PMMultivariateNormalDistribution
		meanVector: mu2
		covarianceMatrix: sigma2.
	
	data1 := (1 to: numberOfPoints) collect: [ :i | dist1 random ].
	data2 := (1 to: numberOfPoints) collect: [ :i | dist2 random ].

	scatterplot1 := RSScatterPlot new
		x: (data1 collect: #first)
		y: (data1 collect: #second);
		color: color1;
		yourself.
	
	scatterplot2 := RSScatterPlot new
		x: (data2 collect: #first)
		y: (data2 collect: #second);
		color: color2;
		yourself.
	
	contour1 := AIContourPlot new
		distribution: dist1;
		yourself.
	
	contour2 := AIContourPlot new
		distribution: dist2;
		yourself.

	chart := RSChart new
		addPlot: scatterplot1;
		addPlot: scatterplot2;
		addPlot: contour1;
		addPlot: contour2;
		addDecoration: RSHorizontalTick new;
		addDecoration: RSVerticalTick new;
		build.
	
	chart open
]

{ #category : #initialization }
AIContourPlot >> defaultShape [
	"No idea how this is used"
	^ RSEllipse new
]

{ #category : #accessing }
AIContourPlot >> distribution: aDistribution [
	| eigen firstEigenvector |
	
	distribution := aDistribution.
	center := (aDistribution meanVector first) @ (aDistribution meanVector second).
	
	eigen := aDistribution covarianceMatrix eigen.
	firstEigenvector := eigen vectors first.
	alpha := (firstEigenvector second / firstEigenvector first) arcTan.

	firstEigenValue := eigen values first.
	secondEigenvalue := eigen values second.
]

{ #category : #'as yet unclassified' }
AIContourPlot >> ellipse [
	^ RSEllipse new
		x: (xScale scale: center x);
		y: (yScale scale: center y);
		color: Color transparent;
		withBorder;
		yourself.
]

{ #category : #'as yet unclassified' }
AIContourPlot >> ellipse95Percent [
	| a b zeroX zeroY |
	a := 2 * (5.991 * firstEigenValue) sqrt.
	b := 2 * (5.991 * secondEigenvalue) sqrt.
	
	zeroX := xScale scale: 0.
	zeroY := xScale scale: 0.
	
	a := xScale scale: a.
	b := xScale scale: b.
	
	a := a - zeroX.
	b := b - zeroY.
	
	b / a.
	
	^ self ellipse
		extent: (a/2)@(b/2);
		rotateByRadians: alpha - (Float pi / 2);
		yourself.
]

{ #category : #rendering }
AIContourPlot >> maxValueX [
	^ center x + ((distribution covarianceMatrix at: 1 at: 1) sqrt * 3)
]

{ #category : #rendering }
AIContourPlot >> maxValueY [
	^ center y + ((distribution covarianceMatrix at: 2 at: 2) sqrt * 3)
]

{ #category : #rendering }
AIContourPlot >> minValueX [
	^ center x - ((distribution covarianceMatrix at: 1 at: 1) sqrt * 3)
]

{ #category : #rendering }
AIContourPlot >> minValueY [
	^ center y - ((distribution covarianceMatrix at: 2 at: 2) sqrt * 3)
]

{ #category : #rendering }
AIContourPlot >> renderIn: canvas [
	"Need to be overridden in subclasses. This methods has to be use trachel to enrich a visualization"
	canvas add: self ellipse95Percent.
]
