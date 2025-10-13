Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A05C2D3EC1
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379382; cv=none; b=Ctdx5wWPU4Gx6REA7F5VOhtviQNc0QllfTDb15dghe7wx53NW/EB9iX1YaTsWms3hxPfEl699JSEYH8s0pRDlPC6VvBuZ9y4v6XuZ03rVQLrR0y6n2sxBZG0FxKhLVM05nmJsBf/dBgHkfAumBxCFuhiF/ixQVqr2pXQ+8WIVCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379382; c=relaxed/simple;
	bh=hdQwasz3k/8aVmkaktfyahi7bymSRNa+aUUKjsQm7jk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DXhz0jeNXeOiVBjUP90hXnoNjZ9hGDtfX7dfPNJGTvvio9jssX30v08TySd5mRRHKlytPpmVcTaA5oSTU1wiVqUCkV0fdPCSE9d62F5ZQU2rnj+J5Z/0SvTd3jtDNW9S+DTZxqCs22dD7fNSKVyZ2qCJX/ml6VinFxJBwnd93ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dDYDMhsR; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dDYDMhsR"
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-86df46fa013so2990868585a.2
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 11:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760379379; x=1760984179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iK3U66KVI+sJzm09jDANDs7sR4Zyydo9qXm47VNoMW8=;
        b=dDYDMhsRuF+DacdAs1t4qgAAQ2MeiqJFvvAgLVPgYd8v1SO/HqWfM3sDkQnJapq+S7
         DoGPC4Uua4YiOdMC2ofGuLTcDM/by4kstq50hEFQt/AYlTtCAYF5bVIEz44QxSwyCXqy
         r26Zw+/P3c7FjhIzhcxNi1GDp+6WR7jn82Pagp2CMtzG1LTQYfp6UEO12WcPKiD2McMV
         JlIQZAYhxKepSID8XzYmctSE1dCOwuh/T3VS2Mvg7Vld1Ea5rrmDHTT4+ETRQNKufl+U
         4t/6/YOiIJn1oX2l3vsVbHpc+bvRA0UNZiUoLVbZ+IL7V0y3XIyJWunPmNvhehKW55PB
         AGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379379; x=1760984179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iK3U66KVI+sJzm09jDANDs7sR4Zyydo9qXm47VNoMW8=;
        b=bTqo7BUGo6oaVaVkBG1WtPKRyhnNUwYOmr+E6Inl5/z9O3fp2ZE92ZiexQ8ZmukwEI
         e/2ukW7Biosk7ZHMQ6wu88SrNodvte96982zjfwT+O6Yxj+Y64FWAMHX454sLIRlzx0B
         R8ZqMtzWztnqeeb/Xonw6ujKQbLR/bX9RvhSPoN5MsXykuRRmWa1SMPZD+jCDt1ZdLgO
         Q42nfiiLljE1OY/IEw8X+NbVDfu4r7vgDuYvz2ivVuflEN0A06b8jZhQpzeCJIAdLiz6
         gdoTZybDNhjmnkR3mYnI5c2Sh1aSfNID+LgLljRkMHQjQtYlAKGOo6kLmD4VkVUpz2Gi
         4VFw==
X-Forwarded-Encrypted: i=1; AJvYcCWW4tC2J0qi8ObxwtgxhsLpiqxETk02rcRB5y4yTFT3F0A1wXTaeA3ZRh9AQZ3gq7KT2M8brvilc4L9IARFbpTh@vger.kernel.org
X-Gm-Message-State: AOJu0YxBYZ0VdAHgmns56G3c+qvTuGbuZXcg5obnmA+C48EJQUd9uWRz
	firIcV9xqkjN3Nky70ts5DDyLgrRWCmU7XLS3O8sQZ3M5pm0NLcYrsLh2EBmED/J+SuPU47wY/A
	7XMjihVZqxw==
X-Google-Smtp-Source: AGHT+IGc7udGKdQSdqQpU6ffFJjcbRcWgNJSXeL3L1GG7uXlpOZlJUqm14HGDZ5C/ApD9XNKSMgMASNedSBB
X-Received: from qknrd8.prod.google.com ([2002:a05:620a:8dc8:b0:884:932e:e4b0])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:4042:b0:878:4b36:bd2f
 with SMTP id af79cd13be357-88354013e59mr3226060385a.73.1760379379323; Mon, 13
 Oct 2025 11:16:19 -0700 (PDT)
Date: Mon, 13 Oct 2025 18:15:59 +0000
In-Reply-To: <20251013181607.2745653-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013181607.2745653-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251013181607.2745653-3-zecheng@google.com>
Subject: [PATCH v4 2/9] perf annotate: Track address registers via TSR_KIND_POINTER
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce TSR_KIND_POINTER to improve the data type profiler's ability
to track pointer-based memory accesses and address register variables.

TSR_KIND_POINTER represents that the location holds a pointer type to
the type in the type state. The semantics match the `breg` registers
that describe a memory location.

This change implements handling for this new kind in mov instructions
and in the check_matching_type() function. When a TSR_KIND_POINTER is
moved to the stack, the stack state size is set to the architecture's
pointer size.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/arch/x86/annotate/instructions.c | 15 ++++-
 tools/perf/util/annotate-data.c             | 63 ++++++++++++++++++---
 tools/perf/util/annotate-data.h             |  1 +
 3 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index da98a4e3c52c..746443e04089 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -391,7 +391,7 @@ static void update_insn_state_x86(struct type_state *state,
 		tsr->ok = true;
 
 		/* To copy back the variable type later (hopefully) */
-		if (tsr->kind == TSR_KIND_TYPE)
+		if (tsr->kind == TSR_KIND_TYPE || tsr->kind == TSR_KIND_POINTER)
 			tsr->copied_from = src->reg1;
 
 		pr_debug_dtp("mov [%x] reg%d -> reg%d",
@@ -455,6 +455,19 @@ static void update_insn_state_x86(struct type_state *state,
 				     insn_offset, src->offset, sreg, dst->reg1);
 			pr_debug_type_name(&tsr->type, tsr->kind);
 		}
+		/* Handle dereference of TSR_KIND_POINTER registers */
+		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
+			 state->regs[sreg].kind == TSR_KIND_POINTER &&
+			 die_get_member_type(&state->regs[sreg].type,
+					     src->offset, &type_die)) {
+			tsr->type = state->regs[sreg].type;
+			tsr->kind = TSR_KIND_TYPE;
+			tsr->ok = true;
+
+			pr_debug_dtp("mov [%x] addr %#x(reg%d) -> reg%d",
+				     insn_offset, src->offset, sreg, dst->reg1);
+			pr_debug_type_name(&tsr->type, tsr->kind);
+		}
 		/* Or check if it's a global variable */
 		else if (sreg == DWARF_REG_PC) {
 			struct map_symbol *ms = dloc->ms;
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 903027a6fb7d..48f3bf20070f 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -59,6 +59,10 @@ void pr_debug_type_name(Dwarf_Die *die, enum type_state_kind kind)
 		pr_info(" constant\n");
 		return;
 	case TSR_KIND_PERCPU_POINTER:
+		pr_info(" percpu pointer");
+		/* it also prints the type info */
+		break;
+	case TSR_KIND_POINTER:
 		pr_info(" pointer");
 		/* it also prints the type info */
 		break;
@@ -578,16 +582,25 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 	int tag;
 	Dwarf_Word size;
 
-	if (dwarf_aggregate_size(type_die, &size) < 0)
+	if (kind == TSR_KIND_POINTER) {
+		/* TODO: arch-dependent pointer size */
+		size = sizeof(void *);
+	}
+	else if (dwarf_aggregate_size(type_die, &size) < 0)
 		size = 0;
 
-	tag = dwarf_tag(type_die);
-
 	stack->type = *type_die;
 	stack->size = size;
 	stack->offset = offset;
 	stack->kind = kind;
 
+	if (kind == TSR_KIND_POINTER) {
+		stack->compound = false;
+		return;
+	}
+
+	tag = dwarf_tag(type_die);
+
 	switch (tag) {
 	case DW_TAG_structure_type:
 	case DW_TAG_union_type:
@@ -898,13 +911,25 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 
 			reg = &state->regs[var->reg];
 
-			/* For gp registers, skip the address registers for now */
-			if (var->is_reg_var_addr)
+			if (reg->ok && reg->kind == TSR_KIND_TYPE &&
+			   (!is_better_type(&reg->type, &mem_die) || var->is_reg_var_addr))
 				continue;
 
-			if (reg->ok && reg->kind == TSR_KIND_TYPE &&
-			    !is_better_type(&reg->type, &mem_die))
+			/* Handle address registers with TSR_KIND_POINTER */
+			if (var->is_reg_var_addr) {
+				if (reg->ok && reg->kind == TSR_KIND_POINTER &&
+				    !is_better_type(&reg->type, &mem_die))
+					continue;
+
+				reg->type = mem_die;
+				reg->kind = TSR_KIND_POINTER;
+				reg->ok = true;
+
+				pr_debug_dtp("var [%"PRIx64"] reg%d addr offset %x",
+					     insn_offset, var->reg, var->offset);
+				pr_debug_type_name(&mem_die, TSR_KIND_POINTER);
 				continue;
+			}
 
 			orig_type = reg->type;
 
@@ -1116,6 +1141,30 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		return PERF_TMR_OK;
 	}
 
+	if (state->regs[reg].kind == TSR_KIND_POINTER) {
+		struct strbuf sb;
+
+		strbuf_init(&sb, 32);
+		die_get_typename_from_type(&state->regs[reg].type, &sb);
+		pr_debug_dtp("(ptr->%s)", sb.buf);
+		strbuf_release(&sb);
+
+		/*
+		 * Register holds a pointer (address) to the target variable.
+		 * The type is the type of the variable it points to.
+		 */
+		*type_die = state->regs[reg].type;
+
+		dloc->type_offset = dloc->op->offset;
+
+		/* Get the size of the actual type */
+		if (dwarf_aggregate_size(type_die, &size) < 0 ||
+		    (unsigned)dloc->type_offset >= size)
+			return PERF_TMR_BAD_OFFSET;
+
+		return PERF_TMR_OK;
+	}
+
 	if (state->regs[reg].kind == TSR_KIND_PERCPU_POINTER) {
 		pr_debug_dtp("percpu ptr");
 
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index df52a0a1f496..026783442056 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -35,6 +35,7 @@ enum type_state_kind {
 	TSR_KIND_PERCPU_BASE,
 	TSR_KIND_CONST,
 	TSR_KIND_PERCPU_POINTER,
+	TSR_KIND_POINTER,
 	TSR_KIND_CANARY,
 };
 
-- 
2.51.0.788.g6d19910ace-goog

