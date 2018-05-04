package com.model2.mvc.service.purchase;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;

import com.model2.mvc.service.domain.Purchase;

public interface PurchaseDao {

	// INSERT ��ǰ����
	public void addPurchase(Purchase  purchase) throws Exception ;

	// SELECT ONE ���� ����ȸ 
	public Purchase getPurchase(int tranNo) throws Exception ;

	// SELECT LIST ���Ÿ����ȸ
	public  List<Purchase> getPurchaseList(Search search,String buyerId) throws Exception ;

	// UPDATE �������� ����
	public void updatePurchase(Purchase purchase) throws Exception ;
	
	// �Խ��� Page ó���� ���� ��üRow(totalCount)  return
	public int getTotalCount(String buyerId) throws Exception ;

	//����ڵ� ���� 2->3 �����̷���ȸ���� ���ǵ��� �������� (�����α���) 
	public void updateTranCode(Purchase purchase) throws Exception ;

	//����ڵ� ���� 1->2 ��ǰ�������� ����ϱ� �������� (���ηα���) 
	public void updateTranCodeByProd(Purchase purchase) throws Exception ;
	
}
