Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9070FC49EA2
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 15:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76BBE6023F
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 15:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhFUPH6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:07:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:58565 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230415AbhFUPHt (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Jun 2021 11:07:49 -0400
IronPort-SDR: CjkkuN2gTWPWHiIC5HJL0OeZiEX+ueGv8ynerseJ6SbTkJozREbkht/ZtdqpWGs1VXcwQ2P7dw
 pw71D62BRX3A==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="193998980"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="193998980"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 08:05:32 -0700
IronPort-SDR: QH7i4VVc90f+kFksP5jG3tQmO8qAnOY81IiV0ns4yDzX9mIFFZ8gZG1y9ozzMxrrjj2nzdXtSe
 2zw3MG4fpqDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="486519609"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2021 08:05:27 -0700
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
Subject: [PATCH RFC 10/11] perf dlfilter: Add attr() to perf_dlfilter_fns
Date:   Mon, 21 Jun 2021 18:05:13 +0300
Message-Id: <20210621150514.32159-11-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210621150514.32159-1-adrian.hunter@intel.com>
References: <20210621150514.32159-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a function, for use by dlfilters, to return the perf_event_attr
structure.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-dlfilter.txt |  5 ++++-
 tools/perf/util/dlfilter.c                 | 11 +++++++++++
 tools/perf/util/perf_dlfilter.h            |  4 +++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-dlfilter.txt b/tools/perf/Documentation/perf-dlfilter.txt
index b6f958983584..d37913343449 100644
--- a/tools/perf/Documentation/perf-dlfilter.txt
+++ b/tools/perf/Documentation/perf-dlfilter.txt
@@ -112,7 +112,8 @@ struct perf_dlfilter_fns {
 	__s32 (*resolve_address)(void *ctx, __u64 address, struct perf_dlfilter_al *al);
 	const __u8 *(*insn)(void *ctx, __u32 *length);
 	const char *(*srcline)(void *ctx, __u32 *line_number);
-	void *(*reserved[123])(void *);
+	struct perf_event_attr *(*attr)(void *ctx);
+	void *(*reserved[122])(void *);
 };
 ----
 
@@ -127,6 +128,8 @@ before calling. Returns 0 on success, -1 otherwise.
 
 'srcline' return source file name and line number.
 
+'attr' returns perf_event_attr, refer <linux/perf_event.h>.
+
 The perf_dlfilter_al structure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index d71b0c97d1eb..2e89f322ff60 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -217,12 +217,23 @@ static const char *dlfilter__srcline(void *ctx, __u32 *line_no)
 	return srcfile;
 }
 
+static struct perf_event_attr *dlfilter__attr(void *ctx)
+{
+	struct dlfilter *d = (struct dlfilter *)ctx;
+
+	if (!d->ctx_valid)
+		return NULL;
+
+	return &d->evsel->core.attr;
+}
+
 static const struct perf_dlfilter_fns perf_dlfilter_fns = {
 	.resolve_ip      = dlfilter__resolve_ip,
 	.resolve_addr    = dlfilter__resolve_addr,
 	.resolve_address = dlfilter__resolve_address,
 	.insn            = dlfilter__insn,
 	.srcline         = dlfilter__srcline,
+	.attr            = dlfilter__attr,
 };
 
 #define CHECK_FLAG(x) BUILD_BUG_ON((u64)PERF_DLFILTER_FLAG_ ## x != (u64)PERF_IP_FLAG_ ## x)
diff --git a/tools/perf/util/perf_dlfilter.h b/tools/perf/util/perf_dlfilter.h
index a91e314ba24a..e2cdf416b22e 100644
--- a/tools/perf/util/perf_dlfilter.h
+++ b/tools/perf/util/perf_dlfilter.h
@@ -99,8 +99,10 @@ struct perf_dlfilter_fns {
 	const __u8 *(*insn)(void *ctx, __u32 *length);
 	/* Return source file name and line number */
 	const char *(*srcline)(void *ctx, __u32 *line_number);
+	/* Return perf_event_attr, refer <linux/perf_event.h> */
+	struct perf_event_attr *(*attr)(void *ctx);
 	/* Reserved */
-	void *(*reserved[123])(void *);
+	void *(*reserved[122])(void *);
 };
 
 /*
-- 
2.17.1

