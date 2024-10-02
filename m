Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB9B433D5
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Oct 2024 03:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727839238; cv=none; b=UyW0hRnH/nRViqG3ABBFTZhjc4lhndlR19cfA7EM73XM/2oBFA3lABv1UV2BDeXeT4bQiEsjNAqkNsIEqhltBQBO5R6HJOUGbOL0DcDQmlCZ5Y33EKmefNbrxQ8uaW200OlCwJVHxEycYttkkPfDPmcuvE7SvU4XQoW1/uVj354=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727839238; c=relaxed/simple;
	bh=0g1nRVYc2P1gyjRrCJd52ixWbdM+SC58Z1dsoHnQioM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LrZCNWQ5Q9dRikaOBoap2UVuVQcFXEObZ/qwNiZ7quUCi545+fqndBipO//VzhsQc1ARu7j5EORVzv8gdQQX1Dz8qGBqXDrgGUmJm6kpJE99M2xeWcmsnQsYthLtN5KTpklh6PyvpejRkKfWkvl6ymvMQ7zeIJwUYUtqbHE575s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZOjGWkWY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZOjGWkWY"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e25d62bfe12so9399958276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 20:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727839236; x=1728444036; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bF65nLXk1UolurWKQzuL9+6VFLZl4ud9B1SFXRw/LFg=;
        b=ZOjGWkWYUvP1dsfLeKbLLFIB1FgvN5BPvCKwzpqHQ21xu4M27imgphf9HrgGQDmu4G
         n5UYTPBnoi8FcEPvjwrH0t9zfCG7LgOsuFlt6RvPqNC5Z2KlYI8uyk1n012v8KfQUsgv
         A7UgmaG7xqEBDCREwuFtaXXs8hzDiRErF2tSO9BQqyRhFwSADW2WLI/2BoXZ0PV7y1CR
         BwRSxB85bR1eyk4MSUObK51qBNtLKAl2Gn85sKUbVcNwYPf+h1KhqABkOMoG9JT7FITP
         VCJPLdom0L3+UDP+j/KiW9smJjVpRgHMolZU4xwKsJkGNVlhI9B9wuUltIfSejVxIo6Q
         2+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727839236; x=1728444036;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bF65nLXk1UolurWKQzuL9+6VFLZl4ud9B1SFXRw/LFg=;
        b=oYL1LaZ72zT8VWEbK9nKYYgIB6y5z749qKYifMsFagmvuX/J1WQK1Oqbf9S6hsEE4T
         sKIAVz1kEhLGg4Aph6SpUDkVsMD7G9SJLKncSbEiVWKNbJ2zlCcMZuQnwQOea1fmprYE
         il+HfliOgHxQADRNVj2YkpGJhvZGGEdGuuTJnptfkf160z77qwgPrWyL3PwysbbSNyY1
         Q7L0sDTCnW3bsMAd4l7SM26fCOusOjR0rtr59oJ7Z/Kn6T9ferwYgId03Cxfuutzjb8F
         IzA4BNaQG8wQK0Y4d4itFwuNOKlB740PO1O65BRUhUMyy+DtlJ4yH8S1RIt1mzcGwWxD
         T21g==
X-Forwarded-Encrypted: i=1; AJvYcCXyxST/LfZg3reVj/2KhiFefMrja5pZ4cg8Wy6d1nVgNF/OcOd4sb82drG6vLgNAc6LBPlMG/ooHBtlToMT5F/6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7qlgxciFdZl19Fh9Ebk2PJm47jGc0nf6oGtDxI1M5jy6wmZOe
	XiFGeeUpLm82XSrPtDvhi4REup+dc/k3zSVjmKlaHhW2KBBd4xDK4UnbqM5oR/7Y2ecPuXuTP9Z
	tlZGlvA==
X-Google-Smtp-Source: AGHT+IFaO8lHdOniNRTpaZuldspmldGJ3TH5FSCfkfLccbjjJ2qmbvropjIYlUbtldgOQhvjL8xdViilvcKa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ffa1:6d00:2acb:535f])
 (user=irogers job=sendgmr) by 2002:a05:6902:10c7:b0:e24:a00a:518e with SMTP
 id 3f1490d57ef6-e263840d766mr9239276.7.1727839236256; Tue, 01 Oct 2024
 20:20:36 -0700 (PDT)
Date: Tue,  1 Oct 2024 20:20:09 -0700
In-Reply-To: <20241002032016.333748-1-irogers@google.com>
Message-Id: <20241002032016.333748-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241002032016.333748-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v3 06/13] perf tool_pmu: Rename perf_tool_event__* to tool_pmu__*
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Weilin Wang <weilin.wang@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Ze Gao <zegao2021@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Now the events are associated with the tool PMU, rename the functions
to reflect this.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c       |  2 +-
 tools/perf/util/metricgroup.c | 22 +++++++++++-----------
 tools/perf/util/pmu.c         |  4 ++--
 tools/perf/util/tool_pmu.c    | 16 ++++++++--------
 tools/perf/util/tool_pmu.h    |  8 ++++----
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 59b2d38c9a65..e6fdbbb3398e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1669,7 +1669,7 @@ bool __evsel__match(const struct evsel *evsel, u32 type, u64 config)
 int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 {
 	if (evsel__is_tool(evsel))
-		return evsel__read_tool(evsel, cpu_map_idx, thread);
+		return evsel__tool_pmu_read(evsel, cpu_map_idx, thread);
 
 	if (evsel__is_retire_lat(evsel))
 		return evsel__read_retire_lat(evsel, cpu_map_idx, thread);
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 1250bf5050b0..46920ebadfd1 100644
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
index 77e848ac5841..d3c7a1c4254c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1836,7 +1836,7 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 	if (!name)
 		return false;
 	if (perf_pmu__is_tool(pmu))
-		return perf_tool_event__from_str(name) != TOOL_PMU__EVENT_NONE;
+		return tool_pmu__str_to_event(name) != TOOL_PMU__EVENT_NONE;
 	if (perf_pmu__find_alias(pmu, name, /*load=*/ true) != NULL)
 		return true;
 	if (pmu->cpu_aliases_added || !pmu->events_table)
@@ -2331,7 +2331,7 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 		return NULL;
 
 	if (perf_pmu__is_tool(pmu))
-		return perf_tool_event__to_str(config);
+		return tool_pmu__event_to_str(config);
 
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index ae0ca023f5ed..2a1524dc2e31 100644
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
@@ -328,7 +328,7 @@ int evsel__tool_pmu_open(struct evsel *evsel,
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
2.46.1.824.gd892dcdcdd-goog

