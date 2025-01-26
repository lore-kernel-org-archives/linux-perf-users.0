Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8423B25A638;
	Sun, 26 Jan 2025 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737925366; cv=none; b=m1eN+ztFV8WTOO9sIi7AaoRQbc54vIXKbpx6gvsVZTeC1WfZHutOnTCc3KbJjWeL0NH8AY+d+W4vb5AA5SHIsYPz2kmYhb+uV8NMr+yNn1u04fCx1JIgZGsNPtpDdlfpHUc/0DqW4zQaqiIbgQ4pX5kUsseH7Vn4I3DgUmgX7ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737925366; c=relaxed/simple;
	bh=FI5b8uj4zAEk1nRY49YoqTY19GyHjARPTRQoDvitfZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jdJeitnPshhJitFEgtn6AyrexUftyhMllr2OoAnjXQHCk1Gf/S0aQshTd+zASLnioni2C52531M1H2XbGRClHtqFpMFWrlbQdTVbqTvLvYUflze3m+YNkqSttbmQQqfT554ZAi53SyIUNd8QH5VNZU2QvC8ZF/P5JkvwVTobP5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx/y+82I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx/y+82I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FBFC4CED3;
	Sun, 26 Jan 2025 21:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737925363;
	bh=FI5b8uj4zAEk1nRY49YoqTY19GyHjARPTRQoDvitfZQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Gx/y+82IyyjEA5HmCqFDHZNaygqIyGOHm6ruZp1dTbmhqee3g4bPE+jpLEbcr3QLF
	 eq0L72mB+PW9NBk2ESLfEzCOODdWDSghg4FIvW4+3A3wgHkPaM9KH9rwC8itKBW0Aa
	 f3AHcyWRrVcLKeahTBkF3nl4RhO0+JL/X4rD84L+5K0pNGqGrmNJdXfBUZ6hJZbvG4
	 14K29fppw1lgmgzYNtcPPTfhQirv7KhaiLXDJhiXyAlVAlKa5O10nptqeLWn6iBFpe
	 4xMuQdcLCQfnm5ikdKAha/BTrf6Onm07UMFakfe+r1j23O5mx06QDFUJvDh8nc3tW2
	 DeuHVGYtPqEsA==
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
	Stephane Eranian <eranian@google.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Blake Jones <blakejones@google.com>
Subject: [PATCH] perf annotate-data: Handle direct use of stack pointer without fbreg
Date: Sun, 26 Jan 2025 13:02:42 -0800
Message-ID: <20250126210242.1181225-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes compiler generates code to use the stack pointer register
without frame pointer.  As we know RSP is the stack register on x86,
let's treat it as same as fbreg.  But the offset would be opposite
direction so update the debug message accordingly.

Reported-by: Blake Jones <blakejones@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/annotate/instructions.c | 22 +++++++++++++++------
 tools/perf/util/annotate-data.c             | 15 +++++++++-----
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index ae94b1f0b9cce1d3..c6d403eae7441168 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -410,7 +410,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 retry:
 		/* Check stack variables with offset */
-		if (sreg == fbreg) {
+		if (sreg == fbreg || sreg == state->stack_reg) {
 			struct type_state_stack *stack;
 			int offset = src->offset - fboff;
 
@@ -433,8 +433,13 @@ static void update_insn_state_x86(struct type_state *state,
 				return;
 			}
 
-			pr_debug_dtp("mov [%x] -%#x(stack) -> reg%d",
-				     insn_offset, -offset, dst->reg1);
+			if (sreg == fbreg) {
+				pr_debug_dtp("mov [%x] -%#x(stack) -> reg%d",
+					     insn_offset, -offset, dst->reg1);
+			} else {
+				pr_debug_dtp("mov [%x] %#x(reg%d) -> reg%d",
+					     insn_offset, offset, sreg, dst->reg1);
+			}
 			pr_debug_type_name(&tsr->type, tsr->kind);
 		}
 		/* And then dereference the pointer if it has one */
@@ -561,7 +566,7 @@ static void update_insn_state_x86(struct type_state *state,
 			return;
 
 		/* Check stack variables with offset */
-		if (dst->reg1 == fbreg) {
+		if (dst->reg1 == fbreg || dst->reg1 == state->stack_reg) {
 			struct type_state_stack *stack;
 			int offset = dst->offset - fboff;
 
@@ -584,8 +589,13 @@ static void update_insn_state_x86(struct type_state *state,
 						    &tsr->type);
 			}
 
-			pr_debug_dtp("mov [%x] reg%d -> -%#x(stack)",
-				     insn_offset, src->reg1, -offset);
+			if (dst->reg1 == fbreg) {
+				pr_debug_dtp("mov [%x] reg%d -> -%#x(stack)",
+					     insn_offset, src->reg1, -offset);
+			} else {
+				pr_debug_dtp("mov [%x] reg%d -> %#x(reg%d)",
+					     insn_offset, src->reg1, offset, dst->reg1);
+			}
 			pr_debug_type_name(&tsr->type, tsr->kind);
 		}
 		/*
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 976abedca09ef547..eaf96fa80c830d05 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -830,7 +830,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 		if (!dwarf_offdie(dloc->di->dbg, var->die_off, &mem_die))
 			continue;
 
-		if (var->reg == DWARF_REG_FB || var->reg == fbreg) {
+		if (var->reg == DWARF_REG_FB || var->reg == fbreg || var->reg == state->stack_reg) {
 			int offset = var->offset;
 			struct type_state_stack *stack;
 
@@ -845,8 +845,13 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 			findnew_stack_state(state, offset, TSR_KIND_TYPE,
 					    &mem_die);
 
-			pr_debug_dtp("var [%"PRIx64"] -%#x(stack)",
-				     insn_offset, -offset);
+			if (var->reg == state->stack_reg) {
+				pr_debug_dtp("var [%"PRIx64"] %#x(reg%d)",
+					     insn_offset, offset, state->stack_reg);
+			} else {
+				pr_debug_dtp("var [%"PRIx64"] -%#x(stack)",
+					     insn_offset, -offset);
+			}
 			pr_debug_type_name(&mem_die, TSR_KIND_TYPE);
 		} else if (has_reg_type(state, var->reg) && var->offset == 0) {
 			struct type_state_reg *reg;
@@ -1127,10 +1132,10 @@ static enum type_match_result check_matching_type(struct type_state *state,
 	}
 
 check_non_register:
-	if (reg == dloc->fbreg) {
+	if (reg == dloc->fbreg || reg == state->stack_reg) {
 		struct type_state_stack *stack;
 
-		pr_debug_dtp("fbreg");
+		pr_debug_dtp("%s", reg == dloc->fbreg ? "fbreg" : "stack");
 
 		stack = find_stack_state(state, dloc->type_offset);
 		if (stack == NULL) {
-- 
2.48.1.262.g85cc9f2d1e-goog

