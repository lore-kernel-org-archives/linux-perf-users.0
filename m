Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A029342AA6
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Aug 2025 19:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151864; cv=none; b=aNNj2ekXuWxzKK1WlirKPjQZjxHinE7r30to7t+z3XGarzIp91byeJosq8HNWYITPPZfd86svcW4PUc4dz6579362kkupMMgFfZSSVKUgFh9DNA1qfrpSbGiF53GDiikGhJA8qgMiaVXKWP7Z1nHA8PMpe27CD+xjDCfQNnjn2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151864; c=relaxed/simple;
	bh=19seW6aur83nA1mYEybwSfkvSC18FQelg/mUMuy77Ic=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eSUB/Hc5viAX5cCvMRO3DseM26A16NqZH7qAryFI5XGSTnWodu4UZShgbY4pYGvEkpKY4+g5CTfOYHWQJU95CUb+39/6G1EPbcF9A7W8Cjs9a6e1b2pllOmPMzjlDXmUSe5WyvbgAJW59cD/jZTisHSpKC+GX2mx/xxRVr4W7Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1BhIE5Uw; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1BhIE5Uw"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-71d605205a0so58302097b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Aug 2025 12:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756151861; x=1756756661; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lOa7FkG+isLBw/+KGBMQqC0Dor21gY5tAbdno+nBPXo=;
        b=1BhIE5Uw9MvJzmU6qSBCak+p3EOmNKddj138TD3Hht7Zq7u4oZ4uQ2W4OeqAXDLuUp
         6eGnflo+bUQMHk/zjxCDYTzqZCBiCZ+evRN+XmxIaTqBErUGwe//5+jVheGbu3/ePKhf
         e7BXw491QNavf1zoA3Aj7gcBJOrvDu+rHR15bk4MlfkeL2tKLLxAdIeQ8nelbU5SIDgF
         0aQR6+MWT3bCZ8GVvitjjenjaX3PYDHgFR9lApPt/Yac6W7QORztQbtoiMlo0QYLyt2e
         fW0xlZ7a/6i/scZ8+rJK8UzKUf1cADVVWCN/D/HD82R/ef1auuwa6Fn2SAONmEZGkSJb
         5kIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151861; x=1756756661;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lOa7FkG+isLBw/+KGBMQqC0Dor21gY5tAbdno+nBPXo=;
        b=BH3FICxyMcGIjSvbbLQbh5EiQC4wnaIDWc7kjfXE7BKI0WhacMga48T0Q19n8RNFBU
         v6u7tQusr+kp9ineAbevYQLPr2k3axEWVm6pKMtEAXXl+D573cMRtJKtj8bzmPgQ6C/7
         oOnX3pVR7Lv94kNHv7Q4U1vKyF51y7X+5un2wHe0BdKCGWVwOvF/k0MW0PE6iw+i5pNV
         uQOwv2y3LDEcDnjTcEQqLXrUeVityXA9xAfMUt5oLI5rGvVS7Q+TJgB6G8mZVuTQiNuf
         frNZZGBA76VZolRjmLrGyY3llBO5t0gSKPemry653QYA9p72O/YUQtBgJoV4X5xFxshD
         VBng==
X-Forwarded-Encrypted: i=1; AJvYcCXQKN0+LhRT6KIiTRBWjPxppHNAPlGbWOZCv46T5IfEcUE86yMMm85F9KXOk4hTrku2tZyGj0JIJaL5r/08jj4M@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0J06y9UN+FjQtjyTjOLOsdXURTYn5ol3WIv+AMleQUu15kBHq
	U4I0Hyg9UAwlN069Tht6hO6NvqqdafDk6az8RBwpCZ3idh1gghnkJ8AgSleSBZG2y2uVPUII1wd
	ytgQdjZ1Hhg==
X-Google-Smtp-Source: AGHT+IFxRyfs3Q+jFblBel8Nx7ZRiULBovkOYxz7tfoMZJfcGsuxk6+4WjeMiuYkI5f3aXZOq7vC7U4mW/T3
X-Received: from ywbbg10.prod.google.com ([2002:a05:690c:30a:b0:720:4612:d75b])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:6711:b0:71b:9c07:cfa7
 with SMTP id 00721157ae682-71fdc4196a1mr147080207b3.40.1756151861642; Mon, 25
 Aug 2025 12:57:41 -0700 (PDT)
Date: Mon, 25 Aug 2025 19:57:37 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825195737.225824-1-zecheng@google.com>
Subject: [PATCH v2 06/10] perf annotate: Track arithmetic instructions on pointers
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Track the arithmetic operations on registers with pointer types. We
handle only add, sub and lea instructions. The original pointer
information needs to be preserved for getting outermost struct types.
For example, reg0 points to a struct cfs_rq, when we add 0x10 to reg0,
it should preserve the information of struct cfs_rq + 0x10 in the
register instead of a pointer type to the child field at 0x10.

Details:

1.  struct type_state_reg now includes an offset, indicating if the
    register points to the start or an internal part of its associated
    type. This offset is used in mem to reg and reg to stack mem
    transfers, and also applied to the final type offset.

2.  lea offset(%sp/%fp), reg is now treated as taking the address of a
    stack variable. It worked fine in most cases, but an issue with this
    approach is the pointer type may not exist.

3.  lea offset(%base), reg is handled by moving the type from %base and
    adding an offset, similar to an add operation followed by a mov reg
    to reg.

4.  Non-stack variables from DWARF with non-zero offsets in their
    location expressions are now accepted with register offset tracking.

Limitation: Offset tracking for register moved to the stack is not yet
implemented. Currently, moving an register with offset to the stack
resolves to the member type, which worked in some of the cases. Strictly
it should be a pointer to the immediate child member. Multi-register
addressing modes in LEA are not supported.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/arch/x86/annotate/instructions.c | 138 +++++++++++++++++++-
 tools/perf/util/annotate-data.c             |  14 +-
 tools/perf/util/annotate-data.h             |   6 +
 3 files changed, 149 insertions(+), 9 deletions(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index c6d403eae744..540b4d0a01af 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -248,6 +248,7 @@ static void update_insn_state_x86(struct type_state *state,
 			tsr = &state->regs[state->ret_reg];
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("call [%x] return -> reg%d",
@@ -284,6 +285,7 @@ static void update_insn_state_x86(struct type_state *state,
 			    !strcmp(var_name, "this_cpu_off") &&
 			    tsr->kind == TSR_KIND_CONST) {
 				tsr->kind = TSR_KIND_PERCPU_BASE;
+				tsr->offset = 0;
 				tsr->ok = true;
 				imm_value = tsr->imm_value;
 			}
@@ -291,6 +293,15 @@ static void update_insn_state_x86(struct type_state *state,
 		else
 			return;
 
+		/* Ignore add to non-pointer types like int */
+		if (dwarf_tag(&tsr->type) == DW_TAG_pointer_type &&
+		    src->reg1 != DWARF_REG_PC && tsr->kind == TSR_KIND_TYPE && !dst->mem_ref) {
+			tsr->offset += imm_value;
+			pr_debug_dtp("add [%x] offset %#"PRIx64" to reg%d",
+				     insn_offset, imm_value, dst->reg1);
+			pr_debug_type_name(&tsr->type, tsr->kind);
+		}
+
 		if (tsr->kind != TSR_KIND_PERCPU_BASE)
 			return;
 
@@ -302,6 +313,7 @@ static void update_insn_state_x86(struct type_state *state,
 			 */
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_POINTER;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("add [%x] percpu %#"PRIx64" -> reg%d",
@@ -311,6 +323,96 @@ static void update_insn_state_x86(struct type_state *state,
 		return;
 	}
 
+	if (!strncmp(dl->ins.name, "sub", 3)) {
+		u64 imm_value = -1ULL;
+
+		if (!has_reg_type(state, dst->reg1))
+			return;
+
+		tsr = &state->regs[dst->reg1];
+		tsr->copied_from = -1;
+
+		if (src->imm)
+			imm_value = src->offset;
+		else if (has_reg_type(state, src->reg1) &&
+			 state->regs[src->reg1].kind == TSR_KIND_CONST)
+			imm_value = state->regs[src->reg1].imm_value;
+
+		if (dwarf_tag(&tsr->type) == DW_TAG_pointer_type &&
+		    src->reg1 != DWARF_REG_PC && tsr->kind == TSR_KIND_TYPE && !dst->mem_ref) {
+			tsr->offset -= imm_value;
+			pr_debug_dtp("sub [%x] offset %#"PRIx64" to reg%d",
+				     insn_offset, imm_value, dst->reg1);
+			pr_debug_type_name(&tsr->type, tsr->kind);
+		}
+	}
+
+	if (!strncmp(dl->ins.name, "lea", 3)) {
+		int sreg = src->reg1;
+		struct type_state_reg src_tsr;
+
+		if (!has_reg_type(state, sreg) ||
+		    !has_reg_type(state, dst->reg1) ||
+		    !src->mem_ref)
+			return;
+
+		src_tsr = state->regs[sreg];
+		tsr = &state->regs[dst->reg1];
+
+		tsr->copied_from = -1;
+		tsr->ok = false;
+
+		/* Case 1: Based on stack pointer or frame pointer */
+		if (sreg == fbreg || sreg == state->stack_reg) {
+			struct type_state_stack *stack;
+			int offset = src->offset - fboff;
+
+			stack = find_stack_state(state, offset);
+			if (!stack)
+				return;
+
+			/* Now the register becomes a pointer to the stack variable */
+			if (!die_find_pointer_to_type(cu_die, &stack->type, &type_die))
+				return;
+
+			tsr->type = type_die;
+			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
+			tsr->ok = true;
+
+			if (sreg == fbreg) {
+				pr_debug_dtp("lea [%x] address of -%#x(stack) -> reg%d",
+					     insn_offset, -src->offset, dst->reg1);
+			} else {
+				pr_debug_dtp("lea [%x] address of %#x(reg%d) -> reg%d",
+					     insn_offset, src->offset, sreg, dst->reg1);
+			}
+
+			pr_debug_type_name(&tsr->type, tsr->kind);
+		}
+		/* Case 2: Based on a register holding a typed pointer */
+		else if (src_tsr.ok && src_tsr.kind == TSR_KIND_TYPE) {
+
+			/* Check if the target type has a member at the new offset */
+			if (__die_get_real_type(&state->regs[sreg].type, &type_die) == NULL ||
+			    die_get_member_type(&type_die,
+					src->offset + src_tsr.offset, &type_die) == NULL)
+				return;
+
+			tsr->type = src_tsr.type;
+			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = src->offset + src_tsr.offset;
+			tsr->ok = true;
+
+			pr_debug_dtp("lea [%x] address of %s%#x(reg%d) -> reg%d",
+						insn_offset, src->offset < 0 ? "-" : "",
+						abs(src->offset), sreg, dst->reg1);
+
+			pr_debug_type_name(&tsr->type, tsr->kind);
+		}
+		return;
+	}
+
 	if (strncmp(dl->ins.name, "mov", 3))
 		return;
 
@@ -345,6 +447,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 			if (var_addr == 40) {
 				tsr->kind = TSR_KIND_CANARY;
+				tsr->offset = 0;
 				tsr->ok = true;
 
 				pr_debug_dtp("mov [%x] stack canary -> reg%d\n",
@@ -361,6 +464,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("mov [%x] this-cpu addr=%#"PRIx64" -> reg%d",
@@ -372,6 +476,7 @@ static void update_insn_state_x86(struct type_state *state,
 		if (src->imm) {
 			tsr->kind = TSR_KIND_CONST;
 			tsr->imm_value = src->offset;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("mov [%x] imm=%#x -> reg%d\n",
@@ -388,6 +493,7 @@ static void update_insn_state_x86(struct type_state *state,
 		tsr->type = state->regs[src->reg1].type;
 		tsr->kind = state->regs[src->reg1].kind;
 		tsr->imm_value = state->regs[src->reg1].imm_value;
+		tsr->offset = 0;
 		tsr->ok = true;
 
 		/* To copy back the variable type later (hopefully) */
@@ -421,12 +527,14 @@ static void update_insn_state_x86(struct type_state *state,
 			} else if (!stack->compound) {
 				tsr->type = stack->type;
 				tsr->kind = stack->kind;
+				tsr->offset = 0;
 				tsr->ok = true;
 			} else if (die_get_member_type(&stack->type,
 						       offset - stack->offset,
 						       &type_die)) {
 				tsr->type = type_die;
 				tsr->kind = TSR_KIND_TYPE;
+				tsr->offset = 0;
 				tsr->ok = true;
 			} else {
 				tsr->ok = false;
@@ -446,9 +554,10 @@ static void update_insn_state_x86(struct type_state *state,
 		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
 			 state->regs[sreg].kind == TSR_KIND_TYPE &&
 			 die_deref_ptr_type(&state->regs[sreg].type,
-					    src->offset, &type_die)) {
+					    src->offset + state->regs[sreg].offset, &type_die)) {
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("mov [%x] %#x(reg%d) -> reg%d",
@@ -473,6 +582,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("mov [%x] global addr=%"PRIx64" -> reg%d",
@@ -504,6 +614,7 @@ static void update_insn_state_x86(struct type_state *state,
 			    die_get_member_type(&type_die, offset, &type_die)) {
 				tsr->type = type_die;
 				tsr->kind = TSR_KIND_TYPE;
+				tsr->offset = 0;
 				tsr->ok = true;
 
 				if (src->multi_regs) {
@@ -526,6 +637,7 @@ static void update_insn_state_x86(struct type_state *state,
 					     src->offset, &type_die)) {
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("mov [%x] pointer %#x(reg%d) -> reg%d",
@@ -548,6 +660,7 @@ static void update_insn_state_x86(struct type_state *state,
 							&var_name, &offset) &&
 				    !strcmp(var_name, "__per_cpu_offset")) {
 					tsr->kind = TSR_KIND_PERCPU_BASE;
+					tsr->offset = 0;
 					tsr->ok = true;
 
 					pr_debug_dtp("mov [%x] percpu base reg%d\n",
@@ -571,6 +684,19 @@ static void update_insn_state_x86(struct type_state *state,
 			int offset = dst->offset - fboff;
 
 			tsr = &state->regs[src->reg1];
+			type_die = tsr->type;
+
+			/* The register is derived from a pointer to the type */
+			if (tsr->offset != 0) {
+				/*
+				 * deref gets the innermost field, but we actually want direct
+				 * child field and take a pointer to it.
+				 * However array type like unsigned long[] is already a pointer
+				 * and is the most common case for this kind of stack variable.
+				 */
+				if (die_deref_ptr_type(&tsr->type, tsr->offset, &type_die) == NULL)
+					return;
+			}
 
 			stack = find_stack_state(state, offset);
 			if (stack) {
@@ -583,10 +709,10 @@ static void update_insn_state_x86(struct type_state *state,
 				 */
 				if (!stack->compound)
 					set_stack_state(stack, offset, tsr->kind,
-							&tsr->type);
+							&type_die);
 			} else {
 				findnew_stack_state(state, offset, tsr->kind,
-						    &tsr->type);
+						    &type_die);
 			}
 
 			if (dst->reg1 == fbreg) {
@@ -596,7 +722,11 @@ static void update_insn_state_x86(struct type_state *state,
 				pr_debug_dtp("mov [%x] reg%d -> %#x(reg%d)",
 					     insn_offset, src->reg1, offset, dst->reg1);
 			}
-			pr_debug_type_name(&tsr->type, tsr->kind);
+			if (tsr->offset != 0)
+				pr_debug_dtp(" reg%d offset %#x ->",
+					src->reg1, tsr->offset);
+
+			pr_debug_type_name(&type_die, tsr->kind);
 		}
 		/*
 		 * Ignore other transfers since it'd set a value in a struct
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 258157cc43c2..e067e91f2037 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -892,7 +892,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 					     insn_offset, -offset);
 			}
 			pr_debug_type_name(&mem_die, TSR_KIND_TYPE);
-		} else if (has_reg_type(state, var->reg) && var->offset == 0) {
+		} else if (has_reg_type(state, var->reg)) {
 			struct type_state_reg *reg;
 			Dwarf_Die orig_type;
 
@@ -907,13 +907,17 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 				continue;
 
 			orig_type = reg->type;
-
+			/*
+			 * var->offset + reg value is the beginning of the struct
+			 * reg->offset is the offset the reg points
+			 */
+			reg->offset = -var->offset;
 			reg->type = mem_die;
 			reg->kind = TSR_KIND_TYPE;
 			reg->ok = true;
 
-			pr_debug_dtp("var [%"PRIx64"] reg%d",
-				     insn_offset, var->reg);
+			pr_debug_dtp("var [%"PRIx64"] reg%d offset %x",
+				     insn_offset, var->reg, var->offset);
 			pr_debug_type_name(&mem_die, TSR_KIND_TYPE);
 
 			/*
@@ -1101,7 +1105,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		if (__die_get_real_type(&state->regs[reg].type, type_die) == NULL)
 			return PERF_TMR_NO_POINTER;
 
-		dloc->type_offset = dloc->op->offset;
+		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
 
 		if (dwarf_tag(type_die) == DW_TAG_typedef)
 			die_get_real_type(type_die, &sized_type);
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 541fee1a5f0a..47a4c752b917 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -173,6 +173,12 @@ extern struct annotated_data_stat ann_data_stat;
 struct type_state_reg {
 	Dwarf_Die type;
 	u32 imm_value;
+	/*
+	 * The offset within the struct that the register points to.
+	 * A value of 0 means the register points to the beginning.
+	 * type_offset = op->offset + reg->offset
+	 */
+	s32 offset;
 	bool ok;
 	bool caller_saved;
 	u8 kind;
-- 
2.51.0.261.g7ce5a0a67e-goog

