package org.leon.hibernate.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "REGISTERED_ADDRESS")
public class RegisteredAddress implements Serializable {

	private static final long serialVersionUID = 8080258600311845131L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "IdAddress")
	private Long id;

	@Column(name = "City")
	private String nameCity;

	@Column(name = "Street")
	private String nameStreet;

//	@OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
//	private Author author;
//
//	public Author getAuthor() {
//		return author;
//	}
//
//	public void setAuthor(Author author) {
//		this.author = author;
//	}

	public String getNameCity() {
		return nameCity;
	}

	public void setNameCity(String nameCity) {
		this.nameCity = nameCity;
	}

	public String getNameStreet() {
		return nameStreet;
	}

	public void setNameStreet(String nameStreet) {
		this.nameStreet = nameStreet;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

//	@Override
//	public String toString() {
//		return "AddressId=" + id + ", CityName='" + nameCity + '\'' + ", StreetName='" + nameStreet + '\'' + ", Age='"
//				+ nameCity + '\'';
//	}
//
//	@Override
//	public int hashCode() {
//		final int prime = 31;
//		int result = 1;
//		result = prime * result + ((author == null) ? 0 : author.hashCode());
//		result = prime * result + ((id == null) ? 0 : id.hashCode());
//		result = prime * result + ((nameCity == null) ? 0 : nameCity.hashCode());
//		result = prime * result + ((nameStreet == null) ? 0 : nameStreet.hashCode());
//		return result;
//	}
//
//	@Override
//	public boolean equals(Object obj) {
//		if (this == obj)
//			return true;
//		if (obj == null)
//			return false;
//		if (getClass() != obj.getClass())
//			return false;
//		RegisteredAddress other = (RegisteredAddress) obj;
//		if (author == null) {
//			if (other.author != null)
//				return false;
//		} else if (!author.equals(other.author))
//			return false;
//		if (id == null) {
//			if (other.id != null)
//				return false;
//		} else if (!id.equals(other.id))
//			return false;
//		if (nameCity == null) {
//			if (other.nameCity != null)
//				return false;
//		} else if (!nameCity.equals(other.nameCity))
//			return false;
//		if (nameStreet == null) {
//			if (other.nameStreet != null)
//				return false;
//		} else if (!nameStreet.equals(other.nameStreet))
//			return false;
//		return true;
//	}

}
