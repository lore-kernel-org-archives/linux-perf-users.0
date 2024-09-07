Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C359A1547EF
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Sep 2024 05:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725685743; cv=none; b=uX9mVJ5gt1+ky286NW28cL1a7I3EDCTqLvW906l9tW7Sy9N1kHKLjBA9q2WlACd32motMGcE2sC/+J0ixxi9I7DYuGiZ8j/MdwDu8950H5GZmj6UzopLQ8wmEeAqEzqOxuXU9Uw0VnxySSZvh71LSzjZN6qoFnyChXvcehHYhkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725685743; c=relaxed/simple;
	bh=SS4AyC2HZ6wr5r+I3X0KxiCA+QUhaGbOEHDFVyEpN+Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=N2q2zBNZNeTQSQlPKm/SUvjkSrW15AjeDNIm6Tp06P3ZUKnppTiQfQb1ll9KqExcd5OK5iurL37r7eWNZqNAwg26b4bpRK6ZGjN2ihMoPFOcqQJ3IMny7Of5nRON2GOf1xxPiACGsWbn+1ndqZq19QQx1gga0E3OZVNN35NoYR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nuyl8Fy4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nuyl8Fy4"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d6bb05f2e9so69965437b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Sep 2024 22:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725685741; x=1726290541; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSf1ni/yxtxnti2/oeR7c7DGLW13Imy8ZmiYhJT1zrk=;
        b=nuyl8Fy4RdtE3Fclji/pYON+joF6i+BnSSGNpimPG/SZIuWZYdtpLU7iQMFhUU64uC
         1N2xw4ByoPjjSn+I2a0kPdEjaMe8i0ai7MGdkfHTyVCPO7IFcwSz4DwL6Sq9akvvZqbi
         QG/lXJw4wYSxtUiaYijnTqyW9CaL84F3abVHNjveWieCfXwUVnBTV+Y0dOu55npIYbjK
         oPfg8B1P+EOA+YlC21yu+T48s9UvbVXrDeRlENCV8Zz6xqy4Ox0gSeoOhCEH9XkDU1l3
         JzyI4qTjgREMrGRiZam/k3dojkzFjP5OrLCdYx1nJdaB64gYyuodwoKJSWogQJEOsfD0
         CzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725685741; x=1726290541;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSf1ni/yxtxnti2/oeR7c7DGLW13Imy8ZmiYhJT1zrk=;
        b=ozpubuSJII2tRDoRYSOJ1upccRuzKs0HIhQXq2rET4ejZuoFhIcaF+MEIR52Z0RqTB
         Tl93T1NaJT+jV6Bjc6z8X5gFevybGPxraUEfvQDWAtZFQBRm/O+vdplBefFkHeBca1hn
         r+eRFAqiu1hg/dtDs3GcdGGI9sp03x0hj2MRQopmoczNCk+PRVUp3FTmQwgdpvr3fdgv
         2hau7rj8ZRWXHDZFYzuopIG7wIVD/ZU4AbSxrNValyo37REiHDNO87c72zV7sKh+6UuM
         kBwt5UGvugbE8UJ1B4hbOKeJ3dOkcZpGSX3idacNSN6/xXR0c+TiMXCNY9PCNKeyXMfJ
         aLQw==
X-Forwarded-Encrypted: i=1; AJvYcCWgZZtekOn0lV0p2qIgpHfOowjTb3ks3nyaT3E5ikgCdnJhEu8rACSvV4TDz3g8h/DITBuIZqLl2drsABk//Fmg@vger.kernel.org
X-Gm-Message-State: AOJu0YzXQTv878+szKBGZJdNPbE/JG/j6JrNm4raSMAlBE9mxlmFbqE1
	2v4UZIq9YBDGVxww11CCxG4G/vtxAhnEAyagLoMgL/bMurIOL/UN2lEM0No6MgIGto7FhYKiWyQ
	n/fXECQ==
X-Google-Smtp-Source: AGHT+IGwXDBxEgaxf8qekRWOgcxeET/yUxtmBdTxQ0BuycxWuZS+279M0BgIeh09ULDAU0htc1vR1SxWOKc3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:90e5:a813:c3d3:daed])
 (user=irogers job=sendgmr) by 2002:a05:690c:dc6:b0:6b2:3ecc:817 with SMTP id
 00721157ae682-6db45160a0bmr4725717b3.8.1725685740937; Fri, 06 Sep 2024
 22:09:00 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:08:24 -0700
In-Reply-To: <20240907050830.6752-1-irogers@google.com>
Message-Id: <20240907050830.6752-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240907050830.6752-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 09/15] perf tool_pmu: Rename perf_tool_event__* to tool_pmu__*
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
index 34766151cfc3..69c26dad3e6c 100644
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
index c56fc0c13899..fb08b0400c81 100644
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
2.46.0.469.g59c65b2a67-goog

