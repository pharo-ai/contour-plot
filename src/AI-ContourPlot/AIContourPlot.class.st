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
