package com.model2.mvc.service.product;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

public interface ProductDao{
	
	// INSERT ��ǰ���
	public void addProduct(Product  product) throws Exception ;

	// SELECT ONE ��ǰ��ȸ 
	public Product  getProduc(int prodNo) throws Exception ;

	// SELECT LIST ��ǰ�����ȸ
	public List<Product> getProductList(Search search) throws Exception ;

	// UPDATE ��ǰ����
	public void updateProduct(Product product) throws Exception ;
	
	// �Խ��� Page ó���� ���� ��üRow(totalCount)  return
	public int getTotalCount(Search search) throws Exception ;

}//end of class


