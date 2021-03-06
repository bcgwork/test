define('fwz/supermarket/review', function(require, exports, module) {

	var Model = require('model/fwz/supermarket'); // 引入接口文件

	module.exports = {

		// 页面绑定事件，所有的事件都在这里写
		initEvents : function() {
			var view = this;
			// 绑定查询事件
			view.$el.on('click', '.j-review', function(event) {
				event.preventDefault();
				var btn = $(this);
				
				var new_status = btn.attr("new-status");
				if(new_status == 'REJECT'){
					layer.prompt({formType:2,title: '请输入原因'},function(value, index, elem){
						  if(value && value != ''){
							  view.update_supermarket(btn,value);
							  layer.close(index);
						  }
						});
				}else{
					layer.confirm('确认上架？', function(index){
						  view.update_supermarket(btn,"");
						  layer.close(index);
						}); 
				}
			});
		},

		// 更新函数
		update_supermarket : function(btn,_reject_reason) {
			var view = this;
			var ajax_data = {
					    id:btn.attr("supermarket-id"),
					    supermarketStatus:btn.attr("new-status"),
					    statusUpdateDescription:_reject_reason
					};
			Model.update_supermarket_status(ajax_data).done(function(data) {
				if (data.callStatus == 'SUCCESS') {
					layer.alert('操作成功',function(index){
						window.location.reload();
					});        
				}
			})
		},

		// 初始化页面函数
		init : function() {
			var view = this;
			view.$el = $('.k_right'); // 准备好这个页面的dom元素
			view.initEvents(); // 初始化绑定事件
		}
	};
});