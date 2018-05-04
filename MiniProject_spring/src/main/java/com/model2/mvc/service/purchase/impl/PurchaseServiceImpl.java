package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;


//==> ���Ű��� ���� ����
@Service("purchaseServiceImpl")

public class PurchaseServiceImpl implements PurchaseService  {
		
	///Field
		@Autowired
		@Qualifier("purchaseDaoImpl")
		 PurchaseDao  purchaseDao;
		
		public void setPruchaseDAO(PurchaseDao purchaseDao){
			this.purchaseDao=purchaseDao;
		}

		///Constructor
		public PurchaseServiceImpl() {
			System.out.println(" purchase service impl ������ ȣ��");
		}
		
		///Method
		//���ſ�û
		public void addPurchase(Purchase purchase) throws Exception{
			System.out.println(" purchase service impl ����");
			purchaseDao.addPurchase(purchase);
		}
		
		//���Ÿ����ȸ
		public Map<String,Object> getPurchaseList(Search search, String buyerId) throws Exception{  
			
			List<Purchase>list = purchaseDao.getPurchaseList(search,buyerId);
			int totalCount = purchaseDao.getTotalCount(buyerId);
			//return productDao.getProductList(search); //��ǰ����� ���ϰ��̸� //������ ���� ���ÿ��� �ٷ� dao.~~() ȣ��
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", list );
			map.put("totalCount", new Integer(totalCount));
			
			return map;
		}
		
		//���� ����ȸ
		public Purchase getPurchase(int tranNo) throws Exception{
			return purchaseDao.getPurchase(tranNo);
		}
		
		//���ż�����ȸ
		public void updatePurchase(Purchase purchase) throws Exception{
			purchaseDao.updatePurchase(purchase);
		}
		
		//�����̷� ��ȸ ���ǵ��� ��������
		public void updateTranCode(Purchase purchaseVO) throws Exception{
			purchaseDao.updateTranCode(purchaseVO);
		}
		
		//Admin ��ǰ�������� ����ϱ⸦ ��������
		public void updateTranCodeByProd(Purchase purchase) throws Exception{
			purchaseDao.updateTranCodeByProd(purchase);
		}
		
}//end of class
