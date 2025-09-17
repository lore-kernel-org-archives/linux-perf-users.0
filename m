Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A362BDC33
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139097; cv=none; b=kn/qcEvvEgA8ANxIl8hlaZdJJnuCFLwRWoXT8emx5yiSwdDRdjPKfe4IbSDR6ZPc9Cg7lg+VZn8Dm+rdhuzfqxSpCwKdHySl0PK86cP6KFqW0ZClMYxSzAXhxLb9BZyfNLlGWbH7E7k7diRDnI24Y/4A0+yzW+oDE1STYEZ+x04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139097; c=relaxed/simple;
	bh=MX7sOJp4Xx/fUFqamHkOj4G4hWS0EnfUo1xRNws8ENU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lBZbMBPgE8Ig9b807MVHUHKOEjfgt+T9aRhdErFcHbP7J+TvrjREUatnO3ggNivzLsGpMS4zdsqnQhjlOL6YNF6WmklJLrdykPhFaHAS93CvfdeSCXVBkCaZRdA1z5F28stiGUUmPihaOu5xMGPiOBgzKPj7ZHmHkM3G2BOX2os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnlX8i41; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnlX8i41"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-7246755a21cso2854427b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 12:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758139094; x=1758743894; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=My5bzXx//Isb0dBX4SeFW0j9qjRvOgbzlew9SX0sll4=;
        b=wnlX8i41AbqieTHUxNuxfQGP76IldAkd+xJ7pxxFGeTRocLVf98ZwvvQa0wxNQ4A+j
         cKDBe8PG/mwwqIlREk44N1kvPuUFPlqAHKuuiIgJJFcqJq4WJ3KjpabER90spT3Z4U7q
         7MjSfWIEXIt73nL5hDvw8bK5Mfirjo/e0YrBn8uW/tEG5yVdgkGnNW4Z+dkcbpazCgP2
         86HyCKzm1H2BtIbjPiVMBn2jRIm9pJ/jSyMIjbwGekPgJgRqR6Nj1jU89ApUghiBvUvc
         40Wj1xG3ufx36Eq/EmuMbZZvd1nCwxsKJHGh+VuORzh+/avPefWOHFXefubTx35fILcX
         +L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139094; x=1758743894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=My5bzXx//Isb0dBX4SeFW0j9qjRvOgbzlew9SX0sll4=;
        b=NXNUzlVcZlV7c/fcx/rXEi3jo8iGe+AV3cqHPBZ5OTuz7pckkx2wZLQfc+AwDPs3RR
         ulx/Oh9/SuzFEQGRS4T9S1hqKDHF4B/PKfXJ6CHLXqQcnPGQXyjvke2G/YeiqKyplRzv
         CqKmCe0qp8C5XkGyAekYNlL+kPPygD1H91+3WwXlI8N45Nv5owpGECYCgcIv6C0k/X7P
         93TPitjuZa/8dB0wtxbASQ6yeEgC8ATN5RXvp6Zusxxur5IFogT04YPrb0cbqACyq2qu
         Cw4itEGXawx8lIGrmRAjwpHRNsyZmh50Axt5pp9oyzmze1HTWlhhJPCTLoo5jNO3UxJV
         J1sw==
X-Forwarded-Encrypted: i=1; AJvYcCWNsPnCil9fZrwQKOZyvhdLR+OTdzOfE5G03uom7+c0/9oe8sPfvTUrLVyrF30+oj2GUJTnU1jfn+yIaks8S7lh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7dXQFUR1Ol1jZLg/EvhSUG97Vxcyz3lTXWaz8D+XyS0aIaLwj
	EAEkn+4PDkB4bGAbF5LPCejI3kv4m2UNJTcvDV6lzfGSHmIsXyzBgTzHy0JrNE+nj+KQcCBwQdC
	p+C191WcpOQ==
X-Google-Smtp-Source: AGHT+IEu8OOTMqVmRfcrDOmDApehT5zQz5PdkdfjeUVjAf7w8nw79NsZXs59+Egbs0u0fc51ew2ksOUpSzy1
X-Received: from ybbgo8.prod.google.com ([2002:a05:6902:4208:b0:e96:fc8a:7763])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:1884:b0:ea4:258:9ee3
 with SMTP id 3f1490d57ef6-ea5c03ebbc1mr3361333276.17.1758139094314; Wed, 17
 Sep 2025 12:58:14 -0700 (PDT)
Date: Wed, 17 Sep 2025 19:58:01 +0000
In-Reply-To: <20250917195808.2514277-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917195808.2514277-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917195808.2514277-4-zecheng@google.com>
Subject: [PATCH v3 03/10] perf annotate: Track address registers via TSR_KIND_POINTER
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

Introduce TSR_KIND_POINTER to improve the data type profiler's ability
to track pointer-based memory accesses and address register variables.

TSR_KIND_POINTER represents a register that holds the address of the
type in the `type_state_reg`. The semantics match the `breg` registers
that describe a memory location.

This change implements handling for this new kind in mov instructions
and in the check_matching_type() function. When a TSR_KIND_POINTER is
moved to the stack, the stack state size is set to the architecture's
pointer size.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/arch/x86/annotate/instructions.c | 19 +++++++-
 tools/perf/util/annotate-data.c             | 52 +++++++++++++++++++--
 tools/perf/util/annotate-data.h             |  1 +
 3 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index da98a4e3c52c..698cbb299c6d 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -391,7 +391,7 @@ static void update_insn_state_x86(struct type_state *state,
 		tsr->ok = true;
 
 		/* To copy back the variable type later (hopefully) */
-		if (tsr->kind == TSR_KIND_TYPE)
+		if (tsr->kind == TSR_KIND_TYPE || tsr->kind == TSR_KIND_POINTER)
 			tsr->copied_from = src->reg1;
 
 		pr_debug_dtp("mov [%x] reg%d -> reg%d",
@@ -418,6 +418,10 @@ static void update_insn_state_x86(struct type_state *state,
 			if (stack == NULL) {
 				tsr->ok = false;
 				return;
+			} else if (stack->kind == TSR_KIND_POINTER) {
+				tsr->type = stack->type;
+				tsr->kind = stack->kind;
+				tsr->ok = true;
 			} else if (!stack->compound) {
 				tsr->type = stack->type;
 				tsr->kind = stack->kind;
@@ -455,6 +459,19 @@ static void update_insn_state_x86(struct type_state *state,
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
index 903027a6fb7d..31b5896276f1 100644
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
@@ -578,7 +582,9 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 	int tag;
 	Dwarf_Word size;
 
-	if (dwarf_aggregate_size(type_die, &size) < 0)
+	if (kind == TSR_KIND_POINTER)
+		size = 8;
+	else if (dwarf_aggregate_size(type_die, &size) < 0)
 		size = 0;
 
 	tag = dwarf_tag(type_die);
@@ -898,13 +904,25 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 
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
 
@@ -1116,6 +1134,30 @@ static enum type_match_result check_matching_type(struct type_state *state,
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
index dd3807b55208..fd0d1084bc4e 100644
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
2.51.0.384.g4c02a37b29-goog

