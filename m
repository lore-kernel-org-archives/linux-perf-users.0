Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6515C380FDF;
	Mon, 14 Sep 2026 06:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368341; cv=none; b=j4oD/klA/oxujH16YdLUhg3LKY0nzczmTvIE2LimlxK1QNDjuH7ApZ5Ty9xfJtJPbyL7d7MrwJKOVF6wSpuRiomKrQDeRdU49f+u+ymrh52h8io2EzqvlJF7SNlk4zJxZwsaGrFJN/tEeGLGaKKjKMiMsYwYYcyKEEOraGeldDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368341; c=relaxed/simple;
	bh=8L3Xi2JZtbV64DEaag63/pchEoZ4oo8EegXOBp5L5Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLDGzr+kc6wHZlhs1VOvwRaYUzMHRiUHdgaof8qMjX3VbE3GSblts27/hYFyjixWIAWgzruMgQG32U4xXiHuvb2GBNTnGqlVsphw+vDXziQxSp7g8n1oah98na3X2zH8SW/kKG7b7gzr/Ys/M8prJ3WZl0xiVeWxHaIHThIKGfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTTC7v8T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTTC7v8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC2B1F00899;
	Mon, 14 Sep 2026 06:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789368340;
	bh=/O6Fs7ytd6i1gURERsPHv6GrvClVL/uDJNVlPhWfnuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TTTC7v8TxoYc1nuz2LdDvbNiJLibhDlViNLxwzSxarRxd0XVIKynoImuIjgIX6loQ
	 /Gq6NRoc5skXhiLkS/2fEDGD0sGUlnQt6iGyeDFMF10juR7CcbRU/kXX8ncrKpjTGO
	 AfwtXwk++qbov3PKIRWMC8Ag2Seq5N43uwkaxGveTRdfsAp0sUGOyEglUU3gdLdgaR
	 9CEYIcbsem4WVUsFXWjMtYeZQAuPLChPjwdBq2JFd+WXSvE+sUpJqA0LFEUGv5KacX
	 0p7cf6qfEpA/dN3Al6+yLiNHuwzEK4VZ9A/BfLUjsDdcy9yiaWM8HsOTybEnLjZovu
	 z1mlLZVkuGzPA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Zecheng Li <zli94@ncsu.edu>,
	Yanbo Zhao <yzhao62@ncsu.edu>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v2 3/4] perf annotate-date: Allow out-of-size access for flex-array types
Date: Sun, 13 Sep 2026 23:45:34 -0700
Message-ID: <20260914064535.1671939-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260914064535.1671939-1-namhyung@kernel.org>
References: <20260914064535.1671939-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Structs that have a flex array will have accesses beyond its original
size as the array was declared as 0 sized.  For now, it just allow any
offset bigger than the size.  It could be refined later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 63 ++++++++++++++++++---------------
 tools/perf/util/annotate-data.h |  2 ++
 2 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index aff60a630fd05b01..e8aff6a916c0afe0 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <inttypes.h>
 #include <linux/zalloc.h>
 
@@ -248,8 +249,15 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	else
 		die_mem = member_type;
 
-	if (dwarf_aggregate_size(&die_mem, &size) < 0)
-		size = 0;
+	if (dwarf_aggregate_size(&die_mem, &size) < 0) {
+		if (dwarf_tag(&die_mem) == DW_TAG_array_type) { /* flex-array? */
+			die_get_real_type(&die_mem, &die_mem);
+			if (dwarf_aggregate_size(&die_mem, &size) < 0)
+				size = 0;
+		} else {
+			size = 0;
+		}
+	}
 
 	if (dwarf_attr_integrate(die, DW_AT_data_member_location, &attr)) {
 		if (dwarf_formudata(&attr, &loc) != 0) {
@@ -399,6 +407,7 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
 	result->self.type_name = type_name;
 	result->self.size = size;
 	INIT_LIST_HEAD(&result->self.children);
+	result->flex_array = die_has_flex_array(type_die);
 
 	if (symbol_conf.annotate_data_member)
 		add_member_types(result, type_die);
@@ -517,13 +526,30 @@ static bool is_better_type(Dwarf_Die *type_a, Dwarf_Die *type_b)
 	return false;
 }
 
+static enum type_match_result check_type_offset(Dwarf_Die *type_die, int offset)
+{
+	Dwarf_Word size;
+
+	/* Get the size of the actual type */
+	if (dwarf_aggregate_size(type_die, &size) < 0)
+		return PERF_TMR_NO_SIZE;
+
+	/* Minimal sanity check */
+	if (offset < 0)
+		return PERF_TMR_BAD_OFFSET;
+
+	if ((unsigned)offset >= size && !die_has_flex_array(type_die))
+		return PERF_TMR_BAD_OFFSET;
+
+	return PERF_TMR_OK;
+}
+
 /* The type info will be saved in @type_die */
 static enum type_match_result check_variable(struct data_loc_info *dloc,
 					     Dwarf_Die *var_die,
 					     Dwarf_Die *type_die, int reg,
 					     int offset, bool is_fbreg)
 {
-	Dwarf_Word size;
 	bool needs_pointer = true;
 	Dwarf_Die sized_type;
 
@@ -554,15 +580,7 @@ static enum type_match_result check_variable(struct data_loc_info *dloc,
 	else
 		sized_type = *type_die;
 
-	/* Get the size of the actual type */
-	if (dwarf_aggregate_size(&sized_type, &size) < 0)
-		return PERF_TMR_NO_SIZE;
-
-	/* Minimal sanity check */
-	if ((unsigned)offset >= size)
-		return PERF_TMR_BAD_OFFSET;
-
-	return PERF_TMR_OK;
+	return check_type_offset(type_die, offset);
 }
 
 struct type_state_stack *find_stack_state(struct type_state *state,
@@ -1112,7 +1130,6 @@ static enum type_match_result check_matching_type(struct type_state *state,
 						  struct disasm_line *dl,
 						  Dwarf_Die *type_die)
 {
-	Dwarf_Word size;
 	u32 insn_offset = dl->al.offset;
 	int reg = dloc->op->reg1;
 	int offset = dloc->op->offset;
@@ -1166,12 +1183,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		else
 			sized_type = *type_die;
 
-		/* Get the size of the actual type */
-		if (dwarf_aggregate_size(&sized_type, &size) < 0 ||
-		    (unsigned)dloc->type_offset >= size)
-			return PERF_TMR_BAD_OFFSET;
-
-		return PERF_TMR_OK;
+		return check_type_offset(&sized_type, dloc->type_offset);
 	}
 
 	if (state->regs[reg].kind == TSR_KIND_POINTER) {
@@ -1190,12 +1202,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 
 		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
 
-		/* Get the size of the actual type */
-		if (dwarf_aggregate_size(type_die, &size) < 0 ||
-		    (unsigned)dloc->type_offset >= size)
-			return PERF_TMR_BAD_OFFSET;
-
-		return PERF_TMR_OK;
+		return check_type_offset(type_die, dloc->type_offset);
 	}
 
 	if (state->regs[reg].kind == TSR_KIND_PERCPU_POINTER) {
@@ -1209,9 +1216,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 
 		dloc->type_offset = dloc->op->offset;
 
-		/* Get the size of the actual type */
-		if (dwarf_aggregate_size(type_die, &size) < 0 ||
-		    (unsigned)dloc->type_offset >= size)
+		if (check_type_offset(type_die, dloc->type_offset) != PERF_TMR_OK)
 			return PERF_TMR_BAIL_OUT;
 
 		return PERF_TMR_OK;
@@ -1839,7 +1844,7 @@ int annotated_data_type__update_samples(struct annotated_data_type *adt,
 			return -1;
 	}
 
-	if (offset < 0 || offset >= adt->self.size)
+	if (offset < 0 || (offset >= adt->self.size && !adt->flex_array))
 		return -1;
 
 	h = &adt->histograms[evsel->core.idx];
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index ca2096a9ee62cbfe..27b7148b64f60350 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -85,6 +85,7 @@ struct type_hist {
  * struct annotated_data_type - Data type to profile
  * @node: RB-tree node for dso->type_tree
  * @self: Actual type information
+ * @flex_array: Whethere it has a flex array
  * @nr_histogram: Number of histogram entries
  * @histograms: An array of histograms
  *
@@ -93,6 +94,7 @@ struct type_hist {
 struct annotated_data_type {
 	struct rb_node node;
 	struct annotated_member self;
+	bool flex_array;
 	int nr_histograms;
 	struct type_hist *histograms;
 };
-- 
2.55.0.1032.g73a4cd73de-goog

