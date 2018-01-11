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
import com.jeefw.model.sys.param.TaskParameter;

/**
 * 字典的实体类
 * @框架唯一的升级和技术支持地址：http://shop111863449.taobao.com
 */ 
@Entity
@Table(name = "task")
@Cache(region = "all", usage = CacheConcurrencyStrategy.READ_WRITE)
@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount", "sortColumns", "cmd", "queryDynamicConditions", "sortedConditions", "dynamicProperties", "success", "message", "sortColumnsString", "flag" })
public class Task extends TaskParameter {

	// 各个字段的含义请查阅文档的数据库结构部分
	private static final long serialVersionUID = -2847988368314678488L;
	@Id
	@GeneratedValue
	@Column(name = "id")
	private Long id;
	
	
	
	@Column(name = "serverIp",length = 40)
	private String serverIp;
	
	
	@Column(name = "serviceName", length = 30)
	private String serviceName;
	
	
	@Column(name = "imagesId", length = 40)
	private String imagesId;
	
	
	
	@Column(name = "scale")
	private int scale;
	
	
	
	@Column(name = "command")
	private String command;
	
	
	@Column(name = "renderClusterName")
	private String renderClusterName;
	
	
	
	
	
	
	public Task() {

	}

	



	public Long getId() {
		return id;
	}





	public void setId(Long id) {
		this.id = id;
	}





	public String getServerIp() {
		return serverIp;
	}





	public void setServerIp(String serverIp) {
		this.serverIp = serverIp;
	}





	public String getServiceName() {
		return serviceName;
	}





	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}





	public String getImagesId() {
		return imagesId;
	}





	public void setImagesId(String imagesId) {
		this.imagesId = imagesId;
	}





	public int getScale() {
		return scale;
	}





	public void setScale(int scale) {
		this.scale = scale;
	}





	public String getCommand() {
		return command;
	}





	





	public String getRenderClusterName() {
		return renderClusterName;
	}





	public void setRenderClusterName(String renderClusterName) {
		this.renderClusterName = renderClusterName;
	}





	public void setCommand(String command) {
		this.command = command;
	}





	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final Task other = (Task) obj;
		return Objects.equal(this.id, other.id) && Objects.equal(this.serverIp, other.serverIp) && Objects.equal(this.serviceName, other.serviceName);
				
	}

	public int hashCode() {
		return Objects.hashCode(this.id, this.serverIp,"编排方式"+this.serviceName);
	}
	
	@Override
	public String toString() {
		//System.out.println(this.register.toString());
		   return this.id+this.serverIp+this.serviceName+this.serviceName+this.renderClusterName;
	}
}
