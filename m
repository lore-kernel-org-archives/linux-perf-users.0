Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112B6C49EAB
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 13:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F02B861C23
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 13:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhF0NUc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Jun 2021 09:20:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:60751 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230388AbhF0NUc (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Jun 2021 09:20:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="195137044"
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="195137044"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 06:18:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="640589014"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2021 06:18:05 -0700
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
Subject: [PATCH V2 02/10] perf script: Add dlfilter__filter_event_early()
Date:   Sun, 27 Jun 2021 16:18:10 +0300
Message-Id: <20210627131818.810-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210627131818.810-1-adrian.hunter@intel.com>
References: <20210627131818.810-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

filter_event_early() can be more than 30% faster than filter_event()
because it is called before internal filtering. In other respects it
is the same as filter_event(), except that it will be passed events
that have yet to be filtered out.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-dlfilter.txt | 13 +++++++----
 tools/perf/builtin-script.c                | 26 +++++++++++++++-------
 tools/perf/util/dlfilter.c                 |  9 ++++++--
 tools/perf/util/dlfilter.h                 | 21 +++++++++++++++--
 tools/perf/util/perf_dlfilter.h            |  6 +++++
 5 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/tools/perf/Documentation/perf-dlfilter.txt b/tools/perf/Documentation/perf-dlfilter.txt
index 15d5f4b01c97..aef1c32babd1 100644
--- a/tools/perf/Documentation/perf-dlfilter.txt
+++ b/tools/perf/Documentation/perf-dlfilter.txt
@@ -36,16 +36,17 @@ const struct perf_dlfilter_fns perf_dlfilter_fns;
 int start(void **data, void *ctx);
 int stop(void *data, void *ctx);
 int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx);
+int filter_event_early(void *data, const struct perf_dlfilter_sample *sample, void *ctx);
 ----
 
 If implemented, 'start' will be called at the beginning, before any
-calls to 'filter_event' . Return 0 to indicate success,
+calls to 'filter_event' or 'filter_event_early'. Return 0 to indicate success,
 or return a negative error code. '*data' can be assigned for use by other
 functions. 'ctx' is needed for calls to perf_dlfilter_fns, but most
 perf_dlfilter_fns are not valid when called from 'start'.
 
 If implemented, 'stop' will be called at the end, after any calls to
-'filter_event'. Return 0 to indicate success, or
+'filter_event' or 'filter_event_early'. Return 0 to indicate success, or
 return a negative error code. 'data' is set by 'start'. 'ctx' is needed
 for calls to perf_dlfilter_fns, but most perf_dlfilter_fns are not valid
 when called from 'stop'.
@@ -55,10 +56,13 @@ Return 0 to keep the sample event, 1 to filter it out, or return a negative
 error code. 'data' is set by 'start'. 'ctx' is needed for calls to
 'perf_dlfilter_fns'.
 
+'filter_event_early' is the same as 'filter_event' except it is called before
+internal filtering.
+
 The perf_dlfilter_sample structure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-'filter_event' is passed a perf_dlfilter_sample
+'filter_event' and 'filter_event_early' are passed a perf_dlfilter_sample
 structure, which contains the following fields:
 [source,c]
 ----
@@ -105,7 +109,8 @@ The perf_dlfilter_fns structure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The 'perf_dlfilter_fns' structure is populated with function pointers when the
-file is loaded. The functions can be called by 'filter_event'.
+file is loaded. The functions can be called by 'filter_event' or
+'filter_event_early'.
 
 [source,c]
 ----
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index aaf2922643a0..e47affe674a5 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2179,9 +2179,20 @@ static int process_sample_event(struct perf_tool *tool,
 	struct addr_location addr_al;
 	int ret = 0;
 
+	/* Set thread to NULL to indicate addr_al and al are not initialized */
+	addr_al.thread = NULL;
+	al.thread = NULL;
+
+	ret = dlfilter__filter_event_early(dlfilter, event, sample, evsel, machine, &al, &addr_al);
+	if (ret) {
+		if (ret > 0)
+			ret = 0;
+		goto out_put;
+	}
+
 	if (perf_time__ranges_skip_sample(scr->ptime_range, scr->range_num,
 					  sample->time)) {
-		return 0;
+		goto out_put;
 	}
 
 	if (debug_mode) {
@@ -2192,24 +2203,22 @@ static int process_sample_event(struct perf_tool *tool,
 			nr_unordered++;
 		}
 		last_timestamp = sample->time;
-		return 0;
+		goto out_put;
 	}
 
 	if (filter_cpu(sample))
-		return 0;
+		goto out_put;
 
 	if (machine__resolve(machine, &al, sample) < 0) {
 		pr_err("problem processing %d event, skipping it.\n",
 		       event->header.type);
-		return -1;
+		ret = -1;
+		goto out_put;
 	}
 
 	if (al.filtered)
 		goto out_put;
 
-	/* Set thread to NULL to indicate addr_al is not initialized */
-	addr_al.thread = NULL;
-
 	if (!show_event(sample, evsel, al.thread, &al, &addr_al))
 		goto out_put;
 
@@ -2238,7 +2247,8 @@ static int process_sample_event(struct perf_tool *tool,
 	}
 
 out_put:
-	addr_location__put(&al);
+	if (al.thread)
+		addr_location__put(&al);
 	return ret;
 }
 
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 03c4bf150656..e93c49c07999 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -175,6 +175,7 @@ static int dlfilter__open(struct dlfilter *d)
 	}
 	d->start = dlsym(d->handle, "start");
 	d->filter_event = dlsym(d->handle, "filter_event");
+	d->filter_event_early = dlsym(d->handle, "filter_event_early");
 	d->stop = dlsym(d->handle, "stop");
 	d->fns = dlsym(d->handle, "perf_dlfilter_fns");
 	if (d->fns)
@@ -251,7 +252,8 @@ int dlfilter__do_filter_event(struct dlfilter *d,
 			      struct evsel *evsel,
 			      struct machine *machine,
 			      struct addr_location *al,
-			      struct addr_location *addr_al)
+			      struct addr_location *addr_al,
+			      bool early)
 {
 	struct perf_dlfilter_sample d_sample;
 	struct perf_dlfilter_al d_ip_al;
@@ -322,7 +324,10 @@ int dlfilter__do_filter_event(struct dlfilter *d,
 
 	d->ctx_valid = true;
 
-	ret = d->filter_event(d->data, &d_sample, d);
+	if (early)
+		ret = d->filter_event_early(d->data, &d_sample, d);
+	else
+		ret = d->filter_event(d->data, &d_sample, d);
 
 	d->ctx_valid = false;
 
diff --git a/tools/perf/util/dlfilter.h b/tools/perf/util/dlfilter.h
index 22b7636028dd..a994560e563d 100644
--- a/tools/perf/util/dlfilter.h
+++ b/tools/perf/util/dlfilter.h
@@ -40,6 +40,9 @@ struct dlfilter {
 	int (*filter_event)(void *data,
 			    const struct perf_dlfilter_sample *sample,
 			    void *ctx);
+	int (*filter_event_early)(void *data,
+				  const struct perf_dlfilter_sample *sample,
+				  void *ctx);
 
 	struct perf_dlfilter_fns *fns;
 };
@@ -54,7 +57,8 @@ int dlfilter__do_filter_event(struct dlfilter *d,
 			      struct evsel *evsel,
 			      struct machine *machine,
 			      struct addr_location *al,
-			      struct addr_location *addr_al);
+			      struct addr_location *addr_al,
+			      bool early);
 
 void dlfilter__cleanup(struct dlfilter *d);
 
@@ -68,7 +72,20 @@ static inline int dlfilter__filter_event(struct dlfilter *d,
 {
 	if (!d || !d->filter_event)
 		return 0;
-	return dlfilter__do_filter_event(d, event, sample, evsel, machine, al, addr_al);
+	return dlfilter__do_filter_event(d, event, sample, evsel, machine, al, addr_al, false);
+}
+
+static inline int dlfilter__filter_event_early(struct dlfilter *d,
+					       union perf_event *event,
+					       struct perf_sample *sample,
+					       struct evsel *evsel,
+					       struct machine *machine,
+					       struct addr_location *al,
+					       struct addr_location *addr_al)
+{
+	if (!d || !d->filter_event_early)
+		return 0;
+	return dlfilter__do_filter_event(d, event, sample, evsel, machine, al, addr_al, true);
 }
 
 #endif
diff --git a/tools/perf/util/perf_dlfilter.h b/tools/perf/util/perf_dlfilter.h
index 82833ee8680d..f7a847fdee59 100644
--- a/tools/perf/util/perf_dlfilter.h
+++ b/tools/perf/util/perf_dlfilter.h
@@ -120,4 +120,10 @@ int stop(void *data, void *ctx);
  */
 int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx);
 
+/*
+ * The same as 'filter_event' except it is called before internal
+ * filtering.
+ */
+int filter_event_early(void *data, const struct perf_dlfilter_sample *sample, void *ctx);
+
 #endif
-- 
2.17.1

