Extension { #name : #PRHTMLWriter }

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
PRHTMLWriter >> gtWriteExampleCode: aGt2ExampleAnnotation [ 
	canvas tag
		name: 'figure';
		parameterAt: 'class' put: 'gtexample-src';
		with: [ 
					canvas tag
						name: 'pre';
						with: [ 
									| code language |
									code := canvas tag
										name: 'code';
										yourself.
									language := PRSmalltalkScriptLanguage default.
									language isSyntaxHighlightingPossible
										ifTrue: [ code parameterAt: 'class' put: language printString ].
									code with: [ aGt2ExampleAnnotation isMethodDefined 
										ifTrue: [ canvas lines: aGt2ExampleAnnotation methodDefinition sourceCode ]
										ifFalse: [ canvas lines: aGt2ExampleAnnotation methodDefinition printString ] ] ].
					canvas tag
						name: 'figcaption';
						with: [ 
									aGt2ExampleAnnotation hasLabel
										ifTrue: [ 
											self createAnchorWith: aGt2ExampleAnnotation label.
											self writeCounterForScript: aGt2ExampleAnnotation ].
									aGt2ExampleAnnotation hasCaption
										ifTrue: [ self visitAll: aGt2ExampleAnnotation caption children ] ] ].
	canvas newLine
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
PRHTMLWriter >> gtWriteExampleResult: aGt2ExampleAnnotation [ 
	| aFigure aFigureReference |
	aFigure := PRFigure new.
	aFigure label: 'figure-' , aGt2ExampleAnnotation methodName.
	aFigure add: (PRText content: 'Result of ' , aGt2ExampleAnnotation methodName).
	aFigureReference := self configuration gtDataWriter exampleResultReferenceFor: aGt2ExampleAnnotation.
	aFigure reference: aFigureReference.
	self visitFigure: aFigure.
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
PRHTMLWriter >> visitGt2ChangesAnnotation: aGt2ChangesAnnotation [
	| aContent |
	aGt2ChangesAnnotation gtDocument: self configuration gtDocument.
	aContent := aGt2ChangesAnnotation cachedChanges tutorialStateRope asString.
	canvas tag
		name: 'figure';
		parameterAt: 'class' put: 'changes';
		with: [ 
					canvas tag
						name: 'pre';
						with: [ canvas lines: aContent ].
				].
	canvas newLine
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
PRHTMLWriter >> visitGt2ClassAnnotation: aGt2ClassAnnotation [
	| uniqueId |
	uniqueId := 	self configuration gtUniqueIdGenerator next printString.
	canvas tag
		name: 'div';
		parameterAt: 'class' put: 'sourceCode';
		with: [ 
					canvas tag
						name: 'a';
						parameterAt: 'href' put: '#' , uniqueId;
						with: [ canvas nextPutAll: aGt2ClassAnnotation referencedClass name ].
						
					canvas tag
						name: 'div';
						parameterAt: 'id' put: uniqueId;
						with: [
							canvas tag
								name: 'pre';
								with: [ canvas lines: aGt2ClassAnnotation referencedClass definition ].
						]
				].
	canvas newLine.
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
PRHTMLWriter >> visitGt2ExampleAnnotation: aGt2ExampleAnnotation [
	aGt2ExampleAnnotation isMethodDefined ifFalse: [ ^ self ].
	aGt2ExampleAnnotation noCode ifFalse: [ self gtWriteExampleCode: aGt2ExampleAnnotation ].
	aGt2ExampleAnnotation isPreviewDefined ifFalse: [ ^ self ].
	self gtWriteExampleResult: aGt2ExampleAnnotation.
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
PRHTMLWriter >> visitGt2ExamplesAnnotation: aGt2ExamplesAnnotation [
	self visitOrderedList: (PROrderedList withAll: (aGt2ExamplesAnnotation allExamples collect: [ :anExample | PRListItem with: (PRText content: anExample method name) ])).
	
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
PRHTMLWriter >> visitGt2IcebergFileAnnotation: aGt2IcebergFileAnnotation [ 
	| aHref |
	aGt2IcebergFileAnnotation isReferenceDefined ifFalse: [ ^ self ]. 
	aHref := GtFileUtilityConstants localGtDirectoryName, '/', aGt2IcebergFileAnnotation path.
	canvas tag
		name: 'a';
		parameterAt: 'href' put: aHref;
		with: [ canvas nextPutAll: aHref ].
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
PRHTMLWriter >> visitGt2MethodAnnotation: aGt2MethodAnnotation [		
	| uniqueId |
	uniqueId := 	self configuration gtUniqueIdGenerator next printString.
	canvas tag
		name: 'div';
		parameterAt: 'class' put: 'sourceCode';
		with: [ 
					canvas tag
						name: 'a';
						parameterAt: 'href' put: '#' , uniqueId;
						with: [ canvas nextPutAll: aGt2MethodAnnotation referencedMethod name ].
					canvas tag
						name: 'div';
						parameterAt: 'id' put: uniqueId;
						with: [
							canvas tag
								name: 'pre';
								with: [ canvas lines: aGt2MethodAnnotation referencedMethod sourceCode ].
						]
				].
	canvas newLine.
]