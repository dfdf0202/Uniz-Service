package com.uniz.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.uniz.domain.MyUnizPoint;
import com.uniz.domain.UserDTO;
import com.uniz.domain.VideoDataVO;

public interface UserMapper {
	
	//대윤
	//USERDATA INSERT
	public int userDataInsert(UserDTO dto);
	
	//USERDATA 테이블에서 중복되는 데이터 있는지 확인
	public int userDuplicationCheck(UserDTO dto);
	
	//닉네임 중복 체크 
	public int userNickDuplicationCheck(@Param("nick") String nick);

	public int userIdkDuplicationCheck(@Param("userId") String userId);

	public void userSelectUnizInsert(@Param("unizSN")List<Long> unizSN);

	public int userLogin(UserDTO user);
	
	public UserDTO getUserData(@Param("userSN")Long userSN);

	public List<MyUnizPoint> userUniz(@Param("userSN") Long userSN);

	public UserDTO getUser(UserDTO user);

	public int userDataUpdate(UserDTO modifyUserDto);

	public void changeUserState(@Param("userSN") Long userSN, @Param("state") int state);

	public void userStateLogInsert(@Param("userSN") Long userSN, @Param("state") int state);

	public void registerUserStateLog(@Param("state") int state);

	public void updateUserLogin(@Param("userSN") Long userSN);

	public int addMyPlaylog(@Param("userSN")Long userSN, @Param("videoSN")long videoSN, @Param("position")int position);

	public List<VideoDataVO> getShowHistory(@Param("userSN")Long userSN);

	public String getUserPassword(UserDTO user);

	public void insertImgUrl(UserDTO userDto);

}
