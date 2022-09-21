package ch7.polyAnswer.main;

import java.util.Scanner;

import ch7.polyAnswer.customer.Customer;
import ch7.polyAnswer.product.Book;
import ch7.polyAnswer.product.Computer;
import ch7.polyAnswer.product.Product;
import ch7.polyAnswer.product.SmartPhone;
import ch7.polyAnswer.product.Tv;

// 다형성 활용 -> 메서드 매개변수
public class PolyArgumentTest {

	public static void main(String[] args) {
		Product product = null;
		Customer psu = new Customer();

		Scanner scan = new Scanner(System.in);

		int num = 0;

		System.out.println("구매할 물건의 번호를 입력하세요.");
		System.out.println("1번 tv");
		System.out.println("2번 컴퓨터");
		System.out.println("3번 스마트폰");
		System.out.println("4번 책");

		num = scan.nextInt();

		switch (num) {
		case 1:
			num = 1;
			product = new Tv();
			break;
		case 2:
			num = 2;
			product = new Computer();
			break;
		case 3:
			num = 3;
			product = new SmartPhone();
			break;
		case 4:
			num = 4;
			product = new Book();
			break;
		default:
			System.out.println("1번에서 4번까지만 입력하세요.");
			break;
		}

		psu.buy(product);
		System.out.println(psu);
		System.out.println(psu.toString(num));

	}

}
