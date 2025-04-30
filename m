Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975C72C032A;
	Wed, 30 Apr 2025 20:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046555; cv=none; b=HcLDTBP00P4l+wWpbeQ8wx/e5kfeo/rvXTpMVFcAGCjyJTtz9t/5Uqblpnyj4Wh/5a6lm/lifSety5XMkqSHftVBexf0dkXAp/bEh/00mA2NCUOTPHujdKmd6mF5WQi24Nafgu4IUy2Gdrdb1vMhIYkHCEimb9YXU1UPuOOhHKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046555; c=relaxed/simple;
	bh=1HgdoUcLZHaR7izvGv+l6i60L6/dassgp57VUa1iSlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQ76vllqClulHSg83D13LggeAa++AfgBuOVXhiqtP6WmpheA7tiQB767fmPwAzrA4Ri5tdc6kf806wvzMo0ey8Ugh9JHTC8yBVSWuL04mwb2Y2shteNyEZBzvhfm2KpcN2Z3N6gihNl5cQGyIjIY/Vme6F6gMukakKhHo+nt0qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxYoD6zI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxYoD6zI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639ECC4CEEC;
	Wed, 30 Apr 2025 20:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746046554;
	bh=1HgdoUcLZHaR7izvGv+l6i60L6/dassgp57VUa1iSlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NxYoD6zI73QFrUGaGRQk/SU2TmzRke7jKR3HPVNlGJZZsJRJs1oC7mHwxOd/U5Wb+
	 g1Rwe1lJxaPbQSTpX2zqaqdswmPRbFh5umyZBATQbSQWVaQ9s5AtQvRg18kIos1RNr
	 3MSFvDO3ZfSrCxnVVypLGAurmOerSBvN2P3xFd79xOFamdXh7TUwtPcBPwpBtGOtZi
	 TXRhwX2cF+oz9ZLeBTqSRanbs1Jxfr9YzKeV2UWGroX8PSllwsE/P8OrDmZzNr0Psu
	 2eMS1i5LilaIKRNyI84ZAX0W9NAwwmseKqkrxYWCxTdDfN4VTZdncWERxNaxq4llEQ
	 n+Le4yVCGp4YA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Leo Yan <leo.yan@arm.com>
Subject: [PATCH 07/11] perf mem: Add 'op' output field
Date: Wed, 30 Apr 2025 13:55:44 -0700
Message-ID: <20250430205548.789750-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250430205548.789750-1-namhyung@kernel.org>
References: <20250430205548.789750-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an actual example of the he_mem_stat based sample breakdown.  It
uses 'mem_op' field of union perf_mem_data_src which means memory
operations.

It'd have basically 'load' or 'store' which can be useful if PMU doesn't
have separate events for them like IBS or SPE.  In addition, there's an
entry in case load and store happen at the same time.  Also adds entries
for prefetching and execution.

  $ perf mem report -F +op -s comm --stdio
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 4K of event 'ibs_op//'
  # Total weight : 9559
  # Sort order   : comm
  #
  #                         ------------------------ Mem Op ------------------------
  # Overhead       Samples     Load  Store  Ld+St Pfetch   Exec  Other    N/A    N/A  Command
  # ........  ............  ........................................................  ...............
  #
      44.85%          4077    21.1%  30.7%   0.0%   0.0%   0.0%  48.3%   0.0%   0.0%  swapper
      26.82%            45    98.8%   0.3%   0.0%   0.0%   0.0%   0.9%   0.0%   0.0%  netsli-prober
       7.19%           442    51.7%  13.7%   0.0%   0.0%   0.0%  34.6%   0.0%   0.0%  perf
       5.81%            75    89.7%   2.2%   0.0%   0.0%   0.0%   8.1%   0.0%   0.0%  qemu-system-ppc
       4.77%             1   100.0%   0.0%   0.0%   0.0%   0.0%   0.0%   0.0%   0.0%  notifications_c
       1.77%            10    95.9%   1.2%   0.0%   0.0%   0.0%   3.0%   0.0%   0.0%  MemoryReleaser
       0.77%            32    71.6%   4.1%   0.0%   0.0%   0.0%  24.3%   0.0%   0.0%  DefaultEventMan
       0.19%            10    66.7%  22.2%   0.0%   0.0%   0.0%  11.1%   0.0%   0.0%  gnome-shell

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/hists.c |  3 +++
 tools/perf/ui/hist.c           | 12 ++++++---
 tools/perf/util/hist.h         |  2 +-
 tools/perf/util/mem-events.c   | 48 ++++++++++++++++++++++++++--------
 tools/perf/util/mem-events.h   | 11 +++++++-
 tools/perf/util/sort.c         |  2 +-
 6 files changed, 61 insertions(+), 17 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index f6ab1310a0bdd6c4..66a4c769b2d76436 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -1284,6 +1284,7 @@ __HPP_COLOR_PERCENT_FN(overhead_guest_sys, period_guest_sys, PERF_HPP_FMT_TYPE__
 __HPP_COLOR_PERCENT_FN(overhead_guest_us, period_guest_us, PERF_HPP_FMT_TYPE__PERCENT)
 __HPP_COLOR_ACC_PERCENT_FN(overhead_acc, period, PERF_HPP_FMT_TYPE__PERCENT)
 __HPP_COLOR_ACC_PERCENT_FN(latency_acc, latency, PERF_HPP_FMT_TYPE__LATENCY)
+__HPP_COLOR_MEM_STAT_FN(op, OP)
 
 #undef __HPP_COLOR_PERCENT_FN
 #undef __HPP_COLOR_ACC_PERCENT_FN
@@ -1307,6 +1308,8 @@ void hist_browser__init_hpp(void)
 				hist_browser__hpp_color_overhead_acc;
 	perf_hpp__format[PERF_HPP__LATENCY_ACC].color =
 				hist_browser__hpp_color_latency_acc;
+	perf_hpp__format[PERF_HPP__MEM_STAT_OP].color =
+				hist_browser__hpp_color_mem_stat_op;
 
 	res_sample_init();
 }
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 2a5c9f2b328b2c5c..427ce687ad815a62 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -342,6 +342,12 @@ static enum mem_stat_type hpp__mem_stat_type(struct perf_hpp_fmt *fmt)
 	if (!perf_hpp__is_mem_stat_entry(fmt))
 		return -1;
 
+	switch (fmt->idx) {
+	case PERF_HPP__MEM_STAT_OP:
+		return PERF_MEM_STAT_OP;
+	default:
+		break;
+	}
 	pr_debug("Should not reach here\n");
 	return -1;
 }
@@ -611,7 +617,7 @@ HPP_AVERAGE_FNS(weight1, weight1)
 HPP_AVERAGE_FNS(weight2, weight2)
 HPP_AVERAGE_FNS(weight3, weight3)
 
-HPP_MEM_STAT_FNS(unknown, UNKNOWN)  /* placeholder */
+HPP_MEM_STAT_FNS(op, OP)
 
 static int64_t hpp__nop_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 			    struct hist_entry *a __maybe_unused,
@@ -715,7 +721,7 @@ struct perf_hpp_fmt perf_hpp__format[] = {
 	HPP__PRINT_FNS("Weight1", weight1, WEIGHT1),
 	HPP__PRINT_FNS("Weight2", weight2, WEIGHT2),
 	HPP__PRINT_FNS("Weight3", weight3, WEIGHT3),
-	HPP__MEM_STAT_PRINT_FNS("Unknown", unknown, UNKNOWN),  /* placeholder */
+	HPP__MEM_STAT_PRINT_FNS("Mem Op", op, OP),
 };
 
 struct perf_hpp_list perf_hpp_list = {
@@ -1070,7 +1076,7 @@ void perf_hpp__reset_width(struct perf_hpp_fmt *fmt, struct hists *hists)
 		fmt->len = 8;
 		break;
 
-	case PERF_HPP__MEM_STAT_UNKNOWN:  /* placeholder */
+	case PERF_HPP__MEM_STAT_OP:
 		fmt->len = MEM_STAT_LEN * MEM_STAT_PRINT_LEN;
 		break;
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 18c696d8d568a9fa..3990cfc21b1615ae 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -587,7 +587,7 @@ enum {
 	PERF_HPP__WEIGHT1,
 	PERF_HPP__WEIGHT2,
 	PERF_HPP__WEIGHT3,
-	PERF_HPP__MEM_STAT_UNKNOWN,  /* placeholder */
+	PERF_HPP__MEM_STAT_OP,
 
 	PERF_HPP__MAX_INDEX
 };
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index a4c1e42de30f8307..1c44ccc026fe9974 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -303,15 +303,12 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr, char **eve
 	}
 
 	if (cpu_map) {
-		struct perf_cpu_map *online = cpu_map__online();
-
-		if (!perf_cpu_map__equal(cpu_map, online)) {
+		if (!perf_cpu_map__equal(cpu_map, cpu_map__online())) {
 			char buf[200];
 
 			cpu_map__snprint(cpu_map, buf, sizeof(buf));
 			pr_warning("Memory events are enabled on a subset of CPUs: %s\n", buf);
 		}
-		perf_cpu_map__put(online);
 		perf_cpu_map__put(cpu_map);
 	}
 
@@ -803,18 +800,32 @@ void c2c_add_stats(struct c2c_stats *stats, struct c2c_stats *add)
 /*
  * It returns an index in hist_entry->mem_stat array for the given val which
  * represents a data-src based on the mem_stat_type.
- *
- * For example, when mst is about cache level, the index can be 1 for L1, 2 for
- * L2 and so on.
  */
 int mem_stat_index(const enum mem_stat_type mst, const u64 val)
 {
+	union perf_mem_data_src src = {
+		.val = val,
+	};
+
 	switch (mst) {
-	case PERF_MEM_STAT_UNKNOWN:  /* placeholder */
+	case PERF_MEM_STAT_OP:
+		switch (src.mem_op) {
+		case PERF_MEM_OP_LOAD:
+			return MEM_STAT_OP_LOAD;
+		case PERF_MEM_OP_STORE:
+			return MEM_STAT_OP_STORE;
+		case PERF_MEM_OP_LOAD | PERF_MEM_OP_STORE:
+			return MEM_STAT_OP_LDST;
+		default:
+			if (src.mem_op & PERF_MEM_OP_PFETCH)
+				return MEM_STAT_OP_PFETCH;
+			if (src.mem_op & PERF_MEM_OP_EXEC)
+				return MEM_STAT_OP_EXEC;
+			return MEM_STAT_OP_OTHER;
+		}
 	default:
 		break;
 	}
-	(void)val;
 	return -1;
 }
 
@@ -822,10 +833,25 @@ int mem_stat_index(const enum mem_stat_type mst, const u64 val)
 const char *mem_stat_name(const enum mem_stat_type mst, const int idx)
 {
 	switch (mst) {
-	case PERF_MEM_STAT_UNKNOWN:
+	case PERF_MEM_STAT_OP:
+		switch (idx) {
+		case MEM_STAT_OP_LOAD:
+			return "Load";
+		case MEM_STAT_OP_STORE:
+			return "Store";
+		case MEM_STAT_OP_LDST:
+			return "Ld+St";
+		case MEM_STAT_OP_PFETCH:
+			return "Pfetch";
+		case MEM_STAT_OP_EXEC:
+			return "Exec";
+		case MEM_STAT_OP_OTHER:
+			return "Other";
+		default:
+			break;
+		}
 	default:
 		break;
 	}
-	(void)idx;
 	return "N/A";
 }
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 7aeb4c5fefc89698..55e5e2607fb732b4 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -90,7 +90,16 @@ int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi);
 void c2c_add_stats(struct c2c_stats *stats, struct c2c_stats *add);
 
 enum mem_stat_type {
-	PERF_MEM_STAT_UNKNOWN,  /* placeholder */
+	PERF_MEM_STAT_OP,
+};
+
+enum mem_stat_op {
+	MEM_STAT_OP_LOAD,
+	MEM_STAT_OP_STORE,
+	MEM_STAT_OP_LDST,
+	MEM_STAT_OP_PFETCH,
+	MEM_STAT_OP_EXEC,
+	MEM_STAT_OP_OTHER,
 };
 
 #define MEM_STAT_PRINT_LEN  7  /* 1 space + 5 digits + 1 percent sign */
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 7c669ea27af247e5..53fcb9191ea0cdc3 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2623,7 +2623,7 @@ static struct hpp_dimension hpp_sort_dimensions[] = {
 	DIM(PERF_HPP__WEIGHT3, "retire_lat"),
 	DIM(PERF_HPP__WEIGHT3, "p_stage_cyc"),
 	/* used for output only when SORT_MODE__MEM */
-	DIM_MEM(PERF_HPP__MEM_STAT_UNKNOWN, "unknown"),  /* placeholder */
+	DIM_MEM(PERF_HPP__MEM_STAT_OP, "op"),
 };
 
 #undef DIM_MEM
-- 
2.49.0.906.g1f30a19c02-goog

