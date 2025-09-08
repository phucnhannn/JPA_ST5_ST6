package vn.iotstar.entity;

import jakarta.persistence.*;
import org.hibernate.annotations.Nationalized;

@Entity
@Table(name = "categories")
public class Category {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "cate_id")
	private Integer cateid;

	@Nationalized
	@Column(name = "cate_name", nullable = false, length = 150, columnDefinition = "nvarchar(150)")
	private String catename;

	@Nationalized
	@Column(name = "icons", length = 255)
	private String icon;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	private User owner;

	public Category() {
	}

	public Category(String catename, String icon) {
		this.catename = catename;
		this.icon = icon;
	}

	public Integer getCateid() {
		return cateid;
	}

	public void setCateid(Integer cateid) {
		this.cateid = cateid;
	}

	public String getCatename() {
		return catename;
	}

	public void setCatename(String catename) {
		this.catename = catename;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public User getOwner() {
		return owner;
	}

	public void setOwner(User owner) {
		this.owner = owner;
	}

	@Override
	public String toString() {
		return "Category{cateid=" + cateid + ", catename='" + catename + "', icon='" + icon + "'}";
	}
}