angular.module "ngJScrollPane", []
angular
	.module("ngJScrollPane")
	.directive "scrollPane", ['$timeout',
		($timeout) ->
			restrict: 'A'
			transclude: true
			template: '<div class="scroll-pane"><div ng-transclude></div></div>'
			link: ($scope, $elem, $attrs) ->
				config = {}
				if $attrs.scrollConfig
					config = $scope.$eval($attrs.scrollConfig)
				fn = ->
					jQuery("##{$attrs.id}").jScrollPane(config)
					$scope.pane = jQuery("##{$attrs.id}").data("jsp")
				if $attrs.scrollTimeout
					$timeout(fn, $scope.$eval($attrs.scrollTimeout))
				else
					do fn
				$scope.$on("reinit-pane", (event, id) ->
					if id is $attrs.id and $scope.pane
						console.log("Reinit pane #{id}")
						$scope.$apply ->
							$scope.pane.destroy()
							fn()
				)
			replace: true
	]
