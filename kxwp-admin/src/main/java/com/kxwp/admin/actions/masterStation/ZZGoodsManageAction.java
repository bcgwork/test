package com.kxwp.admin.actions.masterStation;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.beanutils.BeanUtilsBean2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kxwp.admin.actions.serviceStation.FWZGoodsManageAction;
import com.kxwp.admin.entity.supplier.SupplierAccount;
import com.kxwp.admin.service.supplier.CopyGoodsService;
import com.kxwp.admin.service.supplier.SupplierManageGoodsService;
import com.kxwp.admin.utils.session.FWZUserSessionUtils;
import com.kxwp.common.constants.ErrorPage;
import com.kxwp.common.constants.ReviewTypeEnum;
import com.kxwp.common.data.exchange.ExchangeData;
import com.kxwp.common.entity.supplier.Goods;
import com.kxwp.common.form.goods.CopyGoodsForm;
import com.kxwp.common.model.exception.KXWPNotFoundException;
import com.kxwp.common.model.exception.SYSException;
import com.kxwp.common.model.uc.LoginUserInfo;
import com.kxwp.common.query.goods.SearchGoodsRepoQuery;
import com.kxwp.common.query.goods.UpdateGoodsStatusQuery;
import com.kxwp.common.query.sys.ReviewQuery;
import com.kxwp.common.service.core.ReviewService;
import com.kxwp.common.service.goods.GoodsRepoService;
import com.kxwp.common.utils.KXWPLogUtils;

/**
 * 服务站商品管理 Date: 2016年8月12日 下午6:31:50
 * 
 * @author lou jian wen
 */
@Controller
@RequestMapping("/zz/goods")
public class ZZGoodsManageAction {


  @Autowired
  private GoodsRepoService goodsRepoService;
  
  @Autowired
  private CopyGoodsService copyGoodsService ;


  /**
   * 
   * updateGoodsStatus:(服务站更新商品状态,审核,下架).
   *
   * 2016年8月19日 上午10:11:58
   * 
   * @author lou jian wen
   * @param goodsID
   * @param request
   * @param response
   * @return
   */
  @SuppressWarnings("rawtypes")
  @RequestMapping(value = "/updateGoodsStatus.do",
      produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
  public @ResponseBody ExchangeData updateGoodsStatus(
      @RequestBody UpdateGoodsStatusQuery updateGoodsStatusQuery, HttpServletRequest request,
      HttpServletResponse response) {
    ExchangeData ed = new ExchangeData<>();
    try {

      Goods goods_detail = goodsRepoService.getGoodsByID(updateGoodsStatusQuery.getId());
      if (goods_detail.getServiceStationId().longValue() != FWZUserSessionUtils
          .getUserSession(request).getServiceStation().getId()) {
        ed.mark403();
      } else {
        LoginUserInfo loginUserInfo = new LoginUserInfo();
        BeanUtilsBean2.getInstance().copyProperties(loginUserInfo, FWZUserSessionUtils.getUserSession(request));
        updateGoodsStatusQuery.setLoginUserInfo(loginUserInfo);
        goodsRepoService.updateGoodsStatus(updateGoodsStatusQuery);
      }
    } catch (KXWPNotFoundException | SYSException e) {
      ed.markException(e.getMessage(), e);
    } catch (Exception e) {
      ed.markException(e);
    }

    return ed;
  }

  @Autowired
  private ReviewService reviewService;

  /**
   * 
   * getGoodsDetail:(供应商显示商品详情).
   *
   * 2016年8月14日 下午5:54:49
   * 
   * @author janwen
   * @param request
   * @param response
   * @return
   */
  @RequestMapping(value = "/gotoGoodsDetail.do")
  public String gotoGoodsDetail(@RequestParam Long goodsID, HttpServletRequest request,
      HttpServletResponse response) {
    Goods goods_detail;
    try {
      goods_detail = goodsRepoService.getGoodsByID(goodsID);
      request.setAttribute("goods_detail", goods_detail);
      ReviewQuery reviewQuery = new ReviewQuery();
      reviewQuery.setReviewId(goodsID);
      reviewQuery.setReviewType(ReviewTypeEnum.Goods);
      request.setAttribute("reviews", reviewService.queryReview(reviewQuery));
    } catch (KXWPNotFoundException e) {
      KXWPLogUtils.logException(this.getClass(), e);
      return ErrorPage.PAGE_500;
    }

    return "fwz/fwz.goods_detail";
  }

  @RequestMapping(value = "/gotoGoodsReview.do")
  public String gotoGoodsReview(@RequestParam Long goodsID, HttpServletRequest request,
      HttpServletResponse response) {
    Goods goods_detail;
    try {
      goods_detail = goodsRepoService.getGoodsByID(goodsID);
      request.setAttribute("goods_detail", goods_detail);
      ReviewQuery reviewQuery = new ReviewQuery();
      reviewQuery.setReviewId(goodsID);
      request.setAttribute("reviews", reviewService.queryReview(reviewQuery));
    } catch (KXWPNotFoundException  e) {
      KXWPLogUtils.logException(this.getClass(), e);
      return ErrorPage.PAGE_500;
    }

    return "fwz/fwz.goods_review";
  }


  @Autowired
  private SupplierManageGoodsService supplierManageGoodsServivce;



  @RequestMapping(value = "/listGoods.do")
  public @ResponseBody ExchangeData<List<Goods>> listGoods(@RequestBody SearchGoodsRepoQuery query,
      HttpServletRequest request, HttpServletResponse response) {
    ExchangeData<List<Goods>> edb = new ExchangeData<>();
    try {
      List<Goods> results = supplierManageGoodsServivce.listGoods(query);
      int total = supplierManageGoodsServivce.countSearchGoods(query);
      edb.getPager().setCurrentPage(query.getPager().getCurrentPage());
      edb.getPager().setPageSize(query.getPager().getPageSize());
      edb.getPager().setTotoalResults(total);
      edb.setData(results);
    } catch (Exception e) {
      edb.markException(e);
    }
    return edb;
  }

  @RequestMapping(value = "/gotoListGoods.do")
  public String gotoListGoods(SupplierAccount supplierAccount) {

    return "zz/zz.list_goods";
  }
  
  
  /**
   * gotoCopyGoods:(跳转到复制商品页面).
   *
   * 2016年9月14日 上午9:31:56
   * 
   * @author zhaojn
   * @return
   */
  @RequestMapping(value = "/gotoCopyGoods.do")
  public String gotoCopyGoods() {

    return "zz/zz.copy_goods";
  }

  
  /**
   * copyGoods:(复制商品).
   *
   * 2016年9月14日 上午10:19:01
   * 
   * @author zhaojn
   * @param form
   * @return
   * 
   */
  @SuppressWarnings("rawtypes")
  @RequestMapping(value = "/copyGoods.do", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
  public @ResponseBody ExchangeData copyGoods(@Valid @RequestBody CopyGoodsForm form) {
    ExchangeData edb = new ExchangeData<>();
    try {
      copyGoodsService.copyGoods(form);
    } catch (KXWPNotFoundException | SYSException e) {
      KXWPLogUtils.logException(this.getClass(), e);
      edb.markException(e.getMessage(), e);
    } catch (Exception e) {
      edb.markException("系统出错", e);
      KXWPLogUtils.logException(FWZGoodsManageAction.class, "/copyGoods.do :", e);
    }
    return edb;
  }
}
