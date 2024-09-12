Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A797A1C2435
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167853; cv=none; b=NGRAbzxWxmqJ5NH0Y5wn4UfhmnVElPrtI1GkJ8UUkUa+Lft0H3Kxr14iXt+1B+sPd/flOh2fAn9Yy9ybAEP5ONMkANsUlE2/yHt55pk8edyz2LUWJJJ1vpV1UZIgk4CIk94/9z/XH9sq8n7hd43ZV1J7Lj9z7BABcdQcNkqB05U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167853; c=relaxed/simple;
	bh=zapSEGsQgIL61ZEsU5YA58q0vIiAHQfaNjf0YF8DeB0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Zs+WDuOspYYmOu93bYa1Wsg4Za0DFdJs3dYVtLAvHYRbSat08DuLdNgYi9rz0zPJBkEQFnKlhmzQU49d+qF+Zyd7ZGX37l9SwCofiz8WkJT2hH+mdktBDuEvIV/keT2kQ4c515YoN4YAn7Zh3WGgx3Ib90R4yZgk1a7CkeXuhGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vFCzIZEE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vFCzIZEE"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6886cd07673so32226167b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 12:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726167850; x=1726772650; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qwi2Sac9s+asJZx0ZDodmxFO/gJn7Y8byoQSP/zeaw0=;
        b=vFCzIZEE0+qcwIFeyOA8uLuuUZXW2ppsBBZMEA9gGJYaXqgSQiN1//YijvnwzSrM9k
         aTkEZaEkDWlsKz5wn4cFjtTT/M8XGbr1g3JbRUHnLcgL8/Wy/zji9axgtZS9ZfZV5Vwy
         Ydh/w2WWIxGAoCG/0mUE2ExDZAS882sgMU+aPoMdGh+OnUq7v4JA8uU6K1zD8mvvCWYl
         BuRIonj7LsINnrfKXF8ZvJhVcj1SA/VvRxOqHOdQDYMYlTs0tvpPY5v20k7yDIKfmA6T
         A4wfMPt/26wHJagz2HlNu1AuRV5MrHAed5JE08DALiC0HXnRWdJY28Tb9SJ6tigPk9el
         aqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726167850; x=1726772650;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qwi2Sac9s+asJZx0ZDodmxFO/gJn7Y8byoQSP/zeaw0=;
        b=gjgMM7jLZbPYnlFJ1QZaUwrB5vvRSfXg1BkPfUq6e4l9cTP4hflfAFyoILz+i9Dk4O
         27oGGN3ZxM7Ba/optOytvRxU5IbXDqS7AsOV3CQs3goXej5Y/UBPbYVRcjXet0uvLOe1
         a/R12AsOv75aPqEsjmxbEORsSASuUOzyYeE2Hd8fAvzsR5LOEz93qHsVlO7bUh1aisAz
         6owdmbmzDWdRemNq7yufP2yVg7jayoLthYFKirLXNP+UBBZwNHuIjEe0fg+i4Qga8t8B
         jj5YGDIF+JJRU5F/HU2ZgApbOIE+EpPlHnE1y6QeiNJcVKjT8U4VVaPqxrYFlX5fgZV4
         G7Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWduFGgiqshV/FZbbz6xSJVm8x+aRl/PeyfE9u7fGkZ1zZraPfRd4Ut0Px+c+1T95QpztvlibhpI8hE9hfgcdj6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0FHFf+CtUbG50UiXyF++cj0J2U7q4iUaGFFOX+m2ljMGeiix9
	gq61LieExWlNRHWKyUvXlpLAmp82uNqjoZuyTo0ube0zSVJSHtfz6XKfuPZ0twMB0Q2btr4uR1Q
	P3gLUsA==
X-Google-Smtp-Source: AGHT+IHiG/7TeNX7kdEoKK0lWn5nwEpRZ+1ylyJ4Rp1/rDpABHnz8K1NHY3kjCjIaqVvhOSJz7IMjVmSQDru
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cf0e:7a99:e672:3862])
 (user=irogers job=sendgmr) by 2002:a05:690c:620e:b0:6db:b2ed:7625 with SMTP
 id 00721157ae682-6dbb69be9dbmr457287b3.0.1726167850371; Thu, 12 Sep 2024
 12:04:10 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:03:36 -0700
In-Reply-To: <20240912190341.919229-1-irogers@google.com>
Message-Id: <20240912190341.919229-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240912190341.919229-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v2 09/13] perf tool_pmu: Switch to standard pmu functions and
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
 tools/perf/util/tool_pmu.c | 109 +++++++++++--------------------------
 tools/perf/util/tool_pmu.h |  12 +---
 4 files changed, 46 insertions(+), 105 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 9cb7a4e5e7d4..beb93e2603e2 100644
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
index 6e657c44de58..107de86c2637 100644
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
index 3768c6a42ff6..488c9db33e27 100644
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
+bool tool_pmu__skip_event(const char *name __maybe_unused)
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
@@ -548,6 +501,8 @@ struct perf_pmu *perf_pmus__tool_pmu(void)
 		.caps = LIST_HEAD_INIT(tool.caps),
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
2.46.0.662.g92d0881bb0-goog

