Class {
	#name : #BaselineOfAIContourPlot,
	#superclass : #BaselineOf,
	#category : #BaselineOfAIContourPlot
}

{ #category : #baselines }
BaselineOfAIContourPlot >> baseline: spec [
	<baseline>
	spec for: #common do: [
		"External dependencies"
		spec
			baseline: 'PolyMath'
			with: [ spec repository: 'github://olekscode/PolyMath:master/src' ].
			
		spec
			baseline: 'PolyMath'
			with: [ spec repository: 'github://ObjectProfile/Roassal3/src' ].
			
		"Packages"
		spec 
			package: 'AI-ContourPlot';
			package: 'AI-ContourPlot-Tests' with: [ spec requires: #('AI-ContourPlot') ] ].
]
