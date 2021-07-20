Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A72DC07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Jul 2021 08:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A77611F2
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Jul 2021 08:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhGTHmx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Jul 2021 03:42:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:51765 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231295AbhGTHm3 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Jul 2021 03:42:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="198469894"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="198469894"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 01:22:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="453985379"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga007.jf.intel.com with ESMTP; 20 Jul 2021 01:22:18 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        john.garry@huawei.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf pmu: Create x86 specific perf_pmu__valid_suffix
Date:   Tue, 20 Jul 2021 16:20:44 +0800
Message-Id: <20210720082044.5380-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The commit c47a5599eda3 ("perf tools: Fix pattern matching for same
substring in different PMU type") breaks arm64 system because it
assumes the first token must be followed by a '_', but it is
possibly a numeric on arm64.

For example, perf_pmu__valid_suffix("hisi_sccl3_l3c7", "hisi_sccl")
fails. "hisi_sccl3_l3c7" is pmu name and "hisi_sccl" is token.
"hisi_sccl" is followed by a digit but not followed by a '_'
('3' in this example).

Since the PMU alias format on arm64 has difference than the format
on x86. Create a x86 specific perf_pmu__valid_suffix. For other arch,
the weak function always returns true to keep original behavior
unchanged.

Fixes: c47a5599eda3 ("perf tools: Fix pattern matching for same substring in different PMU type")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reported-by: John Garry <john.garry@huawei.com>
---
 tools/perf/arch/x86/util/pmu.c | 22 ++++++++++++++++++++++
 tools/perf/util/pmu.c          | 27 ++++++---------------------
 tools/perf/util/pmu.h          |  1 +
 3 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index d48d608517fd..519da0811308 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -3,6 +3,7 @@
 
 #include <linux/stddef.h>
 #include <linux/perf_event.h>
+#include <linux/ctype.h>
 
 #include "../../../util/intel-pt.h"
 #include "../../../util/intel-bts.h"
@@ -18,3 +19,24 @@ struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __mayb
 #endif
 	return NULL;
 }
+
+bool perf_pmu__valid_suffix(char *pmu_name, char *tok)
+{
+	char *p;
+
+	if (strncmp(pmu_name, tok, strlen(tok)))
+		return false;
+
+	p = pmu_name + strlen(tok);
+	if (*p == 0)
+		return true;
+
+	if (*p != '_')
+		return false;
+
+	++p;
+	if (*p == 0 || !isdigit(*p))
+		return false;
+
+	return true;
+}
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 44b90d638ad5..a671b16f2d3e 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -742,27 +742,6 @@ struct pmu_events_map *__weak pmu_events_map__find(void)
 	return perf_pmu__find_map(NULL);
 }
 
-static bool perf_pmu__valid_suffix(char *pmu_name, char *tok)
-{
-	char *p;
-
-	if (strncmp(pmu_name, tok, strlen(tok)))
-		return false;
-
-	p = pmu_name + strlen(tok);
-	if (*p == 0)
-		return true;
-
-	if (*p != '_')
-		return false;
-
-	++p;
-	if (*p == 0 || !isdigit(*p))
-		return false;
-
-	return true;
-}
-
 bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 {
 	char *tmp = NULL, *tok, *str;
@@ -1906,3 +1885,9 @@ int perf_pmu__match(char *pattern, char *name, char *tok)
 
 	return 0;
 }
+
+bool __weak perf_pmu__valid_suffix(char *pmu_name __maybe_unused,
+				   char *tok __maybe_unused)
+{
+	return true;
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 926da483a141..901812987b79 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -134,5 +134,6 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 
 bool perf_pmu__has_hybrid(void);
 int perf_pmu__match(char *pattern, char *name, char *tok);
+bool perf_pmu__valid_suffix(char *pmu_name, char *tok);
 
 #endif /* __PMU_H */
-- 
2.17.1

