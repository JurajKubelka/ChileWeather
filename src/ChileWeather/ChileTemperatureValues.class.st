Class {
	#name : #ChileTemperatureValues,
	#superclass : #Object,
	#traits : 'TGtGroupWithItems + TChileTemperatureValues',
	#classTraits : 'TGtGroupWithItems classTrait + TChileTemperatureValues classTrait',
	#category : #'ChileWeather-Temperature'
}

{ #category : #'gt - extensions' }
ChileTemperatureValues >> gtTemperatureValuesPerMonthFor: aView [
	<gtView>
	self items ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Temp. per month';
		items: [ self perMonths ];
		column: 'Month'
			text: [ :aValue | aValue monthIndex ]
			width: 80;
		column: 'Values'
			text: [ :aValue | 
				'{1} {2}'
					format: {aValue size.
							'value' asPluralBasedOn: aValue size} ]
			width: 100;
		column: 'Min time' text: [ :aValue | aValue minTime time ];
		column: 'Max time' text: [ :aValue | aValue maxTime time ];
		column: 'Min temp' text: [ :aValue | aValue minTemperature temperature ];
		column: 'Max temp' text: [ :aValue | aValue maxTemperature temperature ]
]

{ #category : #accessing }
ChileTemperatureValues >> maxTemperature [
	<return: #ChileTemperatureValue>
	^ self items
		detectMax: [ :each | each temperature ifNil: [ Float negativeInfinity ] ]
]

{ #category : #accessing }
ChileTemperatureValues >> minTemperature [
	<return: #ChileTemperatureValue>
	^ self items detectMin: [ :each | each temperature ifNil: [ Float infinity ] ]
]

{ #category : #accessing }
ChileTemperatureValues >> perMonths [
	| months |
	months := Array new: 12.
	self
		do: [ :aValue | 
			| anIndex |
			anIndex := aValue time monthIndex.
			(months at: anIndex)
				ifNil: [ months at: anIndex put: (ChileTemperatureMonthValues new monthIndex: anIndex) ].
			(months at: anIndex) addValue: aValue ].
	^ months
]
