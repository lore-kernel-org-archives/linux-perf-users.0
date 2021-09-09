Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03014C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 06:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF76C61139
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 06:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352227AbhIIGVm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 02:21:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:54028 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244314AbhIIGVl (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 02:21:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="243004509"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="243004509"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 23:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="479489279"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga008.jf.intel.com with ESMTP; 08 Sep 2021 23:20:28 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf list: Display pmu prefix for partially supported hybrid cache events
Date:   Thu,  9 Sep 2021 14:18:44 +0800
Message-Id: <20210909061844.10221-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Part of hardware cache events are only available on one CPU PMU.
For example, 'L1-dcache-load-misses' is only available on cpu_core.
perf list should clearly report this info.

root@otcpl-adl-s-2:~# ./perf list

Before:
  L1-dcache-load-misses                              [Hardware cache event]
  L1-dcache-loads                                    [Hardware cache event]
  L1-dcache-stores                                   [Hardware cache event]
  L1-icache-load-misses                              [Hardware cache event]
  L1-icache-loads                                    [Hardware cache event]
  LLC-load-misses                                    [Hardware cache event]
  LLC-loads                                          [Hardware cache event]
  LLC-store-misses                                   [Hardware cache event]
  LLC-stores                                         [Hardware cache event]
  branch-load-misses                                 [Hardware cache event]
  branch-loads                                       [Hardware cache event]
  dTLB-load-misses                                   [Hardware cache event]
  dTLB-loads                                         [Hardware cache event]
  dTLB-store-misses                                  [Hardware cache event]
  dTLB-stores                                        [Hardware cache event]
  iTLB-load-misses                                   [Hardware cache event]
  node-load-misses                                   [Hardware cache event]
  node-loads                                         [Hardware cache event]
  node-store-misses                                  [Hardware cache event]
  node-stores                                        [Hardware cache event]

After:
  L1-dcache-loads                                    [Hardware cache event]
  L1-dcache-stores                                   [Hardware cache event]
  L1-icache-load-misses                              [Hardware cache event]
  LLC-load-misses                                    [Hardware cache event]
  LLC-loads                                          [Hardware cache event]
  LLC-store-misses                                   [Hardware cache event]
  LLC-stores                                         [Hardware cache event]
  branch-load-misses                                 [Hardware cache event]
  branch-loads                                       [Hardware cache event]
  cpu_atom/L1-icache-loads/                          [Hardware cache event]
  cpu_core/L1-dcache-load-misses/                    [Hardware cache event]
  cpu_core/node-load-misses/                         [Hardware cache event]
  cpu_core/node-loads/                               [Hardware cache event]
  dTLB-load-misses                                   [Hardware cache event]
  dTLB-loads                                         [Hardware cache event]
  dTLB-store-misses                                  [Hardware cache event]
  dTLB-stores                                        [Hardware cache event]
  iTLB-load-misses                                   [Hardware cache event]

Now we can clearly see 'L1-dcache-load-misses' is only available
on cpu_core.

If without pmu prefix, it indicates the event is available on both
cpu_core and cpu_atom.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/parse-events.c | 76 ++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e5eae23cfceb..579fd654cb11 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2704,7 +2704,7 @@ int is_valid_tracepoint(const char *event_string)
 	return 0;
 }
 
-static bool is_event_supported(u8 type, unsigned config)
+static bool is_event_supported(u8 type, u64 config)
 {
 	bool ret = true;
 	int open_return;
@@ -2824,10 +2824,18 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
 
 int print_hwcache_events(const char *event_glob, bool name_only)
 {
-	unsigned int type, op, i, evt_i = 0, evt_num = 0;
-	char name[64];
-	char **evt_list = NULL;
+	unsigned int type, op, i, evt_i = 0, evt_num = 0, npmus = 0;
+	char name[64], new_name[128];
+	char **evt_list = NULL, **evt_pmus = NULL;
 	bool evt_num_known = false;
+	struct perf_pmu *pmu = NULL;
+
+	if (perf_pmu__has_hybrid()) {
+		npmus = perf_pmu__hybrid_pmu_num();
+		evt_pmus = zalloc(sizeof(char *) * npmus);
+		if (!evt_pmus)
+			goto out_enomem;
+	}
 
 restart:
 	if (evt_num_known) {
@@ -2843,20 +2851,61 @@ int print_hwcache_events(const char *event_glob, bool name_only)
 				continue;
 
 			for (i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
+				unsigned int hybrid_supported = 0, j;
+				bool supported;
+
 				__evsel__hw_cache_type_op_res_name(type, op, i, name, sizeof(name));
 				if (event_glob != NULL && !strglobmatch(name, event_glob))
 					continue;
 
-				if (!is_event_supported(PERF_TYPE_HW_CACHE,
-							type | (op << 8) | (i << 16)))
-					continue;
+				if (!perf_pmu__has_hybrid()) {
+					if (!is_event_supported(PERF_TYPE_HW_CACHE,
+								type | (op << 8) | (i << 16))) {
+						continue;
+					}
+				} else {
+					perf_pmu__for_each_hybrid_pmu(pmu) {
+						if (!evt_num_known) {
+							evt_num++;
+							continue;
+						}
+
+						supported = is_event_supported(
+									PERF_TYPE_HW_CACHE,
+									type | (op << 8) | (i << 16) |
+									((__u64)pmu->type << PERF_PMU_TYPE_SHIFT));
+						if (supported) {
+							snprintf(new_name, sizeof(new_name), "%s/%s/",
+								 pmu->name, name);
+							evt_pmus[hybrid_supported] = strdup(new_name);
+							hybrid_supported++;
+						}
+					}
+
+					if (hybrid_supported == 0)
+						continue;
+				}
 
 				if (!evt_num_known) {
 					evt_num++;
 					continue;
 				}
 
-				evt_list[evt_i] = strdup(name);
+				if ((hybrid_supported == 0) ||
+				    (hybrid_supported == npmus)) {
+					evt_list[evt_i] = strdup(name);
+					if (npmus > 0) {
+						for (j = 0; j < npmus; j++)
+							zfree(&evt_pmus[j]);
+					}
+				} else {
+					for (j = 0; j < hybrid_supported; j++) {
+						evt_list[evt_i++] = evt_pmus[j];
+						evt_pmus[j] = NULL;
+					}
+					continue;
+				}
+
 				if (evt_list[evt_i] == NULL)
 					goto out_enomem;
 				evt_i++;
@@ -2868,6 +2917,13 @@ int print_hwcache_events(const char *event_glob, bool name_only)
 		evt_num_known = true;
 		goto restart;
 	}
+
+	for (evt_i = 0; evt_i < evt_num; evt_i++) {
+		if (!evt_list[evt_i])
+			break;
+	}
+
+	evt_num = evt_i;
 	qsort(evt_list, evt_num, sizeof(char *), cmp_string);
 	evt_i = 0;
 	while (evt_i < evt_num) {
@@ -2886,6 +2942,10 @@ int print_hwcache_events(const char *event_glob, bool name_only)
 	for (evt_i = 0; evt_i < evt_num; evt_i++)
 		zfree(&evt_list[evt_i]);
 	zfree(&evt_list);
+
+	for (evt_i = 0; evt_i < npmus; evt_i++)
+		zfree(&evt_pmus[evt_i]);
+	zfree(&evt_pmus);
 	return evt_num;
 
 out_enomem:
-- 
2.17.1

