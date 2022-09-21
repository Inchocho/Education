package four;

public class ThrowsEx {

	void testMethod() {

		try {
			throw new Exception(); // try~catch를 통해서 예외처리를 했으므로 오류가안남 여기서는 <- (2) try~catch로 예외처리함
		} catch (Exception e) {
			// TODO: handle exception
		}

	}

//	메서드에 예외 선언하기
//	throws 키워드를 사용해서 메서드에 선언 할 수 있다
//	선언부에 메서드를 선언해 놓으면 메서드를 사용하려는 사람이
//	메서드의 선언부를 보았을 때, 이 메서드를 사용하기 위해서는
//	어떠한 예외들이 처리되어져야 하는지 쉽게 예측할 수 있다.
	void testMethod(int num) throws Exception { // throw Exception -> 예외가 발생할 수 도 있는 메서드 이므로 예외처리를 부탁한다(1)
		throw new Exception();
	}

//	메서드에 예외 선언하기
//	throws 키워드를 사용해서 메서드에 선언 할 수 있다
//	선언부에 메서드를 선언해 놓으면 메서드를 사용하려는 사람이
//	메서드의 선언부를 보았을 때, 이 메서드를 사용하기 위해서는
//	어떠한 예외들이 처리되어져야 하는지 쉽게 예측할 수 있다.	
	void testMethod(int a, int b) throws ArithmeticException { // throw ArithmeticException -> by zero 예외가 발생할수도 있겠네
		throw new ArithmeticException();
	}

}
