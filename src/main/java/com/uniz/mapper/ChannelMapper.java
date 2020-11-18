package com.uniz.mapper;

import java.util.List;

import com.uniz.domain.ChannelBoardVO;
import com.uniz.domain.ChannelVO;
import com.uniz.domain.Criteria;

public interface ChannelMapper {

	public List<ChannelBoardVO> getChannelList(); // 채널 리스트 출력
	
	public List<ChannelBoardVO> getPostList(Long channelSN); // 해당 채널의 게시글 목록을 보여줌
	
	public List<ChannelBoardVO> getAllPost();
	
	public List<ChannelBoardVO> getPost(Long postSN);
	
	public void createChannel(ChannelVO vo);    // 채널 create
	
	public void insertPost(ChannelBoardVO vo);  // 게시글 DB에 insert 
	
	public void insertCont(ChannelBoardVO vo); // 게시글 내용 DB에 insert
	
	public int deletePost(Long postSN);		   //게시글 delete
	
	public int deleteCont(Long postSN);		   //게시글 내용 delete
	
	public int updatePost(ChannelBoardVO vo); 	   //게시글 update
	
	public int updateCont(ChannelBoardVO vo);		   //게시글 내용 update
	
}
