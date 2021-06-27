Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29411C48BC2
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 13:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15FC3619CB
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 13:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhF0NU6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Jun 2021 09:20:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:60779 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231182AbhF0NU4 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Jun 2021 09:20:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="195137080"
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="195137080"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 06:18:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="640589099"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2021 06:18:27 -0700
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
Subject: [PATCH V2 09/10] perf dlfilter: Add attr() to perf_dlfilter_fns
Date:   Sun, 27 Jun 2021 16:18:17 +0300
Message-Id: <20210627131818.810-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210627131818.810-1-adrian.hunter@intel.com>
References: <20210627131818.810-1-adrian.hunter@intel.com>
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
index df118ddcd7f4..6b1d9da16feb 100644
--- a/tools/perf/Documentation/perf-dlfilter.txt
+++ b/tools/perf/Documentation/perf-dlfilter.txt
@@ -126,7 +126,8 @@ struct perf_dlfilter_fns {
 	__s32 (*resolve_address)(void *ctx, __u64 address, struct perf_dlfilter_al *al);
 	const __u8 *(*insn)(void *ctx, __u32 *length);
 	const char *(*srcline)(void *ctx, __u32 *line_number);
-	void *(*reserved[122])(void *);
+	struct perf_event_attr *(*attr)(void *ctx);
+	void *(*reserved[121])(void *);
 };
 ----
 
@@ -143,6 +144,8 @@ before calling. Returns 0 on success, -1 otherwise.
 
 'srcline' return source file name and line number.
 
+'attr' returns perf_event_attr, refer <linux/perf_event.h>.
+
 The perf_dlfilter_al structure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index f4ce1a80bddc..e50d524906d6 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -235,6 +235,16 @@ static const char *dlfilter__srcline(void *ctx, __u32 *line_no)
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
@@ -242,6 +252,7 @@ static const struct perf_dlfilter_fns perf_dlfilter_fns = {
 	.resolve_address = dlfilter__resolve_address,
 	.insn            = dlfilter__insn,
 	.srcline         = dlfilter__srcline,
+	.attr            = dlfilter__attr,
 };
 
 static char *find_dlfilter(const char *file)
diff --git a/tools/perf/util/perf_dlfilter.h b/tools/perf/util/perf_dlfilter.h
index b989918056e2..f3fc92fcb3c0 100644
--- a/tools/perf/util/perf_dlfilter.h
+++ b/tools/perf/util/perf_dlfilter.h
@@ -101,8 +101,10 @@ struct perf_dlfilter_fns {
 	const __u8 *(*insn)(void *ctx, __u32 *length);
 	/* Return source file name and line number */
 	const char *(*srcline)(void *ctx, __u32 *line_number);
+	/* Return perf_event_attr, refer <linux/perf_event.h> */
+	struct perf_event_attr *(*attr)(void *ctx);
 	/* Reserved */
-	void *(*reserved[122])(void *);
+	void *(*reserved[121])(void *);
 };
 
 /*
-- 
2.17.1

