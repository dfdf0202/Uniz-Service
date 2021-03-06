package com.uniz.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	
	private Long postSN;
	private Long boardSN;
	private Long replySN;
	private Long userSN;
	private Long rn;
	private String youTubePath;
	private String boardTitle;
	private String boardComment;
	private String title;
	private String nick;
	private String postContent;
	private String imgUrl;
	private String imgPath;
	private Date createDateTime;
	private Date updateDateTime;
	private int replyCnt;
	private int viewCnt;
	
	private String changename;
	
	private List<BoardAttachVO> attachList;
	
}
