Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F088185B6C;
	Wed, 21 Aug 2024 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223251; cv=none; b=DVNZcguEKEotTwdraqztspEIYgoXfqjLG+0oo7DU5zrc4alJ1Fdz5ltzudKC1la81nFnoPpoxwqfK758dFWtARtUC5CcgF+QkpP2dEWvFfP6zQbN5RHo96AVypVfiZo+63FIx/5w2tJuNEgG3qWGvJZ/U8rast+NXiMQFnh1LB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223251; c=relaxed/simple;
	bh=eNR/SL4p1SX1iQ5FKWOfRQ8xWIgNGM1hXywpTQs86hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JL+zQZZ9naJLkotrnJurQw98Zj4mNhFELF89uwroRs7zkPSgQKDwCF5wJT8NCovTOHU4HTTp3ITDbIp+OB+6BjtZFz93AvmecjLzpW6keBXXVNH4+I3y3gLe97woaOcp5rWP76UJoPkG9Tv7rpcjnWssPsqL6ENf/nl52GOP/G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGd1rCp2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGd1rCp2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2EBC32786;
	Wed, 21 Aug 2024 06:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724223250;
	bh=eNR/SL4p1SX1iQ5FKWOfRQ8xWIgNGM1hXywpTQs86hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YGd1rCp2NuZ1vhR2F7Ni0trLiVBMuKWYkGdUM1Y13ILjhskjsA8RCCbjfG5rj572W
	 MyOR2WWcU3aPcePDn5h9+e3SRnnJsTXfi3th089Nblxfg7PGS+x6WMcQh/s2UGdGxO
	 7UCihATWrvYBRtCWMDUX3J5Xk/+m3XeD9wwriS+xuObnB5H0cMlXlm6A4zp5KWis11
	 7/P8Apup+iDQ8vvprFAJHGcDwrmKIW/XkSca7ZUGsVw+w3yj7PyRjAjoT0JnIk05S5
	 Pd+4N9jGDGNm7DEnG4ceKZehZML1IRFJcbtbCJAToQpe9q+ryJ+16O9zUBaXxdDt9T
	 /q6sl9Aij7K2A==
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
Subject: [PATCH 3/3] perf annotate-data: Fix percpu pointer check
Date: Tue, 20 Aug 2024 23:54:08 -0700
Message-ID: <20240821065408.285548-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240821065408.285548-1-namhyung@kernel.org>
References: <20240821065408.285548-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In check_matching_type(), it checks the type state of the register in a
wrong order.  When it's the percpu pointer, it should check the type for
the pointer, but it checks the CFA bit first and thought it has no type
in the stack slot.  This resulted in no type info.

  -----------------------------------------------------------
  find data type for 0x28(reg1) at hrtimer_reprogram+0x88
  CU for kernel/time/hrtimer.c (die:0x18f219f)
  frame base: cfa=1 fbreg=7
  ...
  add [72] percpu 0x24500 -> reg1 pointer type='struct hrtimer_cpu_base' size=0x240 (die:0x18f6d46)
  bb: [7a - 7e]
  bb: [80 - 86]                        (here)
  bb: [88 - 88]                         vvv
  chk [88] reg1 offset=0x28 ok=1 kind=4 cfa : no type information
  no type information

Here, instruction at 0x72 found reg1 has a (percpu) pointer and got the
correct type.  But when it checks the final result, it wrongly thought
it was stack variable because it checks the cfa bit first.

After changing the order of state check:
  -----------------------------------------------------------
  find data type for 0x28(reg1) at hrtimer_reprogram+0x88
  CU for kernel/time/hrtimer.c (die:0x18f219f)
  frame base: cfa=1 fbreg=7
  ...                                     (here)
                                        vvvvvvvvvv
  chk [88] reg1 offset=0x28 ok=1 kind=4 percpu ptr : Good!
  found by insn track: 0x28(reg1) type-offset=0x28
  final type: type='struct hrtimer_cpu_base' size=0x240 (die:0x18f6d46)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/annotate/instructions.c |   3 +
 tools/perf/util/annotate-data.c             | 122 ++++++++++----------
 2 files changed, 66 insertions(+), 59 deletions(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 88b5bcf2116f..15dfc2988e24 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -282,6 +282,7 @@ static void update_insn_state_x86(struct type_state *state,
 			    !strcmp(var_name, "this_cpu_off") &&
 			    tsr->kind == TSR_KIND_CONST) {
 				tsr->kind = TSR_KIND_PERCPU_BASE;
+				tsr->ok = true;
 				imm_value = tsr->imm_value;
 			}
 		}
@@ -533,9 +534,11 @@ static void update_insn_state_x86(struct type_state *state,
 							&var_name, &offset) &&
 				    !strcmp(var_name, "__per_cpu_offset")) {
 					tsr->kind = TSR_KIND_PERCPU_BASE;
+					tsr->ok = true;
 
 					pr_debug_dtp("mov [%x] percpu base reg%d\n",
 						     insn_offset, dst->reg1);
+					return;
 				}
 			}
 
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index d3db945afac9..3670251e03b3 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -943,7 +943,10 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		     insn_offset, reg, dloc->op->offset,
 		     state->regs[reg].ok, state->regs[reg].kind);
 
-	if (state->regs[reg].ok && state->regs[reg].kind == TSR_KIND_TYPE) {
+	if (!state->regs[reg].ok)
+		goto check_non_register;
+
+	if (state->regs[reg].kind == TSR_KIND_TYPE) {
 		Dwarf_Die sized_type;
 
 		/*
@@ -976,6 +979,65 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		return PERF_TMR_OK;
 	}
 
+	if (state->regs[reg].kind == TSR_KIND_POINTER) {
+		pr_debug_dtp("percpu ptr");
+
+		/*
+		 * It's actaully pointer but the address was calculated using
+		 * some arithmetic.  So it points to the actual type already.
+		 */
+		*type_die = state->regs[reg].type;
+
+		dloc->type_offset = dloc->op->offset;
+
+		/* Get the size of the actual type */
+		if (dwarf_aggregate_size(type_die, &size) < 0 ||
+		    (unsigned)dloc->type_offset >= size)
+			return PERF_TMR_BAIL_OUT;
+
+		return PERF_TMR_OK;
+	}
+
+	if (state->regs[reg].kind == TSR_KIND_CANARY) {
+		pr_debug_dtp("stack canary");
+
+		/*
+		 * This is a saved value of the stack canary which will be handled
+		 * in the outer logic when it returns failure here.  Pretend it's
+		 * from the stack canary directly.
+		 */
+		setup_stack_canary(dloc);
+
+		return PERF_TMR_BAIL_OUT;
+	}
+
+	if (state->regs[reg].kind == TSR_KIND_PERCPU_BASE) {
+		u64 var_addr = dloc->op->offset;
+		int var_offset;
+
+		pr_debug_dtp("percpu var");
+
+		if (dloc->op->multi_regs) {
+			int reg2 = dloc->op->reg2;
+
+			if (dloc->op->reg2 == reg)
+				reg2 = dloc->op->reg1;
+
+			if (has_reg_type(state, reg2) && state->regs[reg2].ok &&
+			    state->regs[reg2].kind == TSR_KIND_CONST)
+				var_addr += state->regs[reg2].imm_value;
+		}
+
+		if (get_global_var_type(cu_die, dloc, dloc->ip, var_addr,
+					&var_offset, type_die)) {
+			dloc->type_offset = var_offset;
+			return PERF_TMR_OK;
+		}
+		/* No need to retry per-cpu (global) variables */
+		return PERF_TMR_BAIL_OUT;
+	}
+
+check_non_register:
 	if (reg == dloc->fbreg) {
 		struct type_state_stack *stack;
 
@@ -1032,64 +1094,6 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		return PERF_TMR_OK;
 	}
 
-	if (state->regs[reg].kind == TSR_KIND_PERCPU_BASE) {
-		u64 var_addr = dloc->op->offset;
-		int var_offset;
-
-		pr_debug_dtp("percpu var");
-
-		if (dloc->op->multi_regs) {
-			int reg2 = dloc->op->reg2;
-
-			if (dloc->op->reg2 == reg)
-				reg2 = dloc->op->reg1;
-
-			if (has_reg_type(state, reg2) && state->regs[reg2].ok &&
-			    state->regs[reg2].kind == TSR_KIND_CONST)
-				var_addr += state->regs[reg2].imm_value;
-		}
-
-		if (get_global_var_type(cu_die, dloc, dloc->ip, var_addr,
-					&var_offset, type_die)) {
-			dloc->type_offset = var_offset;
-			return PERF_TMR_OK;
-		}
-		/* No need to retry per-cpu (global) variables */
-		return PERF_TMR_BAIL_OUT;
-	}
-
-	if (state->regs[reg].ok && state->regs[reg].kind == TSR_KIND_POINTER) {
-		pr_debug_dtp("percpu ptr");
-
-		/*
-		 * It's actaully pointer but the address was calculated using
-		 * some arithmetic.  So it points to the actual type already.
-		 */
-		*type_die = state->regs[reg].type;
-
-		dloc->type_offset = dloc->op->offset;
-
-		/* Get the size of the actual type */
-		if (dwarf_aggregate_size(type_die, &size) < 0 ||
-		    (unsigned)dloc->type_offset >= size)
-			return PERF_TMR_BAIL_OUT;
-
-		return PERF_TMR_OK;
-	}
-
-	if (state->regs[reg].ok && state->regs[reg].kind == TSR_KIND_CANARY) {
-		pr_debug_dtp("stack canary");
-
-		/*
-		 * This is a saved value of the stack canary which will be handled
-		 * in the outer logic when it returns failure here.  Pretend it's
-		 * from the stack canary directly.
-		 */
-		setup_stack_canary(dloc);
-
-		return PERF_TMR_BAIL_OUT;
-	}
-
 check_kernel:
 	if (dso__kernel(map__dso(dloc->ms->map))) {
 		u64 addr;
-- 
2.46.0.184.g6999bdac58-goog

