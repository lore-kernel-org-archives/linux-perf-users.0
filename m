Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9501BFDE1
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167843; cv=none; b=MsWcE6tIMTysnp1KC41IPVDdA1DAC5DcbU0dC9K/E+7YzQveUTT69URF0f3IocI8YFj5S/IYvNzdhXgKV0HCBVEo7Gp82NBqpqfbvPWspEcmhFnc69mo25lhXcj2feYkEczGCx0xiT0no50vrcUmkOAUQ76SUlkoCTCIdaXctiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167843; c=relaxed/simple;
	bh=9FWIieCrSHJSKwCFDqEEhz9udJYjo0ugqaVRuO1/AxY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JVCYKU4FobHGp7QRhH+LBhgyRt/hP74T3/OQl5Q2pcV8K+1QppK4R/+mw4p/3DYcY6jdYEziAhyS+lTkyAHm2dSYEE9fioo7/Hfff352CakDB84QjEkqXDoI3anSpbiE5SAp71RSvvUuO3eWji7CW8nEv+c6HWnoT3SA2huf3ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mjxIkPe0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mjxIkPe0"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6cf78470a56so29661217b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 12:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726167841; x=1726772641; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIe6eWIujUXnJEIE2MN3RNTRUcp19WY30IesPPBI6A8=;
        b=mjxIkPe017261j0ypGfJQPXF3hD0grU2AS95FmhcGjlYWxanuNDqXwuGIhx0imvTmJ
         zY52K7ew9Jy1Xwp6g7/0XJKcFzmy36brPxLdPWXqKUeFKZ0ydGAFgz3SOYs0YEgTwliq
         BZTUbViWGPuZbNGdBDslK+GQtA5khFbLvpJdnMT6JETfjAhNlWTFne4vH/0HlIjb8UXO
         heZEAv3iAOUbcBUVsfhJCQ7864k9LQoSZB+BEk/G2MutUK1UHVam1NbQZYSJKJe2kuII
         Jt2njti/l8GIkpjeaut05vqoB7lZElsl3UREAbOq2qv285+bOvH/dGrsimtsZL/GKeyx
         m+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726167841; x=1726772641;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIe6eWIujUXnJEIE2MN3RNTRUcp19WY30IesPPBI6A8=;
        b=C+nGTVDzkA2AcsrodH4dk0CMDjrkT5qjoB3+swFXWc9P6yG7MXEaNdh15hNLYymQX+
         6iUACKhiHZ4GxfKoex84056AZN35E/cf1PDCZz/o/JqLe1Ml2l4RKz4r2cQ3sGAaCQzU
         zhNAGkae2NfkviuB97uNbRZ21cNJV+abAZbRqrL5zxyShzWdPmtM002oRuQV2iMKwiL8
         GBjFjLXgjD++kRe5uA+EyN4Z7jnxXghXOaGJgiplR80gnwjQWi8c/s+tcDqHUo1BLQL6
         bVSnSsdJWXLV/dQLFuf/YvhTo0JOaUebQQUqrqXBmL6QxlM7Utv22aZpUxQpD1Oalsae
         TyhA==
X-Forwarded-Encrypted: i=1; AJvYcCVbOjXkSglE/JkVNrzO5XZAy/209wZ4YLsJA/eO+aM85au2lZxxlgk/PNYJySFk+LQ88w5GspQNJ+6rFhmGuiZb@vger.kernel.org
X-Gm-Message-State: AOJu0YwxWlkgoJN83A7sP9PKv3T4i3DcZ0na5c5QU3IjLpi6vfiYOaVu
	S3CqbGM6ieDWVaLw35APNlwp4VQQYnOGP7NptnafD5feCPJZ/rcmlwl2YABKykEwtOl5aljWg7I
	WsCWymA==
X-Google-Smtp-Source: AGHT+IEcXEOeMXGZFMtZnVJqscVGYLWWEnWwHykwGNk7dkqC1vb2k16m1zqYAsupxYdxB4UrmSPK4RIQLIDT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cf0e:7a99:e672:3862])
 (user=irogers job=sendgmr) by 2002:a81:b2c6:0:b0:6d6:cacb:c6d5 with SMTP id
 00721157ae682-6dbb6bb8ec2mr1072857b3.8.1726167841113; Thu, 12 Sep 2024
 12:04:01 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:03:32 -0700
In-Reply-To: <20240912190341.919229-1-irogers@google.com>
Message-Id: <20240912190341.919229-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240912190341.919229-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v2 05/13] perf tool_pmu: Rename enum perf_tool_event to tool_pmu_event
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

To better reflect the events listed are from the tool PMU. Rename the
enum values from PERF_TOOL_* to TOOL_PMU__EVENT_*.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     |  6 ++---
 tools/perf/util/evsel.c       |  4 ++--
 tools/perf/util/metricgroup.c | 12 +++++-----
 tools/perf/util/pmu.c         |  2 +-
 tools/perf/util/stat-shadow.c | 10 ++++----
 tools/perf/util/tool_pmu.c    | 44 +++++++++++++++++------------------
 tools/perf/util/tool_pmu.h    | 22 +++++++++---------
 7 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ae525fdcfbde..a6b4d1b98b3a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -295,14 +295,14 @@ static int read_single_counter(struct evsel *counter, int cpu_map_idx, int threa
 	 * terminates. Use the wait4 values in that case.
 	 */
 	if (err && cpu_map_idx == 0 &&
-	    (evsel__tool_event(counter) == PERF_TOOL_USER_TIME ||
-	     evsel__tool_event(counter) == PERF_TOOL_SYSTEM_TIME)) {
+	    (evsel__tool_event(counter) == TOOL_PMU__EVENT_USER_TIME ||
+	     evsel__tool_event(counter) == TOOL_PMU__EVENT_SYSTEM_TIME)) {
 		u64 val, *start_time;
 		struct perf_counts_values *count =
 			perf_counts(counter->counts, cpu_map_idx, thread);
 
 		start_time = xyarray__entry(counter->start_times, cpu_map_idx, thread);
-		if (evsel__tool_event(counter) == PERF_TOOL_USER_TIME)
+		if (evsel__tool_event(counter) == TOOL_PMU__EVENT_USER_TIME)
 			val = ru_stats.ru_utime_usec_stat.mean;
 		else
 			val = ru_stats.ru_stime_usec_stat.mean;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b75c4a4c7aa7..c0b49c5dd3cf 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1471,8 +1471,8 @@ void evsel__exit(struct evsel *evsel)
 	evsel->per_pkg_mask = NULL;
 	zfree(&evsel->metric_events);
 	perf_evsel__object.fini(evsel);
-	if (evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME ||
-	    evsel__tool_event(evsel) == PERF_TOOL_USER_TIME)
+	if (evsel__tool_event(evsel) == TOOL_PMU__EVENT_SYSTEM_TIME ||
+	    evsel__tool_event(evsel) == TOOL_PMU__EVENT_USER_TIME)
 		xyarray__delete(evsel->start_times);
 }
 
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 9181548e8881..0e21e2f9c170 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -674,20 +674,20 @@ static int metricgroup__build_event_string(struct strbuf *events,
 	struct hashmap_entry *cur;
 	size_t bkt;
 	bool no_group = true, has_tool_events = false;
-	bool tool_events[PERF_TOOL_MAX] = {false};
+	bool tool_events[TOOL_PMU__EVENT_MAX] = {false};
 	int ret = 0;
 
 #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
 
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		const char *sep, *rsep, *id = cur->pkey;
-		enum perf_tool_event ev;
+		enum tool_pmu_event ev;
 
 		pr_debug("found event %s\n", id);
 
 		/* Always move tool events outside of the group. */
 		ev = perf_tool_event__from_str(id);
-		if (ev != PERF_TOOL_NONE) {
+		if (ev != TOOL_PMU__EVENT_NONE) {
 			has_tool_events = true;
 			tool_events[ev] = true;
 			continue;
@@ -1375,7 +1375,7 @@ static void metricgroup__free_metrics(struct list_head *metric_list)
  *               to true if tool event is found.
  */
 static void find_tool_events(const struct list_head *metric_list,
-			     bool tool_events[PERF_TOOL_MAX])
+			     bool tool_events[TOOL_PMU__EVENT_MAX])
 {
 	struct metric *m;
 
@@ -1447,7 +1447,7 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
  */
 static int parse_ids(bool metric_no_merge, bool fake_pmu,
 		     struct expr_parse_ctx *ids, const char *modifier,
-		     bool group_events, const bool tool_events[PERF_TOOL_MAX],
+		     bool group_events, const bool tool_events[TOOL_PMU__EVENT_MAX],
 		     struct evlist **out_evlist)
 {
 	struct parse_events_error parse_error;
@@ -1536,7 +1536,7 @@ static int parse_groups(struct evlist *perf_evlist,
 	struct evlist *combined_evlist = NULL;
 	LIST_HEAD(metric_list);
 	struct metric *m;
-	bool tool_events[PERF_TOOL_MAX] = {false};
+	bool tool_events[TOOL_PMU__EVENT_MAX] = {false};
 	bool is_default = !strcmp(str, "Default");
 	int ret;
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f17e21455498..fadb705fd9a7 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1832,7 +1832,7 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 	if (!name)
 		return false;
 	if (perf_pmu__is_tool(pmu))
-		return perf_tool_event__from_str(name) != PERF_TOOL_NONE;
+		return perf_tool_event__from_str(name) != TOOL_PMU__EVENT_NONE;
 	if (perf_pmu__find_alias(pmu, name, /*load=*/ true) != NULL)
 		return true;
 	if (pmu->cpu_aliases_added || !pmu->events_table)
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 2d653f91400e..e56969d1e39d 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -382,22 +382,22 @@ static int prepare_metric(const struct metric_expr *mexp,
 			double scale;
 
 			switch (evsel__tool_event(metric_events[i])) {
-			case PERF_TOOL_DURATION_TIME:
+			case TOOL_PMU__EVENT_DURATION_TIME:
 				stats = &walltime_nsecs_stats;
 				scale = 1e-9;
 				break;
-			case PERF_TOOL_USER_TIME:
+			case TOOL_PMU__EVENT_USER_TIME:
 				stats = &ru_stats.ru_utime_usec_stat;
 				scale = 1e-6;
 				break;
-			case PERF_TOOL_SYSTEM_TIME:
+			case TOOL_PMU__EVENT_SYSTEM_TIME:
 				stats = &ru_stats.ru_stime_usec_stat;
 				scale = 1e-6;
 				break;
-			case PERF_TOOL_NONE:
+			case TOOL_PMU__EVENT_NONE:
 				pr_err("Invalid tool event 'none'");
 				abort();
-			case PERF_TOOL_MAX:
+			case TOOL_PMU__EVENT_MAX:
 				pr_err("Invalid tool event 'max'");
 				abort();
 			default:
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 702c1131a2a8..7ef559532f5b 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -12,7 +12,7 @@
 #include <fcntl.h>
 #include <strings.h>
 
-static const char *const tool_pmu__event_names[PERF_TOOL_MAX] = {
+static const char *const tool_pmu__event_names[TOOL_PMU__EVENT_MAX] = {
 	NULL,
 	"duration_time",
 	"user_time",
@@ -20,15 +20,15 @@ static const char *const tool_pmu__event_names[PERF_TOOL_MAX] = {
 };
 
 
-const char *perf_tool_event__to_str(enum perf_tool_event ev)
+const char *perf_tool_event__to_str(enum tool_pmu_event ev)
 {
-	if (ev > PERF_TOOL_NONE && ev < PERF_TOOL_MAX)
+	if (ev > TOOL_PMU__EVENT_NONE && ev < TOOL_PMU__EVENT_MAX)
 		return tool_pmu__event_names[ev];
 
 	return NULL;
 }
 
-enum perf_tool_event perf_tool_event__from_str(const char *str)
+enum tool_pmu_event perf_tool_event__from_str(const char *str)
 {
 	int i;
 
@@ -36,7 +36,7 @@ enum perf_tool_event perf_tool_event__from_str(const char *str)
 		if (!strcasecmp(str, tool_pmu__event_names[i]))
 			return i;
 	}
-	return PERF_TOOL_NONE;
+	return TOOL_PMU__EVENT_NONE;
 }
 
 static int tool_pmu__config_term(struct perf_event_attr *attr,
@@ -44,9 +44,9 @@ static int tool_pmu__config_term(struct perf_event_attr *attr,
 				 struct parse_events_error *err)
 {
 	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER) {
-		enum perf_tool_event ev = perf_tool_event__from_str(term->config);
+		enum tool_pmu_event ev = perf_tool_event__from_str(term->config);
 
-		if (ev == PERF_TOOL_NONE)
+		if (ev == TOOL_PMU__EVENT_NONE)
 			goto err_out;
 
 		attr->config = ev;
@@ -120,12 +120,12 @@ bool evsel__is_tool(const struct evsel *evsel)
 	return perf_pmu__is_tool(evsel->pmu);
 }
 
-enum perf_tool_event evsel__tool_event(const struct evsel *evsel)
+enum tool_pmu_event evsel__tool_event(const struct evsel *evsel)
 {
 	if (!evsel__is_tool(evsel))
-		return PERF_TOOL_NONE;
+		return TOOL_PMU__EVENT_NONE;
 
-	return (enum perf_tool_event)evsel->core.attr.config;
+	return (enum tool_pmu_event)evsel->core.attr.config;
 }
 
 const char *evsel__tool_pmu_event_name(const struct evsel *evsel)
@@ -231,8 +231,8 @@ int evsel__tool_pmu_prepare_open(struct evsel *evsel,
 				 struct perf_cpu_map *cpus,
 				 int nthreads)
 {
-	if ((evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME ||
-	     evsel__tool_event(evsel) == PERF_TOOL_USER_TIME) &&
+	if ((evsel__tool_event(evsel) == TOOL_PMU__EVENT_SYSTEM_TIME ||
+	     evsel__tool_event(evsel) == TOOL_PMU__EVENT_USER_TIME) &&
 	    !evsel->start_times) {
 		evsel->start_times = xyarray__new(perf_cpu_map__nr(cpus),
 						  nthreads,
@@ -249,10 +249,10 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 			 struct perf_thread_map *threads,
 			 int start_cpu_map_idx, int end_cpu_map_idx)
 {
-	enum perf_tool_event ev = evsel__tool_event(evsel);
+	enum tool_pmu_event ev = evsel__tool_event(evsel);
 	int pid = -1, idx = 0, thread = 0, nthreads, err = 0, old_errno;
 
-	if (ev == PERF_TOOL_DURATION_TIME) {
+	if (ev == TOOL_PMU__EVENT_DURATION_TIME) {
 		if (evsel->core.attr.sample_period) /* no sampling */
 			return -EINVAL;
 		evsel->start_time = rdclock();
@@ -271,8 +271,8 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 			if (!evsel->cgrp && !evsel->core.system_wide)
 				pid = perf_thread_map__pid(threads, thread);
 
-			if (ev == PERF_TOOL_USER_TIME || ev == PERF_TOOL_SYSTEM_TIME) {
-				bool system = ev == PERF_TOOL_SYSTEM_TIME;
+			if (ev == TOOL_PMU__EVENT_USER_TIME || ev == TOOL_PMU__EVENT_SYSTEM_TIME) {
+				bool system = ev == TOOL_PMU__EVENT_SYSTEM_TIME;
 				__u64 *start_time = NULL;
 				int fd;
 
@@ -340,7 +340,7 @@ int evsel__read_tool(struct evsel *evsel, int cpu_map_idx, int thread)
 	count = perf_counts(evsel->counts, cpu_map_idx, thread);
 
 	switch (evsel__tool_event(evsel)) {
-	case PERF_TOOL_DURATION_TIME:
+	case TOOL_PMU__EVENT_DURATION_TIME:
 		/*
 		 * Pretend duration_time is only on the first CPU and thread, or
 		 * else aggregation will scale duration_time by the number of
@@ -352,9 +352,9 @@ int evsel__read_tool(struct evsel *evsel, int cpu_map_idx, int thread)
 		else
 			cur_time = *start_time;
 		break;
-	case PERF_TOOL_USER_TIME:
-	case PERF_TOOL_SYSTEM_TIME: {
-		bool system = evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME;
+	case TOOL_PMU__EVENT_USER_TIME:
+	case TOOL_PMU__EVENT_SYSTEM_TIME: {
+		bool system = evsel__tool_event(evsel) == TOOL_PMU__EVENT_SYSTEM_TIME;
 
 		start_time = xyarray__entry(evsel->start_times, cpu_map_idx, thread);
 		fd = FD(evsel, cpu_map_idx, thread);
@@ -379,8 +379,8 @@ int evsel__read_tool(struct evsel *evsel, int cpu_map_idx, int thread)
 		adjust = true;
 		break;
 	}
-	case PERF_TOOL_NONE:
-	case PERF_TOOL_MAX:
+	case TOOL_PMU__EVENT_NONE:
+	case TOOL_PMU__EVENT_MAX:
 	default:
 		err = -EINVAL;
 	}
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
index 05a4052c8b9d..b27a26133927 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -8,25 +8,25 @@ struct evsel;
 struct perf_thread_map;
 struct print_callbacks;
 
-enum perf_tool_event {
-	PERF_TOOL_NONE = 0,
-	PERF_TOOL_DURATION_TIME = 1,
-	PERF_TOOL_USER_TIME = 2,
-	PERF_TOOL_SYSTEM_TIME = 3,
+enum tool_pmu_event {
+	TOOL_PMU__EVENT_NONE = 0,
+	TOOL_PMU__EVENT_DURATION_TIME = 1,
+	TOOL_PMU__EVENT_USER_TIME = 2,
+	TOOL_PMU__EVENT_SYSTEM_TIME = 3,
 
-	PERF_TOOL_MAX,
+	TOOL_PMU__EVENT_MAX,
 };
 
 #define perf_tool_event__for_each_event(ev)				\
-	for ((ev) = PERF_TOOL_DURATION_TIME; (ev) < PERF_TOOL_MAX; ev++)
+	for ((ev) = TOOL_PMU__EVENT_DURATION_TIME; (ev) < TOOL_PMU__EVENT_MAX; ev++)
 
 static inline size_t tool_pmu__num_events(void)
 {
-	return PERF_TOOL_MAX - 1;
+	return TOOL_PMU__EVENT_MAX - 1;
 }
 
-const char *perf_tool_event__to_str(enum perf_tool_event ev);
-enum perf_tool_event perf_tool_event__from_str(const char *str);
+const char *perf_tool_event__to_str(enum tool_pmu_event ev);
+enum tool_pmu_event perf_tool_event__from_str(const char *str);
 int tool_pmu__config_terms(struct perf_event_attr *attr,
 			   struct parse_events_terms *terms,
 			   struct parse_events_error *err);
@@ -36,7 +36,7 @@ bool perf_pmu__is_tool(const struct perf_pmu *pmu);
 
 
 bool evsel__is_tool(const struct evsel *evsel);
-enum perf_tool_event evsel__tool_event(const struct evsel *evsel);
+enum tool_pmu_event evsel__tool_event(const struct evsel *evsel);
 const char *evsel__tool_pmu_event_name(const struct evsel *evsel);
 int evsel__tool_pmu_prepare_open(struct evsel *evsel,
 				 struct perf_cpu_map *cpus,
-- 
2.46.0.662.g92d0881bb0-goog

