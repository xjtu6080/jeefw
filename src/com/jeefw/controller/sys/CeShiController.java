package com.jeefw.controller.sys;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jeefw.core.Constant;
import com.jeefw.core.JavaEEFrameworkBaseController;
import com.jeefw.model.sys.CeShi;
import com.jeefw.service.sys.CeShiService;

import core.support.ExtJSBaseParameter;
import core.support.JqGridPageView;
import core.support.QueryResult;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 字典的控制层
 * @框架唯一的升级和技术支持地址：http://shop111863449.taobao.com
 */
@Controller
@RequestMapping("/sys/ceshi")
public class CeShiController extends JavaEEFrameworkBaseController<CeShi> implements Constant {

	@Resource
	private CeShiService ceShiService;

	// 查询字典的表格，包括分页、搜索和排序
	@RequestMapping(value = "/getDict", method = { RequestMethod.POST, RequestMethod.GET })
	public void getDict(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Integer firstResult = Integer.valueOf(request.getParameter("page"));
		Integer maxResults = Integer.valueOf(request.getParameter("rows"));
		String sortedObject = request.getParameter("sidx");
		String sortedValue = request.getParameter("sord");
		String filters = request.getParameter("filters");
		CeShi dict = new CeShi();
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("field").equals("dictKey") && result.getString("op").equals("eq")) {
					dict.set$eq_dictKey(result.getString("data"));
				}
				if (result.getString("field").equals("dictValue") && result.getString("op").equals("cn")) {
					dict.set$like_dictValue(result.getString("data"));
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
		QueryResult<CeShi> queryResult = ceShiService.doPaginationQuery(dict);
		JqGridPageView<CeShi> dictListView = new JqGridPageView<CeShi>();
		dictListView.setMaxResults(maxResults);
		List<CeShi> dictWithSubList = ceShiService.queryCeShiWithSubList(queryResult.getResultList());
		dictListView.setRows(dictWithSubList);
		dictListView.setRecords(queryResult.getTotalCount());
		writeJSON(response, dictListView);
	}

	// 保存字典的实体Bean
	@RequestMapping(value = "/saveDict", method = { RequestMethod.POST, RequestMethod.GET })
	public void doSave(CeShi entity, HttpServletRequest request, HttpServletResponse response) throws IOException {
		ExtJSBaseParameter parameter = ((ExtJSBaseParameter) entity);
		if (CMD_EDIT.equals(parameter.getCmd())) {
			ceShiService.merge(entity);
		} else if (CMD_NEW.equals(parameter.getCmd())) {
			ceShiService.persist(entity);
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
			String dictKey = request.getParameter("dictKey");
			String dictValue = request.getParameter("dictValue");
			String sequence = request.getParameter("sequence");
			String parentDictkey = request.getParameter("parentDictkey");
			CeShi dict = null;
			if (oper.equals("edit")) {
				dict = ceShiService.get(Long.valueOf(id));
			}
			CeShi dictKeyDict = ceShiService.getByProerties("dictKey", dictKey);
			CeShi parentDictkeyDict = ceShiService.getByProerties("dictKey", parentDictkey);
			if (StringUtils.isBlank(dictKey) || StringUtils.isBlank(dictValue)) {
				response.setStatus(HttpServletResponse.SC_LENGTH_REQUIRED);
				result.put("message", "请填写字典编码和字典名称");
				writeJSON(response, result);
			} else if (null != dictKeyDict && oper.equals("add")) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "此字典编码已存在，请重新输入");
				writeJSON(response, result);
			} else if (null != dictKeyDict && !dict.getDictKey().equalsIgnoreCase(dictKey) && oper.equals("edit")) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "此字典编码已存在，请重新输入");
				writeJSON(response, result);
			} else if (StringUtils.isNotBlank(parentDictkey) && null == parentDictkeyDict) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "上级字典编码输入有误，请重新输入");
				writeJSON(response, result);
			} else {
				CeShi entity = new CeShi();
				entity.setDictKey(dictKey);
				entity.setDictValue(dictValue);
				entity.setSequence(sequence == "" ? null : Long.valueOf(sequence));
				entity.setParentDictkey(parentDictkey);
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
	public void deleteDict(HttpServletRequest request, HttpServletResponse response, @RequestParam("ids") Long[] ids) throws IOException {
		boolean flag = ceShiService.deleteByPK(ids);
		if (flag) {
			writeJSON(response, "{success:true}");
		} else {
			writeJSON(response, "{success:false}");
		}
	}

}
