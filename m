Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BBA2DE70C
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139098; cv=none; b=Y6eGau3+qH3CwDXdiM28LDsTVTXtwCUq1yxr0rUlP2qHoDZGV9DtB2uSxxiT85znxnbA7mZymGqzxudoXDa4CIop+rijwmGWQB5AltBhxINdXEHX6ZaEgfoDyJGdWX3gik+lpEe42s7a03mwBL1YZNjS6/NXTAC5CIXD27SOzNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139098; c=relaxed/simple;
	bh=XCrY+1rGpgecUi0nVjyjs9MUlD/2xdG6C/rkH+vuJYs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q/n7WNOFhv8jVYYNsAOT4PzasNQKiSyX0WPasX31g4EHk1qHQBZWGEtz09Hkq80v3sJxuhERMrcoQh5gusklrXJv+CDWptlKYEtKSox9i7ImpZmiclKGi0hfSI85NaxNzy68Of9TSMAMsU5oZ9+4U02STXCzjWJdGRz+eMYQnBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QlCWkuCJ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QlCWkuCJ"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-72396ac948eso3003607b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 12:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758139095; x=1758743895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8hHW+XAp3lKhCTedfjsNdbKqzalF8NTl2yuxT14sQQ0=;
        b=QlCWkuCJL6S7eIO8e0JbelLubowypQLh8n3ZhYnSGksqnNRb7TeMGZ22gC8fzeCk2Q
         b7eIMWSD69qVqCh0AT/OAnAI69fpvIvm3OJ1zdRS00lMLmUGWQx7IHqKkpKj4GRoPdCx
         9Y8KouNEV3ikzlhe8lZn156+OmtvzK9sFgT1uTYW82R8JN0LEZsi4bpbFx7W10cE9Ygk
         g3vUl8CtCMvrVERi23Qd8HLwbPhn3EY1oP9Snfqq0iJO8wf43P7/pXGSI0SIk1VTh/nt
         4euh+uu1THIgZ5CL9h7/IzxoCCcSNhmaU0eYYA0CRq0q27YDckMhZ6tOojtkiV69+ueD
         g7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139095; x=1758743895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8hHW+XAp3lKhCTedfjsNdbKqzalF8NTl2yuxT14sQQ0=;
        b=QxhLE+9HKX3uh7P6QpM/4JcDzZaZ8JQFlCqc1Z1gjB/PAmoKUnBfTUZWF/wMFDqd7l
         FSGL7nfZ31r57uATcEVY+VcLmqnufuSwsxOuuljGMjbGmlfp81gwiU4a0/h/iGwmON1h
         rUdNVX5UBCJg08h/Im7hEaQMXWXSAji//sSxywczhmkdxRNVk5DgZE+4BdDnAPXNOwBN
         JIHg7nRHlOI6GXIsfnElomODIvlTmFCaf7/MmnF9MDUJ/xKpd5P58c4quQEAVZFRfw77
         t2s7ZNBUFD+jmtsEtNabAvumLrwBZ+rl6jexAeQF5rubTNgrhBexdEMCH94l/rAievhy
         WSwA==
X-Forwarded-Encrypted: i=1; AJvYcCWcUXNAYUBjF7gKQnm6VFPct7J+s8eO/dx8bwU+PESV57XOoRbp9PMlKoOHhpOJ9PPoC80DVO1tpzJ87KA4eQU4@vger.kernel.org
X-Gm-Message-State: AOJu0YzgTn7JXvkX3aJqBfJ1Rb0uu3oCvGEjmvQK7c2lcF4tx5su8/w5
	eB6QznDiRBrWNwhj6CnreOFSnwcmoClNmayVQKhL4uoq4BJwgqwUw2QQHwO9NVrDuj38heXgRxA
	CkftfULJy6w==
X-Google-Smtp-Source: AGHT+IE0ago1RspXdbNKJZnBtTNQP8H+m7DjLmXV6pLIDw2hhD6kL8x8NC9PjMJKjLN03yClaD9vqa9Hsskn
X-Received: from ywbgq5.prod.google.com ([2002:a05:690c:4445:b0:71f:d0b0:127a])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:88:b0:720:631:e778
 with SMTP id 00721157ae682-73892a4925emr29091867b3.30.1758139095516; Wed, 17
 Sep 2025 12:58:15 -0700 (PDT)
Date: Wed, 17 Sep 2025 19:58:02 +0000
In-Reply-To: <20250917195808.2514277-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917195808.2514277-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917195808.2514277-5-zecheng@google.com>
Subject: [PATCH v3 04/10] perf annotate: Track arithmetic instructions on pointers
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

Multi-register addressing modes in LEA are not supported.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/arch/x86/annotate/instructions.c | 121 +++++++++++++++++++-
 tools/perf/util/annotate-data.c             |  17 ++-
 tools/perf/util/annotate-data.h             |   6 +
 3 files changed, 136 insertions(+), 8 deletions(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 698cbb299c6d..cfb07cff8fc8 100644
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
@@ -291,6 +293,16 @@ static void update_insn_state_x86(struct type_state *state,
 		else
 			return;
 
+		/* Ignore add to non-pointer types like int */
+		if (tsr->kind == TSR_KIND_POINTER ||
+		    (dwarf_tag(&tsr->type) == DW_TAG_pointer_type &&
+		     src->reg1 != DWARF_REG_PC && tsr->kind == TSR_KIND_TYPE && !dst->mem_ref)) {
+			tsr->offset += imm_value;
+			pr_debug_dtp("add [%x] offset %#"PRIx64" to reg%d",
+				     insn_offset, imm_value, dst->reg1);
+			pr_debug_type_name(&tsr->type, tsr->kind);
+		}
+
 		if (tsr->kind != TSR_KIND_PERCPU_BASE)
 			return;
 
@@ -302,6 +314,7 @@ static void update_insn_state_x86(struct type_state *state,
 			 */
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_PERCPU_POINTER;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("add [%x] percpu %#"PRIx64" -> reg%d",
@@ -311,6 +324,93 @@ static void update_insn_state_x86(struct type_state *state,
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
+		if (tsr->kind == TSR_KIND_POINTER ||
+		    (dwarf_tag(&tsr->type) == DW_TAG_pointer_type &&
+		     src->reg1 != DWARF_REG_PC && tsr->kind == TSR_KIND_TYPE && !dst->mem_ref)) {
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
+			tsr->type = stack->type;
+			tsr->kind = TSR_KIND_POINTER;
+			tsr->offset = offset - stack->offset;
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
 
@@ -345,6 +445,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 			if (var_addr == 40) {
 				tsr->kind = TSR_KIND_CANARY;
+				tsr->offset = 0;
 				tsr->ok = true;
 
 				pr_debug_dtp("mov [%x] stack canary -> reg%d\n",
@@ -361,6 +462,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("mov [%x] this-cpu addr=%#"PRIx64" -> reg%d",
@@ -372,6 +474,7 @@ static void update_insn_state_x86(struct type_state *state,
 		if (src->imm) {
 			tsr->kind = TSR_KIND_CONST;
 			tsr->imm_value = src->offset;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("mov [%x] imm=%#x -> reg%d\n",
@@ -388,6 +491,7 @@ static void update_insn_state_x86(struct type_state *state,
 		tsr->type = state->regs[src->reg1].type;
 		tsr->kind = state->regs[src->reg1].kind;
 		tsr->imm_value = state->regs[src->reg1].imm_value;
+		tsr->offset = state->regs[src->reg1].offset;
 		tsr->ok = true;
 
 		/* To copy back the variable type later (hopefully) */
@@ -421,16 +525,19 @@ static void update_insn_state_x86(struct type_state *state,
 			} else if (stack->kind == TSR_KIND_POINTER) {
 				tsr->type = stack->type;
 				tsr->kind = stack->kind;
+				tsr->offset = 0;
 				tsr->ok = true;
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
@@ -450,9 +557,10 @@ static void update_insn_state_x86(struct type_state *state,
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
@@ -463,9 +571,10 @@ static void update_insn_state_x86(struct type_state *state,
 		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
 			 state->regs[sreg].kind == TSR_KIND_POINTER &&
 			 die_get_member_type(&state->regs[sreg].type,
-					     src->offset, &type_die)) {
+					     src->offset + state->regs[sreg].offset, &type_die)) {
 			tsr->type = state->regs[sreg].type;
 			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = src->offset + state->regs[sreg].offset;
 			tsr->ok = true;
 
 			pr_debug_dtp("mov [%x] addr %#x(reg%d) -> reg%d",
@@ -490,6 +599,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("mov [%x] global addr=%"PRIx64" -> reg%d",
@@ -521,6 +631,7 @@ static void update_insn_state_x86(struct type_state *state,
 			    die_get_member_type(&type_die, offset, &type_die)) {
 				tsr->type = type_die;
 				tsr->kind = TSR_KIND_TYPE;
+				tsr->offset = 0;
 				tsr->ok = true;
 
 				if (src->multi_regs) {
@@ -543,6 +654,7 @@ static void update_insn_state_x86(struct type_state *state,
 					     src->offset, &type_die)) {
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
 			tsr->ok = true;
 
 			pr_debug_dtp("mov [%x] pointer %#x(reg%d) -> reg%d",
@@ -565,6 +677,7 @@ static void update_insn_state_x86(struct type_state *state,
 							&var_name, &offset) &&
 				    !strcmp(var_name, "__per_cpu_offset")) {
 					tsr->kind = TSR_KIND_PERCPU_BASE;
+					tsr->offset = 0;
 					tsr->ok = true;
 
 					pr_debug_dtp("mov [%x] percpu base reg%d\n",
@@ -613,6 +726,10 @@ static void update_insn_state_x86(struct type_state *state,
 				pr_debug_dtp("mov [%x] reg%d -> %#x(reg%d)",
 					     insn_offset, src->reg1, offset, dst->reg1);
 			}
+			if (tsr->offset != 0)
+				pr_debug_dtp(" reg%d offset %#x ->",
+					src->reg1, tsr->offset);
+
 			pr_debug_type_name(&tsr->type, tsr->kind);
 		}
 		/*
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 31b5896276f1..6ca5489f3c4c 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -898,7 +898,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 					     insn_offset, -offset);
 			}
 			pr_debug_type_name(&mem_die, TSR_KIND_TYPE);
-		} else if (has_reg_type(state, var->reg) && var->offset == 0) {
+		} else if (has_reg_type(state, var->reg)) {
 			struct type_state_reg *reg;
 			Dwarf_Die orig_type;
 
@@ -914,6 +914,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 				    !is_better_type(&reg->type, &mem_die))
 					continue;
 
+				reg->offset = -var->offset;
 				reg->type = mem_die;
 				reg->kind = TSR_KIND_POINTER;
 				reg->ok = true;
@@ -925,13 +926,17 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 			}
 
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
@@ -1119,7 +1124,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		if (__die_get_real_type(&state->regs[reg].type, type_die) == NULL)
 			return PERF_TMR_NO_POINTER;
 
-		dloc->type_offset = dloc->op->offset;
+		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
 
 		if (dwarf_tag(type_die) == DW_TAG_typedef)
 			die_get_real_type(type_die, &sized_type);
@@ -1148,7 +1153,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		 */
 		*type_die = state->regs[reg].type;
 
-		dloc->type_offset = dloc->op->offset;
+		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
 
 		/* Get the size of the actual type */
 		if (dwarf_aggregate_size(type_die, &size) < 0 ||
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index fd0d1084bc4e..20237e7e4e2f 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -174,6 +174,12 @@ extern struct annotated_data_stat ann_data_stat;
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
2.51.0.384.g4c02a37b29-goog

