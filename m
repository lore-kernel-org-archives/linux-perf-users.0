Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A6CC48BE5
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 15:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D3C610C7
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 15:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhFUPIA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:08:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:58587 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230423AbhFUPHu (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Jun 2021 11:07:50 -0400
IronPort-SDR: SFbLS8GZk1Uixoy9u2Q181FgIGYmcajngkMVJBaEioVh7h2swALeHpflUhc3pVbergg0Kp2tvr
 8wfHyChrALyg==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="193998987"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="193998987"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 08:05:34 -0700
IronPort-SDR: P0a/YXa1/SzlVpAEpaN+PV4sj9FANBqevN2482jk2KoRV9v83PQ/79h+OxS+iFKiqL/Hu5TbZs
 5tlVf6Z/5JdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="486519627"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2021 08:05:31 -0700
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
Subject: [PATCH RFC 11/11] perf dlfilter: Add object_code() to perf_dlfilter_fns
Date:   Mon, 21 Jun 2021 18:05:14 +0300
Message-Id: <20210621150514.32159-12-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210621150514.32159-1-adrian.hunter@intel.com>
References: <20210621150514.32159-1-adrian.hunter@intel.com>
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
index d37913343449..8a6d21e30fc5 100644
--- a/tools/perf/Documentation/perf-dlfilter.txt
+++ b/tools/perf/Documentation/perf-dlfilter.txt
@@ -113,7 +113,8 @@ struct perf_dlfilter_fns {
 	const __u8 *(*insn)(void *ctx, __u32 *length);
 	const char *(*srcline)(void *ctx, __u32 *line_number);
 	struct perf_event_attr *(*attr)(void *ctx);
-	void *(*reserved[122])(void *);
+	__s32 (*object_code)(void *ctx, __u64 ip, void *buf, __u32 len);
+	void *(*reserved[121])(void *);
 };
 ----
 
@@ -130,6 +131,8 @@ before calling. Returns 0 on success, -1 otherwise.
 
 'attr' returns perf_event_attr, refer <linux/perf_event.h>.
 
+'object_code' reads object code and returns the number of bytes read.
+
 The perf_dlfilter_al structure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 2e89f322ff60..fa087422baa1 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -227,6 +227,39 @@ static struct perf_event_attr *dlfilter__attr(void *ctx)
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
@@ -234,6 +267,7 @@ static const struct perf_dlfilter_fns perf_dlfilter_fns = {
 	.insn            = dlfilter__insn,
 	.srcline         = dlfilter__srcline,
 	.attr            = dlfilter__attr,
+	.object_code     = dlfilter__object_code,
 };
 
 #define CHECK_FLAG(x) BUILD_BUG_ON((u64)PERF_DLFILTER_FLAG_ ## x != (u64)PERF_IP_FLAG_ ## x)
diff --git a/tools/perf/util/perf_dlfilter.h b/tools/perf/util/perf_dlfilter.h
index e2cdf416b22e..4429f3836fa7 100644
--- a/tools/perf/util/perf_dlfilter.h
+++ b/tools/perf/util/perf_dlfilter.h
@@ -101,8 +101,10 @@ struct perf_dlfilter_fns {
 	const char *(*srcline)(void *ctx, __u32 *line_number);
 	/* Return perf_event_attr, refer <linux/perf_event.h> */
 	struct perf_event_attr *(*attr)(void *ctx);
+	/* Read object code, return numbers of bytes read */
+	__s32 (*object_code)(void *ctx, __u64 ip, void *buf, __u32 len);
 	/* Reserved */
-	void *(*reserved[122])(void *);
+	void *(*reserved[121])(void *);
 };
 
 /*
-- 
2.17.1

