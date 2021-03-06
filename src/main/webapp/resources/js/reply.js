console.log("Reply Module.........");

var replyService = (function(){
	function add(reply, callback, error){
		console.log("add reply......");
		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		})
	}
	
	function remove(replySN, callback, error){
		$.ajax({
			type : 'delete',
			url : '/replies/' + replySN,
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function commentUpdateProc(replySN){
		   
		var updateContent = $('[name=content_'+replySN+']').val();
	   	var updateReplySN = $('[name=replySN_'+replySN+']').val();
		var modify = {'replyContent' : updateContent, 'replySN' : updateReplySN};
		var str = /^\s+|\s+$/g;
	    
		$.ajax({
			url : '/replies/update/'+updateReplySN,
			type : 'put',
			data : JSON.stringify(modify),
			contentType : "application/json; charset=utf-8",
	        success : function(data){
	        	
	        	if( modify.replyConent == '' || modify.replyContent.replace(str, '').length == 0 ){
	        		alert(" 댓글 내용을 입력 해주세요");
	        		return false;
	        	}
	        	
	        	showList(1);
	        }
	    });
	}
	
	function get(replySN, callback, error){
		$.get("/replies/" + replySN + ".json", function(result){
			if (callback){
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	
	function displayTime(timeValue){
		var today = new Date();
		var gap = today.getTime() - timeValue;
		var dateObj = new Date(timeValue);
		var str = "";
		
		if(gap < (1000 * 60 * 60 * 24)) {
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0' ) + mi, ':', (ss > 9 ? '' : '0') + ss].join('');
		}else{
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			var dd = dateObj.getDate();
			
			return [yy, '/' , (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd].join('');
		}
	};
	
function commentList(param, callback, error){
		
		var postSN = param.postSN;
		var page = param.page || 1;
		
		$.getJSON("/replies/page/" + postSN + "/" + page + ".json",
				function(data){
			if(callback){
				callback(data.replyCnt, data.list);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	    
	}   

	
	return {
		add :add,
		commentList : commentList,
		remove : remove,
		commentUpdateProc : commentUpdateProc,
		get : get,
		displayTime : displayTime
	};
})();