Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812381BFDE1
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167846; cv=none; b=evJ9QBL2WYOFajq4+ND2Nld9QvmHmZBDNpWWpM+DT5AuZQ2hAMq9ua/caHNt7dhRU9Que06uZDrk4MJ4G6yo68s/89Oo5Sm3I2OndAzpducak7Nw74sD1VQgxphipcl4mjgPq0Yvu381nRFzmnWpYWYw9pGsZsH9zew2BX7eCLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167846; c=relaxed/simple;
	bh=uQ4KFUwL/NCeIgiOA9uomLhotkcV7/jm55QdrlRYrLM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=F4XDnkKbNd5iLvj/g3mHnifwXgLCYGfHo3QscduqbVHa6tIKmM4DM31MbaFqfBeKbZGeSMwk9DXHsNbnz9Er3W7sds1S6BqmGBJYYGNaxBCHq2ZyQIX6xhHv5VXVslM+tSVD/JR+4SNU5EfYtOO7LUTDPyis8pZiCDLKGWVsiaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xkk7hyVx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xkk7hyVx"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d73dd8ac65so4907417b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726167843; x=1726772643; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HR/8SRR0M3K67/iTjnIUMjJYRP6I/W64CEGjcVbEDQc=;
        b=xkk7hyVxSNdMn7HNmUL2aStXT8nTlYf3xyTlfYQ+LkZVin4GUnj5lJlWUcccR8qV9E
         tWaNqX7+PDGfyzNzQj53L656qI26GWhUenH9tUW88v47yu4o5gXwpjRQM/WWqIuL3vFP
         VQ95YB1JVsTG4cdNRAu4BraNS2e2fk0tAQYrOGgRCTpUOBxKGYuw/xxA2ud7MAQKzy89
         azZLQG40LmeQ9lflEFQCU8fNUNdP3agDZu+bwaK/s7B9zmJkCPzBvF4/tshbukgKeyb3
         z4RhfnpKsjYyz7AHFjMPBbau6AulkWk2eEpLfYJdOzm7xaaz+Nccgn9rWS6xqZPcbvtt
         fjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726167843; x=1726772643;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HR/8SRR0M3K67/iTjnIUMjJYRP6I/W64CEGjcVbEDQc=;
        b=YnNg28AVIhwwcFmXhS3fbJ00CQ8blvjQltCzztkm6X1AjxKqTpXPCOfYWq+2Uab+T2
         xsviHe5vlnqzOE3iySYsZNPFpxOgD/Tg1yU+FxbHtwJXOsN6cdT8O2X20Ukalx0LbHkR
         q/Xj5OMW8MYQd32IJrvJkdBxxmxYEfgsGqx8G6U5bQQqAsfQWM5OxwJ82aytWwZUEevF
         FJlWfbhjm+QIJ7E/bG4/t9NKfYytnCkSTcmKv7fwOx3m2CzJfAZBlwOTzacyFdd/HN8l
         7cWU7FI8zo4KwzWdoCMsH6gR0KhZiSNHswBIittXN0bqj7BDsX/IdydIYd/8xlav8mng
         dtKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm+LjSSEOxH56753kqL5swRZrq9KHSS/hjwVeJX03FgSymJdXZhYJD6Q7XfWmTBmS8W3yf9pdEQbDROH1CfJx7@vger.kernel.org
X-Gm-Message-State: AOJu0YyJIA2183umqukXQR97mzvc/UgEd6gZTJ+Uos7lQEtzVA5/RWvw
	7xKv3brJzjvCKjnaJKT8N16HteOJTYvltPsRdcb4E4j94R9Yx0ABZfPar6T/XtPMH1J/RWOhtH2
	FJuk5gg==
X-Google-Smtp-Source: AGHT+IFGQ+QNtBNjpI8Pmkiek6z9XLomsRs6D3HxUgxM5twDVfucPdjntzoXypmzUrxiQ6g31+nV2nRrtQq2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cf0e:7a99:e672:3862])
 (user=irogers job=sendgmr) by 2002:a25:b18b:0:b0:e1a:aa41:5170 with SMTP id
 3f1490d57ef6-e1db00f346emr447276.8.1726167843454; Thu, 12 Sep 2024 12:04:03
 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:03:33 -0700
In-Reply-To: <20240912190341.919229-1-irogers@google.com>
Message-Id: <20240912190341.919229-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240912190341.919229-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v2 06/13] perf tool_pmu: Rename perf_tool_event__* to tool_pmu__*
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Now the events are associated with the tool PMU, rename the functions
to reflect this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c       |  2 +-
 tools/perf/util/metricgroup.c | 22 +++++++++++-----------
 tools/perf/util/pmu.c         |  4 ++--
 tools/perf/util/tool_pmu.c    | 16 ++++++++--------
 tools/perf/util/tool_pmu.h    |  8 ++++----
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c0b49c5dd3cf..9e748ed20988 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1655,7 +1655,7 @@ static int evsel__read_group(struct evsel *leader, int cpu_map_idx, int thread)
 int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 {
 	if (evsel__is_tool(evsel))
-		return evsel__read_tool(evsel, cpu_map_idx, thread);
+		return evsel__tool_pmu_read(evsel, cpu_map_idx, thread);
 
 	if (evsel__is_retire_lat(evsel))
 		return evsel__read_retire_lat(evsel, cpu_map_idx, thread);
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 0e21e2f9c170..e5dd932e4d3f 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -686,7 +686,7 @@ static int metricgroup__build_event_string(struct strbuf *events,
 		pr_debug("found event %s\n", id);
 
 		/* Always move tool events outside of the group. */
-		ev = perf_tool_event__from_str(id);
+		ev = tool_pmu__str_to_event(id);
 		if (ev != TOOL_PMU__EVENT_NONE) {
 			has_tool_events = true;
 			tool_events[ev] = true;
@@ -755,14 +755,14 @@ static int metricgroup__build_event_string(struct strbuf *events,
 	if (has_tool_events) {
 		int i;
 
-		perf_tool_event__for_each_event(i) {
+		tool_pmu__for_each_event(i) {
 			if (tool_events[i]) {
 				if (!no_group) {
 					ret = strbuf_addch(events, ',');
 					RETURN_IF_NON_ZERO(ret);
 				}
 				no_group = false;
-				ret = strbuf_addstr(events, perf_tool_event__to_str(i));
+				ret = strbuf_addstr(events, tool_pmu__event_to_str(i));
 				RETURN_IF_NON_ZERO(ret);
 			}
 		}
@@ -1148,14 +1148,14 @@ static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
 	int i, left_count, right_count;
 
 	left_count = hashmap__size(left->pctx->ids);
-	perf_tool_event__for_each_event(i) {
-		if (!expr__get_id(left->pctx, perf_tool_event__to_str(i), &data))
+	tool_pmu__for_each_event(i) {
+		if (!expr__get_id(left->pctx, tool_pmu__event_to_str(i), &data))
 			left_count--;
 	}
 
 	right_count = hashmap__size(right->pctx->ids);
-	perf_tool_event__for_each_event(i) {
-		if (!expr__get_id(right->pctx, perf_tool_event__to_str(i), &data))
+	tool_pmu__for_each_event(i) {
+		if (!expr__get_id(right->pctx, tool_pmu__event_to_str(i), &data))
 			right_count--;
 	}
 
@@ -1382,11 +1382,11 @@ static void find_tool_events(const struct list_head *metric_list,
 	list_for_each_entry(m, metric_list, nd) {
 		int i;
 
-		perf_tool_event__for_each_event(i) {
+		tool_pmu__for_each_event(i) {
 			struct expr_id_data *data;
 
 			if (!tool_events[i] &&
-			    !expr__get_id(m->pctx, perf_tool_event__to_str(i), &data))
+			    !expr__get_id(m->pctx, tool_pmu__event_to_str(i), &data))
 				tool_events[i] = true;
 		}
 	}
@@ -1472,9 +1472,9 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
 		 *    event1 if #smt_on else 0
 		 * Add a tool event to avoid a parse error on an empty string.
 		 */
-		perf_tool_event__for_each_event(i) {
+		tool_pmu__for_each_event(i) {
 			if (tool_events[i]) {
-				char *tmp = strdup(perf_tool_event__to_str(i));
+				char *tmp = strdup(tool_pmu__event_to_str(i));
 
 				if (!tmp)
 					return -ENOMEM;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index fadb705fd9a7..d6310fa1b8bd 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1832,7 +1832,7 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 	if (!name)
 		return false;
 	if (perf_pmu__is_tool(pmu))
-		return perf_tool_event__from_str(name) != TOOL_PMU__EVENT_NONE;
+		return tool_pmu__str_to_event(name) != TOOL_PMU__EVENT_NONE;
 	if (perf_pmu__find_alias(pmu, name, /*load=*/ true) != NULL)
 		return true;
 	if (pmu->cpu_aliases_added || !pmu->events_table)
@@ -2327,7 +2327,7 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 		return NULL;
 
 	if (perf_pmu__is_tool(pmu))
-		return perf_tool_event__to_str(config);
+		return tool_pmu__event_to_str(config);
 
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 7ef559532f5b..b8116c5c7250 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -20,7 +20,7 @@ static const char *const tool_pmu__event_names[TOOL_PMU__EVENT_MAX] = {
 };
 
 
-const char *perf_tool_event__to_str(enum tool_pmu_event ev)
+const char *tool_pmu__event_to_str(enum tool_pmu_event ev)
 {
 	if (ev > TOOL_PMU__EVENT_NONE && ev < TOOL_PMU__EVENT_MAX)
 		return tool_pmu__event_names[ev];
@@ -28,11 +28,11 @@ const char *perf_tool_event__to_str(enum tool_pmu_event ev)
 	return NULL;
 }
 
-enum tool_pmu_event perf_tool_event__from_str(const char *str)
+enum tool_pmu_event tool_pmu__str_to_event(const char *str)
 {
 	int i;
 
-	perf_tool_event__for_each_event(i) {
+	tool_pmu__for_each_event(i) {
 		if (!strcasecmp(str, tool_pmu__event_names[i]))
 			return i;
 	}
@@ -44,7 +44,7 @@ static int tool_pmu__config_term(struct perf_event_attr *attr,
 				 struct parse_events_error *err)
 {
 	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER) {
-		enum tool_pmu_event ev = perf_tool_event__from_str(term->config);
+		enum tool_pmu_event ev = tool_pmu__str_to_event(term->config);
 
 		if (ev == TOOL_PMU__EVENT_NONE)
 			goto err_out;
@@ -91,10 +91,10 @@ int tool_pmu__for_each_event_cb(struct perf_pmu *pmu, void *state, pmu_event_cal
 	};
 	int i;
 
-	perf_tool_event__for_each_event(i) {
+	tool_pmu__for_each_event(i) {
 		int ret;
 
-		info.name = perf_tool_event__to_str(i);
+		info.name = tool_pmu__event_to_str(i);
 		info.alias = NULL;
 		info.scale_unit = NULL;
 		info.desc = NULL;
@@ -130,7 +130,7 @@ enum tool_pmu_event evsel__tool_event(const struct evsel *evsel)
 
 const char *evsel__tool_pmu_event_name(const struct evsel *evsel)
 {
-	return perf_tool_event__to_str(evsel->core.attr.config);
+	return tool_pmu__event_to_str(evsel->core.attr.config);
 }
 
 static bool read_until_char(struct io *io, char e)
@@ -330,7 +330,7 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 	return err;
 }
 
-int evsel__read_tool(struct evsel *evsel, int cpu_map_idx, int thread)
+int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 {
 	__u64 *start_time, cur_time, delta_start;
 	int fd, err = 0;
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
index b27a26133927..b156645206c4 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -17,7 +17,7 @@ enum tool_pmu_event {
 	TOOL_PMU__EVENT_MAX,
 };
 
-#define perf_tool_event__for_each_event(ev)				\
+#define tool_pmu__for_each_event(ev)					\
 	for ((ev) = TOOL_PMU__EVENT_DURATION_TIME; (ev) < TOOL_PMU__EVENT_MAX; ev++)
 
 static inline size_t tool_pmu__num_events(void)
@@ -25,8 +25,8 @@ static inline size_t tool_pmu__num_events(void)
 	return TOOL_PMU__EVENT_MAX - 1;
 }
 
-const char *perf_tool_event__to_str(enum tool_pmu_event ev);
-enum tool_pmu_event perf_tool_event__from_str(const char *str);
+const char *tool_pmu__event_to_str(enum tool_pmu_event ev);
+enum tool_pmu_event tool_pmu__str_to_event(const char *str);
 int tool_pmu__config_terms(struct perf_event_attr *attr,
 			   struct parse_events_terms *terms,
 			   struct parse_events_error *err);
@@ -44,7 +44,7 @@ int evsel__tool_pmu_prepare_open(struct evsel *evsel,
 int evsel__tool_pmu_open(struct evsel *evsel,
 			 struct perf_thread_map *threads,
 			 int start_cpu_map_idx, int end_cpu_map_idx);
-int evsel__read_tool(struct evsel *evsel, int cpu_map_idx, int thread);
+int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread);
 
 struct perf_pmu *perf_pmus__tool_pmu(void);
 
-- 
2.46.0.662.g92d0881bb0-goog

