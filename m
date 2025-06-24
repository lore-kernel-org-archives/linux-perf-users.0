Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A0A26AA88
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 23:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807146; cv=none; b=Tib7w5ua5/HYS1uKI/o7izxisw40Krt+KvJbYz4qfnSLoH+Tq0ZvX7ZxNjcGlC5xs3o64ZvlylJN5DgH8bnz/V/YmlhP9mcv0t2TNgOIWR8CXXmkdJvd80SZ+7Ou6hYGo1MXvypnG+zFbE7T+QQvj/ZrXiMr6bZMlIge0C2Qt1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807146; c=relaxed/simple;
	bh=UP7c8EZMJCmdtSRgS/00+UGz7KyMyLEWykYE2tYt5nQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T7PdU30+ChWIcCRGOhIJw/a39msbDZGJiUjtx9JNOb6msttnWJYpWj69NWZR9XAd9SJoSxDWLfs4RCF3xvh/zNmENCc0C6+svuQ7ftClWs5n/KlxTAwLZHbf5tqSErSKABhmXhwp7zo6i51eh77UXslmoaW/P3f5buPJDYfagyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s35A0cot; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s35A0cot"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2e990e17650so4352214fac.3
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 16:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750807144; x=1751411944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c3nTtbe0Tv/hCcFjA75rcndb1ZtC/Z05byf6Qgte1y0=;
        b=s35A0cotC0RZvQYmz67TRf3d8l/OuEH9XcTfCAAAEiN+SA+R5WlYmu8RmDQyJ2SWnX
         JmUpl40WHHbZ8JiuiYKVvuSSa00X565vnqN0Vxpqa9yrLHA7nQg52Gs6s3wV1gMCR8nJ
         jhAHtd1M2XaYVw+B04uoeaUz++HtFSkFBauWSESAg7pNy9GIQbyduXS26vMHRCGceLcB
         YlsCc6yJgzJoCqyg+CQrcmWxxVkufRWJuRMa9cWCkw9xIbon0s/DTT3RlYeMt2/pm/72
         MyaoeoacT3kR+Pno5/scNW3oQWTrgL5pUjLzyuprrGKVPvoNGP6ZwA/VxYcIQeKA25dE
         gc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750807144; x=1751411944;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3nTtbe0Tv/hCcFjA75rcndb1ZtC/Z05byf6Qgte1y0=;
        b=bcagWnmRE3kGywVBgsMVgnVyNLLV2reamOGtlUWbNp9B7qGa+BJFXl4A9vXM1kPsM/
         hv+JxJLJ8LxPYkZ5wDfno1uEuW665CO1xO3pn+kliPEU+lCuYhVnewyvDhOU4dYcABDN
         feE8NSNJw8fm054oYO88XiK6QjLIwtUxscAewh2D41XQEwrpfqJkrRmUH3fGFXYQAmm/
         WVre+Vt2e9lHJ7uh0wLqJch9TOmMJ983QaHDQh3QfEY3y8zOuJOpv3KPc2vHR+GfQ8Gl
         pTO39yUbVlK5ngzuCDf5aUL1NJpWiSwNbTx14GQE7oFeTfHSGMZYS2R4NZKGhBMt9vpH
         DJ+A==
X-Forwarded-Encrypted: i=1; AJvYcCWLQLo5re2Bme4vohLgrXAJ1wTqbm3C0829FrjByLMN8LPXiT2l7n8vb2l0faYGvsHo/Wilo2uDoanQEwFEj2nb@vger.kernel.org
X-Gm-Message-State: AOJu0YxFc8IAo6uPREPZrisCfpClqzjVUC2oSnGFhejg5+oskSoXySCt
	A2MPxecKQDKKYSj1N0g7m/oxpGLV94ZdNpnfxl9ggZizTDKfXCYH7csGf0M6c5bc/8UmiSdCW8z
	aalXsUFxYqA==
X-Google-Smtp-Source: AGHT+IFXWZZ1CRCWcrDta6qiLM+gayDxk+xFJqGOzfqYGuNTUXFKwCrv6FyBo0yt7uR6ntZsx4wgNnWjQYGt
X-Received: from oabtd5.prod.google.com ([2002:a05:6871:8785:b0:2d5:2492:cc14])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:6101:b0:2bc:7811:5bb8
 with SMTP id 586e51a60fabf-2efb2367241mr929848fac.18.1750807144437; Tue, 24
 Jun 2025 16:19:04 -0700 (PDT)
Date: Tue, 24 Jun 2025 16:18:35 -0700
In-Reply-To: <20250624231837.179536-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250624231837.179536-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250624231837.179536-2-irogers@google.com>
Subject: [PATCH v4 1/3] perf parse-events: Avoid scanning PMUs that can't
 contain events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Junhao He <hejunhao3@huawei.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, matthew.olson@intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add perf_pmus__scan_for_event that only reads sysfs for pmus that
could contain a given event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 33 ++++++++-------
 tools/perf/util/pmus.c         | 77 ++++++++++++++++++++++++++++++++++
 tools/perf/util/pmus.h         |  2 +
 3 files changed, 97 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d1965a7b97ed..4cd64ffa4fcd 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -490,7 +490,7 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 	int ret = 0;
 	struct evsel *first_wildcard_match = NULL;
 
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan_for_event(pmu, name)) != NULL) {
 		LIST_HEAD(config_terms);
 		struct perf_event_attr attr;
 
@@ -1681,7 +1681,8 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 	INIT_LIST_HEAD(list);
 
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan_for_event(pmu, event_name)) != NULL) {
+
 		if (parse_events__filter_pmu(parse_state, pmu))
 			continue;
 
@@ -1760,19 +1761,21 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 
 	pmu = NULL;
 	/* Failed to add, try wildcard expansion of event_or_pmu as a PMU name. */
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-		if (!parse_events__filter_pmu(parse_state, pmu) &&
-		    perf_pmu__wildcard_match(pmu, event_or_pmu)) {
-			if (!parse_events_add_pmu(parse_state, *listp, pmu,
-						  const_parsed_terms,
-						  first_wildcard_match,
-						  /*alternate_hw_config=*/PERF_COUNT_HW_MAX)) {
-				ok++;
-				parse_state->wild_card_pmus = true;
-			}
-			if (first_wildcard_match == NULL)
-				first_wildcard_match =
-					container_of((*listp)->prev, struct evsel, core.node);
+	while ((pmu = perf_pmus__scan_matching_wildcard(pmu, event_or_pmu)) != NULL) {
+
+		if (parse_events__filter_pmu(parse_state, pmu))
+			continue;
+
+		if (!parse_events_add_pmu(parse_state, *listp, pmu,
+					  const_parsed_terms,
+					  first_wildcard_match,
+					  /*alternate_hw_config=*/PERF_COUNT_HW_MAX)) {
+			ok++;
+			parse_state->wild_card_pmus = true;
+		}
+		if (first_wildcard_match == NULL) {
+			first_wildcard_match =
+				container_of((*listp)->prev, struct evsel, core.node);
 		}
 	}
 	if (ok)
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 3bbd26fec78a..e0094f56b8e7 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -19,6 +19,7 @@
 #include "tool_pmu.h"
 #include "print-events.h"
 #include "strbuf.h"
+#include "string2.h"
 
 /*
  * core_pmus:  A PMU belongs to core_pmus if it's name is "cpu" or it's sysfs
@@ -350,6 +351,82 @@ struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu)
 	return NULL;
 }
 
+struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *event)
+{
+	bool use_core_pmus = !pmu || pmu->is_core;
+
+	if (!pmu) {
+		/* Hwmon filename values that aren't used. */
+		enum hwmon_type type;
+		int number;
+		/*
+		 * Core PMUs, other sysfs PMUs and tool PMU can take all event
+		 * types or aren't wother optimizing for.
+		 */
+		unsigned int to_read_pmus =  PERF_TOOL_PMU_TYPE_PE_CORE_MASK |
+			PERF_TOOL_PMU_TYPE_PE_OTHER_MASK |
+			PERF_TOOL_PMU_TYPE_TOOL_MASK;
+
+		/* Could the event be a hwmon event? */
+		if (parse_hwmon_filename(event, &type, &number, /*item=*/NULL, /*alarm=*/NULL))
+			to_read_pmus |= PERF_TOOL_PMU_TYPE_HWMON_MASK;
+
+		pmu_read_sysfs(to_read_pmus);
+		pmu = list_prepare_entry(pmu, &core_pmus, list);
+	}
+	if (use_core_pmus) {
+		list_for_each_entry_continue(pmu, &core_pmus, list)
+			return pmu;
+
+		pmu = NULL;
+		pmu = list_prepare_entry(pmu, &other_pmus, list);
+	}
+	list_for_each_entry_continue(pmu, &other_pmus, list)
+		return pmu;
+	return NULL;
+}
+
+struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const char *wildcard)
+{
+	bool use_core_pmus = !pmu || pmu->is_core;
+
+	if (!pmu) {
+		/*
+		 * Core PMUs, other sysfs PMUs and tool PMU can have any name or
+		 * aren't wother optimizing for.
+		 */
+		unsigned int to_read_pmus =  PERF_TOOL_PMU_TYPE_PE_CORE_MASK |
+			PERF_TOOL_PMU_TYPE_PE_OTHER_MASK |
+			PERF_TOOL_PMU_TYPE_TOOL_MASK;
+
+		/*
+		 * Hwmon PMUs have an alias from a sysfs name like hwmon0,
+		 * hwmon1, etc. or have a name of hwmon_<name>. They therefore
+		 * can only have a wildcard match if the wildcard begins with
+		 * "hwmon".
+		 */
+		if (strisglob(wildcard) ||
+		    (strlen(wildcard) >= 5 && strncmp("hwmon", wildcard, 5) == 0))
+			to_read_pmus |= PERF_TOOL_PMU_TYPE_HWMON_MASK;
+
+		pmu_read_sysfs(to_read_pmus);
+		pmu = list_prepare_entry(pmu, &core_pmus, list);
+	}
+	if (use_core_pmus) {
+		list_for_each_entry_continue(pmu, &core_pmus, list) {
+			if (perf_pmu__wildcard_match(pmu, wildcard))
+				return pmu;
+		}
+		pmu = NULL;
+		pmu = list_prepare_entry(pmu, &other_pmus, list);
+	}
+	list_for_each_entry_continue(pmu, &other_pmus, list) {
+		if (perf_pmu__wildcard_match(pmu, wildcard))
+			return pmu;
+	}
+	return NULL;
+}
+
 static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 {
 	bool use_core_pmus = !pmu || pmu->is_core;
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 8def20e615ad..2794d8c3a466 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -19,6 +19,8 @@ struct perf_pmu *perf_pmus__find_by_type(unsigned int type);
 
 struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
+struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *event);
+struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const char *wildcard);
 
 const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
 
-- 
2.50.0.727.gbf7dc18ff4-goog

