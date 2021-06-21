Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DCDC4743C
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 15:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF24A610C7
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 15:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhFUPHW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:07:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:58521 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230165AbhFUPHT (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Jun 2021 11:07:19 -0400
IronPort-SDR: JONTOzftqcYIFUWGrGeG9/PgE7zHJrLYxDiKAkR/5cVqYwsJ+bTputmA+gpLTikKTz9hND0js2
 hoMUf5VLr5Mw==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="193998846"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="193998846"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 08:05:05 -0700
IronPort-SDR: j88L93dbtWP5Rp8Rbh2WHRqAd+JbIZP3MGNMuoBG52P0dgluJCwuVxcs++i2g7zhlwxha7yv+3
 8bSnQG38WQ5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="486519338"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2021 08:05:02 -0700
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
Subject: [PATCH RFC 03/11] perf script: Share addr_al between functions
Date:   Mon, 21 Jun 2021 18:05:06 +0300
Message-Id: <20210621150514.32159-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210621150514.32159-1-adrian.hunter@intel.com>
References: <20210621150514.32159-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Share the addr_location of 'addr' so that it need not be resolved more than
once.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c | 38 +++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ff7b43899f2e..d2771a997e26 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1337,17 +1337,18 @@ static const char *resolve_branch_sym(struct perf_sample *sample,
 				      struct evsel *evsel,
 				      struct thread *thread,
 				      struct addr_location *al,
+				      struct addr_location *addr_al,
 				      u64 *ip)
 {
-	struct addr_location addr_al;
 	struct perf_event_attr *attr = &evsel->core.attr;
 	const char *name = NULL;
 
 	if (sample->flags & (PERF_IP_FLAG_CALL | PERF_IP_FLAG_TRACE_BEGIN)) {
 		if (sample_addr_correlates_sym(attr)) {
-			thread__resolve(thread, &addr_al, sample);
-			if (addr_al.sym)
-				name = addr_al.sym->name;
+			if (!addr_al->thread)
+				thread__resolve(thread, addr_al, sample);
+			if (addr_al->sym)
+				name = addr_al->sym->name;
 			else
 				*ip = sample->addr;
 		} else {
@@ -1365,7 +1366,9 @@ static const char *resolve_branch_sym(struct perf_sample *sample,
 static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 					   struct evsel *evsel,
 					   struct thread *thread,
-					   struct addr_location *al, FILE *fp)
+					   struct addr_location *al,
+					   struct addr_location *addr_al,
+					   FILE *fp)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
 	size_t depth = thread_stack__depth(thread, sample->cpu);
@@ -1382,7 +1385,7 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 	if (thread->ts && sample->flags & PERF_IP_FLAG_RETURN)
 		depth += 1;
 
-	name = resolve_branch_sym(sample, evsel, thread, al, &ip);
+	name = resolve_branch_sym(sample, evsel, thread, al, addr_al, &ip);
 
 	if (PRINT_FIELD(DSO) && !(PRINT_FIELD(IP) || PRINT_FIELD(ADDR))) {
 		dlen += fprintf(fp, "(");
@@ -1466,6 +1469,7 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 				    struct evsel *evsel,
 				    struct thread *thread,
 				    struct addr_location *al,
+				    struct addr_location *addr_al,
 				    struct machine *machine, FILE *fp)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
@@ -1474,7 +1478,7 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 	int printed = 0;
 
 	if (PRINT_FIELD(CALLINDENT))
-		printed += perf_sample__fprintf_callindent(sample, evsel, thread, al, fp);
+		printed += perf_sample__fprintf_callindent(sample, evsel, thread, al, addr_al, fp);
 
 	/* print branch_from information */
 	if (PRINT_FIELD(IP)) {
@@ -1931,7 +1935,8 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 static bool show_event(struct perf_sample *sample,
 		       struct evsel *evsel,
 		       struct thread *thread,
-		       struct addr_location *al)
+		       struct addr_location *al,
+		       struct addr_location *addr_al)
 {
 	int depth = thread_stack__depth(thread, sample->cpu);
 
@@ -1947,7 +1952,7 @@ static bool show_event(struct perf_sample *sample,
 	} else {
 		const char *s = symbol_conf.graph_function;
 		u64 ip;
-		const char *name = resolve_branch_sym(sample, evsel, thread, al,
+		const char *name = resolve_branch_sym(sample, evsel, thread, al, addr_al,
 				&ip);
 		unsigned nlen;
 
@@ -1972,6 +1977,7 @@ static bool show_event(struct perf_sample *sample,
 static void process_event(struct perf_script *script,
 			  struct perf_sample *sample, struct evsel *evsel,
 			  struct addr_location *al,
+			  struct addr_location *addr_al,
 			  struct machine *machine)
 {
 	struct thread *thread = al->thread;
@@ -2005,7 +2011,7 @@ static void process_event(struct perf_script *script,
 		perf_sample__fprintf_flags(sample->flags, fp);
 
 	if (is_bts_event(attr)) {
-		perf_sample__fprintf_bts(sample, evsel, thread, al, machine, fp);
+		perf_sample__fprintf_bts(sample, evsel, thread, al, addr_al, machine, fp);
 		return;
 	}
 
@@ -2168,6 +2174,7 @@ static int process_sample_event(struct perf_tool *tool,
 {
 	struct perf_script *scr = container_of(tool, struct perf_script, tool);
 	struct addr_location al;
+	struct addr_location addr_al;
 
 	if (perf_time__ranges_skip_sample(scr->ptime_range, scr->range_num,
 					  sample->time)) {
@@ -2197,7 +2204,10 @@ static int process_sample_event(struct perf_tool *tool,
 	if (al.filtered)
 		goto out_put;
 
-	if (!show_event(sample, evsel, al.thread, &al))
+	/* Set thread to NULL to indicate addr_al is not initialized */
+	addr_al.thread = NULL;
+
+	if (!show_event(sample, evsel, al.thread, &al, &addr_al))
 		goto out_put;
 
 	if (evswitch__discard(&scr->evswitch, evsel))
@@ -2205,16 +2215,16 @@ static int process_sample_event(struct perf_tool *tool,
 
 	if (scripting_ops) {
 		struct addr_location *addr_al_ptr = NULL;
-		struct addr_location addr_al;
 
 		if ((evsel->core.attr.sample_type & PERF_SAMPLE_ADDR) &&
 		    sample_addr_correlates_sym(&evsel->core.attr)) {
-			thread__resolve(al.thread, &addr_al, sample);
+			if (!addr_al.thread)
+				thread__resolve(al.thread, &addr_al, sample);
 			addr_al_ptr = &addr_al;
 		}
 		scripting_ops->process_event(event, sample, evsel, &al, addr_al_ptr);
 	} else {
-		process_event(scr, sample, evsel, &al, machine);
+		process_event(scr, sample, evsel, &al, &addr_al, machine);
 	}
 
 out_put:
-- 
2.17.1

