Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3B8C678D5
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Mar 2023 23:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCHXBi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Mar 2023 18:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCHXAy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Mar 2023 18:00:54 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11991D462A
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Mar 2023 15:00:30 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5395c8fc4a1so818627b3.5
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Mar 2023 15:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678316429;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Zi5p4CfxjslDfFVesFPJB5iL1V/LCfUtX6duyKxd8c=;
        b=LjXnz6DYYHiDu0X6k350blzWWPP29FXBN3YNRMvopF8r7Lc7RlcvqEpNQvK9vITACB
         9x2gwhIxO26Emxvg3atH7tRzm1RW9pN+P6hFR6ql1IaCfQQIwtQkFDn3E0iL01sTpoAS
         g0CdUR15/KIPqui4Zo6azyn2S95kAWNJlejhOld9CRFHApmT1taz3jvmKx8Af4goarhl
         z5anuYxdnOZmri52Y2IYS3zn2hEU/0rDF4RzzfqLOsNpA9I6o22Wo23VmQ3BAgmCv8uP
         91kguIs5EmjxYORgf7QlC1eBsLbfd7uzhaQCG4dzdvAhNZLpCLsAPPD4rJOeJnFYWD/V
         pKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316429;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Zi5p4CfxjslDfFVesFPJB5iL1V/LCfUtX6duyKxd8c=;
        b=jvNMsDMe9jotQZRpfJRcED9AxOkBJc06gR5U5tE9VBq1E1JLu8P6exNRwi4L3Te+CB
         i7nZqVNufZg9k+ZX1QSPznxW4dyGGrMbdxW4p/asSbh16wTbX3pnq8kfZ59Him/JN9mN
         i4aI7J7d9pwuDtb9f5bU1aBn+3Wsn0H8WNBPeJg9OCfinMXDyhalOluuB8FYy9t05tFN
         TxxmLEDrZTZaQg/wJSurTW1Kw4oUqHyVwr7JLfv3tlujpDDdrjrrVVryW+bHrhyYOdeF
         a2/gYULu5lEIPD7w7tDaxQuS/UaomG3sBvbd9p24mfciZSdaE2Ih2LfDyDlmk0Fffjv9
         d3IQ==
X-Gm-Message-State: AO0yUKWlIZrg1a6EeFq5QcA/FKO1VV4MW7/2gs3FpZ4ExdgE4hWtwGcI
        URo6pV3Euy3C5tdw6+IDDZ+B561VAt+z
X-Google-Smtp-Source: AK7set9EAMRcO6EQABbsrZnAAr3aWdINgPuBSnKn8f+TXd/wUXacuEkvrwzZBuIX68FKX33eJuE2Rgs0CsVi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5292:ba14:c261:246a])
 (user=irogers job=sendgmr) by 2002:a0d:c903:0:b0:514:dae0:21ef with SMTP id
 l3-20020a0dc903000000b00514dae021efmr1ywd.133.1678316428741; Wed, 08 Mar 2023
 15:00:28 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:59:10 -0800
In-Reply-To: <20230308225912.1960990-1-irogers@google.com>
Message-Id: <20230308225912.1960990-10-irogers@google.com>
Mime-Version: 1.0
References: <20230308225912.1960990-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v4 09/11] perf evsel: Remove use_uncore_alias
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

