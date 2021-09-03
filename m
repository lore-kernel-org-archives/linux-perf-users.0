Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B498C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Sep 2021 02:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A1860E0B
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Sep 2021 02:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbhICCz0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Sep 2021 22:55:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:65273 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230499AbhICCz0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Sep 2021 22:55:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="280322164"
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; 
   d="scan'208";a="280322164"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 19:54:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; 
   d="scan'208";a="500101861"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga008.fm.intel.com with ESMTP; 02 Sep 2021 19:54:23 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2] perf list: Display hybrid pmu events with cpu type
Date:   Fri,  3 Sep 2021 10:52:39 +0800
Message-Id: <20210903025239.22754-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a new option '--cputype' to perf-list to display core-only pmu events
or atom-only pmu events.

Each hybrid pmu event has been assigned with a pmu name, this patch
compares the pmu name before listing the result.

For example,

perf list --cputype atom
...
cache:
  core_reject_l2q.any
       [Counts the number of request that were not accepted into the L2Q because the L2Q is FULL. Unit: cpu_atom]
...

The "Unit: cpu_atom" is displayed in the brief description section
to indicate this is an atom event.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v2:
 - Rebase to perf/core branch.

 tools/perf/Documentation/perf-list.txt |  4 +++
 tools/perf/builtin-list.c              | 42 ++++++++++++++++++--------
 tools/perf/util/metricgroup.c          |  7 ++++-
 tools/perf/util/metricgroup.h          |  2 +-
 tools/perf/util/parse-events.c         |  8 +++--
 tools/perf/util/parse-events.h         |  3 +-
 tools/perf/util/pmu.c                  | 29 +++++++++++++++---
 tools/perf/util/pmu.h                  |  2 +-
 8 files changed, 73 insertions(+), 24 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 4c7db1da8fcc..4dc8d0af19df 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -39,6 +39,10 @@ any extra expressions computed by perf stat.
 --deprecated::
 Print deprecated events. By default the deprecated events are hidden.
 
+--cputype::
+Print events applying cpu with this type for hybrid platform
+(e.g. --cputype core or --cputype atom)
+
 [[EVENT_MODIFIERS]]
 EVENT MODIFIERS
 ---------------
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 10ab5e40a34f..468958154ed9 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -12,6 +12,7 @@
 
 #include "util/parse-events.h"
 #include "util/pmu.h"
+#include "util/pmu-hybrid.h"
 #include "util/debug.h"
 #include "util/metricgroup.h"
 #include <subcmd/pager.h>
@@ -20,13 +21,15 @@
 
 static bool desc_flag = true;
 static bool details_flag;
+static const char *hybrid_type;
 
 int cmd_list(int argc, const char **argv)
 {
-	int i;
+	int i, ret = 0;
 	bool raw_dump = false;
 	bool long_desc_flag = false;
 	bool deprecated = false;
+	char *pmu_name = NULL;
 	struct option list_options[] = {
 		OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
 		OPT_BOOLEAN('d', "desc", &desc_flag,
@@ -37,6 +40,9 @@ int cmd_list(int argc, const char **argv)
 			    "Print information on the perf event names and expressions used internally by events."),
 		OPT_BOOLEAN(0, "deprecated", &deprecated,
 			    "Print deprecated events."),
+		OPT_STRING(0, "cputype", &hybrid_type, "hybrid cpu type",
+			   "Print events applying cpu with this type for hybrid platform "
+			   "(e.g. core or atom)"),
 		OPT_INCR(0, "debug", &verbose,
 			     "Enable debugging output"),
 		OPT_END()
@@ -56,10 +62,16 @@ int cmd_list(int argc, const char **argv)
 	if (!raw_dump && pager_in_use())
 		printf("\nList of pre-defined events (to be used in -e):\n\n");
 
+	if (hybrid_type) {
+		pmu_name = perf_pmu__hybrid_type_to_pmu(hybrid_type);
+		if (!pmu_name)
+			pr_warning("WARNING: hybrid cputype is not supported!\n");
+	}
+
 	if (argc == 0) {
 		print_events(NULL, raw_dump, !desc_flag, long_desc_flag,
-				details_flag, deprecated);
-		return 0;
+				details_flag, deprecated, pmu_name);
+		goto out;
 	}
 
 	for (i = 0; i < argc; ++i) {
@@ -82,25 +94,27 @@ int cmd_list(int argc, const char **argv)
 		else if (strcmp(argv[i], "pmu") == 0)
 			print_pmu_events(NULL, raw_dump, !desc_flag,
 						long_desc_flag, details_flag,
-						deprecated);
+						deprecated, pmu_name);
 		else if (strcmp(argv[i], "sdt") == 0)
 			print_sdt_events(NULL, NULL, raw_dump);
 		else if (strcmp(argv[i], "metric") == 0 || strcmp(argv[i], "metrics") == 0)
-			metricgroup__print(true, false, NULL, raw_dump, details_flag);
+			metricgroup__print(true, false, NULL, raw_dump, details_flag, pmu_name);
 		else if (strcmp(argv[i], "metricgroup") == 0 || strcmp(argv[i], "metricgroups") == 0)
-			metricgroup__print(false, true, NULL, raw_dump, details_flag);
+			metricgroup__print(false, true, NULL, raw_dump, details_flag, pmu_name);
 		else if ((sep = strchr(argv[i], ':')) != NULL) {
 			int sep_idx;
 
 			sep_idx = sep - argv[i];
 			s = strdup(argv[i]);
-			if (s == NULL)
-				return -1;
+			if (s == NULL) {
+				ret = -1;
+				goto out;
+			}
 
 			s[sep_idx] = '\0';
 			print_tracepoint_events(s, s + sep_idx + 1, raw_dump);
 			print_sdt_events(s, s + sep_idx + 1, raw_dump);
-			metricgroup__print(true, true, s, raw_dump, details_flag);
+			metricgroup__print(true, true, s, raw_dump, details_flag, pmu_name);
 			free(s);
 		} else {
 			if (asprintf(&s, "*%s*", argv[i]) < 0) {
@@ -116,12 +130,16 @@ int cmd_list(int argc, const char **argv)
 			print_pmu_events(s, raw_dump, !desc_flag,
 						long_desc_flag,
 						details_flag,
-						deprecated);
+						deprecated,
+						pmu_name);
 			print_tracepoint_events(NULL, s, raw_dump);
 			print_sdt_events(NULL, s, raw_dump);
-			metricgroup__print(true, true, s, raw_dump, details_flag);
+			metricgroup__print(true, true, s, raw_dump, details_flag, pmu_name);
 			free(s);
 		}
 	}
-	return 0;
+
+out:
+	free(pmu_name);
+	return ret;
 }
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 99d047c5ead0..ad2587079689 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -11,6 +11,7 @@
 #include "evsel.h"
 #include "strbuf.h"
 #include "pmu.h"
+#include "pmu-hybrid.h"
 #include "expr.h"
 #include "rblist.h"
 #include <string.h>
@@ -616,7 +617,7 @@ static int metricgroup__print_sys_event_iter(struct pmu_event *pe, void *data)
 }
 
 void metricgroup__print(bool metrics, bool metricgroups, char *filter,
-			bool raw, bool details)
+			bool raw, bool details, const char *pmu_name)
 {
 	struct pmu_events_map *map = pmu_events_map__find();
 	struct pmu_event *pe;
@@ -642,6 +643,10 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 			break;
 		if (!pe->metric_expr)
 			continue;
+		if (pmu_name && perf_pmu__is_hybrid(pe->pmu) &&
+		    strcmp(pmu_name, pe->pmu)) {
+			continue;
+		}
 		if (metricgroup__print_pmu_event(pe, metricgroups, filter,
 						 raw, details, &groups,
 						 metriclist) < 0)
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index cc4a92492a61..9deee6691f2e 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -53,7 +53,7 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 				   struct rblist *metric_events);
 
 void metricgroup__print(bool metrics, bool groups, char *filter,
-			bool raw, bool details);
+			bool raw, bool details, const char *pmu_name);
 bool metricgroup__has_metric(const char *metric);
 int arch_get_runtimeparam(struct pmu_event *pe __maybe_unused);
 void metricgroup__rblist_exit(struct rblist *metric_events);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e5eae23cfceb..f36e748ad715 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2995,7 +2995,8 @@ void print_symbol_events(const char *event_glob, unsigned type,
  * Print the help text for the event symbols:
  */
 void print_events(const char *event_glob, bool name_only, bool quiet_flag,
-			bool long_desc, bool details_flag, bool deprecated)
+			bool long_desc, bool details_flag, bool deprecated,
+			const char *pmu_name)
 {
 	print_symbol_events(event_glob, PERF_TYPE_HARDWARE,
 			    event_symbols_hw, PERF_COUNT_HW_MAX, name_only);
@@ -3007,7 +3008,7 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag,
 	print_hwcache_events(event_glob, name_only);
 
 	print_pmu_events(event_glob, name_only, quiet_flag, long_desc,
-			details_flag, deprecated);
+			details_flag, deprecated, pmu_name);
 
 	if (event_glob != NULL)
 		return;
@@ -3033,7 +3034,8 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag,
 
 	print_sdt_events(NULL, NULL, name_only);
 
-	metricgroup__print(true, true, NULL, name_only, details_flag);
+	metricgroup__print(true, true, NULL, name_only, details_flag,
+			   pmu_name);
 
 	print_libpfm_events(name_only, long_desc);
 }
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index bf6e41aa9b6a..ce0c910163d1 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -219,7 +219,8 @@ void parse_events_evlist_error(struct parse_events_state *parse_state,
 			       int idx, const char *str);
 
 void print_events(const char *event_glob, bool name_only, bool quiet,
-		  bool long_desc, bool details_flag, bool deprecated);
+		  bool long_desc, bool details_flag, bool deprecated,
+		  const char *pmu_name);
 
 struct event_symbol {
 	const char	*symbol;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6cdbee8a12e7..77204c5af29c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1577,6 +1577,7 @@ static int cmp_sevent(const void *a, const void *b)
 {
 	const struct sevent *as = a;
 	const struct sevent *bs = b;
+	int ret;
 
 	/* Put extra events last */
 	if (!!as->desc != !!bs->desc)
@@ -1592,7 +1593,13 @@ static int cmp_sevent(const void *a, const void *b)
 	if (as->is_cpu != bs->is_cpu)
 		return bs->is_cpu - as->is_cpu;
 
-	return strcmp(as->name, bs->name);
+	ret = strcmp(as->name, bs->name);
+	if (!ret) {
+		if (as->pmu && bs->pmu)
+			return strcmp(as->pmu, bs->pmu);
+	}
+
+	return ret;
 }
 
 static void wordwrap(char *s, int start, int max, int corr)
@@ -1622,7 +1629,8 @@ bool is_pmu_core(const char *name)
 }
 
 void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
-			bool long_desc, bool details_flag, bool deprecated)
+			bool long_desc, bool details_flag, bool deprecated,
+			const char *pmu_name)
 {
 	struct perf_pmu *pmu;
 	struct perf_pmu_alias *alias;
@@ -1648,10 +1656,16 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 	pmu = NULL;
 	j = 0;
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (pmu_name && perf_pmu__is_hybrid(pmu->name) &&
+		    strcmp(pmu_name, pmu->name)) {
+			continue;
+		}
+
 		list_for_each_entry(alias, &pmu->aliases, list) {
 			char *name = alias->desc ? alias->name :
 				format_alias(buf, sizeof(buf), pmu, alias);
-			bool is_cpu = is_pmu_core(pmu->name);
+			bool is_cpu = is_pmu_core(pmu->name) ||
+				      perf_pmu__is_hybrid(pmu->name);
 
 			if (alias->deprecated && !deprecated)
 				continue;
@@ -1699,8 +1713,13 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 	qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
 	for (j = 0; j < len; j++) {
 		/* Skip duplicates */
-		if (j > 0 && !strcmp(aliases[j].name, aliases[j - 1].name))
-			continue;
+		if (j > 0 && !strcmp(aliases[j].name, aliases[j - 1].name)) {
+			if (!aliases[j].pmu || !aliases[j - 1].pmu ||
+			    !strcmp(aliases[j].pmu, aliases[j - 1].pmu)) {
+				continue;
+			}
+		}
+
 		if (name_only) {
 			printf("%s ", aliases[j].name);
 			continue;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 033e8211c025..91fc0de892f5 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -108,7 +108,7 @@ struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 bool is_pmu_core(const char *name);
 void print_pmu_events(const char *event_glob, bool name_only, bool quiet,
 		      bool long_desc, bool details_flag,
-		      bool deprecated);
+		      bool deprecated, const char *pmu_name);
 bool pmu_have_event(const char *pname, const char *name);
 
 int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt, ...) __scanf(3, 4);
-- 
2.27.0

