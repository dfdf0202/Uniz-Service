package com.uniz.service;

import java.util.List;

import com.uniz.domain.BoardAttachVO;
import com.uniz.domain.BoardVO;
import com.uniz.domain.Criteria;
import com.uniz.domain.PageDTO;

public interface BoardService {
	
	public List<BoardVO> getBoardList();
	
	public List<BoardVO> getPostList(Criteria cri, Long boardSN);
	
	public PageDTO getPostListPaging(Criteria cri, Long boardSN);
	
	public List<BoardVO> getAllPost(Criteria cri);
	
	public List<Long> getPostSN();
	
	public BoardVO getRandomPost();
	
	public PageDTO getListPage(Criteria cri);
	
	public List<BoardVO> getList(Long boardSN);
	
	public int checkBoard(Long boardSN);
	
	public void register(BoardVO board);
	
	public boolean delete(Long postSN);
	
	public boolean update(BoardVO board);
	
	public void updateViewCnt(Long postSN, Long amount);
	
	public BoardVO get(Long postSN);
	
	public int getTotal();
	
	public List<BoardAttachVO> getAttachList(Long postSN);	
	
}
