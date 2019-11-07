From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 57/63] perf diff: Don't use hack to skip column length calculation
Date: Thu,  7 Nov 2019 16:00:05 -0300
Message-ID: <20191107190011.23924-58-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Previously we use a nasty hack to skip the hists__calc_col_len for block
since this function is not very suitable for block column length
calculation.

This patch removes the hack code and add a check at the entry of
hists__calc_col_len to skip for block case.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191107074719.26139-2-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c | 11 ++---------
 tools/perf/util/hist.c    |  2 ++
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 5281629c27b1..faf99a81ad3e 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -765,13 +765,6 @@ static void block_hists_match(struct hists *hists_base,
 	}
 }
 
-static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
-{
-	/* Skip the calculation of column length in output_resort */
-	he->filtered = true;
-	return 0;
-}
-
 static void hists__precompute(struct hists *hists)
 {
 	struct rb_root_cached *root;
@@ -820,8 +813,8 @@ static void hists__precompute(struct hists *hists)
 				if (bh->valid && pair_bh->valid) {
 					block_hists_match(&bh->block_hists,
 							  &pair_bh->block_hists);
-					hists__output_resort_cb(&pair_bh->block_hists,
-								NULL, filter_cb);
+					hists__output_resort(&pair_bh->block_hists,
+							     NULL);
 				}
 				break;
 			default:
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 679a1d75090c..daa6eef4fde0 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -80,6 +80,8 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	int symlen;
 	u16 len;
 
+	if (h->block_info)
+		return;
 	/*
 	 * +4 accounts for '[x] ' priv level info
 	 * +2 accounts for 0x prefix on raw addresses
-- 
2.21.0
