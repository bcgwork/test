<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>商品编辑</title>
	<%@include file="../common/share_static.jsp" %>
	<!--第三方end-->
<link rel="stylesheet" href="<%=contextPath %>/css/zz/addGoods.css">
</head>
<body>
<!--外围容器-->
<div class="k_contaniner">
	<%@include file="../common/header.jsp" %>
	<%@include file="../common/leftNav.jsp" %>
	<!--右边开始-->
	<div class="k_right">
		<div class="content">
			<form id="edit_goods_form">
				<div class="sptj">
					<h4>商品基本信息</h4>
					<div class="jbxx">
						<p>
							<span class="input_key">服务站 :</span> <i>${login_user.serviceStation.serviceStationName }</i>
						</p>
						<p>
							<span class="input_key">供应商 :</span> <i>${goods_detail.supplier_name }</i>
						</p>
						<p>
							<input type="hidden" id="goods_id" value="${goods_detail.id }"/>
							<span class="input_key">商品编号 :</span><input type="text" name="goods_no" id="goods_no" value="${goods_detail.goodsNo }" readonly="readonly"/>
						</p>
						<p>
							<span class="input_key">商品条形码 :</span><select type="text" name="goods_barcode" id="goods_barcode" placeholder="123456789" style="width: 255px;"><option value="${goods_detail.barcode }" selected="selected">${goods_detail.barcode }</option></select>
						</p>
						<p>
							<span class="input_key"><i class="icon-asterisk tx_red"></i> 商品名称 :</span> <select name="goods_name" id="goods_name" placeholder="品牌+商品名称+商品类型+包装规格" style="width: 455px;" class="validate[required,maxSize[32]]"><option value="${goods_detail.goodsName }" selected="selected">${goods_detail.goodsName }</option></select>
						</p>
						<p>
							<span class="input_key"><i class="icon-asterisk tx_red"></i> 品牌 :</span> <select class="validate[required]" id="brand_repo" name="brand_repo" style="width:455px;"><option value="${goods_detail.brand_detail.id }" selected="selected">${goods_detail.brand_detail.brandName }</option></select>
						</p>
						<p>
							<span class="input_key"><i class="icon-asterisk tx_red"></i> 商品分类 :</span>
							<select class="w_autosuggest" id="j_first" class="validate[required]">
								<option value="${goods_detail.fir_cat.categoryId }" selected="selected">${goods_detail.fir_cat.category_name }</option>
							</select>
							<select class="w_autosuggest" id="j_second" class="validate[required]">
								<option value="${goods_detail.sec_cat.categoryId }" selected="selected">${goods_detail.sec_cat.category_name }</option>
							</select>
							<select class="w_autosuggest" id="j_third" class="validate[required]">
								<option value="${goods_detail.third_cat.categoryId }" selected="selected">${goods_detail.third_cat.category_name }</option>
							</select>	
						</p>
						<div>
							<span class="input_key"><i class="icon-asterisk tx_red"></i> 商品图片 :</span> <em>建议图片尺寸大小为800px*800px.jpg格式，图片的大小不能超过600KB</em>
							<h5>
								<div class="dis_inb j_main_pic_box">
									<label class="w_filebox">
										<img src="<%=contextPath %>/images/share/sctp.png">
										<input type="file" name="file" id="j_main_pic">
									</label>
									<c:forEach items="${goods_detail.mainPhotoList}" var="photo">
									<label class="w_view_pic" data-file_key="${photo.file_key }"><img src="${photo.file_url }" title="asdsads" /><b class="del">X</b></label>
									</c:forEach>
									<input type="hidden" name="keyID" value="${goods_detail.goodsNo }">
									<input type="hidden" name="bucketName" value="goodsmain">
								</div>
								<span class="right_line"></span>
								<div class="dis_inb j_detail_pic_box" data-max="5">
									<label class="w_filebox">
										<img src="<%=contextPath %>/images/share/sctp.png">
										<input type="file" name="file" id="j_detail_pic" multiple>
									</label>
									<c:forEach items="${goods_detail.detailPhotoList}" var="photo">
									<label class="w_view_pic" data-file_key="${photo.file_key }"><img src="${photo.file_url }" /><b class="del">X</b></label>
									</c:forEach>
									<input type="hidden" name="keyID" value="${goods_detail.goodsNo }" id="keyID">
									<input type="hidden" name="bucketName" value="goodsdetail">
								</div>
							</h5>
							<div class="desc">
								<span class="input_key"></span>
								<span class="input_key main">主图</span>
								<span class="input_key detail">详情图，最多5张</span>
							</div>
						</div>
					</div>
					<h4>商品服务信息</h4>
					<div class="fwxx">
						<p>
							<span class="input"><i class="icon-asterisk tx_red"></i> 包装规格 :</span>
							<input type="text" name="package_first" id="package_first" class="validate[required]" placeholder="1.9L" value="${goods_detail.package_fir }">
							<input type="text" name="package_second" id="package_second" class="validate[required]" placeholder="24" value="${goods_detail.package_sec }">
							<select id="goods_unit" name="goods_unit" data-val="${goods_detail.unit.name }"></select>
							 <i class="icon-question-sign" style="cursor:pointer;font-size:22px;color:#2a9fc2" text="包装规格：商品的最小批发单位。商品以组合包装批发，如牛奶（净含量为250ml），但是以一箱（24盒）为最小批发单位，所以，包装规格为“250ml*24盒/箱" id="hover1"></i><br><i class="ts" style="margin-left:140px;position:relative;top:7px;">商品描述不详细或有误，都会影响到商品的销售，请您仔细核对。</i>
						</p>
						<div>
							<span><i class="icon-asterisk tx_red"></i> 价格 :</span>
							<h6>
								<em>平台价是以商品的最小批发单位(即 :包装规格)来设定的价格</em><br>
								<div class="radio" style="margin-bottom:-10px;">
								  <label>
								    <input  class="validate[required] radio" type="radio" name="set_price" id="set_price" value="N" <c:if test="${goods_detail.lotsPrice.name eq 'N' }">checked="checked"</c:if> style="margin-top: -2px;">
								    设置唯一单价(无论多少采购量，都是统一价)
								  </label>
								</div>
								<i>平台价 :<input type="text" name="sale_price" id="sale_price" class="" <c:if test="${goods_detail.lotsPrice.name eq 'N' }">value="${goods_detail.salePrice}"</c:if> ></i><br>
								<div class="radio" style="margin-bottom:-10px;">
									<label><input class="validate[required] radio" type="radio" name="set_price" value="Y" style="margin-top: -2px;" <c:if test="${goods_detail.lotsPrice.name eq 'Y' }">checked="checked"</c:if>>设置阶梯价格(采购数量不同，单价不同)</label>
								</div>
								
								<div class="j_ladder_box">
								    <!-- 显示默认界面 -->
								    <c:if test="${goods_detail.lotsPrice.name eq 'N' }">
									<div class="j_ladder_item">
									    <i>采购量 :<input type="text" name="minQit" class="validate[custom[number]]" /> 至 <input type="text"  name="maxQit" class="validate[custom[number]]"></i>
										<i>梯度价 :<input type="text" name="lotPrice" class="validate[custom[number]]"> 元 </i><a href="javascript:void(0);" class="j_add_ladder">(添加梯度价)</a>
									</div>
								    </c:if>
								    
								     <!-- 显示阶梯价 -->
								     <c:if test="${goods_detail.lotsPrice.name eq 'Y' }">
								        <c:forEach items="${goods_detail.goodslotPriceList }" var="lotPrice" varStatus="item_status">
								             <c:if test="${item_status.index eq 0 }">
								             	<div class="j_ladder_item">
									             	<i>采购量 :<input type="text" name="minQit" value="${lotPrice.minQit }" /> 至 <input type="text"  name="maxQit" value="${lotPrice.maxQit }"></i>
											     	<i>梯度价 :<input type="text" name="lotPrice" value="${lotPrice.lotPrice }"> 元 </i><a href="javascript:void(0);" class="j_add_ladder">(添加梯度价)</a>
											     </div>
								             </c:if>
								             
								             <c:if test="${item_status.index ne 0 }">
								             	<div class="j_ladder_item"><i>采购量 :<input type="text" name="minQit" value="${lotPrice.minQit }"> 至 <input type="text" name="maxQit" value="${lotPrice.maxQit }"></i><i>梯度价 :<input type="text" name="lotPrice" value="${lotPrice.lotPrice }"> 元 </i><a href="javascript:void(0);" class="j_del_ladder">删除</a></div>
								             </c:if>
								        </c:forEach>
								    </c:if>
								</div>
								<i>建议零售价 :<input class="validate[custom[number]]" type="text" name="suggest_retail_price" id="suggest_retail_price" value="${goods_detail.suggestRetailPrice }"><i class="icon-question-sign" style="cursor:pointer;font-size:22px;color:#2a9fc2" text="建议零售价为新品上新时，指导超市的终端销售价格" id="hover2"></i></i>
							</h6>
						</div>
						<p>
							<span><i class="icon-asterisk tx_red"></i> 最低起送量 :</span><input type="text" id="minPurchased" name="minPurchased" value="${goods_detail.minPurchased }" style="margin-right:10px;" class="validate[required]"><select id="goods_send_unit" placeholder="选择商品单位" class="hide"><option>商品单位</option></select>
						</p>
						<p>
							<span>保质期 :</span><input type="text" name="shelfLife" id="shelfLife" placeholder="30天"  value="${goods_detail.shelfLife }"/>
						</p>
						<p>
							<span>生产日期 :</span><input type="text" name="productDate" id="productDate" placeholder="2016-08-16" class="Wdate" value="${goods_detail.productDate }"/>
						</p>
						<p>
							<span><i class="icon-asterisk tx_red"></i> 退换货 :</span>
							<select style="position:relative;left:-5px;" id="return_policy" name="return_policy" data-val="${goods_detail.returnPolicy.name}"></select>
							<input type="text" name="" placeholder="添加说明" >
						</p>
						<p>
							<span>上架设置 :</span><input type="checkbox" name="submittoReview" id="submittoReview" value="NEW"  checked="checked"/><i>提交审核</i>
						</p>
					</div>
					<h4>商品配送信息</h4>
					<div class="psxx">
						<p>
							<span class="input_key"><i class="icon-asterisk tx_red"></i> 配送范围 :</span>
							<span>${shipping_area_data.province.name },${shipping_area_data.city.name } <i class="icon-question-sign e_hover_i" title="说明: 供应商注册：选择配送范围（服务范围）是基于服务站，只能在服务站服务区域内选择配送范围，如您的业务有延伸至其余区域，请在相关区域注册账号开展业务，感谢您的支持。"></i></span>
						</p>
						<div class="w_label_box tree_box">
				    		<ul class="root">
				    		    <c:forEach items="${shipping_area_data.county_list }" var="county">
					    		    <li class="child_li active">
					    				<label class="first_label"><input type="checkbox"> ${county.name } <i class="icon-angle-down"></i><i class="icon-angle-up"></i></label>
					    				<ul class="clearfix second_box">
					    				    <c:forEach items="${county.childrenRegionList }" var="street">
					    				        <li><label><input type="checkbox" value="${street.id }" <c:if test="${street.isOpendFWZ eq 'Y' }"> checked="checked" </c:if> /> ${street.name }</label></li>
					    				    </c:forEach>
					    				</ul>
					    			</li>
				    		    </c:forEach>
				    		</ul>   	
				      	</div>
						<p>
							<span class="input_key"><i class="icon-asterisk tx_red"></i> 商品排序 :</span>
							<input type="text" name="" value="${goods_detail.listOrder }"  id="listOrder" class="validate[custom[integer]]"><br>
							<b>商品排序为供应商商品列表页的优先排序,数字越小排在前面	</b>
						</p>
						<p>
							<button type="button" class="submit j_submit">提交</button>
							<button type="reset" class="reset">重置</button>
						</p>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!--右边结束-->
	<!--面包屑导航-->
	<div class="k_breadcrumb">
		<ol class="breadcrumb" style="background:#fff">
		  	<li><a href="#">供应商</a></li>
		  	<li><a href="#">商品管理</a></li>
		  	<li><a href="#">编辑商品</a></li>
		</ol>
		<a href="<%=contextPath %>/gys/goods/gotoListGoods.do" class="add_menu">商品列表</a>
	</div>
	<!--面包屑导航结束-->
	<!--footer开始-->
	<%@include file="../common/footer.jsp" %>
	<div id="show" style="display:none"></div>
	<!--footer结束-->
</div>	
<!--end-->
<script type="text/javascript">
	seajs.use("gys/goods/edit", function(view) {
		view.init();
	});
	$(document).ready(function() {
		Common.hovershow($("#hover1"),$("#show"));
		Common.hovershow($("#hover2"),$("#show"));
	})
</script>
</body>
</html>