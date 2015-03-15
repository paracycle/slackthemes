//= require_tree .

angular.module('theme', [])
    .controller('ThemeController', ['$scope', function($scope) {
       $scope.$watch(
            function() { return $scope.theme; },
            function(theme) {
                parts = theme.split(',');
                $scope.column_bg = parts[0];
                $scope.menu_bg = parts[1];
                $scope.active_item = parts[2];
                $scope.active_item_text = parts[3];
                $scope.hover_item = parts[4];
                $scope.text_color = parts[5];
                $scope.active_presence = parts[6];
                $scope.mention_badge = parts[7];
        });
    }]);
