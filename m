Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2EA19EEBF
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723585022; cv=none; b=DRtTZUFqWBQYm/zLmF8qCnWiaUyLHBb4LhbYGliVNfO56VHOU3ty1b06+wkr76uiH2sa4wwHHyGQDl2viRaRim8flerNb8wKEz2O2cLHEqyxLPFS3N0h2W9CGMDMPid8hUegolkipFLIcN+LRmjxieCnh1n5pJM0QqkOqyQglQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723585022; c=relaxed/simple;
	bh=fcW9XUKCOt33erBn6t9MTgddUEzFYWeW53GLZZ5BwNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wy+qf6UE44pz+/JjPVlkyioH5uXaV8ERYScZw6uEvlp71w5GBHAId28hjiIj+/y7m8Eu6inVPw0UD7IrdtIXAm1/G2mBtFne4HSd0Hv+3ehx/7OUldIDPabCWMTMZE+znh9lSYrCV6rHIC6nhVF72uUNhVit1YXy5E+vocRaA9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYyxSFDC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYyxSFDC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723585020; x=1755121020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fcW9XUKCOt33erBn6t9MTgddUEzFYWeW53GLZZ5BwNw=;
  b=LYyxSFDCMWPz6fSBaf2H264QbJI5k1c5O8o9gzELkS7TY4eX7tNEZCj5
   0Mdk0oa1eYQ3I0GZHJ9Cc9zcmb0XOka4Ru6OZqCAS1HnzvOdxNP2WoR4s
   yDy75W+cAekte2U+pmsJz1hPitz0uWZacY+LYi4MG6JwsGlLZ+R0Ll+4I
   FCtnspXfe5x4QHFqisz0SHgbcsx0/Xetnl5ZVwiIomkE4JBn2XLOfrYwO
   uIOBPb8nAFWIOzPqJ84HT1O9hDdQog3IKe2zaJ5AJtF/QMQYBCeAQvlb6
   2teUVU/xFxQTb52aDmseQPg36T/sEurpJayNCWjo6L2fDLDd7H169dGxE
   g==;
X-CSE-ConnectionGUID: b9D5QvoKQcOkm9omPr7TFw==
X-CSE-MsgGUID: Lcsre6iPTSqj5koaGvwICA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21746625"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21746625"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 14:36:58 -0700
X-CSE-ConnectionGUID: EiotbS4JRIyA40g4a8HyvQ==
X-CSE-MsgGUID: 4XwmVlH6TQKj3m7xX/11xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="63734356"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 14:36:58 -0700
From: Andi Kleen <ak@linux.intel.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v10 3/4] perf script: Fix perf script -F +metric
Date: Tue, 13 Aug 2024 14:36:50 -0700
Message-ID: <20240813213651.1057362-3-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813213651.1057362-1-ak@linux.intel.com>
References: <20240813213651.1057362-1-ak@linux.intel.com>
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
Acked-by: Namhyung Kim <namhyung@kernel.org>

----

v2: Reformat code
v3: Work around bogus warning
v4: Set up aggr map only for metrics case to keep perf stat record
working
v5: Broken version
v6: Only set up limited aggregation mode with -F +metric. Add conflict
checks with perf stat record files.
v7: Remove some unnecessary conflict checks. Fix buffer overflow. Minor cleanups.
v8: Add check for leader sampling. Update some comments.
v9: Correct check for leader sampling (Namhyung)
v10: Check for PERF_FORMAT_GROUP and PERF_SAMPLE_READ (Namhyung)
v11: Use define for dummy aggregation index and add argument comments
(Ian)
---
 tools/perf/builtin-script.c | 61 ++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c16224b1fef3..f5d5828bf3db 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -335,10 +335,12 @@ struct evsel_script {
        FILE *fp;
        u64  samples;
        /* For metric output */
-       u64  val;
        int  gnum;
 };
 
+/* Use dummy index because no aggregation needed. */
+#define METRIC_AGGR_IDX 0
+
 static inline struct evsel_script *evsel_script(struct evsel *evsel)
 {
 	return (struct evsel_script *)evsel->priv;
@@ -2127,20 +2129,34 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 	};
 	struct evsel *ev2;
 	u64 val;
+	static int printed;
 
 	if (!evsel->stats)
 		evlist__alloc_stats(&stat_config, script->session->evlist, /*alloc_raw=*/false);
 	if (evsel_script(leader)->gnum++ == 0)
 		perf_stat__reset_shadow_stats();
-	val = sample->period * evsel->scale;
-	evsel_script(evsel)->val = val;
+	val = sample->period;
+	if (!(leader->core.attr.read_format & PERF_FORMAT_GROUP) ||
+	    !(leader->core.attr.sample_type & PERF_SAMPLE_READ)) {
+		if (!printed)
+			fprintf(stderr, "perf script: -F metric requires {}:S for groups leader sampling\n");
+		printed = 1;
+		return;
+	}
+	/*
+	 * Always use the first entry as storage (METRIC_AGGR_IDX)
+	 * because the leader sampling groups are contiguous and
+	 * there's no need to handle multiple indexes for anything.
+	 */
+	evsel->stats->aggr[METRIC_AGGR_IDX].counts.val = val;
 	if (evsel_script(leader)->gnum == leader->core.nr_members) {
 		for_each_group_member (ev2, leader) {
-			perf_stat__print_shadow_stats(&stat_config, ev2,
-						      evsel_script(ev2)->val,
-						      sample->cpu,
-						      &ctx,
-						      NULL);
+			perf_stat__print_shadow_stats(/*config=*/ &stat_config,
+			      /*evsel=*/ ev2,
+			      /*avg=*/ evsel->stats->aggr[METRIC_AGGR_IDX].counts.val,
+			      /*aggr_idx=*/ METRIC_AGGR_IDX,
+			      /*out=*/ &ctx,
+			      /*metric_events=*/ NULL);
 		}
 		evsel_script(leader)->gnum = 0;
 	}
@@ -2325,6 +2341,20 @@ static void process_event(struct perf_script *script,
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
@@ -2334,6 +2364,8 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
 	struct perf_cpu cpu;
 	static int header_printed;
 
+	check_metric_conflict();
+
 	if (!header_printed) {
 		printf("%3s %8s %15s %15s %15s %15s %s\n",
 		       "CPU", "THREAD", "VAL", "ENA", "RUN", "TIME", "EVENT");
@@ -3725,6 +3757,8 @@ static int process_stat_config_event(struct perf_session *session __maybe_unused
 {
 	perf_event__read_stat_config(&stat_config, &event->stat_config);
 
+	check_metric_conflict();
+
 	/*
 	 * Aggregation modes are not used since post-processing scripts are
 	 * supposed to take care of such requirements
@@ -4088,6 +4122,17 @@ int cmd_script(int argc, const char **argv)
 
 	argc = parse_options_subcommand(argc, argv, options, script_subcommands, script_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
+	for (i = 0; i < OUTPUT_TYPE_MAX; i++) {
+		if (output[i].fields & PERF_OUTPUT_METRIC) {
+			stat_config.aggr_map = cpu_aggr_map__empty_new(1);
+			err = -ENOMEM;
+			if (!stat_config.aggr_map)
+				goto out;
+			err = 0;
+			stat_config.aggr_map->nr = 1;
+			break;
+		}
+	}
 
 	if (symbol_conf.guestmount ||
 	    symbol_conf.default_guest_vmlinux_name ||
-- 
2.45.2

