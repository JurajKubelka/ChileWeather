Class {
	#name : #ChileTemperatureMonthValues,
	#superclass : #Object,
	#traits : 'TGtGroup + TChileTemperatureValues',
	#classTraits : 'TGtGroup classTrait + TChileTemperatureValues classTrait',
	#instVars : [
		'monthIndex',
		'values'
	],
	#category : #'ChileWeather-Temperature'
}

{ #category : #accessing }
ChileTemperatureMonthValues >> addValue: aValue [
	self values add: aValue
]

{ #category : #accessing }
ChileTemperatureMonthValues >> asCharElement [
	| aMinTemp aTempDiff aTimeDiff aMaxTemp aMaxTime aMinTime |
	aMinTime := self minTime time.
	aMaxTime := self maxTime time.
	aTimeDiff := aMaxTime - aMinTime.
	aMinTemp := self minTemperature temperature.
	aMaxTemp := self maxTemperature temperature.
	aTempDiff := aMaxTemp - aMinTemp.
	^ BrFrame new
		in: [ :aContainer | 
			self
				do: [ :each | 
					each temperature
						ifNotNil: [ | anElement |
							anElement := BlElement new
									size: 5 @ 5;
									geometry: BlCircleGeometry new;
									background: Color lightGray;
									aptitude: (BrGlamorousWithLabelTooltipAptitude new
											text: each gtDisplayString;
											showDelay: 0 milliSeconds;
											hideDelay: 300 milliSeconds);
									constraintsDo: [ :c | 
										| hValue vValue |
										hValue := ((each time - aMinTime) / aTimeDiff) asFloat.
										vValue := 1 - ((each temperature - aMinTemp) / aTempDiff) asFloat.
										c frame horizontal alignCenterAt: hValue.
										c frame vertical alignCenterAt: vValue ].
							aContainer addChild: anElement ] ] ];
		padding: (BlInsets all: 20);
		matchParent
]

{ #category : #'gt - extensions' }
ChileTemperatureMonthValues >> gtChartFor: aView [
	<gtView>
	^ aView explicit
		title: 'Chart';
		stencil: [ self asCharElement ]
]

{ #category : #accessing }
ChileTemperatureMonthValues >> gtTemperatureValuesPerYearFor: aView [
	<gtView>
	self items ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Temp. per year';
		items: [ ((self groupedBy: [ :each | each time year ]) associations
				sorted: [ :a :b | a key < b key ])
				collect: [ :anAssoc | anAssoc key -> (ChileTemperatureValues withAll: anAssoc value) ] ];
		column: 'Year'
			text: [ :anAssoc | anAssoc key ]
			width: 80;
		column: 'Values'
			text: [ :anAssoc | 
				'{1} {2}'
					format: {anAssoc value size.
							'value' asPluralBasedOn: anAssoc value size} ]
			width: 100;
		column: 'Min temp'
			text: [ :aValue | aValue value minTemperature temperature ];
		column: 'Max temp'
			text: [ :aValue | aValue value maxTemperature temperature ];
		send: #value
]

{ #category : #initialization }
ChileTemperatureMonthValues >> initialize [
	super initialize.
	values := SortedCollection sortBlock: [ :a :b | a time < b time ]
]

{ #category : #accessing }
ChileTemperatureMonthValues >> items [
	^ self values
]

{ #category : #accessing }
ChileTemperatureMonthValues >> maxTemperature [
	<return: #ChileTemperatureValue>
	^ self items
		detectMax: [ :each | each temperature ifNil: [ Float negativeInfinity ] ]
]

{ #category : #accessing }
ChileTemperatureMonthValues >> maxTime [
	^ self items
		detectMax: [ :each | each temperature ifNotNil: [ each time ] ifNil: [ 1900 asYear ] ]
]

{ #category : #accessing }
ChileTemperatureMonthValues >> minTemperature [
	<return: #ChileTemperatureValue>
	^ self items detectMin: [ :each | each temperature ifNil: [ Float infinity ] ]
]

{ #category : #accessing }
ChileTemperatureMonthValues >> minTime [
	^ self items
		detectMin: [ :each | each temperature ifNotNil: [ each time ] ifNil: [ Date today + 1 year ] ]
]

{ #category : #accessing }
ChileTemperatureMonthValues >> monthIndex [
	^ monthIndex
]

{ #category : #accessing }
ChileTemperatureMonthValues >> monthIndex: anObject [
	monthIndex := anObject
]

{ #category : #accessing }
ChileTemperatureMonthValues >> values [
	^ values
]

{ #category : #accessing }
ChileTemperatureMonthValues >> values: anObject [
	values := anObject
]
