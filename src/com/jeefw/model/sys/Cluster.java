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
@Table(name = "cluster")
@Cache(region = "all", usage = CacheConcurrencyStrategy.READ_WRITE)
@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount", "sortColumns", "cmd", "queryDynamicConditions", "sortedConditions", "dynamicProperties", "success", "message", "sortColumnsString", "flag" })
public class Cluster extends CheckServerParameter {

	// 各个字段的含义请查阅文档的数据库结构部分
	private static final long serialVersionUID = -2847988368314678488L;
	@Id
	@GeneratedValue
	@Column(name = "id")
	private Long id;
	
	
	
	@Column(name = "ip",length = 40)
	private String ip;
	
	
	@Column(name = "clusterName", length = 40)
	private String clusterName;
	
	
	@Column(name = "type", length = 30)
	private String type;

	
	@Column(name = "containerIds", length = 30)
	private String containerIds;
	
	
	public Cluster() {

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





	public String getClusterName() {
		return clusterName;
	}





	public void setClusterName(String clusterName) {
		this.clusterName = clusterName;
	}





	public String getType() {
		return type;
	}





	public void setType(String type) {
		this.type = type;
	}





	public String getContainerIds() {
		return containerIds;
	}





	public void setContainerIds(String containerIds) {
		this.containerIds = containerIds;
	}





	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final Cluster other = (Cluster) obj;
		return Objects.equal(this.id, other.id) && Objects.equal(this.ip, other.ip) && Objects.equal(this.clusterName, other.clusterName);
				
	}

	public int hashCode() {
		return Objects.hashCode(this.id, this.ip, this.clusterName);
	}
	
	
	
	
	@Override
	public String toString() {
		//System.out.println(this.register.toString());
	   
		 

		   return this.id+this.ip+this.clusterName+ this.type+this.containerIds;
	   
	
	}
	
	

}
