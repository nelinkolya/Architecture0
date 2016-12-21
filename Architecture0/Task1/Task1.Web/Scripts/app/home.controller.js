angular
    .module("task1")
    .controller("homeCtrl", homeCtrl);

homeCtrl.$inject = ["$http", "userService", "lodash", "$moment"];

function homeCtrl($http, userService, lodash, $moment) {
    var vm = this;

    vm.actions = {
        toggleCreatingPost: toggleCreatingPost,
        savePost: savePost,
        removePost: removePost,
        toggleAddingComment: toggleAddingComment,
        saveComment: saveComment,
        removeComment: removeComment,
        showDeleted: showDeleted,
        hideDeleted: hideDeleted
    }

    init();

    function init() {
        userService.getCurrentUser().then(function(r) {
            vm.currentUser = r;
        });

        $http.get("home/getPosts").then(function(r) {
            vm.posts = r.data;
            formatDates(vm.posts, 'CreatedOn');

            vm.posts.forEach(function(el) {
                if (el.Comments) {
                    formatDates(el.Comments, 'CreatedOn');
                }
            });
        });
    }

    function showDeleted() {
        vm.hideDeleted = false;
        vm.posts = angular.copy(vm.allPosts);
    }

    function hideDeleted() {
        vm.hideDeleted = true;

        vm.allPosts = angular.copy(vm.posts);

        vm.posts = lodash.filter(vm.posts, function(el) {
            return !el.IsDeleted;
        });
    }

    function formatDates(arr, propName, format) {
        arr.forEach(function(el) {
            el[propName] = toLocalFormatDate(el[propName], format);
        });
    }

    function toLocalFormatDate(date, format) {
        return $moment(date).local().format(format || "YYYY/MM/DD HH:mm:ss");
    }

    function toggleCreatingPost() {
        if (vm.newPost && vm.newPost.creating)
            return;
        vm.newPost = { creating: true };
    }

    function toggleAddingComment(post) {
        if (post.newComment && post.newComment.creating)
            return;
        post.newComment = { creating: true, PostId: post.Id };
    }

    function savePost(post) {
        post.saving = true;
        var isNewPost = !(post.Id > 0);

        post.CreatedOn = null;

        $http.post("home/savePost", post).then(function(r) {
            r.data.CreatedOn = toLocalFormatDate(r.data.CreatedOn);
            formatDates(r.data.Comments, 'CreatedOn');

            if (isNewPost) {
                vm.posts.unshift(r.data);
                vm.newPost = {}
            } else {
                replace(vm.posts, r.data);
            }
        });
    }

    function removePost(post) {
        $http.post("home/removePost", { postId: post.Id }).then(function(r) {
            if (vm.currentUser.CanSeeDeleted) {
                r.data.CreatedOn = toLocalFormatDate(r.data.CreatedOn);
                replace(vm.posts, r.data);
            } else {
                remove(vm.posts, post);
            }
        });
    }

    function saveComment(post, comment) {
        var isNew = !comment || !(comment.Id > 0);

        if (isNew) {
            post.newComment.saving = true;
        } else {
            comment.CreatedOn = null;
        }

        $http.post("home/saveComment", isNew ? post.newComment : comment).then(function(r) {
            r.data.CreatedOn = toLocalFormatDate(r.data.CreatedOn);

            if (isNew) {
                post.Comments.unshift(r.data);
                post.newComment = {}
            } else {
                replace(post.Comments, r.data);
            }
        });
    }

    function removeComment(post, comment) {
        $http.post("home/removeComment", { commentId: comment.Id }).then(function() {
            if (vm.currentUser.CanSeeDeleted) {
                comment.IsDeleted = true;
                replace(post.Comments, comment);
            } else {
                remove(post.Comments, comment);
            }
        });
    }

    function remove(arr, item) {
        var index = lodash.findIndex(arr, { "Id": item.Id });
        arr.splice(index, 1);
    }

    function replace(arr, item) {
        var index = lodash.findIndex(arr, { "Id": item.Id });
        arr.splice(index, 1, item);
    }
}