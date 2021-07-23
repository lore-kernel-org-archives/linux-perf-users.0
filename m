Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A72C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 06:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD0E160EE2
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 06:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbhGWFzr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 01:55:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:50829 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234058AbhGWFzk (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jul 2021 01:55:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="191412021"
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="191412021"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 23:36:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="455002309"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga007.jf.intel.com with ESMTP; 22 Jul 2021 23:36:11 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 3/3] perf tools: Enable on a list of CPUs for hybrid
Date:   Fri, 23 Jul 2021 14:34:33 +0800
Message-Id: <20210723063433.7318-4-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723063433.7318-1-yao.jin@linux.intel.com>
References: <20210723063433.7318-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The perf-record and perf-stat have supported the option '-C/--cpus'
to count or collect only on the list of CPUs provided. This option
needs to be supported for hybrid as well.

For hybrid support, it needs to check that the cpu list are available
on hybrid PMU. One example for AlderLake, cpu0-7 is 'cpu_core', cpu8-11
is 'cpu_atom'.

Before:

  # perf stat -e cpu_core/cycles/ -C11 -- sleep 1

   Performance counter stats for 'CPU(s) 11':

     <not supported>      cpu_core/cycles/

         1.006179431 seconds time elapsed

The perf-stat silently returned "<not supported>" without any helpful
information. It should error out that cpu11 was not 'cpu_core'.

After:

  # perf stat -e cpu_core/cycles/ -C11 -- sleep 1
  WARNING: 11 isn't a 'cpu_core', please use a CPU list in the 'cpu_core' range (0-7)
  failed to use cpu list 11

We also need to support the events without pmu prefix specified.

  # perf stat -e cycles -C11 -- sleep 1
  WARNING: 11 isn't a 'cpu_core', please use a CPU list in the 'cpu_core' range (0-7)

   Performance counter stats for 'CPU(s) 11':

           1,067,373      cpu_atom/cycles/

         1.005544738 seconds time elapsed

The perf tool creates two cycles events automatically, cpu_core/cycles/ and
cpu_atom/cycles/. It checks that cpu11 is not 'cpu_core', then shows a warning
for cpu_core/cycles/ and only count the cpu_atom/cycles/.

If part of cpus are 'cpu_core' and part of cpus are 'cpu_atom', for example,

  # perf stat -e cycles -C0,11 -- sleep 1
  WARNING: use 0 in 'cpu_core' for 'cycles', skip other cpus in list.
  WARNING: use 11 in 'cpu_atom' for 'cycles', skip other cpus in list.

   Performance counter stats for 'CPU(s) 0,11':

           1,914,704      cpu_core/cycles/
           2,036,983      cpu_atom/cycles/

         1.005815641 seconds time elapsed

It now automatically selects cpu0 for cpu_core/cycles/, selects cpu11 for
cpu_atom/cycles/, and output with some warnings.

Some more complex examples,

  # perf stat -e cycles,instructions -C0,11 -- sleep 1
  WARNING: use 0 in 'cpu_core' for 'cycles', skip other cpus in list.
  WARNING: use 11 in 'cpu_atom' for 'cycles', skip other cpus in list.
  WARNING: use 0 in 'cpu_core' for 'instructions', skip other cpus in list.
  WARNING: use 11 in 'cpu_atom' for 'instructions', skip other cpus in list.

   Performance counter stats for 'CPU(s) 0,11':

           2,780,387      cpu_core/cycles/
           1,583,432      cpu_atom/cycles/
           3,957,277      cpu_core/instructions/
           1,167,089      cpu_atom/instructions/

         1.006005124 seconds time elapsed

  # perf stat -e cycles,cpu_atom/instructions/ -C0,11 -- sleep 1
  WARNING: use 0 in 'cpu_core' for 'cycles', skip other cpus in list.
  WARNING: use 11 in 'cpu_atom' for 'cycles', skip other cpus in list.
  WARNING: use 11 in 'cpu_atom' for 'cpu_atom/instructions/', skip other cpus in list.

   Performance counter stats for 'CPU(s) 0,11':

           3,290,301      cpu_core/cycles/
           1,953,073      cpu_atom/cycles/
           1,407,869      cpu_atom/instructions/

         1.006260912 seconds time elapsed

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v4:
 - Rename evlist__use_cpu_list to evlist__fix_hybrid_cpus
 - Add comments to evlist__fix_hybrid_cpus.

v3:
 - Rebase to perf/core.
 - No functional change.

v2:
 - Automatically map to hybrid pmu.

 tools/perf/builtin-record.c     |  7 ++++
 tools/perf/builtin-stat.c       |  6 +++
 tools/perf/util/evlist-hybrid.c | 73 +++++++++++++++++++++++++++++++++
 tools/perf/util/evlist-hybrid.h |  1 +
 tools/perf/util/evlist.c        |  1 +
 tools/perf/util/pmu.c           | 35 ++++++++++++++++
 tools/perf/util/pmu.h           |  4 ++
 7 files changed, 127 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 671a21c9ee4d..4065bc8eba3c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2884,6 +2884,13 @@ int cmd_record(int argc, const char **argv)
 	/* Enable ignoring missing threads when -u/-p option is defined. */
 	rec->opts.ignore_missing_thread = rec->opts.target.uid != UINT_MAX || rec->opts.target.pid;
 
+	if (evlist__fix_hybrid_cpus(rec->evlist, rec->opts.target.cpu_list)) {
+		pr_err("failed to use cpu list %s\n",
+		       rec->opts.target.cpu_list);
+		goto out;
+	}
+
+	rec->opts.target.hybrid = perf_pmu__has_hybrid();
 	err = -ENOMEM;
 	if (evlist__create_maps(rec->evlist, &rec->opts.target) < 0)
 		usage_with_options(record_usage, record_options);
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d25cb8088e8c..8153468065ac 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2430,6 +2430,12 @@ int cmd_stat(int argc, const char **argv)
 	if ((stat_config.aggr_mode == AGGR_THREAD) && (target.system_wide))
 		target.per_thread = true;
 
+	if (evlist__fix_hybrid_cpus(evsel_list, target.cpu_list)) {
+		pr_err("failed to use cpu list %s\n", target.cpu_list);
+		goto out;
+	}
+
+	target.hybrid = perf_pmu__has_hybrid();
 	if (evlist__create_maps(evsel_list, &target) < 0) {
 		if (target__has_task(&target)) {
 			pr_err("Problems finding threads of monitor\n");
diff --git a/tools/perf/util/evlist-hybrid.c b/tools/perf/util/evlist-hybrid.c
index db3f5fbdebe1..7c554234b43d 100644
--- a/tools/perf/util/evlist-hybrid.c
+++ b/tools/perf/util/evlist-hybrid.c
@@ -86,3 +86,76 @@ bool evlist__has_hybrid(struct evlist *evlist)
 
 	return false;
 }
+
+int evlist__fix_hybrid_cpus(struct evlist *evlist, const char *cpu_list)
+{
+	struct perf_cpu_map *cpus;
+	struct evsel *evsel, *tmp;
+	struct perf_pmu *pmu;
+	int ret, unmatched_count = 0, events_nr = 0;
+
+	if (!perf_pmu__has_hybrid() || !cpu_list)
+		return 0;
+
+	cpus = perf_cpu_map__new(cpu_list);
+	if (!cpus)
+		return -1;
+
+	/*
+	 * The evsels are created with hybrid pmu's cpus. But now we
+	 * need to check and adjust the cpus of evsel by cpu_list because
+	 * cpu_list may cause conflicts with cpus of evsel. For example,
+	 * cpus of evsel is cpu0-7, but the cpu_list is cpu6-8, we need
+	 * to adjust the cpus of evsel to cpu6-7. And then propatate maps
+	 * in evlist__create_maps().
+	 */
+	evlist__for_each_entry_safe(evlist, tmp, evsel) {
+		struct perf_cpu_map *matched_cpus, *unmatched_cpus;
+		char buf1[128], buf2[128];
+
+		pmu = perf_pmu__find_hybrid_pmu(evsel->pmu_name);
+		if (!pmu)
+			continue;
+
+		ret = perf_pmu__cpus_match(pmu, cpus, &matched_cpus,
+					   &unmatched_cpus);
+		if (ret)
+			goto out;
+
+		events_nr++;
+
+		if (matched_cpus->nr > 0 && (unmatched_cpus->nr > 0 ||
+		    matched_cpus->nr < cpus->nr ||
+		    matched_cpus->nr < pmu->cpus->nr)) {
+			perf_cpu_map__put(evsel->core.cpus);
+			perf_cpu_map__put(evsel->core.own_cpus);
+			evsel->core.cpus = perf_cpu_map__get(matched_cpus);
+			evsel->core.own_cpus = perf_cpu_map__get(matched_cpus);
+
+			if (unmatched_cpus->nr > 0) {
+				cpu_map__snprint(matched_cpus, buf1, sizeof(buf1));
+				pr_warning("WARNING: use %s in '%s' for '%s', skip other cpus in list.\n",
+					   buf1, pmu->name, evsel->name);
+			}
+		}
+
+		if (matched_cpus->nr == 0) {
+			evlist__remove(evlist, evsel);
+			evsel__delete(evsel);
+
+			cpu_map__snprint(cpus, buf1, sizeof(buf1));
+			cpu_map__snprint(pmu->cpus, buf2, sizeof(buf2));
+			pr_warning("WARNING: %s isn't a '%s', please use a CPU list in the '%s' range (%s)\n",
+				   buf1, pmu->name, pmu->name, buf2);
+			unmatched_count++;
+		}
+
+		perf_cpu_map__put(matched_cpus);
+		perf_cpu_map__put(unmatched_cpus);
+	}
+
+	ret = (unmatched_count == events_nr) ? -1 : 0;
+out:
+	perf_cpu_map__put(cpus);
+	return ret;
+}
diff --git a/tools/perf/util/evlist-hybrid.h b/tools/perf/util/evlist-hybrid.h
index 19f74b4c340a..aacdb1b0f948 100644
--- a/tools/perf/util/evlist-hybrid.h
+++ b/tools/perf/util/evlist-hybrid.h
@@ -10,5 +10,6 @@
 int evlist__add_default_hybrid(struct evlist *evlist, bool precise);
 void evlist__warn_hybrid_group(struct evlist *evlist);
 bool evlist__has_hybrid(struct evlist *evlist);
+int evlist__fix_hybrid_cpus(struct evlist *evlist, const char *cpu_list);
 
 #endif /* __PERF_EVLIST_HYBRID_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 06f8890816c3..5f92319ce258 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -27,6 +27,7 @@
 #include "util/perf_api_probe.h"
 #include "util/evsel_fprintf.h"
 #include "util/evlist-hybrid.h"
+#include "util/pmu.h"
 #include <signal.h>
 #include <unistd.h>
 #include <sched.h>
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 44b90d638ad5..229cb975c5d7 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1906,3 +1906,38 @@ int perf_pmu__match(char *pattern, char *name, char *tok)
 
 	return 0;
 }
+
+int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
+			 struct perf_cpu_map **mcpus_ptr,
+			 struct perf_cpu_map **ucpus_ptr)
+{
+	struct perf_cpu_map *pmu_cpus = pmu->cpus;
+	struct perf_cpu_map *matched_cpus, *unmatched_cpus;
+	int matched_nr = 0, unmatched_nr = 0;
+
+	matched_cpus = perf_cpu_map__default_new();
+	if (!matched_cpus)
+		return -1;
+
+	unmatched_cpus = perf_cpu_map__default_new();
+	if (!unmatched_cpus) {
+		perf_cpu_map__put(matched_cpus);
+		return -1;
+	}
+
+	for (int i = 0; i < cpus->nr; i++) {
+		int cpu;
+
+		cpu = perf_cpu_map__idx(pmu_cpus, cpus->map[i]);
+		if (cpu == -1)
+			unmatched_cpus->map[unmatched_nr++] = cpus->map[i];
+		else
+			matched_cpus->map[matched_nr++] = cpus->map[i];
+	}
+
+	unmatched_cpus->nr = unmatched_nr;
+	matched_cpus->nr = matched_nr;
+	*mcpus_ptr = matched_cpus;
+	*ucpus_ptr = unmatched_cpus;
+	return 0;
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 926da483a141..e05ee1906f65 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -11,6 +11,7 @@
 #include "pmu-events/pmu-events.h"
 
 struct evsel_config_term;
+struct perf_cpu_map;
 
 enum {
 	PERF_PMU_FORMAT_VALUE_CONFIG,
@@ -135,4 +136,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 bool perf_pmu__has_hybrid(void);
 int perf_pmu__match(char *pattern, char *name, char *tok);
 
+int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
+			 struct perf_cpu_map **mcpus_ptr,
+			 struct perf_cpu_map **ucpus_ptr);
 #endif /* __PMU_H */
-- 
2.17.1

