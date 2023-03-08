Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41477C64EC4
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Mar 2023 08:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCHITa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Mar 2023 03:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjCHITI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Mar 2023 03:19:08 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1FBAF74D
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Mar 2023 00:18:57 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d7-20020a25adc7000000b00953ffdfbe1aso17249722ybe.23
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Mar 2023 00:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678263537;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Zi5p4CfxjslDfFVesFPJB5iL1V/LCfUtX6duyKxd8c=;
        b=YdAdLYcK8sWIVTwyTrqtRaR0SjJ9t8Q0EKD3edlPqX+FxA9MzgM6TZl6ceBNdgiQLr
         kSvt73qy5ImkjXyUHvd7rYBpwT6IqP3nFqaSAM6c8f4bu/fNU2RNrclF/0UbR5HLPwJk
         uGx9i5KdvGIMqsC4LcJAAJEhAtNP7ABrM6pa2zxLFp4s9LumMndYD4K9hM6sCEpNl7XL
         2ikQCmQBV2One9usFWx0yEgMZ3eqd0zzXM1WghkmON1pEExWdeqxPtFNHqGE66lpnSka
         vpdMbU5TPlLaIcQAfi/8+bBsHsLwuCQGMIq+Z2KHyRr6Cjmbt7QlKp2ukoB98EDvuFFs
         BogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263537;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Zi5p4CfxjslDfFVesFPJB5iL1V/LCfUtX6duyKxd8c=;
        b=iqW3l+Jl5wuwnAR5VMqXWnrrzj1pNkdhoYiC9H095bdG6feK7cSj4ZpYXJdGxrmi/O
         W4J4fkPUF67mNJXq942k1/K/gNoFCPyOMQPvU129k5nGtzM6CDmMCPy8y0Mzukft2CSW
         w/QlJubfw40VMl9HSoZ1Jf8pzZzb+qj0Z3Ntogl9L7uDkCK4WCwld+WZxrAwbUq/G2PI
         +/u6bGPPnLoaC86LvuYKgjL1TUTLlI9ICTMnf9fqnGZeoE5D+BQuG32EveS8+CIQyWCl
         3JuztW04ClXTrxsrCbHJnqvxQxIdAKri7cUNKV2fCHCkEtoQS0mtE3uJPxiBEDsM/tzN
         PrUA==
X-Gm-Message-State: AO0yUKXWf1lRdn9VRmXm6aW8OAfX2A3aScbzSDIWyreQ0A+MdXy8M9Dm
        YfDnMAMt3j/eoAolCkqcsv1gQQRxsCHV
X-Google-Smtp-Source: AK7set/qNl7v0DhqfD6Z5logJRcak5Yq2B6AAWQJB8MADi/RRnIgEzcYG7sfKvgy++dVM8wRwcRtoUNtjD4s
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9a99:fbc4:7488:8b5f])
 (user=irogers job=sendgmr) by 2002:a5b:688:0:b0:aa9:bd2e:3744 with SMTP id
 j8-20020a5b0688000000b00aa9bd2e3744mr8322221ybq.9.1678263536785; Wed, 08 Mar
 2023 00:18:56 -0800 (PST)
Date:   Wed,  8 Mar 2023 00:17:29 -0800
In-Reply-To: <20230308081731.1887278-1-irogers@google.com>
Message-Id: <20230308081731.1887278-10-irogers@google.com>
Mime-Version: 1.0
References: <20230308081731.1887278-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v3 09/11] perf evsel: Remove use_uncore_alias
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Qi Liu <liuqi115@huawei.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This flag used to be used when regrouping uncore events in particular
due to wildcard matches. This is now handled by sorting evlist and so
the flag is redundant.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c        |  1 -
 tools/perf/util/evsel.h        |  1 -
 tools/perf/util/parse-events.c | 12 +++---------
 tools/perf/util/parse-events.h |  3 +--
 tools/perf/util/parse-events.y | 11 +++++++----
 5 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 51d9650267d0..b9b05091bc8f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -458,7 +458,6 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->per_pkg = orig->per_pkg;
 	evsel->percore = orig->percore;
 	evsel->precise_max = orig->precise_max;
-	evsel->use_uncore_alias = orig->use_uncore_alias;
 	evsel->is_libpfm_event = orig->is_libpfm_event;
 
 	evsel->exclude_GH = orig->exclude_GH;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d26745ca6147..c272c06565c0 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -89,7 +89,6 @@ struct evsel {
 		bool			per_pkg;
 		bool			percore;
 		bool			precise_max;
-		bool			use_uncore_alias;
 		bool			is_libpfm_event;
 		bool			auto_merge_stats;
 		bool			collect_stat;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 394ab23089d0..93a90651266f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1445,15 +1445,13 @@ static int parse_events__inside_hybrid_pmu(struct parse_events_state *parse_stat
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *name,
 			 struct list_head *head_config,
-			 bool auto_merge_stats,
-			 bool use_alias)
+			 bool auto_merge_stats)
 {
 	struct perf_event_attr attr;
 	struct perf_pmu_info info;
 	struct perf_pmu *pmu;
 	struct evsel *evsel;
 	struct parse_events_error *err = parse_state->error;
-	bool use_uncore_alias;
 	LIST_HEAD(config_terms);
 
 	pmu = parse_state->fake_pmu ?: perf_pmu__find(name);
@@ -1488,8 +1486,6 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		memset(&attr, 0, sizeof(attr));
 	}
 
-	use_uncore_alias = (pmu->is_uncore && use_alias);
-
 	if (!head_config) {
 		attr.type = pmu->type;
 		evsel = __add_event(list, &parse_state->idx, &attr,
@@ -1499,7 +1495,6 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 				    /*cpu_list=*/NULL);
 		if (evsel) {
 			evsel->pmu_name = name ? strdup(name) : NULL;
-			evsel->use_uncore_alias = use_uncore_alias;
 			return 0;
 		} else {
 			return -ENOMEM;
@@ -1560,7 +1555,6 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		evsel->use_config_name = true;
 
 	evsel->pmu_name = name ? strdup(name) : NULL;
-	evsel->use_uncore_alias = use_uncore_alias;
 	evsel->percore = config_term_percore(&evsel->config_terms);
 
 	if (parse_state->fake_pmu)
@@ -1622,7 +1616,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 				parse_events_copy_term_list(head, &orig_head);
 				if (!parse_events_add_pmu(parse_state, list,
 							  pmu->name, orig_head,
-							  true, true)) {
+							  /*auto_merge_stats=*/true)) {
 					pr_debug("%s -> %s/%s/\n", str,
 						 pmu->name, alias->str);
 					ok++;
@@ -1634,7 +1628,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 	if (parse_state->fake_pmu) {
 		if (!parse_events_add_pmu(parse_state, list, str, head,
-					  true, true)) {
+					  /*auto_merge_stats=*/true)) {
 			pr_debug("%s -> %s/%s/\n", str, "fake_pmu", str);
 			ok++;
 		}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 22fc11b0bd59..fdac44dc696b 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -183,8 +183,7 @@ int parse_events_add_breakpoint(struct list_head *list, int *idx,
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *name,
 			 struct list_head *head_config,
-			 bool auto_merge_stats,
-			 bool use_alias);
+			 bool auto_merge_stats);
 
 struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
 				      const char *name, const char *metric_id,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 90d12f2bc8be..f1b153c72d67 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -313,7 +313,7 @@ event_pmu_name opt_pmu_config
 	list = alloc_list();
 	if (!list)
 		CLEANUP_YYABORT;
-	if (parse_events_add_pmu(_parse_state, list, $1, $2, false, false)) {
+	if (parse_events_add_pmu(_parse_state, list, $1, $2, /*auto_merge_stats=*/false)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;
 
@@ -330,8 +330,10 @@ event_pmu_name opt_pmu_config
 			    !perf_pmu__match(pattern, pmu->alias_name, $1)) {
 				if (parse_events_copy_term_list(orig_terms, &terms))
 					CLEANUP_YYABORT;
-				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
+				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms,
+							  /*auto_merge_stats=*/true)) {
 					ok++;
+				}
 				parse_events_terms__delete(terms);
 			}
 		}
@@ -407,7 +409,8 @@ PE_PMU_EVENT_FAKE sep_dc
 	if (!list)
 		YYABORT;
 
-	err = parse_events_add_pmu(_parse_state, list, $1, NULL, false, false);
+	err = parse_events_add_pmu(_parse_state, list, $1, /*head_config=*/NULL,
+				   /*auto_merge_stats=*/false);
 	free($1);
 	if (err < 0) {
 		free(list);
@@ -425,7 +428,7 @@ PE_PMU_EVENT_FAKE opt_pmu_config
 	if (!list)
 		YYABORT;
 
-	err = parse_events_add_pmu(_parse_state, list, $1, $2, false, false);
+	err = parse_events_add_pmu(_parse_state, list, $1, $2, /*auto_merge_stats=*/false);
 	free($1);
 	parse_events_terms__delete($2);
 	if (err < 0) {
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

