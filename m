Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDBF3AE1BB
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790802062; cv=none; b=Bbb9wo72o8+deAIlG9JPQLjPil5RJanK5c9rJ/2ylzM8Z+eFkW2RP7gjeJoenGDZA3cX8GQyHYyyvluU6poxKXoeKoDzF4xnQ7zaYN8lUnxWWmn6w05cKMmV/bgqJMFGVUGbuFiVAZykCa6gMyVZ2lO5gEUvDXAruy2KQnGyqTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790802062; c=relaxed/simple;
	bh=C6on9fb4dRJ9OF5H+4jptyB19LUKgq66SGPjw8LrbBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2r7Hb6PXGURiko4yyAYJtlSiQAMCTKSZREMok2JYIicUZXsonpp4HxgxvT/p3eivSqMQ8UQnDokk1NUqggsBVFXn1YuiVpjIxDuuKQCBN3CFiC+kQX51WTDDr3DPXmminein4LYgPZ10dWzdI9WKeKp2kZjLCzMoak0RPwfiRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=JwTA/VXu; arc=none smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="JwTA/VXu"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-91788e38a27so21995896d6.3
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 14:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1790802057; x=1791406857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oRua+5qU9W340RitC/sDxdtHM7QXLh0bpym94OxAOC0=;
        b=JwTA/VXu8PBVpeMomfm2pbGJFINPPHR6+iCZ+YrX+KoEwRemsok6DrijV6GMsXJVil
         1C9fhCAzMXQcqKxHKFSFvBoUlT225eMBjVAL9oLI13W3DrmgK71XqRaT3RHHQaP0pqmm
         BSP0wCHOqI45IbPgQr5j/XG1VryVm7qyeLE5fmp33Na68ikFngBiB/77pkcekdlwfCwt
         TMzDkOrSlf8R7EAgZNK7XjB5gAnik93bB8/pwm1R46/esD575C6jBr4EFsNt6ao8M9PN
         4KzaedoQFtwSZzNg3e9S4dQVV+EgimHUL3C4iXAelcajvduHqQpxNMHSTjlLtxDDWpfw
         yDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790802057; x=1791406857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oRua+5qU9W340RitC/sDxdtHM7QXLh0bpym94OxAOC0=;
        b=WmRAfNUZatBjCfF+8aA1F9nJUeC7I/ozjw8u4Ar1XB3BvoW43BHIX894ZEtrReaEHg
         jWjn4t0jxjNUhnSmBLwASGPuokB0XMoIt+mGGIIdINcjqgz6vAmPExNTPtB/kkr76D6z
         +Kq40OahmtO4vQxE5cWOaUUGh3Bw+9r+A1PU7i8FsVeL2FwRLMtZSfJBAeaI6U+uT4MS
         t7IEbXmePxQ9pjsxppdd+Anm/2zgNssM4q+6fSoJ0e6WEHABztszsc6iT52Fn4LwmRIg
         cLUTbc118a+L8qLxvKyMmmi4co06y4zSsFnfVeBgqB9o0ne9bTSQnv3pwwxCe4Hq+sfr
         7YmQ==
X-Forwarded-Encrypted: i=1; AKwUvBxXaoyoV+3RkxDm/H6OLgsDxYB6zLa3TK4+QeZAXZhvI1vJQlBRtoq5NTc4n/4q5JTA1hRJjNJ5+bQRWyaK7/L3@vger.kernel.org
X-Gm-Message-State: AFuF++mk6lCOZAfIdV918v5ZQPLVYZ75R69pKoEStM8ZcltRheY2lOt8
	MAqnU3WJQuad/BP6GC8D/jwCfy18voDzNwLeFeo7TPxOCI1ZS+DuDpRsYegLpiUAEw==
X-Gm-Gg: AYBFou28XCmQmZtor2HFNGeIjKoN9a3nRA8VdLMILpVMk4QsOs2d03fwN48ZUK2N8HS
	JDpjo6Zlv9EP7UMSz6gcj7bB6o23c/wfwC5YDv7PBR3TsrhJG7xS/DOjXcHkcwyWt9Qe/c9YGut
	Z3WnpF03eKe6WouQeBsmhXvORnuTlKdKvPuWI+iwgFC6yXy2VS4PX9p6ybzf85CcWlOGlRhGRAr
	Ef+wxhli+9BlxhCFkUdINmtDO0v59gSh9bRrY/Iqw1An4mcSSD1s/kTkidmG71HZ5Up88StmdHD
	q/9RI9taud3ampAhWynQtybmTrRcWYepSeXuOCtjcxGJCQkon1PTmE8DlVAKUcCysyGfhpEv1tu
	jq/FJitwx6PEG3pVkMfuDBsBtnES+2i+85mMJoB2ofu5W8lq8cSvK6r2ufN+iqHiGfB5t/6DAVy
	wjq1H0sGFn8ksvBzUyoBBTscDgbOgDzY4aH4YtWg3+gB4ZluB3688WtS803eRa6DxQtVr3v7uoj
	W2OWFYEPiGCEGijWCsX+H/NC3qXkyNA0ETNrHNUh+K2CxVVMpe0Uz/JRCxDcQk4t20qMBvV5ose
	8w==
X-Received: by 2002:a05:6214:2262:b0:915:bd52:6dd6 with SMTP id 6a1803df08f44-917a09c991fmr45982566d6.4.1790802055795;
        Wed, 30 Sep 2026 14:00:55 -0700 (PDT)
Received: from flag-System-Product-Name.tail132f98.ts.net ([136.61.118.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917a8a579d8sm8580336d6.38.2026.09.30.14.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 14:00:55 -0700 (PDT)
From: Yanbo Zhao <yzhao62@ncsu.edu>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Zecheng Li <zli94@ncsu.edu>,
	Xu Liu <xliuprof@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yanbo Zhao <yzhao62@ncsu.edu>
Subject: [PATCH v2 3/3] perf annotate: Resolve C++ virtual function calls in x86 insn tracking
Date: Wed, 30 Sep 2026 17:00:38 -0400
Message-ID: <20260930210038.196928-4-yzhao62@ncsu.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930210038.196928-1-yzhao62@ncsu.edu>
References: <20260930210038.196928-1-yzhao62@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A C++ virtual function call is an indirect call through the vtable.
The instruction tracking of the data type profiling cannot resolve the
callee name for it, so the return type is lost and the type of the
register holding the returned value is unknown after the call.  It
matters when the returned value is used directly to access memory, like
in 'p->next()->val', where no DWARF variable describes the temporary.

The vtable pointer and the slot index are known statically from the
type of the object pointer, so the callee can be found by DWARF.  Track
the two steps of a virtual call in update_insn_state_x86():

1. Loading the vtable pointer from the object.  When a load from a
   register with a pointer type hits the '_vptr' member of the class
   (or one of its base classes), the destination register is marked as
   TSR_KIND_VTABLE_PTR with the class DIE returned by
   die_get_vptr_class().

2. Calling through the vtable.  GCC emits the call in two forms:

     mov    (%rbx),%rax          # vtable pointer
     call   *0x8(%rax)           # slot 1

   or, with speculative devirtualization when it can guess the target,
   the function pointer is loaded first and compared with the guess:

     mov    (%rbx),%rax          # vtable pointer
     mov    0x8(%rax),%rax       # function pointer at slot 1
     cmp    %r14,%rax
     je     <inlined copy>
     call   *%rax

   For the first form, the call handler resolves the slot from the
   offset of the target operand when the base register is a vtable
   pointer.  For the second form, the load from a vtable pointer
   register marks the destination as TSR_KIND_VFUNC_PTR holding the
   return type of the function at the slot, and the call handler uses
   it when the target operand is such a register.  In both cases the
   function DIE is found by die_find_virtual_func() and its return
   type is set to the return value register like a direct call.  Void
   functions have no return type and are simply ignored.

The resolution happens before the caller-saved registers are
invalidated since the register used for the call is one of them.

To let the call handler see the target operand, call__parse() saves
the operand of an indirect call (without the leading '*') to
ops->target.raw so that annotate_get_insn_location() can extract the
register and offset for both '*0x8(%rax)' and '*%rax'.

The new kinds are pointer-sized and not compound when saved to the
stack, and pr_debug_type_name() knows how to print them.

The slot index is calculated with the host pointer size like the
other places for now.  Only the primary vtable is handled: a virtual
call through a pointer to a non-primary base class subobject (multiple
inheritance) gets the class of that base from die_get_vptr_class() so
the slot index is looked up in the right vtable, but the receiver
adjustment (this pointer thunks) is not tracked.

For example, with the following code built with -O2 -g:

  struct Node {
      long val;
      Node *nxt;
      virtual Node *next() { return nxt; }
      ...
  };

  long run(Node *p, long n)
  {
      long s = 0;
      for (long i = 0; i < n; i++)
          s += p->next()->val;
      return s;
  }

'perf annotate --code-with-type' now shows the type for the access to
the returned pointer after the call which was unknown before:

  1251:  movq  (%rbp), %rax      # data-type: struct Node +0 (_vptr.Node)
  1255:  movq  (%rax), %rax
  1258:  cmpq  %r14, %rax
  125b:  je    0x1240
  125d:  movq  %rbp, %rdi
  1260:  addq  $1, %rbx
  1264:  callq *%rax
  1266:  addq  8(%rax), %r12     # data-type: struct Node +0x8 (val)

Signed-off-by: Yanbo Zhao <yzhao62@ncsu.edu>
---
Changes in v2:
- Remove the receiver ('this' pointer) register update after the call
  and the type_state::arg0_reg field.  The code was unreachable since
  the register is caller-saved and already invalidated, and it's not
  needed: the 'this' pointer lives in a callee-saved register or on
  the stack across the call and the DWARF location lists cover it
  (Sashiko, Namhyung).
- Handle 'call *%reg' in addition to 'call *N(%reg)'.  GCC emits it
  with speculative devirtualization: the function pointer is loaded
  from the vtable, compared with the guessed target and then called.
  The load is tracked as TSR_KIND_VFUNC_PTR holding the return type
  of the function at the slot (Sashiko).
- Strip the leading '*' of an indirect call operand in call__parse()
  when saving ops->target.raw, instead of in extract_reg_offset()
  which is not reached for '*%reg' (Sashiko).
- Ignore virtual functions returning void (no return type) instead of
  treating it as a failure (Namhyung).
- Keep the existing pointer dereference branch and its fall-through
  to the multi-register and per-cpu paths intact.  The vtable pointer
  is detected from the member type resolved there, so the common
  path only pays a tag check.
- Treat the new register kinds as pointer-sized and non-compound when
  saved to the stack.
- Drop the unnecessary include of dwarf-aux.h and hist.h.

 tools/perf/util/annotate-arch/annotate-x86.c | 76 +++++++++++++++++++-
 tools/perf/util/annotate-data.c              | 15 +++-
 tools/perf/util/annotate-data.h              |  4 ++
 tools/perf/util/disasm.c                     |  5 ++
 4 files changed, 96 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index 1acf31a2c759..d21192b74b6b 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -216,6 +216,29 @@ static void invalidate_reg_state(struct type_state_reg *reg)
 	reg->copied_from = -1;
 }
 
+/*
+ * Get the return type of the C++ virtual function at the @offset in the
+ * vtable of @class_die.  Returns false if it's not found or the function
+ * returns void.
+ */
+static bool vtable_get_rettype(Dwarf_Die *class_die, int offset,
+			       Dwarf_Die *type_die)
+{
+	Dwarf_Die func_die;
+	int index;
+
+	if (offset < 0)
+		return false;
+
+	/* TODO: arch-dependent pointer size */
+	index = offset / sizeof(void *);
+
+	if (die_find_virtual_func(class_die, index, &func_die) == NULL)
+		return false;
+
+	return die_get_real_type(&func_die, type_die) != NULL;
+}
+
 static void update_insn_state_x86(struct type_state *state,
 				  struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				  struct disasm_line *dl)
@@ -236,6 +259,7 @@ static void update_insn_state_x86(struct type_state *state,
 		struct symbol *func = dl->ops.target.sym;
 		const char *call_name;
 		u64 call_addr;
+		bool has_rettype = false;
 
 		/* Try to resolve the call target name */
 		if (func)
@@ -252,6 +276,26 @@ static void update_insn_state_x86(struct type_state *state,
 		else
 			pr_debug_dtp("call [%x] <unknown>\n", insn_offset);
 
+		/*
+		 * Resolve the return type of a C++ virtual function call
+		 * before invalidating the caller-saved register used for the
+		 * indirect call.  It's either through the vtable pointer
+		 * directly like 'call *0x8(%rax)' or through the function
+		 * pointer loaded from the vtable like 'call *%rax'.
+		 */
+		if (has_reg_type(state, dst->reg1) && state->regs[dst->reg1].ok) {
+			tsr = &state->regs[dst->reg1];
+
+			if (dst->mem_ref && !dst->multi_regs &&
+			    tsr->kind == TSR_KIND_VTABLE_PTR &&
+			    vtable_get_rettype(&tsr->type, dst->offset, &type_die)) {
+				has_rettype = true;
+			} else if (!dst->mem_ref && tsr->kind == TSR_KIND_VFUNC_PTR) {
+				type_die = tsr->type;
+				has_rettype = true;
+			}
+		}
+
 		/* Invalidate caller-saved registers after call */
 		call_addr = map__rip_2objdump(dloc->ms->map,
 					      dloc->ms->sym->start + dl->al.offset);
@@ -267,7 +311,10 @@ static void update_insn_state_x86(struct type_state *state,
 		}
 
 		/* Update register with the return type (if any) */
-		if (call_name && die_find_func_rettype(cu_die, call_name, &type_die)) {
+		if (call_name && die_find_func_rettype(cu_die, call_name, &type_die))
+			has_rettype = true;
+
+		if (has_rettype) {
 			tsr = &state->regs[state->ret_reg];
 			tsr->type = type_die;
 			tsr->kind = TSR_KIND_TYPE;
@@ -622,13 +669,38 @@ static void update_insn_state_x86(struct type_state *state,
 			}
 			pr_debug_type_name(&tsr->type, tsr->kind);
 		}
+		/* Load a function pointer from the vtable (for 'call *%reg') */
+		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
+			 state->regs[sreg].kind == TSR_KIND_VTABLE_PTR &&
+			 vtable_get_rettype(&state->regs[sreg].type, src->offset,
+					    &type_die)) {
+			tsr->type = type_die;
+			tsr->kind = TSR_KIND_VFUNC_PTR;
+			tsr->offset = 0;
+			tsr->ok = true;
+
+			pr_debug_dtp("mov [%x] %#x(reg%d) -> reg%d",
+				     insn_offset, src->offset, sreg, dst->reg1);
+			pr_debug_type_name(&tsr->type, tsr->kind);
+		}
 		/* And then dereference the pointer if it has one */
 		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
 			 state->regs[sreg].kind == TSR_KIND_TYPE &&
 			 die_deref_ptr_type(&state->regs[sreg].type,
 					    src->offset + state->regs[sreg].offset, &type_die)) {
+			/*
+			 * The vtable pointer of a C++ object needs the class
+			 * to resolve virtual calls through it.
+			 */
+			if (die_is_vtbl_ptr_type(&type_die) &&
+			    die_deref_vptr_class(&state->regs[sreg].type,
+						 src->offset + state->regs[sreg].offset,
+						 &type_die))
+				tsr->kind = TSR_KIND_VTABLE_PTR;
+			else
+				tsr->kind = TSR_KIND_TYPE;
+
 			tsr->type = type_die;
-			tsr->kind = TSR_KIND_TYPE;
 			tsr->offset = 0;
 			tsr->ok = true;
 
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 8a9d3f2eec4d..e9bf76cc2863 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -67,6 +67,14 @@ void pr_debug_type_name(Dwarf_Die *die, enum type_state_kind kind)
 		pr_info(" pointer");
 		/* it also prints the type info */
 		break;
+	case TSR_KIND_VTABLE_PTR:
+		pr_info(" vtable pointer");
+		/* it also prints the type info */
+		break;
+	case TSR_KIND_VFUNC_PTR:
+		pr_info(" virtual function pointer returning");
+		/* it also prints the type info */
+		break;
 	case TSR_KIND_CANARY:
 		pr_info(" stack canary\n");
 		return;
@@ -715,8 +723,11 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 			    Dwarf_Die *type_die, int ptr_offset)
 {
 	Dwarf_Word size;
+	bool is_pointer = (kind == TSR_KIND_POINTER ||
+			   kind == TSR_KIND_VTABLE_PTR ||
+			   kind == TSR_KIND_VFUNC_PTR);
 
-	if (kind == TSR_KIND_POINTER) {
+	if (is_pointer) {
 		/* TODO: arch-dependent pointer size */
 		size = sizeof(void *);
 	}
@@ -729,7 +740,7 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 	stack->ptr_offset = ptr_offset;
 	stack->kind = kind;
 
-	if (kind == TSR_KIND_POINTER) {
+	if (is_pointer) {
 		stack->compound = false;
 		return;
 	}
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index bbf4fd35c1d7..14dab1beae2c 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -36,6 +36,10 @@ enum type_state_kind {
 	TSR_KIND_CONST,
 	TSR_KIND_PERCPU_POINTER,
 	TSR_KIND_POINTER,
+	/* C++ vtable pointer of the class in 'type' */
+	TSR_KIND_VTABLE_PTR,
+	/* C++ virtual function pointer with the return type in 'type' */
+	TSR_KIND_VFUNC_PTR,
 	TSR_KIND_CANARY,
 };
 
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 5478c134e7e3..5d96ee4c866b 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -300,6 +300,11 @@ static int call__parse(const struct arch *arch, struct ins_operands *ops, struct
 	if (tok != NULL) {
 		endptr++;
 
+		/* Save the operand (without '*') to extract register and offset */
+		ops->target.raw = strdup(tok + 1);
+		if (ops->target.raw == NULL)
+			return -1;
+
 		/* Indirect call can use a non-rip register and offset: callq  *0x8(%rbx).
 		 * Do not parse such instruction.  */
 		if (strstr(endptr, "(%r") == NULL)
-- 
2.53.0

