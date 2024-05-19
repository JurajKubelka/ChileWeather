Class {
	#name : #ChileTemperatureValue,
	#superclass : #Object,
	#instVars : [
		'code',
		'time',
		'temperature'
	],
	#category : #'ChileWeather-Temperature'
}

{ #category : #accessing }
ChileTemperatureValue >> code [
	^ code
]

{ #category : #accessing }
ChileTemperatureValue >> code: anObject [
	code := anObject
]

{ #category : #printing }
ChileTemperatureValue >> gtDisplayOn: aStream [
	aStream
		nextPutAll: 'time: ';
		print: (time
				ifNotNil: [ :aTime | aTime asDate asString , ' ' , aTime hour24 asString , ':00' ]);
		nextPutAll: ', temperature: ';
		print: temperature
]

{ #category : #printing }
ChileTemperatureValue >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: 'time: ';
		print: (time
				ifNotNil: [ :aTime | aTime asDate asString , ' ' , aTime hour24 asString , ':00' ]);
		nextPutAll: ', temperature: ';
		print: temperature;
		nextPut: $)
]

{ #category : #accessing }
ChileTemperatureValue >> temperature [
	^ temperature
]

{ #category : #accessing }
ChileTemperatureValue >> temperature: anObject [
	temperature := anObject
]

{ #category : #accessing }
ChileTemperatureValue >> time [
	^ time
]

{ #category : #accessing }
ChileTemperatureValue >> time: anObject [
	time := anObject
]
