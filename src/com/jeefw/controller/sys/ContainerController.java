package com.jeefw.controller.sys;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jeefw.core.Constant;
import com.jeefw.core.JavaEEFrameworkBaseController;
import com.jeefw.model.sys.Cluster;
import com.jeefw.model.sys.Container;
import com.jeefw.service.sys.ContainerService;

import core.support.ExtJSBaseParameter;
import core.support.JqGridPageView;
import core.support.QueryResult;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 字典的控制层
 * 
 * @框架唯一的升级和技术支持地址：http://shop111863449.taobao.com
 */
@Controller
@RequestMapping("/sys/container")
public class ContainerController extends JavaEEFrameworkBaseController<Container> implements Constant {

	@Resource
	private ContainerService containerService;

	// 查询字典的表格，包括分页、搜索和排序
	@RequestMapping(value = "/getDict", method = { RequestMethod.POST, RequestMethod.GET })
	public void getDict(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Integer firstResult = Integer.valueOf(request.getParameter("page"));
		Integer maxResults = Integer.valueOf(request.getParameter("rows"));
		String sortedObject = request.getParameter("sidx");
		String sortedValue = request.getParameter("sord");
		String filters = request.getParameter("filters");
		Container dict = new Container();
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("field").equals("ip") && result.getString("op").equals("eq")) {
					dict.set$eq_ip(result.getString("data"));
				}
				if (result.getString("field").equals("containerId") && result.getString("op").equals("cn")) {
					dict.set$like_containerId(result.getString("data"));
				}
			}
			if (((String) jsonObject.get("groupOp")).equalsIgnoreCase("OR")) {
				dict.setFlag("OR");
			} else {
				dict.setFlag("AND");
			}
		}
		dict.setFirstResult((firstResult - 1) * maxResults);
		dict.setMaxResults(maxResults);
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(sortedObject, sortedValue);
		dict.setSortedConditions(sortedCondition);
		QueryResult<Container> queryResult = containerService.doPaginationQuery(dict);

		JqGridPageView<Container> dictListView = new JqGridPageView<Container>();
		dictListView.setMaxResults(maxResults);
		List<Container> dictWithSubList = containerService.queryContainerWithSubList(queryResult.getResultList());
		System.out.println(dictWithSubList);
		dictListView.setRows(dictWithSubList);
		dictListView.setRecords(queryResult.getTotalCount());
		writeJSON(response, dictListView);
	}

	// 保存字典的实体Bean
	@RequestMapping(value = "/saveDict", method = { RequestMethod.POST, RequestMethod.GET })
	public void doSave(Container entity, HttpServletRequest request, HttpServletResponse response) throws IOException {
		ExtJSBaseParameter parameter = ((ExtJSBaseParameter) entity);
		if (CMD_EDIT.equals(parameter.getCmd())) {
			containerService.merge(entity);
		} else if (CMD_NEW.equals(parameter.getCmd())) {
			containerService.persist(entity);
		}
		parameter.setSuccess(true);
		writeJSON(response, parameter);
	}

	// 操作字典的删除、导出Excel、字段判断和保存
	@RequestMapping(value = "/operateDict", method = { RequestMethod.POST, RequestMethod.GET })
	public void operateDict(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String oper = request.getParameter("oper");
		String id = request.getParameter("id");
		if (oper.equals("del")) {
			String[] ids = id.split(",");
			deleteDict(request, response, (Long[]) ConvertUtils.convert(ids, Long.class));
		} else if (oper.equals("excel")) {
			response.setContentType("application/msexcel;charset=UTF-8");
			try {
				response.addHeader("Content-Disposition", "attachment;filename=file.xls");
				OutputStream out = response.getOutputStream();
				out.write(URLDecoder.decode(request.getParameter("csvBuffer"), "UTF-8").getBytes());
				out.flush();
				out.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			Map<String, Object> result = new HashMap<String, Object>();
			String images = request.getParameter("images");
			String ip = request.getParameter("ip");
			String command = request.getParameter("command");
			String status = request.getParameter("status");
			String ports = request.getParameter("ports");
			String createDate = request.getParameter("createDate");
			String containerId = request.getParameter("containerId");
			String clusterName = request.getParameter("clusterName");

			Container dict = null;
			if (oper.equals("edit")) {
				dict = containerService.get(Long.valueOf(id));
			}
			Container dictKeyDict = containerService.getByProerties("ip", ip);
			Container parentDictkeyDict = containerService.getByProerties("ip", ip);
			if (StringUtils.isBlank(ip) || StringUtils.isBlank(ports)) {
				response.setStatus(HttpServletResponse.SC_LENGTH_REQUIRED);
				result.put("message", "请填写容器的宿主机ip和端口");
				writeJSON(response, result);
			} else if (null != dictKeyDict && oper.equals("add")) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "此集群已存在，请重新输入");
				writeJSON(response, result);
			} else if (null != dictKeyDict && !dict.getIp().equalsIgnoreCase(ip) && oper.equals("edit")) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "此集群已存在，请重新输入");
				writeJSON(response, result);
			} else {

			
				
				Container entity = new Container();
				entity.setIp(ip);
				entity.setContainerId(containerId);
				entity.setStatus(status);
				entity.setCommand(command);
				entity.setImages(images);
				entity.setClusterName(clusterName);
				if (ports != null && ports.length() > 0)
					entity.setPorts(ports);
				
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date date=new Date();
					entity.setCreateDate(date);
					
				if (oper.equals("edit")) {
					entity.setId(Long.valueOf(id));
					entity.setCmd("edit");
					doSave(entity, request, response);
				} else if (oper.equals("add")) {
					entity.setCmd("new");
					doSave(entity, request, response);
				}
			}
		}
	}

	// 删除字典
	@RequestMapping("/deleteDict")
	public void deleteDict(HttpServletRequest request, HttpServletResponse response, @RequestParam("ids") Long[] ids)
			throws IOException {
		boolean flag = containerService.deleteByPK(ids);
		if (flag) {
			writeJSON(response, "{success:true}");
		} else {
			writeJSON(response, "{success:false}");
		}
	}
		

}
