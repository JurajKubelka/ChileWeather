Class {
	#name : #BaselineOfChileWeather,
	#superclass : #BaselineOf,
	#category : #BaselineOfChileWeather
}

{ #category : #loading }
BaselineOfChileWeather class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'ChileWeather' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfChileWeather >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'ChileWeather'
		]
]
