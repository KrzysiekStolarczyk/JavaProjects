package org.leon.hibernate;

import java.util.Scanner;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class App {
	public static void main(String[] args) {

		SharedMethod shared = new SharedMethod();

		Scanner keyboard = new Scanner(System.in);
		ClassLoader loader = Thread.currentThread().getContextClassLoader();
		SetRandomData randomData = new SetRandomData();
		SessionFactory sessionFactory = new Configuration().configure(loader.getResource("config/hibernate.cfg.xml"))
				.buildSessionFactory();

		while (true) {
			Session session = sessionFactory.openSession();
			Transaction tx = session.beginTransaction();

			System.out.println("\nWybierz jedną z opcji i wciśnij ENTER\n" + "1: Dodaj nowego autora\n"
					+ "2: Dodaj nową książkę\n" + "3: Wyświetl wszystkie książki\n" + "4: Wyświetl wszystkich autorów\n"
					+ "5: Usuń autora podajac jego id\n" + "6: Wyświetlenie danych z warunkami\n" + "7: Update Autor\n"
					+ "8: Dodaj adres autora\n" + "9: Generuj randomowe dane\n");

			int myChoice = keyboard.nextInt();
			try {

				if (myChoice == 1) {

					shared.AddNewAuthor(session);

				} else if (myChoice == 2) {

					shared.SelectAuthor(session);
					shared.AddNewBook(session, tx);

				} else if (myChoice == 3) {

					shared.SelectBooks(session);

				} else if (myChoice == 4) {

					shared.SelectAuthor(session);

				} else if (myChoice == 5) {

					shared.SelectAuthor(session);
					shared.DeleteAuthorWithId(session, tx);
				} else if (myChoice == 6) {

					shared.SelectAuthorWithRestrictions(session);
				} else if (myChoice == 7) {

					shared.updateAuthor(session);
				} else if (myChoice == 8) {

					shared.AddAddress(session, tx);
				} else if (myChoice == 9) {

					for (int i = 0; i < 40; i++) {
						randomData.RandomAuthorAddress(session);
					}
					for (int i = 0; i < 40; i++) {

						if (!tx.isActive()) {
							tx = session.beginTransaction();
						}
						randomData.RandomAddBooks(session, tx);
					}
				}
			}

			catch (Exception e) {
				keyboard.close();
				System.err.println("Coś nie działa: " + e + "\n");
				e.printStackTrace(System.out);
			} finally {
				session.close();
			}

		}
	}
}
