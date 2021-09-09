Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD7AC4167E
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 06:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C9761101
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 06:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352540AbhIIGZS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 02:25:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:61778 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352517AbhIIGZQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 02:25:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="220727885"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="220727885"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 23:24:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="479491328"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga008.jf.intel.com with ESMTP; 08 Sep 2021 23:24:04 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf stat: Support --cputype option for hybrid events
Date:   Thu,  9 Sep 2021 14:22:15 +0800
Message-Id: <20210909062215.10278-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In previous patch, we have supported the syntax which enables
the event on a specified pmu, such as:

cpu_core/<event>/
cpu_atom/<event>/

While this syntax is not very easy for applying on a set of
events or applying on a group. In following example, we have to
explicitly assign the pmu prefix.

  # ./perf stat -e '{cpu_core/cycles/,cpu_core/instructions/}' -- sleep 1

   Performance counter stats for 'sleep 1':

           1,158,545      cpu_core/cycles/
           1,003,113      cpu_core/instructions/

         1.002428712 seconds time elapsed

A much easier way is:

  # ./perf stat --cputype core -e '{cycles,instructions}' -- sleep 1

   Performance counter stats for 'sleep 1':

           1,101,071      cpu_core/cycles/
             939,892      cpu_core/instructions/

         1.002363142 seconds time elapsed

For this example, the '--cputype' enables the events from specified
pmu (cpu_core).

If '--cputype' conflicts with pmu prefix, '--cputype' is ignored.

  # ./perf stat --cputype core -e cycles,cpu_atom/instructions/ -a -- sleep 1

   Performance counter stats for 'system wide':

          21,003,407      cpu_core/cycles/
             367,886      cpu_atom/instructions/

         1.002203520 seconds time elapsed

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt |  4 ++++
 tools/perf/builtin-stat.c              | 24 ++++++++++++++++++++++++
 tools/perf/util/evlist.h               |  1 +
 tools/perf/util/parse-events-hybrid.c  |  9 ++++++---
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 4c9310be6acc..33da737161a6 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -493,6 +493,10 @@ This option can be enabled in perf config by setting the variable
 
 $ perf config stat.no-csv-summary=true
 
+--cputype::
+Only enable events on applying cpu with this type for hybrid platform
+(e.g. core or atom)"
+
 EXAMPLES
 --------
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f6e87b7be5fa..752e2bf1029f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1168,6 +1168,26 @@ static int parse_stat_cgroups(const struct option *opt,
 	return parse_cgroups(opt, str, unset);
 }
 
+static int parse_hybrid_type(const struct option *opt,
+			     const char *str,
+			     int unset __maybe_unused)
+{
+	struct evlist *evlist = *(struct evlist **)opt->value;
+
+	if (!list_empty(&evlist->core.entries)) {
+		fprintf(stderr, "Must define cputype before events/metrics\n");
+		return -1;
+	}
+
+	evlist->hybrid_pmu_name = perf_pmu__hybrid_type_to_pmu(str);
+	if (!evlist->hybrid_pmu_name) {
+		fprintf(stderr, "--cputype %s is not supported!\n", str);
+		return -1;
+	}
+
+	return 0;
+}
+
 static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
@@ -1282,6 +1302,10 @@ static struct option stat_options[] = {
 		       "don't print 'summary' for CSV summary output"),
 	OPT_BOOLEAN(0, "quiet", &stat_config.quiet,
 			"don't print output (useful with record)"),
+	OPT_CALLBACK(0, "cputype", &evsel_list, "hybrid cpu type",
+		     "Only enable events on applying cpu with this type "
+		     "for hybrid platform (e.g. core or atom)",
+		     parse_hybrid_type),
 #ifdef HAVE_LIBPFM
 	OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
 		"libpfm4 event selector. use 'perf list' to list available events",
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 97bfb8d0be4f..7af5b247e319 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -64,6 +64,7 @@ struct evlist {
 	struct evsel *selected;
 	struct events_stats stats;
 	struct perf_env	*env;
+	const char *hybrid_pmu_name;
 	void (*trace_event_sample_raw)(struct evlist *evlist,
 				       union perf_event *event,
 				       struct perf_sample *sample);
diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
index 10160ab126f9..3875a8d086e4 100644
--- a/tools/perf/util/parse-events-hybrid.c
+++ b/tools/perf/util/parse-events-hybrid.c
@@ -62,10 +62,13 @@ static int create_event_hybrid(__u32 config_type, int *idx,
 static int pmu_cmp(struct parse_events_state *parse_state,
 		   struct perf_pmu *pmu)
 {
-	if (!parse_state->hybrid_pmu_name)
-		return 0;
+	if (parse_state->evlist && parse_state->evlist->hybrid_pmu_name)
+		return strcmp(parse_state->evlist->hybrid_pmu_name, pmu->name);
+
+	if (parse_state->hybrid_pmu_name)
+		return strcmp(parse_state->hybrid_pmu_name, pmu->name);
 
-	return strcmp(parse_state->hybrid_pmu_name, pmu->name);
+	return 0;
 }
 
 static int add_hw_hybrid(struct parse_events_state *parse_state,
-- 
2.17.1

