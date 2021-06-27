Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360A1C49EA6
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 13:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B5161C23
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 13:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhF0NUw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Jun 2021 09:20:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:60779 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231266AbhF0NUv (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Jun 2021 09:20:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="195137072"
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="195137072"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 06:18:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="640589084"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2021 06:18:23 -0700
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
Subject: [PATCH V2 08/10] perf dlfilter: Add srcline() to perf_dlfilter_fns
Date:   Sun, 27 Jun 2021 16:18:16 +0300
Message-Id: <20210627131818.810-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210627131818.810-1-adrian.hunter@intel.com>
References: <20210627131818.810-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a function, for use by dlfilters, to return source code file name and
line number.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-dlfilter.txt |  5 +++-
 tools/perf/util/dlfilter.c                 | 28 ++++++++++++++++++++++
 tools/perf/util/perf_dlfilter.h            |  4 +++-
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-dlfilter.txt b/tools/perf/Documentation/perf-dlfilter.txt
index bc4dba0995d8..df118ddcd7f4 100644
--- a/tools/perf/Documentation/perf-dlfilter.txt
+++ b/tools/perf/Documentation/perf-dlfilter.txt
@@ -125,7 +125,8 @@ struct perf_dlfilter_fns {
 	char **(*args)(void *ctx, int *dlargc);
 	__s32 (*resolve_address)(void *ctx, __u64 address, struct perf_dlfilter_al *al);
 	const __u8 *(*insn)(void *ctx, __u32 *length);
-	void *(*reserved[123])(void *);
+	const char *(*srcline)(void *ctx, __u32 *line_number);
+	void *(*reserved[122])(void *);
 };
 ----
 
@@ -140,6 +141,8 @@ before calling. Returns 0 on success, -1 otherwise.
 
 'insn' returns instruction bytes and length.
 
+'srcline' return source file name and line number.
+
 The perf_dlfilter_al structure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 79a899255c01..f4ce1a80bddc 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -19,6 +19,7 @@
 #include "thread.h"
 #include "trace-event.h"
 #include "symbol.h"
+#include "srcline.h"
 #include "dlfilter.h"
 #include "perf_dlfilter.h"
 
@@ -208,12 +209,39 @@ static const __u8 *dlfilter__insn(void *ctx, __u32 *len)
 	return (__u8 *)d->sample->insn;
 }
 
+static const char *dlfilter__srcline(void *ctx, __u32 *line_no)
+{
+	struct dlfilter *d = (struct dlfilter *)ctx;
+	struct addr_location *al;
+	unsigned int line = 0;
+	char *srcfile = NULL;
+	struct map *map;
+	u64 addr;
+
+	if (!d->ctx_valid || !line_no)
+		return NULL;
+
+	al = get_al(d);
+	if (!al)
+		return NULL;
+
+	map = al->map;
+	addr = al->addr;
+
+	if (map && map->dso)
+		srcfile = get_srcline_split(map->dso, map__rip_2objdump(map, addr), &line);
+
+	*line_no = line;
+	return srcfile;
+}
+
 static const struct perf_dlfilter_fns perf_dlfilter_fns = {
 	.resolve_ip      = dlfilter__resolve_ip,
 	.resolve_addr    = dlfilter__resolve_addr,
 	.args            = dlfilter__args,
 	.resolve_address = dlfilter__resolve_address,
 	.insn            = dlfilter__insn,
+	.srcline         = dlfilter__srcline,
 };
 
 static char *find_dlfilter(const char *file)
diff --git a/tools/perf/util/perf_dlfilter.h b/tools/perf/util/perf_dlfilter.h
index 763c5af3c5f7..b989918056e2 100644
--- a/tools/perf/util/perf_dlfilter.h
+++ b/tools/perf/util/perf_dlfilter.h
@@ -99,8 +99,10 @@ struct perf_dlfilter_fns {
 	__s32 (*resolve_address)(void *ctx, __u64 address, struct perf_dlfilter_al *al);
 	/* Return instruction bytes and length */
 	const __u8 *(*insn)(void *ctx, __u32 *length);
+	/* Return source file name and line number */
+	const char *(*srcline)(void *ctx, __u32 *line_number);
 	/* Reserved */
-	void *(*reserved[123])(void *);
+	void *(*reserved[122])(void *);
 };
 
 /*
-- 
2.17.1

