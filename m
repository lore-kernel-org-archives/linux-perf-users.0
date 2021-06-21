Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303BAC4743C
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 15:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19EF06023F
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 15:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhFUPHl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:07:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:58558 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230346AbhFUPHf (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Jun 2021 11:07:35 -0400
IronPort-SDR: cTjTX1G1Vt7XDRH5ggAYHZq0MB3Q8ZRmEE9AaDLCpIbV9mtq5GCpbWdUMtDBsamq64A7egdzLh
 vENBXrTTkPag==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="193998920"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="193998920"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 08:05:20 -0700
IronPort-SDR: yMPZVJk31ykv1uny18fTrdT6G3bS5gscPLO8nDss2ss0rZmJQUSOHOyZxDhOlRaPGtg4G/pqv4
 HUdEIYj6PkOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="486519566"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2021 08:05:17 -0700
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
Subject: [PATCH RFC 07/11] perf dlfilter: Add resolve_address() to perf_dlfilter_fns
Date:   Mon, 21 Jun 2021 18:05:10 +0300
Message-Id: <20210621150514.32159-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210621150514.32159-1-adrian.hunter@intel.com>
References: <20210621150514.32159-1-adrian.hunter@intel.com>
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
index 8eada542330a..c3fe3bc02819 100644
--- a/tools/perf/Documentation/perf-dlfilter.txt
+++ b/tools/perf/Documentation/perf-dlfilter.txt
@@ -109,7 +109,8 @@ file is loaded. The functions can be called by 'filter_event' or
 struct perf_dlfilter_fns {
 	const struct perf_dlfilter_al *(*resolve_ip)(void *ctx);
 	const struct perf_dlfilter_al *(*resolve_addr)(void *ctx);
-	void *(*reserved[126])(void *);
+	__s32 (*resolve_address)(void *ctx, __u64 address, struct perf_dlfilter_al *al);
+	void *(*reserved[125])(void *);
 };
 ----
 
@@ -117,6 +118,9 @@ struct perf_dlfilter_fns {
 
 'resolve_addr' returns information about addr (if addr_correlates_sym).
 
+'resolve_address' provides information about 'address'. al->size must be set
+before calling. Returns 0 on success, -1 otherwise.
+
 The perf_dlfilter_al structure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 8a2b196f07a7..3b29bf9f2bd3 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -131,9 +131,38 @@ static const struct perf_dlfilter_al *dlfilter__resolve_addr(void *ctx)
 	return d_addr_al;
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
+	.resolve_address = dlfilter__resolve_address,
 };
 
 #define CHECK_FLAG(x) BUILD_BUG_ON((u64)PERF_DLFILTER_FLAG_ ## x != (u64)PERF_IP_FLAG_ ## x)
diff --git a/tools/perf/util/perf_dlfilter.h b/tools/perf/util/perf_dlfilter.h
index d24c3e2a8407..97bceb625b54 100644
--- a/tools/perf/util/perf_dlfilter.h
+++ b/tools/perf/util/perf_dlfilter.h
@@ -90,8 +90,13 @@ struct perf_dlfilter_fns {
 	const struct perf_dlfilter_al *(*resolve_ip)(void *ctx);
 	/* Return information about addr (if addr_correlates_sym) */
 	const struct perf_dlfilter_al *(*resolve_addr)(void *ctx);
+	/*
+	 * Return information about address (al->size must be set before
+	 * calling). Returns 0 on success, -1 otherwise.
+	 */
+	__s32 (*resolve_address)(void *ctx, __u64 address, struct perf_dlfilter_al *al);
 	/* Reserved */
-	void *(*reserved[126])(void *);
+	void *(*reserved[125])(void *);
 };
 
 /*
-- 
2.17.1

