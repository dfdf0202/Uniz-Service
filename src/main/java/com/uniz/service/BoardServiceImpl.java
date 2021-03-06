package com.uniz.service;

import java.util.Collections;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.uniz.domain.BoardAttachVO;
import com.uniz.domain.BoardVO;
import com.uniz.domain.Criteria;
import com.uniz.domain.PageDTO;
import com.uniz.mapper.BoardAttachMapper;
import com.uniz.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_ =@Autowired)
	private BoardAttachMapper attachMapper;

	@Override
	public List<BoardVO> getBoardList(){
		return mapper.getBoardList();
	}
	
	@Override
	public List<BoardVO> getPostList( Criteria cri , Long boardSN){
		return mapper.getPostList(cri, boardSN);
	}
	
	@Override
	public List<BoardVO> getAllPost(Criteria cri){
		
		return mapper.getAllPost(cri);
		
	}
	@Override
	public PageDTO getPostListPaging(Criteria cri, Long boardSN) {

		return new PageDTO(mapper.getTotalCountByBoard(boardSN),
						   mapper.getPostList(cri, boardSN));
		
	}
	
	@Override
	public PageDTO getListPage(Criteria cri) {
		return new PageDTO(mapper.getTotalCount() , mapper.getAllPost(cri));
	}
	
	@Override
	public List<BoardVO> getList(Long boardSN){
		
		
		
		log.info("board매퍼 ======="+ mapper);
		
		return mapper.getList(boardSN);
		
	}
	
	@Override
	public BoardVO getRandomPost(){
		
		List<Long> list = mapper.getPostSN();
		
		Collections.shuffle(list);
		
		log.info("============== " + list);
		
		Long postSN = list.get(0);
		
		return mapper.getRandomPost(postSN);
		
	}
	
	@Override
	public List<Long> getPostSN(){
		
		return mapper.getPostSN();
		
	}
	
	public int checkBoard(Long boardSN) {
		
		return mapper.checkBoard(boardSN);
		
	}
	
	@Transactional
	@Override
	public void register(BoardVO board)  {
		
		mapper.insertPost(board);
		log.info("BoardPost 데이터 추가");

		log.info("postSN1 : " + board.getPostSN());
		
		mapper.insertCont(board);
		log.info("postSN2 : " + board.getPostSN());
		
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		board.getAttachList().forEach(attach ->{
			
			log.info("postSN3 : " + board.getPostSN());
			attach.setPostSN(board.getPostSN());
			attachMapper.insert(attach);
		});
		
		log.info("BoardPostContent 데이터 추가");
}
	
	@Transactional
	@Override
	public boolean delete(Long postSN) {
		
		attachMapper.deleteAll(postSN);
		 
		 mapper.deleteReply(postSN);
		 
		 int chCont = mapper.deleteCont(postSN);
		 int chPost = mapper.deletePost(postSN);
		 
		 log.info("chPost : " + chPost);
		 log.info("chCont : " + chCont);
		 
		if(chCont == 1 && chPost == 1 ) {
			return true;
		}
			  
		return false;
		
	}
	@Transactional
	@Override
	public boolean update(BoardVO board) {
		
		attachMapper.deleteAll(board.getPostSN());
		
		boolean modifyResult = mapper.updateCont(board) == 1 && mapper.updatePost(board) ==1;
		
		if( modifyResult && board.getAttachList() != null 
				&& board.getAttachList().size() > 0) {
			
			board.getAttachList().forEach(attach -> {
				
				attach.setPostSN(board.getPostSN());
				attachMapper.insert(attach);
				
			});
			
			
		}
		return modifyResult;
	}
	
	@Override
	public void updateViewCnt(Long postSN , Long amount) {
		
		mapper.updateViewCnt(postSN, amount);
		
	}
	
	@Override
	public BoardVO get(Long postSN) {
		
		return mapper.read(postSN);
		
	}
	
	@Override
	public int getTotal() {
		
		return mapper.getTotalCount();
		
	}
	
	@Override
	public List<BoardAttachVO> getAttachList(Long postSN){
		
		log.info("첨부 파일 불러오기 : " + postSN);
		
		return attachMapper.findByPostSN(postSN);
		
	}

}
