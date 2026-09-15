Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA40A42902E;
	Tue, 15 Sep 2026 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789454443; cv=none; b=X/exyE8tO8ZxiXJdHLZ0Xq+CUbuog7JFBUAB94hOgQBVB/tyv50kAqWtvxamGZxjf4nkMea6uJYla1WKei4PlOmcoj7mfxhsPBP+kjNiGcNK9gokEv0/y2cCs8hAeSCkJdjb5LSo8+BUAHqt7AYYWK3g7eeEjiIxGUv71eirADo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789454443; c=relaxed/simple;
	bh=RI6tZtIIzGIQFJ+xsVri2MLvcptS6c7Hi2l2YV+6MAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZaonzyt/y9P/a5lSr1KpLzZbh1hzDNP0FaxtOGC+R/++P8DWQg6POgqncsoctvLdMm7yElhJmyV5IQ5mOBJIufIV1Mim5HIZYs+nvortt9knqnj928bZh2JV3CU4yLybHlVCXIGv0E3+44jPpoi43yvYNDPdHHGgcakGBfAsqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5IXkHxk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5IXkHxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337EC1F00893;
	Tue, 15 Sep 2026 06:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789454441;
	bh=lidfxj0j6v8CyF9hCR2LKoYiQPRjEweGxhqs/Ke+j60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R5IXkHxkHLE2E0EbrHjnMj5AFgH63QlOf4TIU0/TU8bilVlDxMmjpNrZI2t37bZdb
	 rHpTyf0wnz5isj+rBOS6pSVDIW5eeD5AjEUnlW8gIHLQFSP7OYH6Ug15kBoTWD/6Ze
	 ORgRHHFbr532EFSce7UXAXRpBlQ5nbL2cbdKacfHor5us7LM7aSamfDy9S1/aWlmMY
	 sf37qVmVCroDhWh4tQfHffqcrR7n8qYSvGodtOBS2IqCB6R43/B2ewCVqetlGQ5sn8
	 H9iP11Iv4ejjkM5gEUHmjbYh4qy6QIqqvmJ4Dvjuw4VhEyhsGso3CDi7dWMOCpTvGD
	 SmiXPFlgrLKFw==
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
Subject: [PATCH v3 2/3] perf annotate-date: Allow out-of-size access for flex-array types
Date: Mon, 14 Sep 2026 23:40:34 -0700
Message-ID: <20260915064035.1970175-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260915064035.1970175-1-namhyung@kernel.org>
References: <20260915064035.1970175-1-namhyung@kernel.org>
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
2.55.0.1082.g2b9226bbc0-goog

