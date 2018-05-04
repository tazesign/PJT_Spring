package com.model2.mvc.service.purchase;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseService {

	public void addPurchase(Purchase purchase) throws Exception;

	public Map<String,Object> getPurchaseList(Search search, String buyerId) throws Exception;
	
	//���� ��� ��ȸ���� no��ũŸ�� ���� ������ ��ǰ ���°�
	public Purchase getPurchase(int tranNo) throws Exception;
	
	//���ſ�û�� ����
	public void updatePurchase(Purchase purchase) throws Exception;
	
	/*public PurchaseVO getPurchase2(int ProdNo) throws Exception;
	
	public HashMap<String,Object> getSaleList(SearchVO searchVO) throws Exception;*/
	
	//�����̷���ȸ���� ���ǵ��� �������� 
	public void updateTranCode(Purchase purchase) throws Exception;
	
	//��ǰ�������� ����ϱ⸦ ��������
	public void updateTranCodeByProd(Purchase purchase) throws Exception;
	
}