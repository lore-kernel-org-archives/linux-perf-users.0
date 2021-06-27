Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78663C49EAF
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 13:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6148461C49
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 13:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhF0NUt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Jun 2021 09:20:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:60751 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231251AbhF0NUs (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Jun 2021 09:20:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="195137069"
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="195137069"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 06:18:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="640589067"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2021 06:18:20 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 07/10] perf dlfilter: Add insn() to perf_dlfilter_fns
Date:   Sun, 27 Jun 2021 16:18:15 +0300
Message-Id: <20210627131818.810-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210627131818.810-1-adrian.hunter@intel.com>
References: <20210627131818.810-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a function, for use by dlfilters, to return instruction bytes.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-dlfilter.txt |  5 +++-
 tools/perf/util/dlfilter.c                 | 32 ++++++++++++++++++++++
 tools/perf/util/perf_dlfilter.h            |  4 ++-
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-dlfilter.txt b/tools/perf/Documentation/perf-dlfilter.txt
index 642323ac8934..bc4dba0995d8 100644
--- a/tools/perf/Documentation/perf-dlfilter.txt
+++ b/tools/perf/Documentation/perf-dlfilter.txt
@@ -124,7 +124,8 @@ struct perf_dlfilter_fns {
 	const struct perf_dlfilter_al *(*resolve_addr)(void *ctx);
 	char **(*args)(void *ctx, int *dlargc);
 	__s32 (*resolve_address)(void *ctx, __u64 address, struct perf_dlfilter_al *al);
-	void *(*reserved[124])(void *);
+	const __u8 *(*insn)(void *ctx, __u32 *length);
+	void *(*reserved[123])(void *);
 };
 ----
 
@@ -137,6 +138,8 @@ struct perf_dlfilter_fns {
 'resolve_address' provides information about 'address'. al->size must be set
 before calling. Returns 0 on success, -1 otherwise.
 
+'insn' returns instruction bytes and length.
+
 The perf_dlfilter_al structure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 4b03227541d3..79a899255c01 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -17,6 +17,7 @@
 #include "dso.h"
 #include "map.h"
 #include "thread.h"
+#include "trace-event.h"
 #include "symbol.h"
 #include "dlfilter.h"
 #include "perf_dlfilter.h"
@@ -177,11 +178,42 @@ static __s32 dlfilter__resolve_address(void *ctx, __u64 address, struct perf_dlf
 	return 0;
 }
 
+static const __u8 *dlfilter__insn(void *ctx, __u32 *len)
+{
+	struct dlfilter *d = (struct dlfilter *)ctx;
+
+	if (!len)
+		return NULL;
+
+	*len = 0;
+
+	if (!d->ctx_valid)
+		return NULL;
+
+	if (d->sample->ip && !d->sample->insn_len) {
+		struct addr_location *al = d->al;
+
+		if (!al->thread && machine__resolve(d->machine, al, d->sample) < 0)
+			return NULL;
+
+		if (al->thread->maps && al->thread->maps->machine)
+			script_fetch_insn(d->sample, al->thread, al->thread->maps->machine);
+	}
+
+	if (!d->sample->insn_len)
+		return NULL;
+
+	*len = d->sample->insn_len;
+
+	return (__u8 *)d->sample->insn;
+}
+
 static const struct perf_dlfilter_fns perf_dlfilter_fns = {
 	.resolve_ip      = dlfilter__resolve_ip,
 	.resolve_addr    = dlfilter__resolve_addr,
 	.args            = dlfilter__args,
 	.resolve_address = dlfilter__resolve_address,
+	.insn            = dlfilter__insn,
 };
 
 static char *find_dlfilter(const char *file)
diff --git a/tools/perf/util/perf_dlfilter.h b/tools/perf/util/perf_dlfilter.h
index dfd0f8482824..763c5af3c5f7 100644
--- a/tools/perf/util/perf_dlfilter.h
+++ b/tools/perf/util/perf_dlfilter.h
@@ -97,8 +97,10 @@ struct perf_dlfilter_fns {
 	 * calling). Returns 0 on success, -1 otherwise.
 	 */
 	__s32 (*resolve_address)(void *ctx, __u64 address, struct perf_dlfilter_al *al);
+	/* Return instruction bytes and length */
+	const __u8 *(*insn)(void *ctx, __u32 *length);
 	/* Reserved */
-	void *(*reserved[124])(void *);
+	void *(*reserved[123])(void *);
 };
 
 /*
-- 
2.17.1

