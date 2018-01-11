package com.jeefw.model.sys;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.google.common.base.Objects;
import com.jeefw.model.sys.param.ContainerParameter;

/**
 * 字典的实体类
 * @框架唯一的升级和技术支持地址：http://shop111863449.taobao.com
 */ 
@Entity
@Table(name = "container")
@Cache(region = "all", usage = CacheConcurrencyStrategy.READ_WRITE)
@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount", "sortColumns", "cmd", "queryDynamicConditions", "sortedConditions", "dynamicProperties", "success", "message", "sortColumnsString", "flag" })
public class Container extends ContainerParameter {

	// 各个字段的含义请查阅文档的数据库结构部分
	private static final long serialVersionUID = -2847988368314678488L;
	@Id
	@GeneratedValue
	@Column(name = "id")
	private Long id;
	
	
	
	@Column(name = "containerId",length = 40)
	private String containerId;
	
	
	@Column(name = "images", length = 30)
	private String images;
	
	
	@Column(name = "command", length = 40)
	private String command;
	
	
	
	@Column(name = "createDate")
	private Date createDate;
	
	
	@Column(name = "status", length = 40)
	private String status;
	
	
	
	@Column(name = "ports", length = 40)
	private String  ports;
	
	
	@Column(name = "ip", length = 40)
	private String  ip;
	

	private String clusterName;
	
	
	
	
	
	
	public Container() {

	}

	




	public Long getId() {
		return id;
	}






	public void setId(Long id) {
		this.id = id;
	}






	public String getContainerId() {
		return containerId;
	}






	public void setContainerId(String containerId) {
		this.containerId = containerId;
	}






	public String getImages() {
		return images;
	}






	public void setImages(String images) {
		this.images = images;
	}






	public String getCommand() {
		return command;
	}






	public void setCommand(String command) {
		this.command = command;
	}





	@Temporal(TemporalType.TIMESTAMP)
	public Date getCreateDate() {
		return createDate;
	}






	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}






	public String getStatus() {
		return status;
	}






	public void setStatus(String status) {
		this.status = status;
	}


	public String getPorts() {
		return ports;
	}

	public void setPorts(String ports) {
		this.ports = ports;
	}

	@ManyToOne(targetEntity = Cluster.class)
	 @JoinColumn(name = "clusterName")
	public String getClusterName() {
		return clusterName;
	}






	public void setClusterName(String clusterName) {
		this.clusterName = clusterName;
	}






	public String getIp() {
		return ip;
	}






	public void setIp(String ip) {
		this.ip = ip;
	}






	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final Container other = (Container) obj;
		return Objects.equal(this.id, other.id) && Objects.equal(this.ip, other.ip) && Objects.equal(this.containerId, other.containerId);
				
	}

	public int hashCode() {
		return Objects.hashCode(this.id, this.ip, this.containerId);
	}
	
	@Override
	public String toString() {
		
		   return this.id+this.ip+this.containerId+this.images+this.createDate.toGMTString()+"所属集群"+this.clusterName;
	}
}
