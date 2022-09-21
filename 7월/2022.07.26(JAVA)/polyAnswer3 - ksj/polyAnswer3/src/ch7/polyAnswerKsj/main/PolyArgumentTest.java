package ch7.polyAnswerKsj.main;

import ch7.polyAnswerKsj.customer.Customer;
import ch7.polyAnswerKsj.product.Book;
import ch7.polyAnswerKsj.product.Computer;
import ch7.polyAnswerKsj.product.SmartPhone;
import ch7.polyAnswerKsj.product.Tv;

// 다형성 활용 -> 메서드 매개변수
public class PolyArgumentTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Customer[] customerArr = new Customer[12];

		customerArr[0] = new Customer(10000, 0, "김소진");
		customerArr[1] = new Customer(10000, 0, "손다예");
		customerArr[2] = new Customer(10000, 0, "남기형");
		customerArr[3] = new Customer(10000, 0, "조윤성");
		customerArr[4] = new Customer(10000, 0, "이동현");
		customerArr[5] = new Customer(10000, 0, "박윤미");
		customerArr[6] = new Customer(10000, 0, "오건황");
		customerArr[7] = new Customer(10000, 0, "조현석");
		customerArr[8] = new Customer(10000, 0, "이영빈");
		customerArr[9] = new Customer(10000, 0, "황원준");
		customerArr[10] = new Customer(10000, 0, "안병규");
		customerArr[11] = new Customer(10000, 0, "김태훈");

		Tv tv = new Tv();
		Computer com = new Computer();
		SmartPhone smart = new SmartPhone();
		Book book = new Book();

		for (int i = 0; i < customerArr.length; i++) {
			int n = 3;
			if (i < n*1) {
				customerArr[i].buy(tv);
			} else if (i < n*2) {
				customerArr[i].buy(com);
			} else if (i < n*3) {
				customerArr[i].buy(smart);
			} else {
				customerArr[i].buy(book);
			}
			System.out.println(customerArr[i]);
		}

//		Customer ksj = new Customer();
//		Customer sdy = new Customer();
//		Customer ngh = new Customer();
//		Customer jys = new Customer();
//		Customer ldh = new Customer();
//		Customer pym = new Customer();
//		Customer ogh = new Customer();
//		Customer jhs = new Customer();
//		Customer lyb = new Customer();
//		Customer hwj = new Customer();
//		Customer abg = new Customer();
//		Customer kth = new Customer();

//		ksj.buy(new Tv());
//		sdy.buy(new Tv());
//		ngh.buy(new Tv());
//		System.out.println(ksj);
//		System.out.println(sdy);
//		System.out.println(ngh);
//		System.out.println();
//		jys.buy(new Computer());
//		ldh.buy(new Computer());
//		pym.buy(new Computer());
//		System.out.println(jys);
//		System.out.println(ldh);
//		System.out.println(pym);
//		System.out.println();
//		ogh.buy(new SmartPhone());
//		jhs.buy(new SmartPhone());
//		lyb.buy(new SmartPhone());
//		System.out.println(ogh);
//		System.out.println(jhs);
//		System.out.println(lyb);
//		System.out.println();
//		hwj.buy(new Book());
//		abg.buy(new Book());
//		kth.buy(new Book());
//		System.out.println(hwj);
//		System.out.println(abg);
//		System.out.println(kth);

	}

}
