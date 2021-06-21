Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B2FC4743C
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 15:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C3B60FE9
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 15:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhFUPHq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:07:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:58565 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhFUPHm (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Jun 2021 11:07:42 -0400
IronPort-SDR: 0yA6vWL11V6xSibA9j/qtRBqGDCHf4z3hPFMBaVH1tZw0dJZl4ulpu99wNkkcNaGAUtUvSdVKl
 KFFQfdLu+7Ug==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="193998961"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="193998961"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 08:05:27 -0700
IronPort-SDR: 4ctVNoP08vz7FbtzokVVCpedMsje9N9zb4X7XK6g1asnMT/16cRxecA3zNcm/2JlOCxMvXWUYc
 W4ge5uzFhnGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="486519595"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2021 08:05:24 -0700
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
Subject: [PATCH RFC 09/11] perf dlfilter: Add srcline() to perf_dlfilter_fns
Date:   Mon, 21 Jun 2021 18:05:12 +0300
Message-Id: <20210621150514.32159-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210621150514.32159-1-adrian.hunter@intel.com>
References: <20210621150514.32159-1-adrian.hunter@intel.com>
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
index 5ed64bbf084e..b6f958983584 100644
--- a/tools/perf/Documentation/perf-dlfilter.txt
+++ b/tools/perf/Documentation/perf-dlfilter.txt
@@ -111,7 +111,8 @@ struct perf_dlfilter_fns {
 	const struct perf_dlfilter_al *(*resolve_addr)(void *ctx);
 	__s32 (*resolve_address)(void *ctx, __u64 address, struct perf_dlfilter_al *al);
 	const __u8 *(*insn)(void *ctx, __u32 *length);
-	void *(*reserved[124])(void *);
+	const char *(*srcline)(void *ctx, __u32 *line_number);
+	void *(*reserved[123])(void *);
 };
 ----
 
@@ -124,6 +125,8 @@ before calling. Returns 0 on success, -1 otherwise.
 
 'insn' returns instruction bytes and length.
 
+'srcline' return source file name and line number.
+
 The perf_dlfilter_al structure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 375fb01bdeb8..d71b0c97d1eb 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -17,6 +17,7 @@
 #include "thread.h"
 #include "trace-event.h"
 #include "symbol.h"
+#include "srcline.h"
 #include "dlfilter.h"
 #include "perf_dlfilter.h"
 
@@ -190,11 +191,38 @@ static const __u8 *dlfilter__insn(void *ctx, __u32 *len)
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
 	.resolve_address = dlfilter__resolve_address,
 	.insn            = dlfilter__insn,
+	.srcline         = dlfilter__srcline,
 };
 
 #define CHECK_FLAG(x) BUILD_BUG_ON((u64)PERF_DLFILTER_FLAG_ ## x != (u64)PERF_IP_FLAG_ ## x)
diff --git a/tools/perf/util/perf_dlfilter.h b/tools/perf/util/perf_dlfilter.h
index 913b773af268..a91e314ba24a 100644
--- a/tools/perf/util/perf_dlfilter.h
+++ b/tools/perf/util/perf_dlfilter.h
@@ -97,8 +97,10 @@ struct perf_dlfilter_fns {
 	__s32 (*resolve_address)(void *ctx, __u64 address, struct perf_dlfilter_al *al);
 	/* Return instruction bytes and length */
 	const __u8 *(*insn)(void *ctx, __u32 *length);
+	/* Return source file name and line number */
+	const char *(*srcline)(void *ctx, __u32 *line_number);
 	/* Reserved */
-	void *(*reserved[124])(void *);
+	void *(*reserved[123])(void *);
 };
 
 /*
-- 
2.17.1

