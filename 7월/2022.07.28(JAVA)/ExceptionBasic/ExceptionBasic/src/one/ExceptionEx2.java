package one;

import java.util.InputMismatchException;
import java.util.Scanner;

public class ExceptionEx2 {

	public static void main(String[] args) {

		int num = 0;

		Scanner scan = new Scanner(System.in);

		while (true) {

			try {
				System.out.println("숫자 입력");
				num = scan.nextInt();

				System.out.println(num);
			} catch (InputMismatchException ime) { // 입력한 타입이 다를경우 발생하는 예외처리
				System.out.println(ime);
				System.out.println("고객님 숫자만 입력하세요.");
				scan.next();
			} catch (IllegalStateException ise) { // scan.close() 발생시 스캐너사용불가시 발생하는 예외
				System.out.println(ise);
				System.err.println("죄송합니다.");
				System.err.println("고객센터에 문의해주세요.");
				num = -1;
			}

			if (num == 999) {
				scan.close();
			}

			if (num == -1) {
				break;
			}
		}

		scan.close();
		System.out.println("프로그램 종료");

	}

}
