Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C821A0B1E;
	Tue, 13 Aug 2024 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564902; cv=none; b=SPjCokUbw6HPNAR1IZLA4YqlHNVPP9F0/w9yGLgwsePHsBjN4jR31vVbMJVmavklTumulG75pHBfawL07Vi4qhD2eK2jcyGrph3zsiO2XMbaex/axQmBipGdvlXwl6mZTN5E24Dj9CDRNkZQvgkkbPm6SYD6o0jbTLf5z9Qigo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564902; c=relaxed/simple;
	bh=Ph5KwKnno7foh1DN9iqmyFy82JRkinAvPiWd5IiGz68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pmzbi8+h0sNXZoDtL6WQAvrRf6vAyFgw3qvkIZ1CREFPC0CZB4fyvFJPgb9oGb3Ebf4G00ZYRfx3vnD6M5sH+X1tX7xzAW2ARGvU3h2szx6hK6ZVGY7rkZvPinuTY1a1xMeHOYX7RsXAdlaYS3NUSNxRiFhYZPxPmZapIR363dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLZzwkI5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLZzwkI5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723564901; x=1755100901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ph5KwKnno7foh1DN9iqmyFy82JRkinAvPiWd5IiGz68=;
  b=eLZzwkI5ezFbLWPliWWYdkE+3g1aNHXv8o+22HHesfnY+UZDe2OQl1/F
   Z992ZVjauoR6SxhIgnWhMMxeMMMZG+tcXmMY1GOx2EiqKtr8agNg1x43+
   83Aji26KH57T5dKaBJ3fMliermXhFeJ7iETslkAqWE8dAWwDwHgBrVOfT
   F9+i/aVQardeGmE6frsd42lIKqsXYkFXyvQCGwQxgG0IEIbY5hKlQUoD4
   GNFN+E2YBwSTsDW+U2cWfliqgYan31ss/IhLkzuyAcqBBwUAPyIJuIJO5
   0MOgKHSyoF6HUffqv24b7FrE1Vz9rjX8Ia8SVYRm1lBILgPcbmgdbi30M
   g==;
X-CSE-ConnectionGUID: 3T6IUcJTRHSFTkRaZBX+5Q==
X-CSE-MsgGUID: DHzPuZwNTHG02IMIVvIAoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21383211"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="21383211"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 09:01:36 -0700
X-CSE-ConnectionGUID: af7tkjICRAuNQ/UGGDWYew==
X-CSE-MsgGUID: ytfN6cAYRwCEY4FtX5arDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="59479747"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa008.jf.intel.com with ESMTP; 13 Aug 2024 09:01:36 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 4/9] perf annotate: Save branch counters for each block
Date: Tue, 13 Aug 2024 09:02:03 -0700
Message-Id: <20240813160208.2493643-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240813160208.2493643-1-kan.liang@linux.intel.com>
References: <20240813160208.2493643-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

When annotating a basic block, it's useful to display the occurrences
of other events in the block.

The branch counter feature is only available for newer Intel platforms.
So a dedicated option to display the branch counters is not introduced.
Reuse the existing --total-cycles option, which triggers the annotation
of a basic block and displays the cycle-related annotation. When the
branch counters information is available, the branch counters are
automatically appended after all the cycle-related annotation.
Accounting the branch counters as well when accounting the cycles in
hist__account_cycles().

In struct annotated_branch, introduce a br_cntr array to save the
accumulation of each branch counter.
In a sample, all the branch counters for a branch are saved in a u64
space. Because the saturation of a branch counter is small, e.g., for
Intel Sierra Forest, the saturation is only 3. Add
ANNOTATION__BR_CNTR_SATURATED_FLAG to indicate if a branch counter
once saturated. That can be used to indicate a potential event lost
because of the saturation.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-annotate.c |  3 +-
 tools/perf/builtin-diff.c     |  4 +--
 tools/perf/builtin-report.c   |  2 +-
 tools/perf/builtin-top.c      |  4 +--
 tools/perf/util/annotate.c    | 68 ++++++++++++++++++++++++++++-------
 tools/perf/util/annotate.h    | 10 +++++-
 tools/perf/util/branch.h      |  1 +
 tools/perf/util/hist.c        |  5 +--
 tools/perf/util/hist.h        |  2 +-
 tools/perf/util/machine.c     |  3 ++
 10 files changed, 80 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index d6f6ba5a569d..9b4a8a379b5b 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -221,7 +221,8 @@ static int process_branch_callback(struct evsel *evsel,
 	if (a.map != NULL)
 		dso__set_hit(map__dso(a.map));
 
-	hist__account_cycles(sample->branch_stack, al, sample, false, NULL);
+	hist__account_cycles(sample->branch_stack, al, sample, false,
+			     NULL, evsel);
 
 	ret = hist_entry_iter__add(&iter, &a, PERF_MAX_STACK_DEPTH, ann);
 out:
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 28c5208fcdc9..6983b5373372 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -431,8 +431,8 @@ static int diff__process_sample_event(const struct perf_tool *tool,
 			goto out;
 		}
 
-		hist__account_cycles(sample->branch_stack, &al, sample, false,
-				     NULL);
+		hist__account_cycles(sample->branch_stack, &al, sample,
+				     false, NULL, evsel);
 		break;
 
 	case COMPUTE_STREAM:
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 04b9a5c1bc7e..ab450644e5b3 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -328,7 +328,7 @@ static int process_sample_event(const struct perf_tool *tool,
 	if (ui__has_annotation() || rep->symbol_ipc || rep->total_cycles_mode) {
 		hist__account_cycles(sample->branch_stack, &al, sample,
 				     rep->nonany_branch_mode,
-				     &rep->total_cycles);
+				     &rep->total_cycles, evsel);
 	}
 
 	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1cdac4e190e9..881b861c35ee 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -735,8 +735,8 @@ static int hist_iter__top_callback(struct hist_entry_iter *iter,
 		perf_top__record_precise_ip(top, iter->he, iter->sample, evsel, al->addr);
 
 	hist__account_cycles(iter->sample->branch_stack, al, iter->sample,
-		     !(top->record_opts.branch_stack & PERF_SAMPLE_BRANCH_ANY),
-		     NULL);
+			     !(top->record_opts.branch_stack & PERF_SAMPLE_BRANCH_ANY),
+			     NULL, evsel);
 	return 0;
 }
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a87d2e97e10d..c269758d47c8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -266,22 +266,30 @@ struct annotated_branch *annotation__get_branch(struct annotation *notes)
 	return notes->branch;
 }
 
-static struct cyc_hist *symbol__cycles_hist(struct symbol *sym)
+static struct annotated_branch *symbol__find_branch_hist(struct symbol *sym,
+							 unsigned int br_cntr_nr)
 {
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotated_branch *branch;
+	const size_t size = symbol__size(sym);
 
 	branch = annotation__get_branch(notes);
 	if (branch == NULL)
 		return NULL;
 
 	if (branch->cycles_hist == NULL) {
-		const size_t size = symbol__size(sym);
-
 		branch->cycles_hist = calloc(size, sizeof(struct cyc_hist));
+		if (!branch->cycles_hist)
+			return NULL;
+	}
+
+	if (br_cntr_nr && branch->br_cntr == NULL) {
+		branch->br_cntr = calloc(br_cntr_nr * size, sizeof(u64));
+		if (!branch->br_cntr)
+			return NULL;
 	}
 
-	return branch->cycles_hist;
+	return branch;
 }
 
 struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
@@ -316,16 +324,44 @@ static int symbol__inc_addr_samples(struct map_symbol *ms,
 	return src ? __symbol__inc_addr_samples(ms, src, evsel->core.idx, addr, sample) : 0;
 }
 
-static int symbol__account_cycles(u64 addr, u64 start,
-				  struct symbol *sym, unsigned cycles)
+static int symbol__account_br_cntr(struct annotated_branch *branch,
+				   struct evsel *evsel,
+				   unsigned offset,
+				   u64 br_cntr)
+{
+	unsigned int br_cntr_nr = evsel__leader(evsel)->br_cntr_nr;
+	unsigned int base = evsel__leader(evsel)->br_cntr_idx;
+	unsigned int width = evsel__env(evsel)->br_cntr_width;
+	unsigned int off = offset * evsel->evlist->nr_br_cntr;
+	unsigned int i, mask = (1L << width) - 1;
+	u64 *branch_br_cntr = branch->br_cntr;
+
+	if (!br_cntr || !branch_br_cntr)
+		return 0;
+
+	for (i = 0; i < br_cntr_nr; i++) {
+		u64 cntr = (br_cntr >> i * width) & mask;
+
+		branch_br_cntr[off + i + base] += cntr;
+		if (cntr == mask)
+			branch_br_cntr[off + i + base] |= ANNOTATION__BR_CNTR_SATURATED_FLAG;
+	}
+
+	return 0;
+}
+
+static int symbol__account_cycles(u64 addr, u64 start, struct symbol *sym,
+				  unsigned cycles, struct evsel *evsel,
+				  u64 br_cntr)
 {
-	struct cyc_hist *cycles_hist;
+	struct annotated_branch *branch;
 	unsigned offset;
+	int ret;
 
 	if (sym == NULL)
 		return 0;
-	cycles_hist = symbol__cycles_hist(sym);
-	if (cycles_hist == NULL)
+	branch = symbol__find_branch_hist(sym, evsel->evlist->nr_br_cntr);
+	if (!branch)
 		return -ENOMEM;
 	if (addr < sym->start || addr >= sym->end)
 		return -ERANGE;
@@ -337,15 +373,22 @@ static int symbol__account_cycles(u64 addr, u64 start,
 			start = 0;
 	}
 	offset = addr - sym->start;
-	return __symbol__account_cycles(cycles_hist,
+	ret = __symbol__account_cycles(branch->cycles_hist,
 					start ? start - sym->start : 0,
 					offset, cycles,
 					!!start);
+
+	if (ret)
+		return ret;
+
+	return symbol__account_br_cntr(branch, evsel, offset, br_cntr);
 }
 
 int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
 				    struct addr_map_symbol *start,
-				    unsigned cycles)
+				    unsigned cycles,
+				    struct evsel *evsel,
+				    u64 br_cntr)
 {
 	u64 saddr = 0;
 	int err;
@@ -371,7 +414,7 @@ int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
 			start ? start->addr : 0,
 			ams->ms.sym ? ams->ms.sym->start + map__start(ams->ms.map) : 0,
 			saddr);
-	err = symbol__account_cycles(ams->al_addr, saddr, ams->ms.sym, cycles);
+	err = symbol__account_cycles(ams->al_addr, saddr, ams->ms.sym, cycles, evsel, br_cntr);
 	if (err)
 		pr_debug2("account_cycles failed %d\n", err);
 	return err;
@@ -412,6 +455,7 @@ static void annotated_branch__delete(struct annotated_branch *branch)
 {
 	if (branch) {
 		zfree(&branch->cycles_hist);
+		free(branch->br_cntr);
 		free(branch);
 	}
 }
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 0e52558baa01..6b3023f3b18f 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -14,6 +14,7 @@
 #include "spark.h"
 #include "hashmap.h"
 #include "disasm.h"
+#include "branch.h"
 
 struct hist_browser_timer;
 struct hist_entry;
@@ -288,6 +289,9 @@ struct annotated_source {
 struct annotation_line *annotated_source__get_line(struct annotated_source *src,
 						   s64 offset);
 
+/* A branch counter once saturated */
+#define ANNOTATION__BR_CNTR_SATURATED_FLAG	(1ULL << 63)
+
 /**
  * struct annotated_branch - basic block and IPC information for a symbol.
  *
@@ -297,6 +301,7 @@ struct annotation_line *annotated_source__get_line(struct annotated_source *src,
  * @cover_insn: Number of distinct, actually executed instructions.
  * @cycles_hist: Array of cyc_hist for each instruction.
  * @max_coverage: Maximum number of covered basic block (used for block-range).
+ * @br_cntr: Array of the occurrences of events (branch counters) during a block.
  *
  * This struct is used by two different codes when the sample has branch stack
  * and cycles information.  annotation__compute_ipc() calculates average IPC
@@ -313,6 +318,7 @@ struct annotated_branch {
 	unsigned int		cover_insn;
 	struct cyc_hist		*cycles_hist;
 	u64			max_coverage;
+	u64			*br_cntr;
 };
 
 struct LOCKABLE annotation {
@@ -383,7 +389,9 @@ struct annotated_branch *annotation__get_branch(struct annotation *notes);
 
 int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
 				    struct addr_map_symbol *start,
-				    unsigned cycles);
+				    unsigned cycles,
+				    struct evsel *evsel,
+				    u64 br_cntr);
 
 int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *sample,
 				 struct evsel *evsel, u64 addr);
diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 87704d713ff6..b80c12c74bbb 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -34,6 +34,7 @@ struct branch_info {
 	struct addr_map_symbol from;
 	struct addr_map_symbol to;
 	struct branch_flags    flags;
+	u64		       branch_stack_cntr;
 	char		       *srcline_from;
 	char		       *srcline_to;
 };
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index c8c1b511f8a7..0f554febf9a1 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2677,7 +2677,7 @@ int hists__unlink(struct hists *hists)
 
 void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			  struct perf_sample *sample, bool nonany_branch_mode,
-			  u64 *total_cycles)
+			  u64 *total_cycles, struct evsel *evsel)
 {
 	struct branch_info *bi;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
@@ -2701,7 +2701,8 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			for (int i = bs->nr - 1; i >= 0; i--) {
 				addr_map_symbol__account_cycles(&bi[i].from,
 					nonany_branch_mode ? NULL : prev,
-					bi[i].flags.cycles);
+					bi[i].flags.cycles, evsel,
+					bi[i].branch_stack_cntr);
 				prev = &bi[i].to;
 
 				if (total_cycles)
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 5273f5c37050..30c13fc8cbe4 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -742,7 +742,7 @@ unsigned int hists__overhead_width(struct hists *hists);
 
 void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			  struct perf_sample *sample, bool nonany_branch_mode,
-			  u64 *total_cycles);
+			  u64 *total_cycles, struct evsel *evsel);
 
 struct option;
 int parse_filter_percentage(const struct option *opt, const char *arg, int unset);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 706be5e4a076..c08774d06d14 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2141,6 +2141,7 @@ struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
 	unsigned int i;
 	const struct branch_stack *bs = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
+	u64 *branch_stack_cntr = sample->branch_stack_cntr;
 	struct branch_info *bi = calloc(bs->nr, sizeof(struct branch_info));
 
 	if (!bi)
@@ -2150,6 +2151,8 @@ struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
 		ip__resolve_ams(al->thread, &bi[i].to, entries[i].to);
 		ip__resolve_ams(al->thread, &bi[i].from, entries[i].from);
 		bi[i].flags = entries[i].flags;
+		if (branch_stack_cntr)
+			bi[i].branch_stack_cntr  = branch_stack_cntr[i];
 	}
 	return bi;
 }
-- 
2.38.1

