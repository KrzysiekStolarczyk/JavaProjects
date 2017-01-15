package org.leon.hibernate;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.leon.hibernate.entity.Author;
import org.leon.hibernate.entity.Book;
import org.leon.hibernate.entity.RegisteredAddress;

public class SetRandomData {

	String imieMeskie[] = { "Piotr", "Krzysztof", "Andrzej", "Jan", "Stanisław", "Tomasz", "Paweł" };
	String nazwisko[] = { "Nowak", "Kowalski", "Wiśniewski", "Dąbrowski", "Lewandowski", "Wójcik", "Kamiński",
			"Kowalczyk", "Zieliński", "Szymański", "Woźniak", "Kozłowski", "Jankowski" };
	String ulica[] = { "Polna", "Leśna", "Słoneczna", "Krótka", "Szkolna", "Ogrodowa", "Lipowa", "Brzozowa", "Łąkowa",
			"Kwiatowa" };
	String miasto[] = { "Warszawa", "Kraków", "Łódź", "Wrocław", "Poznań", "Gdańsk", "Szczecin", "Bydgoszcz", "Lublin",
			"Katowice" };

	String books[] = { "Duma i uprzedzenie", "Władca Pierścieni", "Jane Eyre", "Seria o Harrym Potterze",
			"Zabić drozdad", "Biblia", "Wichrowe Wzgórza", "Rok 1984", "Mroczne materie", "Wielkie nadzieje",
			"Małe kobietki", "Tessa D’Urberville", "Paragraf 22", "Dzieła zebrane Szekspira", "Rebeka", "Hobbit",
			"Birdsong" };

	public void RandomAddBooks(Session session,Transaction tx) {
		try {
			Random rand = new Random();
			Book book = new Book();
			List<Author> author = new ArrayList<Author>();

			int loop = rand.nextInt(5)+1;
			long value;
			for (int i = 0; i < loop; i++) {
				value=rand.nextInt(99)+1;
				author.add(session.find(Author.class,value));
			}
			book.setAuthor(author);	
			book.setName(books[rand.nextInt(books.length - 1)]);
			
			
			session.persist(book);
			
			tx.commit();
			
		} catch (Exception e) {
			tx.rollback();
			System.err.println("Coś nie działa: " + e + "\n");
			e.printStackTrace(System.out);
		}
	}

	public void RandomAuthorAddress(Session session) {
		Author author = new Author();
		RegisteredAddress address = new RegisteredAddress();
		Random rand = new Random();

		author.setName(imieMeskie[rand.nextInt(imieMeskie.length - 1)]);

		author.setSurname(nazwisko[rand.nextInt(nazwisko.length - 1)]);

		address.setNameCity(miasto[rand.nextInt(miasto.length - 1)]);

		address.setNameStreet(ulica[rand.nextInt(ulica.length - 1)]);
		session.persist(address);
		author.setAge(rand.nextInt(50) + 20);
		author.setAddress(address);

		session.persist(author);
	}

}
