package com.almiv.spring.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@MappedSuperclass
public abstract class AbstractAuditEntity {
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="date_created", nullable=false)
	private Date date_created;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="date_created", nullable=false)
	private Date date_modified;
	
	@PrePersist
	protected void onCreate() {
		date_modified=date_created=new Date();
	}
	@PreUpdate
	protected void onUpdate() {
		date_modified=new Date();
	}
}
