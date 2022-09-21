package str.answer;

public class StringEx5 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		// 절대 원본 데이터를 변경하지 않는다
		String originStr = "문자열 m메서드를 활용haja하자"; // 기준
		String changeStr = "";
		
//		영어로 적힌 부분들을 모두 대문자화 하여 
//		기존의 문자열에 출력되도록 하시오
// 		ex: 문자열 메서드를 활용HAJA하자
		
		
		String tempFirstStr = "";
		String tempSecondStr = "";
		String tempEngStr = "";
		
		tempFirstStr = originStr.substring(0, 12);
		tempEngStr = originStr.substring(12, 16);
		tempSecondStr = originStr.substring(16, originStr.length());
		
//		System.out.println(tempFirstStr);
//		System.out.println(tempSecondStr);
		tempEngStr = tempEngStr.toUpperCase();
//		System.out.println(tempEngStr);
		
		changeStr = tempFirstStr + tempEngStr + tempSecondStr;
		
		System.out.println(originStr);
		System.out.println(changeStr);

	}

}
