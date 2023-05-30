Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9DCC7EE24
	for <linux-perf-users@archiver.kernel.org>; Tue, 30 May 2023 23:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjE3X1k (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 30 May 2023 19:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjE3X1j (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 May 2023 19:27:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D7DB2
        for <linux-perf-users@vger.kernel.org>; Tue, 30 May 2023 16:27:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8337a578dso5854554276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 30 May 2023 16:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685489255; x=1688081255;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cJuTC9DxBW82caH0GcepkvAjPrpGnpz/bsWipDc0UKQ=;
        b=2WtcYSIa5JCiR+liVu9oe5hCQpHVwKYrsRig5qd9iUUjJJEteSNtw6YXlDqPtEGr+G
         bkPAxeRMIYSWOc9ZfUGzTy2P8i/2z8fP6shuGN8G7eO8lBeJMx9IbsNP3jG2JEyXmmgL
         qNTyIhL3sYmRXGOx9/zfzUB3P+K/48kL0IIqvzaBqZDgruB7Ak2Ng8cHgij1Uyh73oF/
         KTtYZ3tTEC9zXRF6gs6h3/2oZWtloTQTfKaWjyn6WTyKc2YG1n2M028tG42rVwWVSm33
         oKTtGdS9BZB8uy06fhVx2rIN0jUYOkd9J3g81aTX7LW3g3ACX5I1MM9O01RACUObP4nL
         4vlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685489255; x=1688081255;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJuTC9DxBW82caH0GcepkvAjPrpGnpz/bsWipDc0UKQ=;
        b=gyet6MCkVPm3l9JfcAAkwSEu+gQ0X0QmCKKrCrY8DgLA7if8nacTtRsW1M241XOdgq
         /FPDBYLNfkN6WAYOCS49pcEzpJ/tvFmvpFIIG9lezVCA1cL8V4vofC799uPpoTVGnyoh
         3z3mRvjxQrqHrG9IjWioOSY5kjgtjjU5IxpGKhtWiqU3dN33c47nzmKIDZM+9nqL1oI9
         xlTxae7V4SMYF5DSdd8wCVRnPnakOZstD52coMv2IyRkLLpPt87hsnuXr07/myXYjZht
         B4gXNe/1i7A9q97QcjUKfJbic7LsBhBJR0v2uKXFZHeVRcJt9sh36vSUUVZnbhBd141n
         aQLw==
X-Gm-Message-State: AC+VfDw199nHQLzPrRYklQ900TQ277DvqlmPC75Yb1CdKnPQZVDsfs4R
        rKJNnkBR0l4JT1hGzAW6+8y2us6/Eijj
X-Google-Smtp-Source: ACHHUZ6mpXBzGx/RWGH9G0a3GcJ01iDMFxGChEI8Tsr2tgPIX9kgrokiwxTJn+2ShnWUnJ5Uk8zB9Rw/ETUN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:da6e:5e97:22c7:d7b5])
 (user=irogers job=sendgmr) by 2002:a25:547:0:b0:ba8:2415:f27c with SMTP id
 68-20020a250547000000b00ba82415f27cmr2223918ybf.3.1685489255756; Tue, 30 May
 2023 16:27:35 -0700 (PDT)
Date:   Tue, 30 May 2023 16:27:30 -0700
Message-Id: <20230530232730.155084-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1] perf parse-events: Wildcard most "numeric" events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Numeric events are either raw events or those with ABI defined numbers
matched by the lexer. All raw events that don't specify a PMU type
should wildcard match on hybrid systems. So "cycles" should match each
PMU type with an extended type, not just PERF_TYPE_HARDWARE.

Change wildcard matching to add the event if wildcard PMU scanning
fails, there will be no extended type but this best matches previous
behavior.

Only set the extended type when the event type supports it and when
perf_pmus__supports_extended_type is true. This new function returns
true if >1 core PMU and avoids potential errors on older kernels.

Try to always pass a PMU for parse_events_add_numeric, update
evsel__compute_group_pmu_name as software events will have a PMU and
pmu_name rather than NULL. This makes homogeneous and heterogeneous
PMU events more similar.

Set a parse events error if a hardware term's PMU lookup fails to
provide extra diagnostics.

Reported-by: Kan Liang <kan.liang@linux.intel.com>
Fixes: 8bc75f699c14 ("perf parse-events: Support wildcards on raw events")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 71 +++++++++++++++++++++-------------
 tools/perf/util/parse-events.y |  4 +-
 tools/perf/util/pmus.c         |  5 +++
 tools/perf/util/pmus.h         |  1 +
 4 files changed, 53 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7f047ac11168..58c9f34bcd95 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -372,7 +372,7 @@ static int config_attr(struct perf_event_attr *attr,
  *                                     contain hyphens and the longest name
  *                                     should always be selected.
  */
-int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u64 *config)
+int parse_events__decode_legacy_cache(const char *name, int extended_pmu_type, __u64 *config)
 {
 	int len, cache_type = -1, cache_op = -1, cache_result = -1;
 	const char *name_end = &name[strlen(name) + 1];
@@ -423,8 +423,9 @@ int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u64 *con
 	if (cache_result == -1)
 		cache_result = PERF_COUNT_HW_CACHE_RESULT_ACCESS;
 
-	*config = ((__u64)pmu_type << PERF_PMU_TYPE_SHIFT) |
-		cache_type | (cache_op << 8) | (cache_result << 16);
+	*config = cache_type | (cache_op << 8) | (cache_result << 16);
+	if (perf_pmus__supports_extended_type())
+		*config |= (__u64)extended_pmu_type << PERF_PMU_TYPE_SHIFT;
 	return 0;
 }
 
@@ -1204,11 +1205,17 @@ static int config_term_pmu(struct perf_event_attr *attr,
 		const struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
 
 		if (!pmu) {
-			pr_debug("Failed to find PMU for type %d", attr->type);
+			char *err_str;
+
+			if (asprintf(&err_str, "Failed to find PMU for type %d", attr->type) >= 0)
+				parse_events_error__handle(err, term->err_term,
+							   err_str, /*help=*/NULL);
 			return -EINVAL;
 		}
 		attr->type = PERF_TYPE_HARDWARE;
-		attr->config = ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT) | term->val.num;
+		attr->config = term->val.num;
+		if (perf_pmus__supports_extended_type())
+			attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
 		return 0;
 	}
 	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER ||
@@ -1435,8 +1442,8 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
 
 static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 				struct list_head *list,
-				struct perf_pmu *pmu, u32 type, u64 config,
-				struct list_head *head_config)
+				struct perf_pmu *pmu, u32 type, u32 extended_type,
+				u64 config, struct list_head *head_config)
 {
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
@@ -1446,6 +1453,10 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 	memset(&attr, 0, sizeof(attr));
 	attr.type = type;
 	attr.config = config;
+	if (extended_type && (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)) {
+		assert(perf_pmus__supports_extended_type());
+		attr.config |= (u64)extended_type << PERF_PMU_TYPE_SHIFT;
+	};
 
 	if (head_config) {
 		if (config_attr(&attr, head_config, parse_state->error,
@@ -1474,24 +1485,26 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 	struct perf_pmu *pmu = NULL;
 	bool found_supported = false;
 
-	if (!wildcard)
-		return __parse_events_add_numeric(parse_state, list, /*pmu=*/NULL,
-						  type, config, head_config);
-
 	/* Wildcards on numeric values are only supported by core PMUs. */
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
-		int ret;
+	if (wildcard && perf_pmus__supports_extended_type()) {
+		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+			int ret;
 
-		if (parse_events__filter_pmu(parse_state, pmu))
-			continue;
+			found_supported = true;
+			if (parse_events__filter_pmu(parse_state, pmu))
+				continue;
 
-		found_supported = true;
-		ret = __parse_events_add_numeric(parse_state, list, pmu, pmu->type,
-						 config, head_config);
-		if (ret)
-			return ret;
+			ret = __parse_events_add_numeric(parse_state, list, pmu,
+							 type, pmu->type,
+							 config, head_config);
+			if (ret)
+				return ret;
+		}
+		if (found_supported)
+			return 0;
 	}
-	return found_supported ? 0 : -EINVAL;
+	return __parse_events_add_numeric(parse_state, list, perf_pmus__find_by_type(type),
+					type, /*extended_type=*/0, config, head_config);
 }
 
 int parse_events_add_tool(struct parse_events_state *parse_state,
@@ -1989,7 +2002,10 @@ static int evsel__compute_group_pmu_name(struct evsel *evsel,
 {
 	struct evsel *leader = evsel__leader(evsel);
 	struct evsel *pos;
-	const char *group_pmu_name = evsel->pmu_name ?: "cpu";
+	const char *group_pmu_name = "cpu";
+
+	if (evsel->core.attr.type != PERF_TYPE_SOFTWARE && evsel->pmu_name)
+		group_pmu_name = evsel->pmu_name;
 
 	/*
 	 * Software events may be in a group with other uncore PMU events. Use
@@ -2002,14 +2018,17 @@ static int evsel__compute_group_pmu_name(struct evsel *evsel,
 	if (evsel->core.attr.type == PERF_TYPE_SOFTWARE || evsel__is_aux_event(leader)) {
 		/*
 		 * Starting with the leader, find the first event with a named
-		 * PMU. for_each_group_(member|evsel) isn't used as the list
-		 * isn't yet sorted putting evsel's in the same group together.
+		 * non-software PMU. for_each_group_(member|evsel) isn't used as
+		 * the list isn't yet sorted putting evsel's in the same group
+		 * together.
 		 */
-		if (leader->pmu_name) {
+		if (leader->pmu_name && leader->core.attr.type != PERF_TYPE_SOFTWARE) {
 			group_pmu_name = leader->pmu_name;
 		} else if (leader->core.nr_members > 1) {
 			list_for_each_entry(pos, head, core.node) {
-				if (evsel__leader(pos) == leader && pos->pmu_name) {
+				if (evsel__leader(pos) == leader &&
+				    pos->core.attr.type != PERF_TYPE_SOFTWARE &&
+				    pos->pmu_name) {
 					group_pmu_name = pos->pmu_name;
 					break;
 				}
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index abd6ab460e12..48c21314cf6b 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -449,7 +449,7 @@ value_sym '/' event_config '/'
 	list = alloc_list();
 	ABORT_ON(!list);
 	err = parse_events_add_numeric(_parse_state, list, type, config, $3,
-				       /*wildcard=*/false);
+				       /*wildcard=*/true);
 	parse_events_terms__delete($3);
 	if (err) {
 		free_list_evsel(list);
@@ -468,7 +468,7 @@ value_sym sep_slash_slash_dc
 	ABORT_ON(!list);
 	ABORT_ON(parse_events_add_numeric(_parse_state, list, type, config,
 					  /*head_config=*/NULL,
-					  /*wildcard=*/false));
+					  /*wildcard=*/true));
 	$$ = list;
 }
 |
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 53f11f6ce878..e1d0a93147e5 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -477,6 +477,11 @@ int perf_pmus__num_core_pmus(void)
 	return count;
 }
 
+bool perf_pmus__supports_extended_type(void)
+{
+	return perf_pmus__num_core_pmus() > 1;
+}
+
 struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 {
 	struct perf_pmu *pmu = evsel->pmu;
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 1e710720aec7..d02ffea5d3a4 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -19,5 +19,6 @@ int perf_pmus__num_mem_pmus(void);
 void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *print_state);
 bool perf_pmus__have_event(const char *pname, const char *name);
 int perf_pmus__num_core_pmus(void);
+bool perf_pmus__supports_extended_type(void);
 
 #endif /* __PMUS_H */
-- 
2.41.0.rc0.172.g3f132b7071-goog

