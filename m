Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A223E51D3;
	Wed, 16 Sep 2026 06:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539571; cv=none; b=nA+oiiv7b9nC8kjJFEP2TzTMJ0KkrbYj+L8e8b081UsBUv5aFeMqaQuzfpG+Lc3jPobkidUVSzncHSS2GhNVPj3fH4xj+F7VDKe6Lt8HbbL/GshS6Q32NPK6X7xPw0PmN0u3nCvX+I8tlmjq4v8fVdOOWQgF7Oh1QiY7h4FtTvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539571; c=relaxed/simple;
	bh=G0+M+Va18IqX91+BQxV7uhF+TWrKFnps5jPMoV6Kt/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFA+x8MLY+dV5HnC32FxGIE/G/ewM8qsKPan+at4He/amaItQapUA401RFWIHjeC/maMwiUx4O9O6H1kcDft9npf7yDwTtI0CqAVAeXsxwR6YxCrJ5AgWYjfMsCraD2cW0VFN5nhpHo0D6F3pKyX9NalYO9+0l94q0CeUkRzdUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEM7NrWU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEM7NrWU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3CA1F00898;
	Wed, 16 Sep 2026 06:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789539570;
	bh=sh5JSRzhDENGmdXk+Huz5lrQSwPH0Q0xbstUepcD51Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lEM7NrWUi6bqijY8BSe6ULzMfuxenL3We2Xdm9TRh2u8xVap23rWZupLYe1WcojfV
	 e2hx7HH0FlkzcPd8Y9jm3OuouiuNuinGZoNRSCdgfr+I/C7sR5tYbKUsC6PNRbQBTM
	 8V+Qtd9Iwt9FKgWfx9qBcu/OJe4VrZs/Lknk1JtqBMqpBAW/8zbh2mC7ciY2R5wY8k
	 a2pE/8hWqUt8ca76B+iBgoVCan0qammI07f79h53fc6u6DbALYJvefGaqXLmFWnEUd
	 f5auDB92pZ/+YsFWGpTwqb8VLXIo9rYUFmRFCcIUjIJVCuEH/rr7S252OSpHunLrkh
	 O3/aPrDtr2K9g==
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
Subject: [PATCH v4 2/3] perf annotate-date: Allow out-of-size access for flex-array types
Date: Tue, 15 Sep 2026 23:19:25 -0700
Message-ID: <20260916061926.2224222-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916061926.2224222-1-namhyung@kernel.org>
References: <20260916061926.2224222-1-namhyung@kernel.org>
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
index aff60a630fd05b01..1ee2b74f99205567 100644
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
+	return check_type_offset(&sized_type, offset);
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
index ca2096a9ee62cbfe..957726334907cc0e 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -85,6 +85,7 @@ struct type_hist {
  * struct annotated_data_type - Data type to profile
  * @node: RB-tree node for dso->type_tree
  * @self: Actual type information
+ * @flex_array: Whether it has a flex array
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

