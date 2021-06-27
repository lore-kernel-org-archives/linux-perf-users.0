Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00093C48BC2
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 13:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F1461C3D
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 13:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhF0NUr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Jun 2021 09:20:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:60751 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231182AbhF0NUo (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Jun 2021 09:20:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="195137058"
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="195137058"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 06:18:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="640589057"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2021 06:18:17 -0700
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
Subject: [PATCH V2 06/10] perf dlfilter: Add resolve_address() to perf_dlfilter_fns
Date:   Sun, 27 Jun 2021 16:18:14 +0300
Message-Id: <20210627131818.810-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210627131818.810-1-adrian.hunter@intel.com>
References: <20210627131818.810-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a function, for use by dlfilters, to resolve addresses from branch
stacks or callchains.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-dlfilter.txt |  6 ++++-
 tools/perf/util/dlfilter.c                 | 29 ++++++++++++++++++++++
 tools/perf/util/perf_dlfilter.h            |  7 +++++-
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-dlfilter.txt b/tools/perf/Documentation/perf-dlfilter.txt
index 5795ab3ca23b..642323ac8934 100644
--- a/tools/perf/Documentation/perf-dlfilter.txt
+++ b/tools/perf/Documentation/perf-dlfilter.txt
@@ -123,7 +123,8 @@ struct perf_dlfilter_fns {
 	const struct perf_dlfilter_al *(*resolve_ip)(void *ctx);
 	const struct perf_dlfilter_al *(*resolve_addr)(void *ctx);
 	char **(*args)(void *ctx, int *dlargc);
-	void *(*reserved[125])(void *);
+	__s32 (*resolve_address)(void *ctx, __u64 address, struct perf_dlfilter_al *al);
+	void *(*reserved[124])(void *);
 };
 ----
 
@@ -133,6 +134,9 @@ struct perf_dlfilter_fns {
 
 'args' returns arguments from --dlarg options.
 
+'resolve_address' provides information about 'address'. al->size must be set
+before calling. Returns 0 on success, -1 otherwise.
+
 The perf_dlfilter_al structure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index eaa3cea49178..4b03227541d3 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -149,10 +149,39 @@ static char **dlfilter__args(void *ctx, int *dlargc)
 	return d->dlargv;
 }
 
+static __s32 dlfilter__resolve_address(void *ctx, __u64 address, struct perf_dlfilter_al *d_al_p)
+{
+	struct dlfilter *d = (struct dlfilter *)ctx;
+	struct perf_dlfilter_al d_al;
+	struct addr_location al;
+	struct thread *thread;
+	__u32 sz;
+
+	if (!d->ctx_valid || !d_al_p)
+		return -1;
+
+	thread = get_thread(d);
+	if (!thread)
+		return -1;
+
+	thread__find_symbol_fb(thread, d->sample->cpumode, address, &al);
+
+	al_to_d_al(&al, &d_al);
+
+	d_al.is_kernel_ip = machine__kernel_ip(d->machine, address);
+
+	sz = d_al_p->size;
+	memcpy(d_al_p, &d_al, min((size_t)sz, sizeof(d_al)));
+	d_al_p->size = sz;
+
+	return 0;
+}
+
 static const struct perf_dlfilter_fns perf_dlfilter_fns = {
 	.resolve_ip      = dlfilter__resolve_ip,
 	.resolve_addr    = dlfilter__resolve_addr,
 	.args            = dlfilter__args,
+	.resolve_address = dlfilter__resolve_address,
 };
 
 static char *find_dlfilter(const char *file)
diff --git a/tools/perf/util/perf_dlfilter.h b/tools/perf/util/perf_dlfilter.h
index 35e03aa41a7f..dfd0f8482824 100644
--- a/tools/perf/util/perf_dlfilter.h
+++ b/tools/perf/util/perf_dlfilter.h
@@ -92,8 +92,13 @@ struct perf_dlfilter_fns {
 	const struct perf_dlfilter_al *(*resolve_addr)(void *ctx);
 	/* Return arguments from --dlarg option */
 	char **(*args)(void *ctx, int *dlargc);
+	/*
+	 * Return information about address (al->size must be set before
+	 * calling). Returns 0 on success, -1 otherwise.
+	 */
+	__s32 (*resolve_address)(void *ctx, __u64 address, struct perf_dlfilter_al *al);
 	/* Reserved */
-	void *(*reserved[125])(void *);
+	void *(*reserved[124])(void *);
 };
 
 /*
-- 
2.17.1

