package org.leon.hibernate;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.LogicalExpression;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.query.Query;
import org.leon.hibernate.entity.Author;
import org.leon.hibernate.entity.Book;
import org.leon.hibernate.entity.RegisteredAddress;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;

public class SharedMethod {

	Scanner keyboard = new Scanner(System.in);

	public List<Author> GetIdAuthorFromKeyboard(Session session) {
		List<Author> authors = new ArrayList<Author>();
		System.out.println("Wprowadz ilość autorów.");
		int iloscAutorow = keyboard.nextInt();

		for (int i = 0; i < iloscAutorow; i++) {
			System.out.println("Proszę o wprowadzenie id autora");
			authors.add(session.find(Author.class, keyboard.nextLong()));
		}
		return authors;
	}

	public void AddNewAuthor(Session session) {
		try {
			Author author = new Author();
			System.out.println("Podaj wiek.");
			author.setAge(keyboard.nextInt());
			System.out.println("Podaj imie.");
			author.setName(keyboard.next());
			System.out.println("Podaj nazwisko.");
			author.setSurname(keyboard.next());
			// session.save(author);
			session.persist(author);
		} catch (Exception e) {
			System.err.println("Coś nie działa: " + e + "\n");
			e.printStackTrace(System.out);
		} finally {
			session.close();
		}
	}

	public void SelectAuthor(Session session) {
		// EntityManager selectAuthor = sessionFactory.createEntityManager();
		// // manager.persist(author);
		// CriteriaBuilder criteriaBuilder = selectAuthor.getCriteriaBuilder();
		// CriteriaQuery<Author> query =
		// criteriaBuilder.createQuery(Author.class);
		// Root<Author> from = query.from(Author.class);
		// CriteriaQuery<Author> select = query.select(from);
		// TypedQuery<Author> queryFromManager =
		// selectAuthor.createQuery(select);
		// // manager.getTransaction().begin();
		// for (Author author : queryFromManager.getResultList()) {
		// System.out.println(author.toString());
		// }
		// selectAuthor.close();
		try {
			String hql = "FROM Author";
			Query query = session.createQuery(hql);
			List<Author> results = query.list();

			for (Author author : results) {
				System.out.println(author.toString());

			}
		} catch (Exception e) {
			System.err.println("Coś nie działa: " + e + "\n");
			e.printStackTrace(System.out);
		}
	}

	public void SelectAuthorWithRestrictions(Session session) {
		Criteria criteria1, criteria2, criteria3, criteria4, criteria5;
		List<Author> results;
		List number;
		ProjectionList toCount1, toCount2, toCount3, toCount4;
		try {

			System.out.println("\nWarunek, że wiek musi być równy 22\n");
			criteria1 = session.createCriteria(Author.class);
			criteria1.add(Restrictions.eq("age", 22));
			results = criteria1.list();

			for (Author author : results) {
				System.out.println(author.toString());
			}

			toCount1 = Projections.projectionList();
			toCount1.add(Projections.countDistinct("id"));
			criteria1.setProjection(toCount1);

			number = criteria1.list();
			System.out.println("Ilość: " + number);

			System.out.println("\nWarunek, że wiek musi być mniejszy niż 36\n");
			criteria2 = session.createCriteria(Author.class);
			criteria2.add(Restrictions.lt("age", 36));
			results = criteria2.list();

			for (Author author : results) {
				System.out.println(author.toString());
			}

			toCount2 = Projections.projectionList();
			toCount2.add(Projections.countDistinct("id"));
			criteria2.setProjection(toCount2);

			number = criteria2.list();
			System.out.println("Ilość: " + number);

			System.out.println("\nWarunek, że imie to Jan\n");
			criteria3 = session.createCriteria(Author.class);
			criteria3.add(Restrictions.like("name", "Jan"));
			results = criteria3.list();

			for (Author author : results) {
				System.out.println(author.toString());
			}

			toCount3 = Projections.projectionList();
			toCount3.add(Projections.countDistinct("id"));
			criteria3.setProjection(toCount3);

			number = criteria3.list();
			System.out.println("Ilość: " + number);

			System.out.println("\nWarunek, że imie to Piotr a wiek jest wiekszy niż 56\n");
			criteria4 = session.createCriteria(Author.class);

			Criterion age = Restrictions.gt("age", 56);
			Criterion name = Restrictions.like("name", "Piotr");
			LogicalExpression andExp = Restrictions.and(age, name);
			criteria4.add(andExp);

			results = criteria4.list();

			for (Author author : results) {
				System.out.println(author.toString());
			}

			toCount4 = Projections.projectionList();
			toCount4.add(Projections.countDistinct("id"));
			criteria4.setProjection(toCount4);

			number = criteria4.list();
			System.out.println("Ilość: " + number);

			System.out.println("\nZsumowanie wieku wszystkich autorów\n");
			criteria5 = session.createCriteria(Author.class);

			criteria5.setProjection(Projections.sum("age"));
			number = criteria5.list();

			System.out.println("Suma lat wszystkich autorów to: " + number.get(0));

		} catch (Exception e) {
			System.err.println("Coś nie działa: " + e + "\n");
			e.printStackTrace(System.out);
		} finally {
			session.close();
		}
	}

	public void updateAuthor(Session session) {
		try {
			Query query = session.createQuery("update Author set name = :Name1 where name = :Name");
			query.setParameter("Name1", "Stanisław");
			query.setParameter("Name", "Marian");
			int result = query.executeUpdate();
			System.out.println("Ilość zmienionych rekordów: " + result);
		} catch (Exception e) {
			System.err.println("Coś nie działa: " + e + "\n");
			e.printStackTrace(System.out);

		} finally {
			session.close();
		}

	}

	public void SelectJoin(Session session) {
		try {

			Query q = session.createQuery("select u.books a.name from Author u inner join u.Book a");

			// List<Book> books = q.list();
			// for (Book book : books) {
			System.out.println(q.list().toString());
			// }
		} catch (Exception e) {
			System.err.println("Coś nie działa: " + e + "\n");
			e.printStackTrace(System.out);
		} finally {
			session.close();
		}
	}

	public void SelectBooks(Session session) {
		// EntityManager selectBook = sessionFactory.createEntityManager();
		// // manager.persist(author);
		// CriteriaBuilder criteriaBuilder = selectBook.getCriteriaBuilder();
		// CriteriaQuery<Book> query = criteriaBuilder.createQuery(Book.class);
		// Root<Book> from = query.from(Book.class);
		// CriteriaQuery<Book> select = query.select(from);
		// TypedQuery<Book> queryFromManager = selectBook.createQuery(select);
		// // manager.getTransaction().begin();
		// for (Book book : queryFromManager.getResultList()) {
		// System.out.println(book.toString());
		// }
		// selectBook.close();
		try {
			String hql = "FROM Book";
			Query query = session.createQuery(hql);
			List<Book> results = query.list();

			for (Book book : results) {
				System.out.println(book.toString());
			}
		} catch (Exception e) {
			System.err.println("Coś nie działa: " + e + "\n");
			e.printStackTrace(System.out);
		} finally {
			session.close();
		}
	}

	public void DeleteAuthorWithId(Session session, Transaction tx) {
		try {
			List<Author> author = GetIdAuthorFromKeyboard(session);

			for (Iterator iterator = author.iterator(); iterator.hasNext();) {
				session.remove((Author) iterator.next());

			}
			tx.commit();

			System.out.println("Poprawnie wykonana operacja, został usuniety wpis\n" + author.toString());
		} catch (IllegalArgumentException e) {
			System.err.println("Nie ma takiego Autora: " + e + "\n");
			tx.rollback();
		} catch (Exception e) {
			tx.rollback();
			System.err.println("Coś nie działa: " + e + "\n");
			e.printStackTrace(System.out);
		} finally {
			session.close();
		}
	}

	public void AddNewBook(Session session, Transaction tx) {
		try {

			Book book = new Book();
			book.setAuthor(GetIdAuthorFromKeyboard(session));
			System.out.println("Podaj nazwę książki.\n");
			book.setName(keyboard.next());

			session.persist(book);
			tx.commit();
			System.out.println("Poprawnie wykonana operacja, została dodana książka\n" + book.toString());

		} catch (javax.persistence.PersistenceException e) {

			tx.rollback();
			System.err.println("Nie ma takiego Autora: " + e + "\n");
			e.printStackTrace(System.out);
		} catch (Exception e) {

			tx.rollback();
			System.err.println("Coś nie działa: " + e + "\n");
			e.printStackTrace(System.out);
		} finally {
			session.close();
		}
	}

	public void AddAddress(Session session, Transaction tx) {
		try {

			RegisteredAddress address = new RegisteredAddress();
			Author author= new Author();
			System.out.println("Podaj nazwę miasta.\n");
			address.setNameCity(keyboard.next());
			System.out.println("Podaj nazwę ulicy.\n");
			address.setNameStreet(keyboard.next());
			
//			System.out.println("Proszę o wprowadzenie id autora");
//			author=session.find(Author.class, keyboard.nextLong());
//			address.setAuthor(author);
			session.persist(address);
			tx.commit();
			System.out.println("Poprawnie wykonana operacja, została dodany\n" + address.toString()+"\nDla autora: "+author);

		} catch (javax.persistence.PersistenceException e) {

			tx.rollback();
			System.err.println("Nie ma takiego Autora: " + e + "\n");
			e.printStackTrace(System.out);
		} catch (Exception e) {

			tx.rollback();
			System.err.println("Coś nie działa: " + e + "\n");
			e.printStackTrace(System.out);
		} finally {
			session.close();
		}
	}
}
