Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68ED6C74A44
	for <linux-perf-users@archiver.kernel.org>; Sun, 12 Mar 2023 02:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCLCR7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Mar 2023 21:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjCLCRr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Mar 2023 21:17:47 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E34B567A2
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Mar 2023 18:17:21 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536a5a0b6e3so97724817b3.10
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Mar 2023 18:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678587440;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XftaVtT6DBaR6TmU1BfUjZFS2j5Dv53zloyEU1YN4Tc=;
        b=EBIRD4BvBs5N1uLmenNLq6Q0KHywSkUXNiV9JBr63KlvUkcScAgxamWWEGYgAqoQX8
         btnNSUTDtI5NTTsA6iuLtocZEOduFAA3ruNB1i5rHpdgYgz5FHADZx0r3qzCPciO9R1x
         YJGYVNIgh5VF/CnlfHmpxRweCFdfZwRudW5TUAcxFgi2tq0W6OVONJBiwP39ga3Pt3Qo
         HYB+p+B00hHpG2OF65oRzgnqeflOeLhCY9/KLKkwoVtnXKqaEFl5jxtL0mlvO5Ozr14I
         BXNSMFUiszBDbYbZtm06mweCd+UkxkM9rVQYprDrdx9CqvR5suuisKwR+wNrs2DCxsDb
         NXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678587440;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XftaVtT6DBaR6TmU1BfUjZFS2j5Dv53zloyEU1YN4Tc=;
        b=6tLaY7YpWDIfTRrUB+QJmVeT6C+OOONhrApWS1dhj+xEZ5IeipIcmN+gLzzzCeNJI+
         L21sBzAnSRKgTVR0pasaSNpCbmCyyWjlXTnPzl2fW1fph3+Hy9XB37Y0reMHqRbxZJGK
         t6YgkR82cgmpLSPsIPeElInhkCR8JuDQAx3Te+kGr/roxmNomg8E+pBs+ss+iFfpKxH8
         vQ1avHnFNHwdBKSNjuazcAqNMhHWUPDMKCNHB6erVaOBKUavxxdikXyUKpn5d9IN8XD2
         eK3hc/JIh9XQUNNpbHzniIvZxNTho+vndkqvtCVFLQn1o64uHkoD58fly5dp+b6or7hM
         6PNA==
X-Gm-Message-State: AO0yUKUVIA4WtYQsHE3t9qNMcHbXRDq+IOB8uHA01Zy27tI22VWS5Oyk
        p76KdSMhE6MMy1XpQclSSqlvZ1mfJNHp
X-Google-Smtp-Source: AK7set8mDjxcyITu3npZkWCgchptcXmCcdHmOK3V6cpZLYMuIA1g+7UeIT8WVkaT9+MW0Q1jvz2rE0VAZIjn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b42b:2e07:afb:877e])
 (user=irogers job=sendgmr) by 2002:a81:ac67:0:b0:541:753d:32f9 with SMTP id
 z39-20020a81ac67000000b00541753d32f9mr1633136ywj.9.1678587440627; Sat, 11 Mar
 2023 18:17:20 -0800 (PST)
Date:   Sat, 11 Mar 2023 18:15:43 -0800
In-Reply-To: <20230312021543.3060328-1-irogers@google.com>
Message-Id: <20230312021543.3060328-12-irogers@google.com>
Mime-Version: 1.0
References: <20230312021543.3060328-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 11/11] perf parse-events: Warn when events are regrouped
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

Use if an event is reordered or the number of groups increases to
signal that regrouping has happened and warn about it. Disable the
warning in the case wild card PMU names are used and for metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c |  2 +-
 tools/perf/tests/pmu-events.c   |  2 +-
 tools/perf/util/metricgroup.c   |  3 ++-
 tools/perf/util/parse-events.c  | 39 ++++++++++++++++++++++++---------
 tools/perf/util/parse-events.h  |  7 +++---
 tools/perf/util/parse-events.y  |  1 +
 6 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index ffa6f0a90741..b1c2f0a20306 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2103,7 +2103,7 @@ static int test_event_fake_pmu(const char *str)
 
 	parse_events_error__init(&err);
 	perf_pmu__test_parse_init();
-	ret = __parse_events(evlist, str, &err, &perf_pmu__fake);
+	ret = __parse_events(evlist, str, &err, &perf_pmu__fake, /*warn_if_reordered=*/true);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
 			 str, ret, err.str);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 6ccd413b5983..7f8e86452527 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -785,7 +785,7 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
 		 */
 		perf_pmu__test_parse_init();
 	}
-	ret = __parse_events(evlist, dup, error, fake_pmu);
+	ret = __parse_events(evlist, dup, error, fake_pmu, /*warn_if_reordered=*/true);
 	free(dup);
 
 	evlist__delete(evlist);
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index de6dd527a2ba..5783f4c2d1ef 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1441,7 +1441,8 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 	}
 	pr_debug("Parsing metric events '%s'\n", events.buf);
 	parse_events_error__init(&parse_error);
-	ret = __parse_events(parsed_evlist, events.buf, &parse_error, fake_pmu);
+	ret = __parse_events(parsed_evlist, events.buf, &parse_error, fake_pmu,
+			     /*warn_if_reordered=*/false);
 	if (ret) {
 		parse_events_error__print(&parse_error, events.buf);
 		goto err_out;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 9ec3c1dc81e0..3b2e5bb3e852 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2157,11 +2157,13 @@ static int evlist__cmp(void *state, const struct list_head *l, const struct list
 	return arch_evlist__cmp(lhs, rhs);
 }
 
-static void parse_events__sort_events_and_fix_groups(struct list_head *list)
+static bool parse_events__sort_events_and_fix_groups(struct list_head *list)
 {
-	int idx = -1;
+	int idx = 0, unsorted_idx = -1;
 	struct evsel *pos, *cur_leader = NULL;
 	struct perf_evsel *cur_leaders_grp = NULL;
+	bool idx_changed = false;
+	int orig_num_leaders = 0, num_leaders = 0;
 
 	/*
 	 * Compute index to insert ungrouped events at. Place them where the
@@ -2170,15 +2172,22 @@ static void parse_events__sort_events_and_fix_groups(struct list_head *list)
 	list_for_each_entry(pos, list, core.node) {
 		const struct evsel *pos_leader = evsel__leader(pos);
 
-		if (pos != pos_leader || pos->core.nr_members > 1)
-			continue;
+		if (pos == pos_leader)
+			orig_num_leaders++;
 
-		idx = pos->core.idx;
-		break;
+		/*
+		 * Ensure indexes are sequential, in particular for multiple
+		 * event lists being merged. The indexes are used to detect when
+		 * the user order is modified.
+		 */
+		pos->core.idx = idx++;
+
+		if (unsorted_idx == -1 && pos == pos_leader && pos->core.nr_members < 2)
+			unsorted_idx = pos->core.idx;
 	}
 
 	/* Sort events. */
-	list_sort(&idx, list, evlist__cmp);
+	list_sort(&unsorted_idx, list, evlist__cmp);
 
 	/*
 	 * Recompute groups, splitting for PMUs and adding groups for events
@@ -2192,6 +2201,8 @@ static void parse_events__sort_events_and_fix_groups(struct list_head *list)
 		bool force_grouped = arch_evsel__must_be_in_group(pos);
 
 		/* Reset index and nr_members. */
+		if (pos->core.idx != idx)
+			idx_changed = true;
 		pos->core.idx = idx++;
 		pos->core.nr_members = 0;
 
@@ -2225,12 +2236,18 @@ static void parse_events__sort_events_and_fix_groups(struct list_head *list)
 		}
 	}
 	list_for_each_entry(pos, list, core.node) {
-		pos->core.leader->nr_members++;
+		struct evsel *pos_leader = evsel__leader(pos);
+
+		if (pos == pos_leader)
+			num_leaders++;
+		pos_leader->core.nr_members++;
 	}
+	return idx_changed || num_leaders != orig_num_leaders;
 }
 
 int __parse_events(struct evlist *evlist, const char *str,
-		   struct parse_events_error *err, struct perf_pmu *fake_pmu)
+		   struct parse_events_error *err, struct perf_pmu *fake_pmu,
+		   bool warn_if_reordered)
 {
 	struct parse_events_state parse_state = {
 		.list	  = LIST_HEAD_INIT(parse_state.list),
@@ -2250,7 +2267,9 @@ int __parse_events(struct evlist *evlist, const char *str,
 		return -1;
 	}
 
-	parse_events__sort_events_and_fix_groups(&parse_state.list);
+	if (parse_events__sort_events_and_fix_groups(&parse_state.list) &&
+	    warn_if_reordered && !parse_state.wild_card_pmus)
+		pr_warning("WARNING: events were regrouped to match PMUs\n");
 
 	/*
 	 * Add list to the evlist even with errors to allow callers to clean up.
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 767ad1729228..46204c1a7916 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -26,13 +26,13 @@ int parse_events_option(const struct option *opt, const char *str, int unset);
 int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset);
 __attribute__((nonnull(1, 2, 3)))
 int __parse_events(struct evlist *evlist, const char *str, struct parse_events_error *error,
-		   struct perf_pmu *fake_pmu);
+		   struct perf_pmu *fake_pmu, bool warn_if_reordered);
 
-__attribute__((nonnull))
+__attribute__((nonnull(1, 2, 3)))
 static inline int parse_events(struct evlist *evlist, const char *str,
 			       struct parse_events_error *err)
 {
-	return __parse_events(evlist, str, err, NULL);
+	return __parse_events(evlist, str, err, /*fake_pmu=*/NULL, /*warn_if_reordered=*/true);
 }
 
 int parse_event(struct evlist *evlist, const char *str);
@@ -128,6 +128,7 @@ struct parse_events_state {
 	int			   stoken;
 	struct perf_pmu		  *fake_pmu;
 	char			  *hybrid_pmu_name;
+	bool			   wild_card_pmus;
 };
 
 void parse_events__shrink_config_terms(void);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 3a04602d2982..4488443e506e 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -323,6 +323,7 @@ event_pmu_name opt_pmu_config
 				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms,
 							  /*auto_merge_stats=*/true)) {
 					ok++;
+					parse_state->wild_card_pmus = true;
 				}
 				parse_events_terms__delete(terms);
 			}
-- 
2.40.0.rc1.284.g88254d51c5-goog

