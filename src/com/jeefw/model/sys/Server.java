package com.jeefw.model.sys;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.google.common.base.Objects;
import com.jeefw.model.sys.param.CheckServerParameter;

/**
 * 字典的实体类
 * @框架唯一的升级和技术支持地址：http://shop111863449.taobao.com
 */ 
@Entity
@Table(name = "server")
@Cache(region = "all", usage = CacheConcurrencyStrategy.READ_WRITE)
@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount", "sortColumns", "cmd", "queryDynamicConditions", "sortedConditions", "dynamicProperties", "success", "message", "sortColumnsString", "flag" })
public class Server extends CheckServerParameter {

	// 各个字段的含义请查阅文档的数据库结构部分
	private static final long serialVersionUID = -2847988368314678488L;
	@Id
	@GeneratedValue
	@Column(name = "id")
	private Long id;
	
	@Column(name = "ip",length = 40)
	private String ip;
	
	
	@Column(name = "hostname", length = 40)
	private String hostname;
	
	
	@Column(name = "configuration", length = 30)
	private String configuration;
	
	
	
	@Column(name = "owner", length = 20)
	private String owner;
	
	@Column(name = "register")
	private Date register;
	
	
	
	@Column(name = "usefulLife", length = 20)
	private String usefulLife;
	
	@Column(name = "status", length = 30)
	private String status;
	
	
	
	
	
	

	
	public Server() {

	}

	

	public Long getId() {
		return id;
	}



	public void setId(Long id) {
		this.id = id;
	}



	



	public String getIp() {
		return ip;
	}



	public void setIp(String ip) {
		this.ip = ip;
	}



	public String getHostname() {
		return hostname;
	}



	public void setHostname(String hostname) {
		this.hostname = hostname;
	}



	public String getConfiguration() {
		return configuration;
	}



	public void setConfiguration(String configuration) {
		this.configuration = configuration;
	}



	public String getOwner() {
		return owner;
	}



	public void setOwner(String owner) {
		this.owner = owner;
	}


	@Temporal(TemporalType.TIMESTAMP)
	public Date getRegister() {
		return register;
	}



	public void setRegister(Date register) {
		this.register = register;
	}



	public String getUsefulLife() {
		return usefulLife;
	}



	public void setUsefulLife(String usefulLife) {
		this.usefulLife = usefulLife;
	}



	public String getStatus() {
		return status;
	}



	public void setStatus(String status) {
		this.status = status;
	}



	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final Server other = (Server) obj;
		return Objects.equal(this.id, other.id) && Objects.equal(this.ip, other.ip) && Objects.equal(this.hostname, other.hostname) && Objects.equal(this.owner, other.owner)
				&& Objects.equal(this.configuration, other.configuration)&& Objects.equal(this.status, other.status);
	}

	public int hashCode() {
		return Objects.hashCode(this.id, this.ip, this.hostname, this.owner, this.configuration,this.status);
	}
	
	
	
	
	@Override
	public String toString() {
		//System.out.println(this.register.toString());
	   
		   SimpleDateFormat dateFormat=new SimpleDateFormat("yy-MM-dd HH");

		   return this.id+this.ip+this.hostname+ this.owner+this.configuration+this.status+this.usefulLife+dateFormat.format(this.register);
	   
	 /*  else {
		   System.out.println("没有日期");
			return this.id+this.ip+this.hostname+ this.owner+this.configuration+this.status+this.usefulLife;

	   }*/
	}
	
	

}
