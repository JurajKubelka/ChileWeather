Trait {
	#name : #TChileTemperatureValues,
	#category : #'ChileWeather-Temperature'
}

{ #category : #'gt - extensions' }
TChileTemperatureValues >> gtTemperatureValuesFor: aView [
	<gtView>
	self items ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Temperatures';
		items: [ self items ];
		column: 'Code' text: #code;
		column: 'Date' text: [ :aValue | aValue time asDate ];
		column: 'Time' text: [ :aValue | aValue time asTime ];
		column: 'Temperature' text: [ :aValue | aValue temperature asString , '°C' ]
]
