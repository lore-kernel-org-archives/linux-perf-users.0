Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8281CEAC0;
	Thu, 10 Oct 2024 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728585650; cv=none; b=sYr28Ds59zqo02EjmAdZ9OrLrzvPKNkfpHkIxNq8SqrEob425/FwDpoKeHWR3zAbCrJ/LvYWV5ivInua6fNZVibMvIX7EO+NiYvXY9ioAtQ5IsZ3WCFgxYFWfKLAsSoI3mUumNq5/GO840P8SgaXrMVWXQr/N87ZOFR51WQQ4mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728585650; c=relaxed/simple;
	bh=8zyGryIG+8f37y9X6+jQKoGyj1yPV5E+vuAhGInmxiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IS83kcCeIlrlF04K9gVj8Sw5YfsrRKDIMbbLKfVSbcssFlGkciix0dQsjwxrBcYEFtWqZ4zBMq/wx4nsVcesI9AnUKtKuB60WH80mDy9YBrLNSoGOvPq4l741UNGVhud9SiQdqgr6itnAqjeFe1nWNkFdZqlLZwwoe9u20aCi3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bt57W1IZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bt57W1IZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728585648; x=1760121648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8zyGryIG+8f37y9X6+jQKoGyj1yPV5E+vuAhGInmxiI=;
  b=bt57W1IZ0LRfDDWGHBIYZI2+d3IwQ6xDXqWI/uqFR8s6Hb7q4xbFVtjv
   QK9xjTApsW/Dj+BDzxI6VCCvs42fSR9RFW2I0J7vgJQ2AbKcuAuwj7v7M
   esv/ajPTnHlXegBYpCngXpj9qOGNudXd3hivbxxSZa7LfaFrav307GCGK
   27WlkhqD0bXxzIwSgiA5O/jgzaow8i6/nGsn9kqiTW67Pl4uJZCpFKKI3
   PMJb5MX0KNFz9oSBlJ0XklNhojWOhkfycd3mxHbr5Yny6aMFjAHiwQocw
   I0syqK9eR5jmpyWjhQ0AMtSIMrKwGnwHBDTCD0OemBwxFMGDqvmIzq93G
   Q==;
X-CSE-ConnectionGUID: W0CXof51TYiSEZIxOmz0mA==
X-CSE-MsgGUID: vjvKMwi1RjaQ6F+CQ87qRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="27415478"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="27415478"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 11:40:47 -0700
X-CSE-ConnectionGUID: PvEJGH1rSJ2DMABBSKGV8A==
X-CSE-MsgGUID: Wz80ePwJR/OsOjWgGi1q9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76882872"
Received: from tfalcon-desk.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.223.143])
  by orviesa006.jf.intel.com with ESMTP; 10 Oct 2024 11:40:46 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ak@linux.intel.com,
	linux@treblig.org
Subject: [PATCH] perf report: Display columns Predicted/Abort/Cycles in --branch-history
Date: Thu, 10 Oct 2024 13:40:46 -0500
Message-ID: <20241010184046.203822-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <Zwcg3ULyehsSODxF@google.com>
References: <Zwcg3ULyehsSODxF@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original commit message:

"
Use current sort mechanism but the real .se_cmp() just returns 0 so
that new columns "Predicted", "Abort" and "Cycles" are created in display
but actually these keys are not the sort keys.

For example:

Overhead  Source:Line   Symbol    Shared Object  Predicted  Abort  Cycles
........  ............  ........  .............  .........  .....  ......

  38.25%  div.c:45      [.] main  div            97.6%      0      3
"

Update missed commit from series "perf report: Show branch flags/cycles
in --branch-history callgraph view" to apply to current repository so that
new columns described above are visible.

Link to original series:
https://lore.kernel.org/lkml/1477876794-30749-1-git-send-email-yao.jin@linux.intel.com/

Reported-by: Dr. David Alan Gilbert <linux@treblig.org>
Suggested-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/Documentation/perf-report.txt |   8 ++
 tools/perf/builtin-report.c              |   6 +-
 tools/perf/util/hist.c                   |   3 +
 tools/perf/util/hist.h                   |   3 +
 tools/perf/util/sort.c                   | 113 ++++++++++++++++++++++-
 tools/perf/util/sort.h                   |   3 +
 6 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 7c66d81ab978..87f864519406 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -391,6 +391,14 @@ OPTIONS
 	This allows to examine the path the program took to each sample.
 	The data collection must have used -b (or -j) and -g.
 
+	Also show with some branch flags that can be:
+	- Predicted: display the average percentage of predicated branches.
+		     (predicated number / total number)
+	- Abort: display the number of tsx aborted branches.
+	- Cycles: cycles in basic block.
+
+	- iterations: display the average number of iterations in callchain list.
+
 --addr2line=<path>::
         Path to addr2line binary.
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 5dc17ffee27a..36b344e39dd6 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1271,6 +1271,10 @@ static int process_attr(const struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
+#define CALLCHAIN_BRANCH_SORT_ORDER	\
+	"srcline,symbol,dso,callchain_branch_predicted," \
+	"callchain_branch_abort,callchain_branch_cycles"
+
 int cmd_report(int argc, const char **argv)
 {
 	struct perf_session *session;
@@ -1639,7 +1643,7 @@ int cmd_report(int argc, const char **argv)
 		symbol_conf.use_callchain = true;
 		callchain_register_param(&callchain_param);
 		if (sort_order == NULL)
-			sort_order = "srcline,symbol,dso";
+			sort_order = CALLCHAIN_BRANCH_SORT_ORDER;
 	}
 
 	if (report.mem_mode) {
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index f387e85a0087..fff134565801 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -218,6 +218,9 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	hists__new_col_len(hists, HISTC_LOCAL_P_STAGE_CYC, 13);
 	hists__new_col_len(hists, HISTC_GLOBAL_P_STAGE_CYC, 13);
 	hists__new_col_len(hists, HISTC_ADDR, BITS_PER_LONG / 4 + 2);
+	hists__new_col_len(hists, HISTC_CALLCHAIN_BRANCH_PREDICTED, 9);
+	hists__new_col_len(hists, HISTC_CALLCHAIN_BRANCH_ABORT, 5);
+	hists__new_col_len(hists, HISTC_CALLCHAIN_BRANCH_CYCLES, 6);
 
 	if (symbol_conf.nanosecs)
 		hists__new_col_len(hists, HISTC_TIME, 16);
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 7d7ae94b4b31..1131056924d9 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -87,6 +87,9 @@ enum hist_column {
 	HISTC_TYPE_OFFSET,
 	HISTC_SYMBOL_OFFSET,
 	HISTC_TYPE_CACHELINE,
+	HISTC_CALLCHAIN_BRANCH_PREDICTED,
+	HISTC_CALLCHAIN_BRANCH_ABORT,
+	HISTC_CALLCHAIN_BRANCH_CYCLES,
 	HISTC_NR_COLS, /* Last entry */
 };
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 013020f33ece..168c488f0178 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -677,6 +677,102 @@ struct sort_entry sort_sym_ipc_null = {
 	.se_width_idx	= HISTC_SYMBOL_IPC,
 };
 
+/* --sort callchain_branch_predicted */
+
+static int64_t
+sort__callchain_branch_predicted_cmp(struct hist_entry *left __maybe_unused,
+				     struct hist_entry *right __maybe_unused)
+{
+	return 0;
+}
+
+static int hist_entry__callchain_branch_predicted_snprintf(
+	struct hist_entry *he, char *bf, size_t size, unsigned int width)
+{
+	u64 branch_count, predicted_count;
+	double percent = 0.0;
+	char str[32];
+
+	callchain_branch_counts(he->callchain, &branch_count,
+				&predicted_count, NULL, NULL);
+
+	if (branch_count)
+		percent = predicted_count * 100.0 / branch_count;
+
+	snprintf(str, sizeof(str), "%.1f%%", percent);
+	return repsep_snprintf(bf, size, "%-*.*s", width, width, str);
+}
+
+struct sort_entry sort_callchain_branch_predicted = {
+	.se_header	= "Predicted",
+	.se_cmp		= sort__callchain_branch_predicted_cmp,
+	.se_snprintf	= hist_entry__callchain_branch_predicted_snprintf,
+	.se_width_idx	= HISTC_CALLCHAIN_BRANCH_PREDICTED,
+};
+
+/* --sort callchain_branch_abort */
+
+static int64_t
+sort__callchain_branch_abort_cmp(struct hist_entry *left __maybe_unused,
+				 struct hist_entry *right __maybe_unused)
+{
+	return 0;
+}
+
+static int hist_entry__callchain_branch_abort_snprintf(struct hist_entry *he,
+						       char *bf, size_t size,
+						       unsigned int width)
+{
+	u64 branch_count, abort_count;
+	char str[32];
+
+	callchain_branch_counts(he->callchain, &branch_count,
+				NULL, &abort_count, NULL);
+
+	snprintf(str, sizeof(str), "%" PRId64, abort_count);
+	return repsep_snprintf(bf, size, "%-*.*s", width, width, str);
+}
+
+struct sort_entry sort_callchain_branch_abort = {
+	.se_header	= "Abort",
+	.se_cmp		= sort__callchain_branch_abort_cmp,
+	.se_snprintf	= hist_entry__callchain_branch_abort_snprintf,
+	.se_width_idx	= HISTC_CALLCHAIN_BRANCH_ABORT,
+};
+
+/* --sort callchain_branch_cycles */
+
+static int64_t
+sort__callchain_branch_cycles_cmp(struct hist_entry *left __maybe_unused,
+				  struct hist_entry *right __maybe_unused)
+{
+	return 0;
+}
+
+static int hist_entry__callchain_branch_cycles_snprintf(struct hist_entry *he,
+							char *bf, size_t size,
+							unsigned int width)
+{
+	u64 branch_count, cycles_count, cycles = 0;
+	char str[32];
+
+	callchain_branch_counts(he->callchain, &branch_count,
+				NULL, NULL, &cycles_count);
+
+	if (branch_count)
+		cycles = cycles_count / branch_count;
+
+	snprintf(str, sizeof(str), "%" PRId64 "", cycles);
+	return repsep_snprintf(bf, size, "%-*.*s", width, width, str);
+}
+
+struct sort_entry sort_callchain_branch_cycles = {
+	.se_header	= "Cycles",
+	.se_cmp		= sort__callchain_branch_cycles_cmp,
+	.se_snprintf	= hist_entry__callchain_branch_cycles_snprintf,
+	.se_width_idx	= HISTC_CALLCHAIN_BRANCH_CYCLES,
+};
+
 /* --sort srcfile */
 
 static char no_srcfile[1];
@@ -2456,6 +2552,15 @@ static struct sort_dimension bstack_sort_dimensions[] = {
 	DIM(SORT_SYM_IPC, "ipc_lbr", sort_sym_ipc),
 	DIM(SORT_ADDR_FROM, "addr_from", sort_addr_from),
 	DIM(SORT_ADDR_TO, "addr_to", sort_addr_to),
+	DIM(SORT_CALLCHAIN_BRANCH_PREDICTED,
+		"callchain_branch_predicted",
+		sort_callchain_branch_predicted),
+	DIM(SORT_CALLCHAIN_BRANCH_ABORT,
+		"callchain_branch_abort",
+		sort_callchain_branch_abort),
+	DIM(SORT_CALLCHAIN_BRANCH_CYCLES,
+		"callchain_branch_cycles",
+		sort_callchain_branch_cycles)
 };
 
 #undef DIM
@@ -3484,7 +3589,13 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 		if (!sd->name || strncasecmp(tok, sd->name, strlen(tok)))
 			continue;
 
-		if (sort__mode != SORT_MODE__BRANCH)
+		if ((sort__mode != SORT_MODE__BRANCH) &&
+			strncasecmp(tok, "callchain_branch_predicted",
+				    strlen(tok)) &&
+			strncasecmp(tok, "callchain_branch_abort",
+				    strlen(tok)) &&
+			strncasecmp(tok, "callchain_branch_cycles",
+				    strlen(tok)))
 			return -EINVAL;
 
 		if (sd->entry == &sort_sym_from || sd->entry == &sort_sym_to)
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 9ff68c6786e7..a8572574e168 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -88,6 +88,9 @@ enum sort_type {
 	SORT_SYM_IPC,
 	SORT_ADDR_FROM,
 	SORT_ADDR_TO,
+	SORT_CALLCHAIN_BRANCH_PREDICTED,
+	SORT_CALLCHAIN_BRANCH_ABORT,
+	SORT_CALLCHAIN_BRANCH_CYCLES,
 
 	/* memory mode specific sort keys */
 	__SORT_MEMORY_MODE,
-- 
2.47.0

