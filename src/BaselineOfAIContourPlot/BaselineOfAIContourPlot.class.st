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
			baseline: 'Roassal3'
			with: [ spec repository: 'github://ObjectProfile/Roassal3/src' ].
			
		"Packages"
		spec 
			package: 'AI-ContourPlot' with: [ spec requires: #('PolyMath' 'Roassal3') ];
			package: 'AI-ContourPlot-Tests' with: [ spec requires: #('AI-ContourPlot') ] ].
]
