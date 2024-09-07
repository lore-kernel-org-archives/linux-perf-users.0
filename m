Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96649158A36
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Sep 2024 05:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725685750; cv=none; b=aLF+a+KnX75VYU6r1WS9gLCyLb2QHIaIgluco/yYIvTq45p1XDon1cG2kGzQYssQ8Sm6JsqVAW2L5HYnQa33SF9OF5j0nA/jub6odwddQVjTs7GZ6gb7bMFfOlAtZ4CvBd+H43rL9mgg0SlWR0WwM1te7nkrFXmhPe+GM1qdgXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725685750; c=relaxed/simple;
	bh=BCTWy93AfdqyOigImfyqNMnfwBuoTS0E2c+uZn61FBs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=UfQyZftZkR3DlekzN6V5eVb27ImALKOEJ+JPkFfNqOj4QPCOL6eH8CmLZna2aIroP+HCzsSIFJyq9LIGk0hfKXqsk+eM+KTj9XIj5ZWLTzJ0wC+WJTvRb5Fwf8JQFnikv0sjdf9ejmOQ5Lzr2BCtN8xWiUX6DekvAMpo7ML2sb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bm+eZ+Md; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bm+eZ+Md"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d5dd6d28c2so90705907b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Sep 2024 22:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725685748; x=1726290548; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=slZLFT9lPrc7VqceilkcCPojjko5Bk6sW8avWD2Z9qM=;
        b=Bm+eZ+MdZzmBQLA1IwIRDPki92RNA/gAa3/iwb2+ObSJk5YsJvJiwoBROcDXHAryOK
         TIsOIcVDr8zYwW0OUFYVWEV8Jnj58cUQKoWJvpm18BeXiuS/3F0dglKxPke8qESlYqFS
         ij2XH8KeAV+IQ0rjXmWhrU8lFVf8Zx+RU4+DHnRJdgLa5NLPzhz0v54eVPcQOkhZLjAP
         5QGlVUsWMaWLTm6BlyEv1A+i4EE5Wyy4qwCt7HPockx0I9FlmpJEGll4Uahylned4vj8
         mYvL/zVSXxbZoEJ1dWHNU1jKZXeBVE2b/bC8Hn0ubYkUgPR+taRkU6sGBppuFv1QWZew
         zI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725685748; x=1726290548;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slZLFT9lPrc7VqceilkcCPojjko5Bk6sW8avWD2Z9qM=;
        b=RBxipUQSJXE/5SeXIzBZGZgAJF+QqfPvegeqEqVHopgyMkWdk51ndSHQ9hac6BAvbr
         FNFnO/mcuoVnjeUwkUHE0MBdP/6bix5RibnOouHB9uOAm1tWJgIuRxd/hnzko9gWnT+j
         vbiE061WN2GC9zKQcbic7X8P6C0yRNQ7HqcbEM373EwMrR8IQ2hHyKIgZvi9uJjzs9zh
         0Lkxtk08egGU8T3UN945IswgkhcDJVu/LW9AItbKMFqPxTp29J4dWHktwVxcUkSymShA
         wlPQyUEQy9NQUvHm0qJM7J4/r186moh46iQuga3c3cBsMzg8AjmRuihVObwiuFr6badD
         ta/A==
X-Forwarded-Encrypted: i=1; AJvYcCUz1eMK7eAAy8yduSlmQjN7RgIvAFfIhlqTrNpdxXzJ3xJTjiQUumkqlmT/SKMRIB1oCLbO75XCPT3XgUASmKnr@vger.kernel.org
X-Gm-Message-State: AOJu0YxIYJE8yUbmndF0bPozWlsPjEBFzdr5N6gD/TqwFODKsFmrGJm4
	bprqg1cMS9SohVE8pHDBZUonLBkC2Tu73ACaD/HbpGwMUtSIvwdkiAcHi+9jWb+YkNTlm9I9t9V
	aEz9yJQ==
X-Google-Smtp-Source: AGHT+IGLiZcjgrj2XjNehV5+ClfMF3R9wQ2qO71KbUxt7f6DyDr91FIcVb8RjqFnfZGSwjjR0iqUkJkUrKp3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:90e5:a813:c3d3:daed])
 (user=irogers job=sendgmr) by 2002:a25:3628:0:b0:e03:2f90:e81d with SMTP id
 3f1490d57ef6-e1d34a40ed1mr9063276.11.1725685747597; Fri, 06 Sep 2024 22:09:07
 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:08:27 -0700
In-Reply-To: <20240907050830.6752-1-irogers@google.com>
Message-Id: <20240907050830.6752-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240907050830.6752-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 12/15] perf tool_pmu: Switch to standard pmu functions and
 json descriptions
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

Use the regular PMU approaches with tool json events to reduce the
amount of special tool_pmu code - tool_pmu__config_terms and
tool_pmu__for_each_event_cb are removed. Some functions remain, like
tool_pmu__str_to_event, as conveniences to metricgroups. Add
tool_pmu__skip_event/tool_pmu__num_skip_events to handle the case that
tool json events shouldn't appear on certain architectures. This isn't
done in jevents.py due to complexity in the empty-pmu-events.c and
when all vendor json is built into the tool.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c      |  26 ++++-----
 tools/perf/util/pmus.c     |   4 +-
 tools/perf/util/tool_pmu.c | 111 ++++++++++++-------------------------
 tools/perf/util/tool_pmu.h |  12 +---
 4 files changed, 48 insertions(+), 105 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index a412c9c62f9c..5ff6556292fd 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1549,9 +1549,6 @@ int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 {
 	bool zero = !!pmu->perf_event_attr_init_default;
 
-	if (perf_pmu__is_tool(pmu))
-		return tool_pmu__config_terms(attr, head_terms, err);
-
 	/* Fake PMU doesn't have proper terms so nothing to configure in attr. */
 	if (perf_pmu__is_fake(pmu))
 		return 0;
@@ -1664,8 +1661,8 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 	info->scale    = 0.0;
 	info->snapshot = false;
 
-	/* Tool/fake PMU doesn't rewrite terms. */
-	if (perf_pmu__is_tool(pmu) || perf_pmu__is_fake(pmu))
+	/* Fake PMU doesn't rewrite terms. */
+	if (perf_pmu__is_fake(pmu))
 		goto out;
 
 	list_for_each_entry_safe(term, h, &head_terms->terms, list) {
@@ -1831,8 +1828,8 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 {
 	if (!name)
 		return false;
-	if (perf_pmu__is_tool(pmu))
-		return tool_pmu__str_to_event(name) != TOOL_PMU__EVENT_NONE;
+	if (perf_pmu__is_tool(pmu) && tool_pmu__skip_event(name))
+		return false;
 	if (perf_pmu__find_alias(pmu, name, /*load=*/ true) != NULL)
 		return true;
 	if (pmu->cpu_aliases_added || !pmu->events_table)
@@ -1844,9 +1841,6 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 {
 	size_t nr;
 
-	if (perf_pmu__is_tool(pmu))
-		return tool_pmu__num_events();
-
 	pmu_aliases_parse(pmu);
 	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;
 
@@ -1857,6 +1851,9 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 	else
 		assert(pmu->cpu_json_aliases == 0);
 
+	if (perf_pmu__is_tool(pmu))
+		nr -= tool_pmu__num_skip_events();
+
 	return pmu->selectable ? nr + 1 : nr;
 }
 
@@ -1907,15 +1904,15 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	int ret = 0;
 	struct strbuf sb;
 
-	if (perf_pmu__is_tool(pmu))
-		return tool_pmu__for_each_event_cb(pmu, state, cb);
-
 	strbuf_init(&sb, /*hint=*/ 0);
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
 		size_t buf_used, pmu_name_len;
 
+		if (perf_pmu__is_tool(pmu) && tool_pmu__skip_event(event->name))
+			continue;
+
 		info.pmu_name = event->pmu_name ?: pmu->name;
 		pmu_name_len = pmu_deduped_name_len(pmu, info.pmu_name,
 						    skip_duplicate_pmus);
@@ -2321,9 +2318,6 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 	if (!pmu)
 		return NULL;
 
-	if (perf_pmu__is_tool(pmu))
-		return tool_pmu__event_to_str(config);
-
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 36329bc77316..19673b9991c6 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -440,6 +440,7 @@ static int perf_pmus__print_pmu_events__callback(void *vstate,
 		pr_err("Unexpected event %s/%s/\n", info->pmu->name, info->name);
 		return 1;
 	}
+	assert(info->pmu != NULL || info->name != NULL);
 	s = &state->aliases[state->index];
 	s->pmu = info->pmu;
 #define COPY_STR(str) s->str = info->str ? strdup(info->str) : NULL
@@ -590,9 +591,6 @@ void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print_cb, voi
 		int len = pmu_name_len_no_suffix(pmu->name);
 		const char *desc = "(see 'man perf-list' or 'man perf-record' on how to encode it)";
 
-		if (perf_pmu__is_tool(pmu))
-			continue;
-
 		if (!pmu->is_core)
 			desc = NULL;
 
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 3dc7cc7b8d32..f2d26e9e51f5 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -33,101 +33,54 @@ static const char *const tool_pmu__event_names[TOOL_PMU__EVENT_MAX] = {
 	"system_tsc_freq",
 };
 
-
-const char *tool_pmu__event_to_str(enum tool_pmu_event ev)
-{
-	if (ev > TOOL_PMU__EVENT_NONE && ev < TOOL_PMU__EVENT_MAX)
-		return tool_pmu__event_names[ev];
-
-	return NULL;
-}
-
-enum tool_pmu_event tool_pmu__str_to_event(const char *str)
+bool tool_pmu__skip_event(const char *name)
 {
-	int i;
-
-	tool_pmu__for_each_event(i) {
-		if (!strcasecmp(str, tool_pmu__event_names[i])) {
 #if !defined(__aarch64__)
-			/* The slots event should only appear on arm64. */
-			if (i == TOOL_PMU__EVENT_SLOTS)
-				return TOOL_PMU__EVENT_NONE;
+	/* The slots event should only appear on arm64. */
+	if (strcasecmp(name, "slots") == 0)
+		return true;
 #endif
-			return i;
-		}
-	}
-	return TOOL_PMU__EVENT_NONE;
+#if !defined(__i386__) && !defined(__x86_64__)
+	/* The system_tsc_freq event should only appear on x86. */
+	if (strcasecmp(name, "system_tsc_freq") == 0)
+		return true;
+#endif
+	return false;
 }
 
-static int tool_pmu__config_term(struct perf_event_attr *attr,
-				 struct parse_events_term *term,
-				 struct parse_events_error *err)
+int tool_pmu__num_skip_events(void)
 {
-	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER) {
-		enum tool_pmu_event ev = tool_pmu__str_to_event(term->config);
+	int num = 0;
 
-		if (ev == TOOL_PMU__EVENT_NONE)
-			goto err_out;
-
-		attr->config = ev;
-		return 0;
-	}
-err_out:
-	if (err) {
-		char *err_str;
-
-		parse_events_error__handle(err, term->err_val,
-					asprintf(&err_str,
-						"unexpected tool event term (%s) %s",
-						parse_events__term_type_str(term->type_term),
-						term->config) < 0
-					? strdup("unexpected tool event term")
-					: err_str,
-					NULL);
-	}
-	return -EINVAL;
+#if !defined(__aarch64__)
+	num++;
+#endif
+#if !defined(__i386__) && !defined(__x86_64__)
+	num++;
+#endif
+	return num;
 }
 
-int tool_pmu__config_terms(struct perf_event_attr *attr,
-			   struct parse_events_terms *terms,
-			   struct parse_events_error *err)
+const char *tool_pmu__event_to_str(enum tool_pmu_event ev)
 {
-	struct parse_events_term *term;
-
-	list_for_each_entry(term, &terms->terms, list) {
-		if (tool_pmu__config_term(attr, term, err))
-			return -EINVAL;
-	}
-
-	return 0;
+	if (ev > TOOL_PMU__EVENT_NONE && ev < TOOL_PMU__EVENT_MAX)
+		return tool_pmu__event_names[ev];
 
+	return NULL;
 }
 
-int tool_pmu__for_each_event_cb(struct perf_pmu *pmu, void *state, pmu_event_callback cb)
+enum tool_pmu_event tool_pmu__str_to_event(const char *str)
 {
-	struct pmu_event_info info = {
-		.pmu = pmu,
-		.event_type_desc = "Tool event",
-	};
 	int i;
 
+	if (tool_pmu__skip_event(str))
+		return TOOL_PMU__EVENT_NONE;
+
 	tool_pmu__for_each_event(i) {
-		int ret;
-
-		info.name = tool_pmu__event_to_str(i);
-		info.alias = NULL;
-		info.scale_unit = NULL;
-		info.desc = NULL;
-		info.long_desc = NULL;
-		info.encoding_desc = NULL;
-		info.topic = NULL;
-		info.pmu_name = pmu->name;
-		info.deprecated = false;
-		ret = cb(state, &info);
-		if (ret)
-			return ret;
+		if (!strcasecmp(str, tool_pmu__event_names[i]))
+			return i;
 	}
-	return 0;
+	return TOOL_PMU__EVENT_NONE;
 }
 
 bool perf_pmu__is_tool(const struct perf_pmu *pmu)
@@ -544,8 +497,12 @@ struct perf_pmu *perf_pmus__tool_pmu(void)
 	static struct perf_pmu tool = {
 		.name = "tool",
 		.type = PERF_PMU_TYPE_TOOL,
+		.aliases = LIST_HEAD_INIT(tool.aliases),
+		.caps = LIST_HEAD_INIT(tool.caps),
 		.format = LIST_HEAD_INIT(tool.format),
 	};
+	if (!tool.events_table)
+		tool.events_table = find_core_events_table("common", "common");
 
 	return &tool;
 }
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
index ecdf316525bb..a60184859080 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -29,17 +29,11 @@ enum tool_pmu_event {
 #define tool_pmu__for_each_event(ev)					\
 	for ((ev) = TOOL_PMU__EVENT_DURATION_TIME; (ev) < TOOL_PMU__EVENT_MAX; ev++)
 
-static inline size_t tool_pmu__num_events(void)
-{
-	return TOOL_PMU__EVENT_MAX - 1;
-}
-
 const char *tool_pmu__event_to_str(enum tool_pmu_event ev);
 enum tool_pmu_event tool_pmu__str_to_event(const char *str);
-int tool_pmu__config_terms(struct perf_event_attr *attr,
-			   struct parse_events_terms *terms,
-			   struct parse_events_error *err);
-int tool_pmu__for_each_event_cb(struct perf_pmu *pmu, void *state, pmu_event_callback cb);
+bool tool_pmu__skip_event(const char *name);
+int tool_pmu__num_skip_events(void);
+
 bool tool_pmu__read_event(enum tool_pmu_event ev, u64 *result);
 
 u64 tool_pmu__cpu_slots_per_cycle(void);
-- 
2.46.0.469.g59c65b2a67-goog

