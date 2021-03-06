package com.uniz.service;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.uniz.domain.MyUnizPoint;
import com.uniz.domain.UserDTO;
import com.uniz.domain.VideoDataVO;
import com.uniz.mapper.UnizPointMapper;
import com.uniz.mapper.UserMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService{

	private UserMapper mapper;
	private UnizPointMapper unizPointMapper;
	private BCryptPasswordEncoder PasswordEncode;
		
	@Transactional
	@Override
	public int userRegister(UserDTO dto,List<Long> unizSN) {
		final int SUCCESS = 1;
		final int NO_DUPLICATION = 0;
		final int DB_ERROR = -1;
		final int ADD_POINT = 50;//포인트 증가값
		final int TYPE = 2; //관심 유니즈 등록 =2 
		log.info("dto : "+ dto);
		
		if(dto.getImgUrl()==null) {
			dto.setImgUrl("default.jpg");
		}
		//회원가입 전 NotNull 데이터 널 체크
		if(isNotUserDTO(dto)==true) {
			//데이터 중복체크
			if((mapper.userDuplicationCheck(dto) == NO_DUPLICATION)) {
				try {
					mapper.userDataInsert(dto);	
					mapper.userSelectUnizInsert(unizSN);
					mapper.registerUserStateLog(dto.getState());
					
					unizPointMapper.addHistorys(dto.getUserSN(), unizSN, ADD_POINT, TYPE);
					
					return SUCCESS;
				}catch(Exception e){
					e.printStackTrace();
					return DB_ERROR;
				}
			}
		}
		return NO_DUPLICATION;
	}
	
	@Transactional
	public boolean isNotUserDTO(UserDTO dto) {
		
		return dto.getUserId() != null &&  dto.getPassword() != null && dto.getNick() != null ? true : false;
		
	}
	public boolean isVaildUser(UserDTO dto) {
		return dto.getUserId() != null &&  dto.getPassword() != null ? true : false;
	}
	//Ajax용 닉네임 중복검사
	public String userNickDuplicationCheck(String nick) {
		final String NO_DUPLICATION = "SUCCESS";
		final String YES_DUPLICATION = "DUPLICATION";
		final String DB_ERROR = "DB ERROR";
		//1. null체크
		if(nick != null) {
			//해당 닉네임이 중복인지 확인
			try {
				// DB에서 COUNT한 값이 0보다 작다 = 중복되는값이 없다
				if(mapper.userNickDuplicationCheck(nick) <=0) {
					return NO_DUPLICATION;
				}
			}catch(Exception e){
				e.printStackTrace();
				return DB_ERROR;
			}
		}
		return YES_DUPLICATION;
	}
	
	//Ajax용 닉네임 아이디검사
	public String userIdDuplicationCheck(String userId) {
		final String NO_DUPLICATION = "SUCCESS";
		final String YES_DUPLICATION = "DUPLICATION";
		final String DB_ERROR = "DB ERROR";
		//1. null체크
		if(userId != null) {
			//해당 닉네임이 중복인지 확인
			try {
				// DB에서 COUNT한 값이 0보다 작다 = 중복되는값이 없다
				if(mapper.userIdkDuplicationCheck(userId) <=0) {
					return NO_DUPLICATION;
				}
			}catch(Exception e){
				e.printStackTrace();
				return DB_ERROR;
			}
		}
		return YES_DUPLICATION;
	}
	
	@Override
	public int userLogin(UserDTO user,HttpSession session) {
		final int SUCCESS = 1;
		final int NO_DUPLICATION = 0;
		final int FAIL = -1;
		
		//아이디, 비밀번호 유효성 체크
		if(isVaildUser(user) == true) {
			//아이디랑 비밀번호가 DB의 값과 일치하는지 확인한다.
			String password= user.getPassword();
			String dbPassword = mapper.getUserPassword(user);
			Boolean pwdMatch = PasswordEncode.matches(password, dbPassword);
			//로그인 성공
			if(pwdMatch) {
				user.setPassword(dbPassword);
				mapper.userLogin(user);
				//세션 생성
				user = mapper.getUser(user);
				session.setAttribute("user", user);
				session.setAttribute("userType", user.getUserType());
				session.setAttribute("userSN", user.getUserSN());
				
				//로그인 이력 변경
				mapper.updateUserLogin(user.getUserSN());
				return SUCCESS;
			}
		}
		return FAIL;
	}

	@Override
	public List<MyUnizPoint> getUserUniz(Long userSN) {
		
		if(userSN != null) {
			//user의 MyUnizpoint(유저의 유니즈 목록을 가져온다)
			try {
				return mapper.userUniz(userSN);				
			}catch(Exception e){
				e.printStackTrace();
				return null;
			}
		}
		return null;
	}

	@Override
	public String modifyUser(UserDTO userDto, UserDTO modifyUserDto, String com_password,HttpSession session) {
		modifyUserDto.setUserSN(userDto.getUserSN());
		final String SUCCESS= "SUCCESS";
		final String FAIL = "FAIL";
		final String DB_ERROR = "DB ERROR";
		//비밀번호 변경이라고 가정
		
		log.info("현재 아이디 : " +userDto);
		log.info("변경할 아이디 :" + modifyUserDto);
		log.info("현재비밀번호  : " +com_password);
		
		String realPassword = userDto.getPassword(); //바꾸기 전 비밀번호 , 비교 = com_password
		String modifyPassword = modifyUserDto.getPassword();
		//1. NULL CHECK
		if(isValid(realPassword, modifyPassword, com_password) == true) {
			
			//DB비밀번호와 입력한 비밀번호가 같으면
			if(PasswordEncode.matches(com_password, userDto.getPassword())) {
				//UPDATE
				try {
					
					//비밀번호말고 다른 정보도 바꾼다면 변경해야함
					String EncPassword = PasswordEncode.encode(modifyPassword);
					modifyUserDto.setPassword(EncPassword);
					
					int result = mapper.userDataUpdate(modifyUserDto);
					
					session.invalidate();
					
					return SUCCESS;
				}catch(Exception e) {
					e.printStackTrace();
					return DB_ERROR;
				}
			}
		}
		return FAIL;
		
	}
	
	@Override
	@Transactional
	public void changeUserState(Long userSN,int state) {
		if(userSN != null) {
			try {
				//회원상태를 3으로 변경해야한다.
				mapper.changeUserState(userSN, state);
				//userstateLog 테이블에도 데이터를 추가해 줘야한다.
				mapper.userStateLogInsert(userSN, state);
				
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}
	}
	
	@Override
	public String addMyPlayLog(Long userSN, Long videoSN, int currentTime) {
		final String SUCCESS = "SUCCESS";
		final String FAIL = "FAIL";
		
		//3. 회원이 본 영상을 기록하기 위해 Myplaylog에 추가
		try {			
			int result = mapper.addMyPlaylog(userSN, videoSN, currentTime);
			
		}catch(Exception e) {			
			e.printStackTrace();
			return FAIL;
		}
		return SUCCESS;
	}
	//나중에 통일할것
	public boolean isValid(String realPassword, String modifyPassword, String com_password) {
		
		return realPassword != null && modifyPassword != null && com_password != null ? true : false;
	}

	@Override
	public List<VideoDataVO> getShowHistory(Long userSN) {
		
		//시청로그 가져오기
		
		return mapper.getShowHistory(userSN);
	}
	
	@Override
	public void modifyImg(UserDTO userDto, MultipartFile imgFile,HttpServletRequest request) throws Exception {
		
		//저장용 파일 이름, 물리적저장, DB 저장용
		String imgName = "";
		
		//물리적인 저장
		//1. 저장 경로 설정
		String uploadUri ="C:\\Uniz-Project\\Uniz-Service\\src\\main\\webapp\\resources\\imgUpload\\UserPhoto";
		
		//2. 시스템의 물리적인 경로
		
		// 유저아이디_파일이름.jpg
		imgName = userDto.getUserId()+"_"+imgFile.getOriginalFilename(); //DB에 저장할이름
		
		//저장
		imgFile.transferTo(new File(uploadUri,imgName));
		
		log.info("이미지이름 : " + imgName);
		
		userDto.setImgUrl(imgName);
		
		mapper.insertImgUrl(userDto);
	}

}
