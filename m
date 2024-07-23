Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F839200A3
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721767731; cv=none; b=ajlYlxeeQsLRleaJBV5hVbIpqPj85nv9SqTj9xGVt74OrlLaEUDNvOAVd/fpEE+UzPRtyMdeu2y0Qffn8RBFitR9moq999hLGKz3KeYLYtbiqb3bACxrDTlpWEaZBgss+IE+i9DLKHbZC/YeuOY+mpd+6wU6T1v7kTq8FCfBS3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721767731; c=relaxed/simple;
	bh=kae2fhxc/22vjmGQhz3NJbp835i5oXTM9mfEV7uu+w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJHH6qG5Ckfc6JpGfhBiQnll7ZRKIMdchQcc793oVD0Ks3W/5p2po0kjvNkvE0dr3jI4rzIf78ymHXSRaxc4feU/juouXWlmdPK3du4mSpTA851m/xMjRd5kUJAId/JKE7CvHor/efYwkqEqSjj0PU3PaD5NI5NkjNK4JZOOPRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTFGuD8U; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTFGuD8U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721767729; x=1753303729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kae2fhxc/22vjmGQhz3NJbp835i5oXTM9mfEV7uu+w4=;
  b=OTFGuD8Uwmd+o9N5svr7a7EgkNuT/73nY62uydheRd0x/PMBut+sXuky
   2cFOIEI8QjxQfnuVJ+xwRtpjJJ+19LaEvxL4vLlt83oA2AuXo18LbnAfS
   N3cY/5x06NDhpKHkdD8JCZNQHnU1ueprgX/e90fScjPnpluGjAtg+4oDt
   iJAWcR3oktwLdqQyONEQ82vTywxLsYlHIw0Og5br9h6NitDgDaR8kCz3c
   idCp4vbFYeUcHnB+kzEfu4aKFbKvXBLBZsNGZAz6NmTVNPZoGMmEt+gPe
   w0HMeOWlNhL0yvU8E/S8npqKMbYF6/aATEhQtRxM60iZ/TahrKVAflEWg
   w==;
X-CSE-ConnectionGUID: 8nHUELgqRO2OJbCtDCc3zA==
X-CSE-MsgGUID: HKJqwIt7QoatOEeLKIwtcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19564602"
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="19564602"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 13:48:47 -0700
X-CSE-ConnectionGUID: 3mp3Ca2+Sd+VTy51OUA75g==
X-CSE-MsgGUID: P/clbsdnQiqMA2aV3jXkBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="56654797"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 13:48:46 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v6 3/4] perf script: Fix perf script -F +metric
Date: Tue, 23 Jul 2024 13:48:33 -0700
Message-ID: <20240723204834.3617647-3-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723204834.3617647-1-ak@linux.intel.com>
References: <20240723204834.3617647-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a regression with perf script -F +metric originally caused by :

commit 37cc8ad77cf81f3ffd226856c367b0e15333a738
Author: Ian Rogers <irogers@google.com>
Date:   Sun Feb 19 01:28:46 2023 -0800

    perf metric: Directly use counts rather than saved_value

In the perf script environment the evsel wouldn't allocate an aggr
values array, which led to a -1 reference because the metric
evaluation would try to reference NULL - 1 (for aggr_idx)

Give the perf script evsels a single CPU aggr setup. That's
enough because the groups are always contiguous, so no need
to store more than one CPU's worth of values.

Before

% perf record -e '{cycles,instructions}:S' perf bench  mem memcpy
% perf script -F +metric
Segmentation fault (core dumped)

After:

% perf record -e '{cycles,instructions}:S' perf bench  mem memcpy
...
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.028 MB perf.data (90 samples) ]
% perf script -F +metric
       perf-exec 1847557 264658.180789:       3009       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
       perf-exec 1847557 264658.180789:        382 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
       perf-exec 1847557 264658.180789:         metric:    0.13  insn per cycle
...

Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather ...")
Signed-off-by: Andi Kleen <ak@linux.intel.com>

----

v2: Reformat code
v3: Work around bogus warning
v4: Set up aggr map only for metrics case to keep perf stat record
working
v5: Broken version
v6: Only set up limited aggregation mode with -F +metric. Add conflict
checks with perf stat record files.
---
 tools/perf/builtin-script.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c16224b1fef3..1a4b9b3d240d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2133,12 +2133,17 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 	if (evsel_script(leader)->gnum++ == 0)
 		perf_stat__reset_shadow_stats();
 	val = sample->period * evsel->scale;
+	/*
+	 * Always use CPU 0 storage because the groups are contiguous
+	 * and there's no need to handle multiple indexes for anything
+	 */
+	evsel->stats->aggr[0].counts.val = val;
 	evsel_script(evsel)->val = val;
 	if (evsel_script(leader)->gnum == leader->core.nr_members) {
 		for_each_group_member (ev2, leader) {
 			perf_stat__print_shadow_stats(&stat_config, ev2,
 						      evsel_script(ev2)->val,
-						      sample->cpu,
+						      0,
 						      &ctx,
 						      NULL);
 		}
@@ -2325,6 +2330,20 @@ static void process_event(struct perf_script *script,
 		fflush(fp);
 }
 
+static void check_metric_conflict(void)
+{
+	int i;
+	/*
+	 * Avoid conflict with the aggregation mode used for the metric printing.
+	 */
+	for (i = 0; i < OUTPUT_TYPE_MAX; i++) {
+		if (output[i].fields & PERF_OUTPUT_METRIC) {
+			fprintf(stderr, "perf stat record files are not supported with -F metric\n");
+			exit(1);
+		}
+	}
+}
+
 static struct scripting_ops	*scripting_ops;
 
 static void __process_stat(struct evsel *counter, u64 tstamp)
@@ -2334,6 +2353,8 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
 	struct perf_cpu cpu;
 	static int header_printed;
 
+	check_metric_conflict();
+
 	if (!header_printed) {
 		printf("%3s %8s %15s %15s %15s %15s %s\n",
 		       "CPU", "THREAD", "VAL", "ENA", "RUN", "TIME", "EVENT");
@@ -3725,6 +3746,8 @@ static int process_stat_config_event(struct perf_session *session __maybe_unused
 {
 	perf_event__read_stat_config(&stat_config, &event->stat_config);
 
+	check_metric_conflict();
+
 	/*
 	 * Aggregation modes are not used since post-processing scripts are
 	 * supposed to take care of such requirements
@@ -3760,6 +3783,8 @@ int process_thread_map_event(struct perf_session *session,
 	struct perf_tool *tool = session->tool;
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 
+	check_metric_conflict();
+
 	if (dump_trace)
 		perf_event__fprintf_thread_map(event, stdout);
 
@@ -3785,6 +3810,8 @@ int process_cpu_map_event(struct perf_session *session,
 	if (dump_trace)
 		perf_event__fprintf_cpu_map(event, stdout);
 
+	check_metric_conflict();
+
 	if (script->cpus) {
 		pr_warning("Extra cpu map event, ignoring.\n");
 		return 0;
@@ -4088,6 +4115,10 @@ int cmd_script(int argc, const char **argv)
 
 	argc = parse_options_subcommand(argc, argv, options, script_subcommands, script_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
+	for (i = 0; i < OUTPUT_TYPE_MAX; i++) {
+		if (output[i].fields & PERF_OUTPUT_METRIC)
+			stat_config.aggr_map = &(struct cpu_aggr_map){ .nr = 1 };
+	}
 
 	if (symbol_conf.guestmount ||
 	    symbol_conf.default_guest_vmlinux_name ||
-- 
2.45.2

