Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9283F39C8
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 05:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787288559; cv=none; b=s2NDLgW/DESn+dC/anHA/VH7V1W/TVVtFCjzjqOy7rQ93BJEjDcbOYAPvBh8SV+S5llUalbfU/Z2rqvhBBm/1lV55Xgl5DAkZqdcq+ZqpXsGOjX5qm3Tb0aaxMVyHYAe9TlaCUHFMPdd2Z5KEbP/MRJ+S0h+FMM5w501I9vvqIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787288559; c=relaxed/simple;
	bh=8JI029aHHVd4hzfZslrLMNIc0yKFwbk2r2Yl5nBhqZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qDH3GoF0O30Cby0s5U3gYJSpXPS4hsSj59gc5ovepM5LuAjsjKI0sUQgQX0YxGhUvg1+44yIFYPRs2the1c5swXWN4k9A2kMfungZIWD+NMAO3OJX5ISgx+gPJ+HHx9A9cVxKjw6N8hgwDW6VPfYnQpfr1i8+fbEI7EJEmFHlM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=Qnu+ekyl; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="Qnu+ekyl"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-52de178a66aso3624421cf.3
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 22:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1787288556; x=1787893356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wPbluY6yf1PyMOHReNPfj1WTJm+vQ4UBgCAO3CQP2eE=;
        b=Qnu+ekylt6PGtIVMUl1w2UAPs6kXzOPHHvwG3npk3y9wlxRipB9EGFmaJf1hXBmV0c
         CrsFK/LmqBO8zEZKicW/i0l5XTk/+GMRVD61HZGQrw1aMRknKRVjkcYT4g+3i7V8oGLJ
         GUO3QMrPWr/KQElJdc4zUJ+DksGYYR7iz1fcVw3d94zPC0kD0vNyV7AG4aG2nv9PlonO
         xgIfhC2J0HF2H2ar+3Io097+04DyeV9G3aPpYb2U5qYJoj2fcHn7xXpQfj19xYu4/YQT
         w3NTuE1Ha/mGE6KjX37UpbZJiBElsoRdB+nM6uzLWjxJBB1sojC3k0N2vuyy3va2XC5W
         puBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787288556; x=1787893356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wPbluY6yf1PyMOHReNPfj1WTJm+vQ4UBgCAO3CQP2eE=;
        b=a2zLTokpnR6N4mvowrPRLuwwVvEWkYDaULQ1cOQ+2YfrP6S/E5OW8SiMkSJcXuPq11
         x1cxcVQS9ZuVLMKoQ+6WOVYAKUognd+w0HsqMgS+MpZWo0UvfDyKxoIb71IkOk82djZ5
         9n/bLIDw/VjlXZrHhXFzwtdpu3nFlFTPULOwUu/RvF0PCztq+Y6obrIkrgHVdZfg/u+H
         uR9Wo57MHi+E8yAB5GhbSdVK21EbEBVL4dgWl9vxKIDLoqr8AE1foebr7Mj2A1qFr7WZ
         RWAfSaubKv8eoqIlBB9JUvMLinWO6wESsfpcTqbIRay66oiDvsf6XD4L2JTKg7ylyHtg
         Ssfg==
X-Forwarded-Encrypted: i=1; AHgh+RqFANKehjQ4zRr/urC9WA+l2tH/2ZvcR5NVNibYMrcSH/0wsn8wkYF821YQgBCIubaD66TZpbbO405BmhyCuWKd@vger.kernel.org
X-Gm-Message-State: AOJu0YzgZeMVQ/mStX4E8HclB05R6mlls+hwnxEX4twyD5iW8QzJ+MPW
	9sjSAp87wwQ31XpO/tp5rUEOCP39eFyo6WxLyxUMvXiEOkUAlMPiO6Rd21Jgw9pPTQ==
X-Gm-Gg: AR+sD11GBtMcuTJrGsGjmwRJbBuZ1lsixvAVFVc+wp+Am65MX5zZtGDfRLr0nZAp/PV
	lvU3g4CTP4fkZYsMjilV4+BySZ+RbGr5tCZPe2934GBZTFgPbJsHF5EXNulQTVMl8zqTNn1GNu9
	HqMjIOU8o3YvEQa7aPXuQuGNwNZubcsuE+Or2B4MEvFnuysuLW/2VVmGfEoFyNjX6cHzPyzub05
	IfW+2igUnk5co7MDkueyEPPAjSqcL1FFMLeOCY011oxSEeKuII5DKnaqvyuffXmuwAgiuWKied7
	xHyxSiYphLrUEImeEwmsHQrzz9Gfp5qxmw0GyhZfqrRXJq+RgSLCEGvo0ZAJMYar1MHhCic3FMJ
	7U2yjxgg+8ddgzNJoZLnhIDsM9Vlre2FSzeMpeWue2O3bkTAFi+Gzt+Ssv3gIYqOMdXeSMAU+l8
	wcl/atnBo7KUyTzXpJudz0O8AIT6QYo08LaqoisuDaEbCRG+Z1d4nPCml8xA57aHL5KFHr6d+di
	RTRE7iLCZ9i270Gdd6mLw==
X-Received: by 2002:a05:622a:1485:b0:52d:c1a:797a with SMTP id d75a77b69052e-52df56e48f6mr35689151cf.8.1787288556178;
        Thu, 20 Aug 2026 22:02:36 -0700 (PDT)
Received: from home.localdomain ([136.61.118.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5eec1e7fsm54368116d6.12.2026.08.20.22.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 22:02:35 -0700 (PDT)
From: Yanbo Zhao <yzhao62@ncsu.edu>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Zecheng Li <zli94@ncsu.edu>,
	Xu Liu <xliuprof@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yanbo Zhao <yzhao62@ncsu.edu>
Subject: [PATCH 3/3] perf disasm & annotate x86: Track C++ vptr and resolve virtual function calls
Date: Fri, 21 Aug 2026 01:02:07 -0400
Message-Id: <20260821050207.4517-4-yzhao62@ncsu.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260821050207.4517-1-yzhao62@ncsu.edu>
References: <20260821050207.4517-1-yzhao62@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement disassembler and x86 type profiling support for C++ virtual
dispatch and indirect call resolution:
- In call__parse() for indirect calls, duplicate and store ops->raw into
  ops->target.raw so instruction location extraction can retrieve target
  operand registers and offsets.
- In extract_reg_offset(), skip any leading '*' prefix (e.g. *%rax).
- Add TSR_KIND_VTABLE_PTR to enum type_state_kind and handle it in
  pr_debug_type_name().
- In update_insn_state_x86() for mov instructions, inspect member
  name and identify '_vptr' access, setting register kind to
  TSR_KIND_VTABLE_PTR via die_is_vptr_member() helper.
- For call instructions targeting virtual function tables, look up
  the virtual function DIE via die_find_virtual_func() before
  register state invalidation.  Only the primary vtable is handled
  for now (TODO: multiple inheritance).
- Update the receiver ('this' pointer) register to the C++ class DIE
  upon virtual call resolution when CU is C++.  The register number
  comes from the new type_state::arg0_reg field initialized per arch
  like ret_reg, instead of being hardcoded.
- Move caller-saved register invalidation after reading target
  operands to prevent losing state required for virtual call
  resolution.

Signed-off-by: Yanbo Zhao <yzhao62@ncsu.edu>
---
 tools/perf/util/annotate-arch/annotate-x86.c | 103 ++++++++++++++++---
 tools/perf/util/annotate-data.c              |   7 ++
 tools/perf/util/annotate-data.h              |   3 +
 tools/perf/util/annotate.c                   |   4 +
 tools/perf/util/disasm.c                     |   1 +
 5 files changed, 105 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index 7e6136536393..cfb37a6130ba 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -11,6 +11,8 @@
 #include "../map.h"
 #include "../string2.h" // strstarts
 #include "../symbol.h"
+#include "../hist.h"
+#include "../dwarf-aux.h"
 
 /*
  * x86 instruction nmemonic table to parse disasm lines for annotate.
@@ -234,6 +236,11 @@ static void update_insn_state_x86(struct type_state *state,
 		struct symbol *func = dl->ops.target.sym;
 		const char *call_name;
 		u64 call_addr;
+		Dwarf_Die target_func_die;
+		bool resolved_statically = false;
+		Dwarf_Die class_die;
+		bool has_class_die = false;
+		struct annotated_op_loc *target_op;
 
 		/* Try to resolve the call target name */
 		if (func)
@@ -245,12 +252,42 @@ static void update_insn_state_x86(struct type_state *state,
 		if (call_name && !strcmp(call_name, "__fentry__"))
 			return;
 
+		/*
+		 * 1. Resolve target statically (virtual call fallback) FIRST
+		 * (before invalidation)
+		 */
+		target_op = &loc.ops[INSN_OP_TARGET];
+
+		if (target_op->mem_ref && has_reg_type(state, target_op->reg1)) {
+			struct type_state_reg *reg = &state->regs[target_op->reg1];
+
+			if (reg->ok && reg->kind == TSR_KIND_VTABLE_PTR) {
+				/* TODO: handle multiple inheritance (non-primary vtables) */
+				int vtable_index = target_op->offset / 8;
+				Dwarf_Die target_class_die = reg->type;
+
+				if (die_find_virtual_func(&target_class_die, vtable_index,
+							  &target_func_die) &&
+				    die_get_type(&target_func_die, &type_die)) {
+					resolved_statically = true;
+					class_die = target_class_die;
+					has_class_die = true;
+				}
+			}
+		}
+
+		/* Fallback to name-based resolution for direct calls */
+		if (!resolved_statically && call_name) {
+			if (die_find_func_rettype(cu_die, call_name, &type_die))
+				resolved_statically = true;
+		}
+
 		if (call_name)
 			pr_debug_dtp("call [%x] %s\n", insn_offset, call_name);
 		else
 			pr_debug_dtp("call [%x] <unknown>\n", insn_offset);
 
-		/* Invalidate caller-saved registers after call */
+		/* 2. Invalidate caller-saved registers after we read them for resolution */
 		call_addr = map__rip_2objdump(dloc->ms->map,
 					      dloc->ms->sym->start + dl->al.offset);
 		for (unsigned i = 0; i < ARRAY_SIZE(state->regs); i++) {
@@ -264,8 +301,8 @@ static void update_insn_state_x86(struct type_state *state,
 			invalidate_reg_state(reg);
 		}
 
-		/* Update register with the return type (if any) */
-		if (call_name && die_find_func_rettype(cu_die, call_name, &type_die)) {
+		/* 3. Apply resolved types to registers */
+		if (resolved_statically) {
 			tsr = &state->regs[state->ret_reg];
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
@@ -275,6 +312,20 @@ static void update_insn_state_x86(struct type_state *state,
 			pr_debug_dtp("call [%x] return -> reg%d",
 				     insn_offset, state->ret_reg);
 			pr_debug_type_name(&type_die, tsr->kind);
+
+			/* Update receiver ('this' pointer) register if C++ */
+			if (has_class_die && cu_is_cplusplus(cu_die)) {
+				struct type_state_reg *recv_tsr = &state->regs[state->arg0_reg];
+
+				if (recv_tsr->ok &&
+				    (recv_tsr->kind == TSR_KIND_TYPE ||
+				     recv_tsr->kind == TSR_KIND_POINTER)) {
+					recv_tsr->type = class_die;
+					pr_debug_dtp("call [%x] update receiver reg%d to C++ class",
+						     insn_offset, state->arg0_reg);
+					pr_debug_type_name(&class_die, recv_tsr->kind);
+				}
+			}
 		}
 		return;
 	}
@@ -622,17 +673,43 @@ static void update_insn_state_x86(struct type_state *state,
 		}
 		/* And then dereference the pointer if it has one */
 		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
-			 state->regs[sreg].kind == TSR_KIND_TYPE &&
-			 die_deref_ptr_type(&state->regs[sreg].type,
-					    src->offset + state->regs[sreg].offset, &type_die)) {
-			tsr->type = type_die;
-			tsr->kind = TSR_KIND_TYPE;
-			tsr->offset = 0;
-			tsr->ok = true;
+			 state->regs[sreg].kind == TSR_KIND_TYPE) {
+			Dwarf_Die class_type;
+			Dwarf_Die member;
+			int total_offset = src->offset + state->regs[sreg].offset;
+			bool is_vptr = false;
+
+			if (die_get_real_type(&state->regs[sreg].type, &class_type) &&
+			    die_is_compound_type(&class_type) &&
+			    die_find_member_by_offset(&class_type, total_offset, &member) &&
+			    die_is_vptr_member(&member)) {
+				tsr->type = class_type;
+				tsr->kind = TSR_KIND_VTABLE_PTR;
+				tsr->offset = 0;
+				tsr->ok = true;
 
-			pr_debug_dtp("mov [%x] %#x(reg%d) -> reg%d",
-				     insn_offset, src->offset, sreg, dst->reg1);
-			pr_debug_type_name(&tsr->type, tsr->kind);
+				pr_debug_dtp("mov [%x] %#x(reg%d) -> reg%d (vptr)",
+					     insn_offset, src->offset,
+					     sreg, dst->reg1);
+				pr_debug_type_name(&class_type, tsr->kind);
+				is_vptr = true;
+			}
+
+			if (!is_vptr) {
+				if (die_deref_ptr_type(&state->regs[sreg].type,
+						       total_offset, &type_die)) {
+					tsr->type = type_die;
+					tsr->kind = TSR_KIND_TYPE;
+					tsr->offset = 0;
+					tsr->ok = true;
+
+					pr_debug_dtp("mov [%x] %#x(reg%d) -> reg%d",
+						     insn_offset, src->offset, sreg, dst->reg1);
+					pr_debug_type_name(&tsr->type, tsr->kind);
+				} else {
+					invalidate_reg_state(tsr);
+				}
+			}
 		}
 		/* Handle dereference of TSR_KIND_POINTER registers */
 		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index ee6bd2d0012d..875e5ba2fe9f 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -28,6 +28,8 @@
 
 /* register number of the stack pointer */
 #define X86_REG_SP 7
+/* register number of the first integer argument (%rdi) */
+#define X86_REG_DI 5
 
 static void delete_var_types(struct die_var_type *var_types);
 
@@ -66,6 +68,10 @@ void pr_debug_type_name(Dwarf_Die *die, enum type_state_kind kind)
 		pr_info(" pointer");
 		/* it also prints the type info */
 		break;
+	case TSR_KIND_VTABLE_PTR:
+		pr_info(" C++ vtable pointer");
+		/* it also prints the type info */
+		break;
 	case TSR_KIND_CANARY:
 		pr_info(" stack canary\n");
 		return;
@@ -177,6 +183,7 @@ static void init_type_state(struct type_state *state, const struct arch *arch)
 		state->regs[10].caller_saved = true;
 		state->regs[11].caller_saved = true;
 		state->ret_reg = 0;
+		state->arg0_reg = X86_REG_DI;
 		state->stack_reg = X86_REG_SP;
 	}
 }
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index c26130744260..785e1d1777ce 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -36,6 +36,7 @@ enum type_state_kind {
 	TSR_KIND_CONST,
 	TSR_KIND_PERCPU_POINTER,
 	TSR_KIND_POINTER,
+	TSR_KIND_VTABLE_PTR,
 	TSR_KIND_CANARY,
 };
 
@@ -224,6 +225,8 @@ struct type_state {
 	struct list_head stack_vars;
 	/* return value register */
 	int ret_reg;
+	/* first integer argument register (holds 'this' for C++ methods) */
+	int arg0_reg;
 	/* stack pointer register */
 	int stack_reg;
 };
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index df70e95a8470..b4c6b45b4da3 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2509,6 +2509,10 @@ static int extract_reg_offset(const struct arch *arch, const char *str,
 	if (arch->objdump.register_char == 0)
 		return -1;
 
+	/* Skip leading '*' for indirect call/jmp operands (e.g. *%rax) */
+	if (*str == '*')
+		str++;
+
 	/*
 	 * It should start from offset, but it's possible to skip 0
 	 * in the asm.  So 0(%rax) should be same as (%rax).
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 6cfdbabbb8c7..01266eeddbb4 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -279,6 +279,7 @@ static int call__parse(const struct arch *arch, struct ins_operands *ops, struct
 	return 0;
 
 indirect_call:
+	ops->target.raw = strdup(ops->raw);
 	tok = strchr(endptr, '*');
 	if (tok != NULL) {
 		endptr++;
-- 
2.25.1

