package com.uniz.mapper;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.junit.Test;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.uniz.domain.UnizLayerListVO;
import com.uniz.domain.UnizVO;
import com.uniz.domain.VideoDataVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
@WebAppConfiguration
public class UnizHitMapperTest {

	@Setter(onMethod_ = @Autowired)
	private UnizHitMapper mapper;

//	@Test
//	public void testRead() {
//		VideoDataVO uniz = mapper.read(1L);
//		log.info("result :" + uniz);
//	}
//	

//	@Test
//	public void testReadList() {
//		
//		mapper.getHitList().forEach(video -> log.info(video));
//
//		
//	}
	
//	@Test
//	public void testkeywordList() {
//		
//		List<VideoDataVO> video = mapper.keywordHitList((long) 20);
//		
//		video.forEach(list -> log.info(list));
//		
//	}
	
	@Test
	public void testkeywordUniz() {
		
		List<UnizLayerListVO> video = mapper.keywordUniz((long)1002);
		
		video.forEach(list -> log.info(list));
		
		List<VideoDataVO> video2 = mapper.keywordHitList(video);
		
		video2.forEach(list2 -> log.info(list2));
	}
	
	
	
}