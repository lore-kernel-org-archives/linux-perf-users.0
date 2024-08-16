Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC5B1494DB;
	Fri, 16 Aug 2024 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723852723; cv=none; b=sPMWmNEIjFO4L1okReYVCeJmV3+Wx2aAzgepP2OeE3dc9OZPviZxkjN3RGJxeCHt5FBzu72wPD7elj0qhIgUItS5nWkgQHp4VWDt0drwuW9yLkmZikpZGqHlkpvDl0C0SwM3WZY/2X5Zt9Nleutmgk6tf1Lo7Axp2EhSQi48thg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723852723; c=relaxed/simple;
	bh=qAsQm8iWb0RyWNE4stpu0Prg2j6/cF+goHITQqqkfYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivV3VML4xTZruoPgmQUbdQS23nM1ojMXWiT5ZciwPVaHPLY3zyIczDt3vZxnUYaBOziNjdvjeujZ3KD+UcZIurExUoY7sH2GJhCc/EK1SVxini8Ic8EaaFAm+wxb1Q6AkqjGKdX2nIknImRXv72j2scmpfCOZsjSUiuVb34lMLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQ06jIOc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQ06jIOc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547FFC4AF18;
	Fri, 16 Aug 2024 23:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723852722;
	bh=qAsQm8iWb0RyWNE4stpu0Prg2j6/cF+goHITQqqkfYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qQ06jIOciObesF+CbY3aQz2LHNzdHKcV9VLWMw2L8Hyp/5RTnctV1QDn7I4QOS8Re
	 pq9eRBe5D6oN/TnlRdgze5Akgw63l4OKR+FVSEFVBs1amCszeYK4KAsmwyqudOodgn
	 zFCR6R7sfUokVI7P5eb93V4lD4RTPSZ4kZ5uDc8wRvtAtCpvlmTbEJLjenx9L6IqrJ
	 W5uvnP43nHk5a5FByxvAQyKnCPNwW4GQYrpCj5amWvw8abBHeCp05umTS0lrvKwmDF
	 vdLBpp4qKiUV9Bldh1FwMaKHMTcx7BQWS1aq3Qo7Z63RJM6XUcDTJgfQJP63lh0B5Y
	 TASIIL0C04SFQ==
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 3/9] perf annotate-data: Add enum type_match_result
Date: Fri, 16 Aug 2024 16:58:33 -0700
Message-ID: <20240816235840.2754937-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240816235840.2754937-1-namhyung@kernel.org>
References: <20240816235840.2754937-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

And let check_variable() return the enum value so that callers can know
what was the problem.  This will be used by the later patch to update
the statistics correctly and print the error message in a right place.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 36 +++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index fd8d3cdead5a..8e3b422eca22 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -345,9 +345,20 @@ static bool find_cu_die(struct debuginfo *di, u64 pc, Dwarf_Die *cu_die)
 	return false;
 }
 
+enum type_match_result {
+	PERF_TMR_UNKNOWN = 0,
+	PERF_TMR_OK,
+	PERF_TMR_NO_TYPE,
+	PERF_TMR_NO_POINTER,
+	PERF_TMR_NO_SIZE,
+	PERF_TMR_BAD_OFFSET,
+};
+
 /* The type info will be saved in @type_die */
-static int check_variable(struct data_loc_info *dloc, Dwarf_Die *var_die,
-			  Dwarf_Die *type_die, int reg, int offset, bool is_fbreg)
+static enum type_match_result check_variable(struct data_loc_info *dloc,
+					     Dwarf_Die *var_die,
+					     Dwarf_Die *type_die, int reg,
+					     int offset, bool is_fbreg)
 {
 	Dwarf_Word size;
 	bool is_pointer = true;
@@ -364,7 +375,7 @@ static int check_variable(struct data_loc_info *dloc, Dwarf_Die *var_die,
 	if (__die_get_real_type(var_die, type_die) == NULL) {
 		pr_debug_dtp("variable has no type\n");
 		ann_data_stat.no_typeinfo++;
-		return -1;
+		return PERF_TMR_NO_TYPE;
 	}
 
 	/*
@@ -378,7 +389,7 @@ static int check_variable(struct data_loc_info *dloc, Dwarf_Die *var_die,
 		    __die_get_real_type(type_die, type_die) == NULL) {
 			pr_debug_dtp("no pointer or no type\n");
 			ann_data_stat.no_typeinfo++;
-			return -1;
+			return PERF_TMR_NO_POINTER;
 		}
 	}
 
@@ -391,7 +402,7 @@ static int check_variable(struct data_loc_info *dloc, Dwarf_Die *var_die,
 	if (dwarf_aggregate_size(&sized_type, &size) < 0) {
 		pr_debug_dtp("type size is unknown\n");
 		ann_data_stat.invalid_size++;
-		return -1;
+		return PERF_TMR_NO_SIZE;
 	}
 
 	/* Minimal sanity check */
@@ -399,10 +410,10 @@ static int check_variable(struct data_loc_info *dloc, Dwarf_Die *var_die,
 		pr_debug_dtp("offset: %d is bigger than size: %"PRIu64"\n",
 			     offset, size);
 		ann_data_stat.bad_offset++;
-		return -1;
+		return PERF_TMR_BAD_OFFSET;
 	}
 
-	return 0;
+	return PERF_TMR_OK;
 }
 
 struct type_state_stack *find_stack_state(struct type_state *state,
@@ -652,7 +663,7 @@ bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 	/* Try to get the variable by address first */
 	if (die_find_variable_by_addr(cu_die, var_addr, &var_die, &offset) &&
 	    check_variable(dloc, &var_die, type_die, DWARF_REG_PC, offset,
-			   /*is_fbreg=*/false) == 0) {
+			   /*is_fbreg=*/false) == PERF_TMR_OK) {
 		var_name = dwarf_diename(&var_die);
 		*var_offset = offset;
 		goto ok;
@@ -666,7 +677,7 @@ bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 	/* Try to get the name of global variable */
 	if (die_find_variable_at(cu_die, var_name, pc, &var_die) &&
 	    check_variable(dloc, &var_die, type_die, DWARF_REG_PC, *var_offset,
-			   /*is_fbreg=*/false) == 0)
+			   /*is_fbreg=*/false) == PERF_TMR_OK)
 		goto ok;
 
 	return false;
@@ -1205,6 +1216,7 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 	bool is_fbreg = false;
 	u64 pc;
 	char buf[64];
+	enum type_match_result result;
 
 	if (dloc->op->multi_regs)
 		snprintf(buf, sizeof(buf), "reg%d, reg%d", dloc->op->reg1, dloc->op->reg2);
@@ -1299,8 +1311,8 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 		}
 
 		/* Found a variable, see if it's correct */
-		ret = check_variable(dloc, &var_die, type_die, reg, offset, is_fbreg);
-		if (ret == 0) {
+		result = check_variable(dloc, &var_die, type_die, reg, offset, is_fbreg);
+		if (result == PERF_TMR_OK) {
 			pr_debug_dtp("found \"%s\" in scope=%d/%d (die: %#lx) ",
 				     dwarf_diename(&var_die), i+1, nr_scopes,
 				     (long)dwarf_dieoffset(&scopes[i]));
@@ -1315,12 +1327,14 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 			}
 			pr_debug_location(&var_die, pc, reg);
 			pr_debug_type_name(type_die, TSR_KIND_TYPE);
+			ret = 0;
 		} else {
 			pr_debug_dtp("check variable \"%s\" failed (die: %#lx)\n",
 				     dwarf_diename(&var_die),
 				     (long)dwarf_dieoffset(&var_die));
 			pr_debug_location(&var_die, pc, reg);
 			pr_debug_type_name(type_die, TSR_KIND_TYPE);
+			ret = -1;
 		}
 		dloc->type_offset = offset;
 		goto out;
-- 
2.46.0.184.g6999bdac58-goog

