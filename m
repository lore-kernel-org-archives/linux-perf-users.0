Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B39815AC
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Oct 2023 01:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nA4/KoKB"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9631B6;
	Fri, 13 Oct 2023 18:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697248404; x=1728784404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IjMkAcoAQSGwioMAwpD/a+CM8q0l4GbMybMr40inTJg=;
  b=nA4/KoKBDMvL/ZquPsNaNgl5SA158DOsg0WrdFb7gOrB3mfiuhfs46x9
   cAuoYHb/Y7Ln48mqhPSvPEj2BVA7SMe6g376bEQ6aXni5mNWMdbHhvqPl
   Ieh6f6TLTgu/NMj9tFp70O2zgHqJR7NgeNy6SyLSga9KYsYUEYu+D3eUW
   fKsbEUrePnqywWdZMlAuksYqFiHnkG6xkthCkScyamnb2s8vE2fIrIfn6
   l1Ru/d08GO2Oeuj3UNiHTyeWD54i3NwA84Qkd2O7oF/gBeXpl5D8RoW+h
   xUI2B0bmMamkVO4Lr7CBruj7JOs56yNMDv00Xiw89rECvV1o1JIm0bKCX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="389154778"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="389154778"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 18:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="731565706"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="731565706"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by orsmga006.jf.intel.com with ESMTP; 13 Oct 2023 18:52:21 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Yang Jihong <yangjihong1@huawei.com>
Subject: [RFC PATCH v2 16/17] perf stat: Add tool events support in hardware-grouping
Date: Fri, 13 Oct 2023 18:52:01 -0700
Message-Id: <20231014015202.1175377-17-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231014015202.1175377-1-weilin.wang@intel.com>
References: <20231014015202.1175377-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Weilin Wang <weilin.wang@intel.com>

Add tool events into default_core grouping strings if find tool events so
that metrics use tool events could be correctly calculated. Need this step
to support TopdownL4-L5.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 49 ++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 1222cff8d..c584f194b 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1391,6 +1391,35 @@ static void find_tool_events(const struct list_head *metric_list,
 	}
 }
 
+/**
+ * get_tool_event_str - Generate and return a string with all the used tool
+ * event names.
+ */
+static int get_tool_event_str(struct strbuf *events,
+			      const bool tool_events[PERF_TOOL_MAX],
+			      bool *has_tool_event)
+{
+	int i = 0;
+	int ret;
+
+	perf_tool_event__for_each_event(i) {
+		if (tool_events[i]) {
+			const char *tmp = strdup(perf_tool_event__to_str(i));
+
+			if (!tmp)
+				return -ENOMEM;
+			*has_tool_event = true;
+			ret = strbuf_addstr(events, ",");
+			if (ret)
+				return ret;
+			ret = strbuf_addstr(events, tmp);
+			if (ret)
+				return ret;
+		}
+	}
+	return 0;
+}
+
 /**
  * build_combined_expr_ctx - Make an expr_parse_ctx with all !group_events
  *                           metric IDs, as the IDs are held in a set,
@@ -1954,6 +1983,7 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
 
 static int hw_aware_metricgroup__build_event_string(struct list_head *group_strs,
 					   const char *modifier,
+					   const bool tool_events[PERF_TOOL_MAX],
 					   struct list_head *groups)
 {
 	struct metricgroup__pmu_group_list *p;
@@ -1961,8 +1991,12 @@ static int hw_aware_metricgroup__build_event_string(struct list_head *group_strs
 	struct metricgroup__group_events *ge;
 	bool no_group = true;
 	int ret = 0;
+	struct strbuf tool_event_str = STRBUF_INIT;
+	bool has_tool_event = false;
 
 #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
+	ret = get_tool_event_str(&tool_event_str, tool_events, &has_tool_event);
+	RETURN_IF_NON_ZERO(ret);
 
 	list_for_each_entry(p, groups, nd) {
 		list_for_each_entry(g, &p->group_head, nd) {
@@ -2034,6 +2068,12 @@ static int hw_aware_metricgroup__build_event_string(struct list_head *group_strs
 			}
 			ret = strbuf_addf(events, "}:W");
 			RETURN_IF_NON_ZERO(ret);
+
+			if (!strcmp(p->pmu_name, "default_core") && has_tool_event) {
+				ret = strbuf_addstr(events, tool_event_str.buf);
+				RETURN_IF_NON_ZERO(ret);
+			}
+
 			pr_debug("events-buf: %s\n", events->buf);
 			list_add_tail(&new_group_str->nd, group_strs);
 		}
@@ -2119,6 +2159,7 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx,
 		if (ret)
 			goto err_out;
 	}
+
 	ret = get_pmu_counter_layouts(&pmu_info_list, ltable);
 	if (ret)
 		goto err_out;
@@ -2164,6 +2205,7 @@ static void metricgroup__free_grouping_strs(struct list_head
  */
 static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 			     struct expr_parse_ctx *ids, const char *modifier,
+			     const bool tool_events[PERF_TOOL_MAX],
 			     struct evlist **out_evlist)
 {
 	struct parse_events_error parse_error;
@@ -2177,7 +2219,8 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 	ret = hw_aware_build_grouping(ids, &grouping);
 	if (ret)
 		goto out;
-	ret = hw_aware_metricgroup__build_event_string(&grouping_str, modifier, &grouping);
+	ret = hw_aware_metricgroup__build_event_string(&grouping_str, modifier,
+						      tool_events, &grouping);
 	if (ret)
 		goto out;
 
@@ -2312,6 +2355,7 @@ static int hw_aware_parse_groups(struct evlist *perf_evlist,
 	struct evlist *combined_evlist = NULL;
 	LIST_HEAD(metric_list);
 	struct metric *m;
+	bool tool_events[PERF_TOOL_MAX] = {false};
 	int ret;
 	bool metric_no_group = false;
 	bool metric_no_merge = false;
@@ -2330,11 +2374,14 @@ static int hw_aware_parse_groups(struct evlist *perf_evlist,
 	if (!metric_no_merge) {
 		struct expr_parse_ctx *combined = NULL;
 
+		find_tool_events(&metric_list, tool_events);
+
 		ret = hw_aware_build_combined_expr_ctx(&metric_list, &combined);
 
 		if (!ret && combined && hashmap__size(combined->ids)) {
 			ret = hw_aware_parse_ids(fake_pmu, combined,
 						/*modifier=*/NULL,
+						tool_events,
 						&combined_evlist);
 		}
 
-- 
2.39.3

