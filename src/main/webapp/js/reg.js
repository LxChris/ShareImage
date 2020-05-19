(function($) {

    $(".toggle-password").click(function() {

        $(this).toggleClass("zmdi-eye zmdi-eye-off");
        var input = $($(this).attr("toggle"));
        if (input.attr("type") == "password") {
          input.attr("type", "text");
        } else {
          input.attr("type", "password");
        }
      });

})(jQuery);


(function() {
  'use strict';
  window.addEventListener('load', function() {
    // Fetch all the forms we want to apply custom Bootstrap validation styles to
    // var forms = document.getElementsByClassName('needs-validation');
    var forms = document.getElementsByClassName('needs-validation');
    // Loop over them and prevent submission
    var validation = Array.prototype.filter.call(forms, function(form) {
      form.addEventListener('submit', function(event) {
        if (form.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    });
  }, false);
})();


// (function($){
//   $('form').bootstrapValidator({

//     message: 'This value is not valid',
//       　feedbackIcons: {
//           　　　　　　　　valid: 'glyphicon glyphicon-ok',
//           　　　　　　　　invalid: 'glyphicon glyphicon-remove',
//           　　　　　　　　validating: 'glyphicon glyphicon-refresh'
//       　　　　　　　　   },
//       fields: {
//           username: {
//               message: '用户名验证失败',
//               validators: {
//                   notEmpty: {
//                       message: '用户名不能为空'
//                   }
//               }
//           },
//           email: {
//               validators: {
//                   notEmpty: {
//                       message: '邮箱地址不能为空'
//                   }
//               }
//           }
//       }
//   });
// });