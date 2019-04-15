Class {
	#name : #GtStyledNodeBuilderProperties,
	#superclass : #Object,
	#instVars : [
		'dictionary'
	],
	#category : #'GToolkit-Documenter-Styler Builder'
}

{ #category : #'accessing - document properties' }
GtStyledNodeBuilderProperties >> action [
	^ self at: #action
]

{ #category : #'accessing - document properties' }
GtStyledNodeBuilderProperties >> action: anAction [
	^ self at: #action put: anAction
]

{ #category : #'accessing - basic properties' }
GtStyledNodeBuilderProperties >> at: aSymbol [
	^ self collection 
		at: aSymbol 
		ifAbsent: [ self error: 'Property must be set before using it' ]
]

{ #category : #'accessing - basic properties' }
GtStyledNodeBuilderProperties >> at: aSymbol ifAbsentPut: aValue [
	^ self collection 
		at: aSymbol 
		ifAbsentPut: aValue
]

{ #category : #'accessing - basic properties' }
GtStyledNodeBuilderProperties >> at: aSymbol ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ self collection 
		at: aSymbol 
		ifPresent: aPresentBlock 
		ifAbsent: anAbsentBlock
]

{ #category : #'accessing - basic properties' }
GtStyledNodeBuilderProperties >> at: aSymbol put: aValue [
	^ self collection 
		at: aSymbol 
		put: aValue
]

{ #category : #accessing }
GtStyledNodeBuilderProperties >> collection [
	<return: #Dictionary>
	^ dictionary
]

{ #category : #accessing }
GtStyledNodeBuilderProperties >> collection: anObject [
	dictionary := anObject
]

{ #category : #'accessing - cursor properties' }
GtStyledNodeBuilderProperties >> cursorEnterAction [
	^ self at: #cursorEnterAction
]

{ #category : #'accessing - cursor properties' }
GtStyledNodeBuilderProperties >> cursorEnterAction: anAction [
	self at: #cursorEnterAction put: anAction
]

{ #category : #'accessing - cursor properties' }
GtStyledNodeBuilderProperties >> cursorLeaveAction [
	^ self at: #cursorLeaveAction
]

{ #category : #'accessing - cursor properties' }
GtStyledNodeBuilderProperties >> cursorLeaveAction: anAction [
	self at: #cursorLeaveAction put: anAction
]

{ #category : #'accessing - hide properties' }
GtStyledNodeBuilderProperties >> hideInterval: anInterval [
	| anIntervals |
	anIntervals := self at: #hidingIntervals ifAbsentPut: [ OrderedCollection new: 2 ].
	anIntervals addLast: anInterval.
]

{ #category : #'accessing - hide properties' }
GtStyledNodeBuilderProperties >> hidingIntervals [
	^ self at: #hidingIntervals
]

{ #category : #initialization }
GtStyledNodeBuilderProperties >> initialize [
	super initialize.
	dictionary := Dictionary new.
]

{ #category : #'accessing - hide properties' }
GtStyledNodeBuilderProperties >> keepChildDisplayed [
	^ self at: #keepChildDisplayed
]

{ #category : #'accessing - hide properties' }
GtStyledNodeBuilderProperties >> keepChildDisplayed: aPRDocumentItem [
	self at: #keepChildDisplayed put: aPRDocumentItem
]

{ #category : #'accessing - document properties' }
GtStyledNodeBuilderProperties >> name [
	^ self at: #name
]

{ #category : #'accessing - document properties' }
GtStyledNodeBuilderProperties >> name: aString [
	^ self at: #name put: aString
]

{ #category : #'accessing - hide properties' }
GtStyledNodeBuilderProperties >> shouldHideParts [
	^ self collection includesKey: #hidingIntervals
]

{ #category : #'accessing - hide properties' }
GtStyledNodeBuilderProperties >> shouldKeepChildDisplayed [
	^ self collection includesKey: #keepChildDisplayed
]