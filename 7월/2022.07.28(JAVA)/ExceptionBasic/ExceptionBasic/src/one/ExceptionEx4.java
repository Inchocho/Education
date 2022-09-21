package one;

public class ExceptionEx4 {

	public static void main(String[] args) {

//		try ~ catch문 실행순서 확인 (예외발생시 코드실행순서 디버깅)

		System.out.println(1);
		System.out.println(2);
		
//		특정 catch 구문에 선택되는 조건은 다형성에 의해 결정 된다

//		catch 하고 있는 예외의 자식 객체면 예외를 catch 할 수 있다
//		부모클래스가 먼저 예외처리 될시 자녀 클래스의 예외는 처리될 수 없다
//		부모클래에 예외에서 자녀 클래스의 예외까지 처리해버리기 때문에
//		그렇기 때문에 부모클래스의 예외를 자식클래스의 예외보다 먼저 처리하면 컴파일 에러가 발생한다
//		Exception 클래스는 모든 예외 클래스에 부모클래스로 사용하면 모든 예외를 모드 catch 할 수 있다

		try {
			System.out.println(3);
			System.out.println(0 / 0); // 예외발생
			System.out.println(4);
		} catch (ArithmeticException e) {	// 자식클래스 - 부모클래스 예외작성은 가능함
			System.err.println(5);
			return;
		} catch (Exception e) { // Exception은 (뭐시기~~~~)Exception 류 전부에 부모클래스임 
			// TODO: handle exception
			System.err.println(6);

		} finally {
			System.out.println(7);
		}

		System.out.println(9);
	}
}
