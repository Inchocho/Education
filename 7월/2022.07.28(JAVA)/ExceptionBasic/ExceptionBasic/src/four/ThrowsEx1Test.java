package four;

public class ThrowsEx1Test {

	public static void main(String[] args) {

		ThrowsEx test = new ThrowsEx();

		test.testMethod();

		try {					// 호출했으므로 try~catch를 통해 예외처리 해서 에러 사라짐 -> (2) 물론 아직 구현은안함
			test.testMethod(0);	// testMethod(int num) throws Exception -> 호출할때 예외처리 해줘라 (1)
		} catch (Exception e) {
			System.out.println("뭐로 예외처리하라는지 모르겠네~ 화이팅!!");
		}

	}
}
