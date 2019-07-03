From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/18] perf hists: Add block_info in hist_entry
Date: Wed,  3 Jul 2019 00:27:31 -0300
Message-ID: <20190703032746.21692-4-acme@kernel.org>
References: <20190703032746.21692-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190703032746.21692-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

The block_info contains the program basic block information, i.e,
contains the start address and the end address of this basic block and
how much cycles it takes.

We need to compare, sort and even print out the basic block by some
orders, i.e. sort by cycles.

For this purpose, we add block_info field to hist_entry. In order not to
impact current interface, we creates a new function
hists__add_entry_block.

 v6:
 ---
 Remove the 'ops' argument in hists__add_entry_block

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1561713784-30533-3-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 20 ++++++++++++++++++--
 tools/perf/util/hist.h |  5 +++++
 tools/perf/util/sort.h |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index fb3271fd420c..c4defff151ed 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -574,6 +574,8 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 			 */
 			mem_info__zput(entry->mem_info);
 
+			block_info__zput(entry->block_info);
+
 			/* If the map of an existing hist_entry has
 			 * become out-of-date due to an exec() or
 			 * similar, update it.  Otherwise we will
@@ -645,6 +647,7 @@ __hists__add_entry(struct hists *hists,
 		   struct symbol *sym_parent,
 		   struct branch_info *bi,
 		   struct mem_info *mi,
+		   struct block_info *block_info,
 		   struct perf_sample *sample,
 		   bool sample_self,
 		   struct hist_entry_ops *ops)
@@ -677,6 +680,7 @@ __hists__add_entry(struct hists *hists,
 		.hists	= hists,
 		.branch_info = bi,
 		.mem_info = mi,
+		.block_info = block_info,
 		.transaction = sample->transaction,
 		.raw_data = sample->raw_data,
 		.raw_size = sample->raw_size,
@@ -699,7 +703,7 @@ struct hist_entry *hists__add_entry(struct hists *hists,
 				    struct perf_sample *sample,
 				    bool sample_self)
 {
-	return __hists__add_entry(hists, al, sym_parent, bi, mi,
+	return __hists__add_entry(hists, al, sym_parent, bi, mi, NULL,
 				  sample, sample_self, NULL);
 }
 
@@ -712,10 +716,22 @@ struct hist_entry *hists__add_entry_ops(struct hists *hists,
 					struct perf_sample *sample,
 					bool sample_self)
 {
-	return __hists__add_entry(hists, al, sym_parent, bi, mi,
+	return __hists__add_entry(hists, al, sym_parent, bi, mi, NULL,
 				  sample, sample_self, ops);
 }
 
+struct hist_entry *hists__add_entry_block(struct hists *hists,
+					  struct addr_location *al,
+					  struct block_info *block_info)
+{
+	struct hist_entry entry = {
+		.block_info = block_info,
+		.hists = hists,
+	}, *he = hists__findnew_entry(hists, &entry, al, false);
+
+	return he;
+}
+
 static int
 iter_next_nop_entry(struct hist_entry_iter *iter __maybe_unused,
 		    struct addr_location *al __maybe_unused)
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 76ff6c6d03b8..c670122b4e40 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -16,6 +16,7 @@ struct addr_location;
 struct map_symbol;
 struct mem_info;
 struct branch_info;
+struct block_info;
 struct symbol;
 
 enum hist_filter {
@@ -149,6 +150,10 @@ struct hist_entry *hists__add_entry_ops(struct hists *hists,
 					struct perf_sample *sample,
 					bool sample_self);
 
+struct hist_entry *hists__add_entry_block(struct hists *hists,
+					  struct addr_location *al,
+					  struct block_info *bi);
+
 int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 			 int max_stack_depth, void *arg);
 
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index ce376a73f964..43623fa874b2 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -144,6 +144,7 @@ struct hist_entry {
 	long			time;
 	struct hists		*hists;
 	struct mem_info		*mem_info;
+	struct block_info	*block_info;
 	void			*raw_data;
 	u32			raw_size;
 	int			num_res;
-- 
2.20.1
