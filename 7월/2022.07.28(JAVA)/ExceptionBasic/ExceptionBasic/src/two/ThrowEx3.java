package two;

public class ThrowEx3 {

	public static void main(String[] args) {

//      indexOutOf바운드 예외
//      
//      널포인터예외를 발생 시켜서 예외처리를 수행하시오

		IndexOutOfBoundsException ioobe = null;
		NullPointerException npe = null;

		try {
//			ioobe = new IndexOutOfBoundsException("IndexOutOfBoundsException");
			npe = new NullPointerException("NullPointerException");

//         	throw ioobe;
			throw npe;

		} catch (Exception e) { // Exception e는 Exception클래스의 최상위클래스 이므로 어떤 Exception이든 처리 가능하다
			System.out.println(e.getMessage());
		}

	}

}
