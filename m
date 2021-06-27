Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDABAC49EA6
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 13:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84BA61C21
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 13:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhF0NVB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Jun 2021 09:21:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:6344 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231285AbhF0NU7 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Jun 2021 09:20:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="229454388"
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="229454388"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 06:18:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="640589119"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2021 06:18:31 -0700
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
Subject: [PATCH V2 10/10] perf dlfilter: Add object_code() to perf_dlfilter_fns
Date:   Sun, 27 Jun 2021 16:18:18 +0300
Message-Id: <20210627131818.810-11-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210627131818.810-1-adrian.hunter@intel.com>
References: <20210627131818.810-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a function, for use by dlfilters, to read object code.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-dlfilter.txt |  5 +++-
 tools/perf/util/dlfilter.c                 | 34 ++++++++++++++++++++++
 tools/perf/util/perf_dlfilter.h            |  4 ++-
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-dlfilter.txt b/tools/perf/Documentation/perf-dlfilter.txt
index 6b1d9da16feb..02842cb4cf90 100644
--- a/tools/perf/Documentation/perf-dlfilter.txt
+++ b/tools/perf/Documentation/perf-dlfilter.txt
@@ -127,7 +127,8 @@ struct perf_dlfilter_fns {
 	const __u8 *(*insn)(void *ctx, __u32 *length);
 	const char *(*srcline)(void *ctx, __u32 *line_number);
 	struct perf_event_attr *(*attr)(void *ctx);
-	void *(*reserved[121])(void *);
+	__s32 (*object_code)(void *ctx, __u64 ip, void *buf, __u32 len);
+	void *(*reserved[120])(void *);
 };
 ----
 
@@ -146,6 +147,8 @@ before calling. Returns 0 on success, -1 otherwise.
 
 'attr' returns perf_event_attr, refer <linux/perf_event.h>.
 
+'object_code' reads object code and returns the number of bytes read.
+
 The perf_dlfilter_al structure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index e50d524906d6..ca33fbc5efde 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -245,6 +245,39 @@ static struct perf_event_attr *dlfilter__attr(void *ctx)
 	return &d->evsel->core.attr;
 }
 
+static __s32 dlfilter__object_code(void *ctx, __u64 ip, void *buf, __u32 len)
+{
+	struct dlfilter *d = (struct dlfilter *)ctx;
+	struct addr_location *al;
+	struct addr_location a;
+	struct map *map;
+	u64 offset;
+
+	if (!d->ctx_valid)
+		return -1;
+
+	al = get_al(d);
+	if (!al)
+		return -1;
+
+	map = al->map;
+
+	if (map && ip >= map->start && ip < map->end &&
+	    machine__kernel_ip(d->machine, ip) == machine__kernel_ip(d->machine, d->sample->ip))
+		goto have_map;
+
+	thread__find_map_fb(al->thread, d->sample->cpumode, ip, &a);
+	if (!a.map)
+		return -1;
+
+	map = a.map;
+have_map:
+	offset = map->map_ip(map, ip);
+	if (ip + len >= map->end)
+		len = map->end - ip;
+	return dso__data_read_offset(map->dso, d->machine, offset, buf, len);
+}
+
 static const struct perf_dlfilter_fns perf_dlfilter_fns = {
 	.resolve_ip      = dlfilter__resolve_ip,
 	.resolve_addr    = dlfilter__resolve_addr,
@@ -253,6 +286,7 @@ static const struct perf_dlfilter_fns perf_dlfilter_fns = {
 	.insn            = dlfilter__insn,
 	.srcline         = dlfilter__srcline,
 	.attr            = dlfilter__attr,
+	.object_code     = dlfilter__object_code,
 };
 
 static char *find_dlfilter(const char *file)
diff --git a/tools/perf/util/perf_dlfilter.h b/tools/perf/util/perf_dlfilter.h
index f3fc92fcb3c0..3eef03d661b4 100644
--- a/tools/perf/util/perf_dlfilter.h
+++ b/tools/perf/util/perf_dlfilter.h
@@ -103,8 +103,10 @@ struct perf_dlfilter_fns {
 	const char *(*srcline)(void *ctx, __u32 *line_number);
 	/* Return perf_event_attr, refer <linux/perf_event.h> */
 	struct perf_event_attr *(*attr)(void *ctx);
+	/* Read object code, return numbers of bytes read */
+	__s32 (*object_code)(void *ctx, __u64 ip, void *buf, __u32 len);
 	/* Reserved */
-	void *(*reserved[121])(void *);
+	void *(*reserved[120])(void *);
 };
 
 /*
-- 
2.17.1

