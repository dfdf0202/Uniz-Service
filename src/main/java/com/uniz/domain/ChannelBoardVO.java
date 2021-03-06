package com.uniz.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ChannelBoardVO {
	
	private Long postSN;
	private Long channelSN;
	private Long userSN;
	private Long rn;
	private String postContent;
	private String channelTitle;
	private String title;
	private String nick;
	private String imgUrl;
	private int viewCnt;
	private int likeCnt;
	private Date createDateTime;
	private Date updateDateTime;
	private int replyCnt;
	
	private List<ChannelAttachVO> attachList;
	
}
