package two;

public class ThrowEx2 {

	public static void main(String[] args) {

//		indexOutOfBound 예외

//		nullPointer 예외를 발생 시켜서 예외처리를 수행하시오

		String message = "";

		IndexOutOfBoundsException e = null;
		NullPointerException e2 = null;

		try {
			e = new IndexOutOfBoundsException(message);
			e2 = new NullPointerException(message);
			throw e;
		} catch (IndexOutOfBoundsException indexOutOfBoundsException) {
			message = "인덱스아웃오브바운드에러";
			System.err.println("에러 메시지: " + indexOutOfBoundsException.getMessage());
			indexOutOfBoundsException.printStackTrace();
		} catch (NullPointerException nullPointerException) {
			message = "null포인터에러";
			System.err.println("에러 메시지: " + nullPointerException.getMessage());

		}
		System.out.println(message + " 입니다.");
	}
}
