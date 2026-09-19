Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DA337C903;
	Sat, 19 Sep 2026 06:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789799880; cv=none; b=FDHIlXQ84lopTSboo41iLMHa8d/skNRVFTIYIc+Tpv4tyPiAg23tp8aQ0KpAwi6boOpWqmhdaaKL9jnm765nAdNqBWvXVwke55kUpvJjVcTj/EQQ0m3YerN6MsHdngKiOu0jOzsX3GmukU4nMEHloiysR0T9RZ9VZQtY9HSpd8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789799880; c=relaxed/simple;
	bh=Hqk/Vspkt4I9EttbLbcBjp1rM/k7Q923m+aS37h9O6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqXQGU5lllQSj7ZiP/2eR4bPPGNgTHDA2am7mS3Ysa9Yy58XwZRyPZYiTwANE7JVsaswayx2nDvfYG5sX/8qGMsccQTDUs7Rdk1xEdh1k5X+FjbxkdJdcttPblo7/vTNENF0ykhHVTpHLodo+3hoUpHwvKE2vrS4FSdv3KANvIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbHZ4xzN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbHZ4xzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549C91F00899;
	Sat, 19 Sep 2026 06:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789799874;
	bh=O8MjfrwV8yk1Fc4uVimleJ3OeeIK7YwAhHdhnAUKz9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UbHZ4xzNQknoIQS2c96xgezlmaTGG4XhZ+gxedxVwgDYH+WXrHly2whiUspYTAf2R
	 c2X8nJ4gHnxU8/vG7xI9TJQ6VgbNkpprfySGAeyrIGRaKMMgx+AG/6unogHtemMRG2
	 8H2oZzjz3QEWFLlbglvg9Wqxp6SvSR7EbiS7PUcFFD5zAk8RPzWErMXd41+w67aj9p
	 RspGr6RbfRAMiGgJ8H2SOVc8nTjh+ubmmAwxqxQaJJBRum4PTzGDSvX85Qjac3ZsKq
	 QsE4K0urTYTOmFI1aHq3dzfcJ9sMyaQHoivve7MlQGgd/+y23Lt3ahmhAA3j98IT83
	 UOkjjetndHQqQ==
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
Subject: [PATCH v5 3/4] perf annotate-data: Allow out-of-size access for flex-array types
Date: Fri, 18 Sep 2026 23:37:44 -0700
Message-ID: <20260919063745.48444-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919063745.48444-1-namhyung@kernel.org>
References: <20260919063745.48444-1-namhyung@kernel.org>
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
index 845a5d8c2b84b6a6..5dd6c6ec2d42451d 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <inttypes.h>
 #include <linux/zalloc.h>
 
@@ -249,8 +250,15 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 
 	die_get_real_type(die, &die_mem);
 
-	if (dwarf_aggregate_size(&die_mem, &size) < 0)
-		size = 0;
+	if (dwarf_aggregate_size(&die_mem, &size) < 0 || size == 0) {
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
@@ -400,6 +408,7 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
 	result->self.type_name = type_name;
 	result->self.size = size;
 	INIT_LIST_HEAD(&result->self.children);
+	result->flex_array = die_has_flex_array(type_die);
 
 	if (symbol_conf.annotate_data_member)
 		add_member_types(result, type_die);
@@ -518,13 +527,30 @@ static bool is_better_type(Dwarf_Die *type_a, Dwarf_Die *type_b)
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
 
@@ -555,15 +581,7 @@ static enum type_match_result check_variable(struct data_loc_info *dloc,
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
@@ -1113,7 +1131,6 @@ static enum type_match_result check_matching_type(struct type_state *state,
 						  struct disasm_line *dl,
 						  Dwarf_Die *type_die)
 {
-	Dwarf_Word size;
 	u32 insn_offset = dl->al.offset;
 	int reg = dloc->op->reg1;
 	int offset = dloc->op->offset;
@@ -1167,12 +1184,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
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
@@ -1191,12 +1203,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 
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
@@ -1210,9 +1217,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 
 		dloc->type_offset = dloc->op->offset;
 
-		/* Get the size of the actual type */
-		if (dwarf_aggregate_size(type_die, &size) < 0 ||
-		    (unsigned)dloc->type_offset >= size)
+		if (check_type_offset(type_die, dloc->type_offset) != PERF_TMR_OK)
 			return PERF_TMR_BAIL_OUT;
 
 		return PERF_TMR_OK;
@@ -1840,7 +1845,7 @@ int annotated_data_type__update_samples(struct annotated_data_type *adt,
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
2.55.0

