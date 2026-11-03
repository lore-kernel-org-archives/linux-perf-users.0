Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721463;
	b=EAl3ahlu3qMh6UnJzN3unDn6dqY/sfGWjcLW3NIDqfrH3ELH4jxIPG2fBxOm/G7sIhoN
	 f1NsFcmzrURlTLxzrwsCOmT+URN/yISLkSlW+T+6p5MYOX7/DlyZYjMzd9OIpCjapFGRb
	 uMVsm7y3pG3lWqQ5Pm4Pp7zYUEgkOk85YCfpYayhx2+KbQElh2yq+NyA0xQk/+LfvByls
	 P4rloXa0RUQo/IdQZyfaHBAlssFqCkhn3+b+IQwaYwkeDvtinqy1ll5Pu7XtRfVr3bEOw
	 Qd8gWND5nfZrsX25cFpcOz3O4Zd7/UgmIOYu0zFDamUqz04JCQlkoDGvXFNDH4/4tCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uQcKwX3BnP45/pu0JqkDovrGfy/j7hh8EiRyeDKnHpI=;
	b=rjjFCSmR08TqINQtVI8C9IYmM52RX/HYRX5g1zcPGcvvC6Y/CpNyyaB7wbrmmCE3HeLv
	 K+DpOQQTLWrQVatRAmsuumyN6Lc12ix6tUdBGg5tm4A7jp+H3PKkOnAFHdnbE4K5Hu1Tq
	 Vz1TUFIOtcyQLiyBeIzOH7oFyJrZDNreh5oR/skWXnM7CKMUjayTbIGiZrCznir6uo4Zb
	 +/+LVP3FSJUPL9x3Lh3JuNORbmSddSOIyVJEMXat7uLA3FuRkStqOyLkbxAv7f1AJgfUq
	 0YgdkBFUBrZFQ+VfPPRh01Y5+Z2dShtYwlRrh/OEBn4ykCwIdUucbWAnQpzNHJ97rsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ncsu.edu;
	spf=pass smtp.mailfrom=ncsu.edu;
	dkim=pass header.d=ncsu.edu header.i=@ncsu.edu header.a=rsa-sha256 header.s=google header.b="Fr/9PQI0";
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73F60A3808
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 15:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A73F60A3808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ncsu.edu header.i=@ncsu.edu header.a=rsa-sha256 header.s=google header.b=Fr/9PQI0
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93e6eb77f0bso419708985a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 07:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1793721461; x=1794326261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uQcKwX3BnP45/pu0JqkDovrGfy/j7hh8EiRyeDKnHpI=;
        b=Fr/9PQI0ygsrMR+id/dmyWfNkNJVEUldKbZZaxlKTXe8GpCxCzmZVdHeYWB0k1KH6+
         iKFRxWjRJrD3UGkCz+mYrsPePgTCstOY1NM/VGhL1wx3Xca9mDN64y9xuawHNebFtc4q
         B2KV4EfYWk7bJEZIiZY04Vo3Icam8VOH8sFomaZq7EFCHimF/GZRVjCcIAAZJPZxuYLk
         saUpOcoWxKtP5gUAETZzUmm83aq/PpsXl0R/g7GtXcZdumV4bMOM+HoqRc5UXUqni8m+
         R4VyRCJN8jVX4nMP5MrsCnMsTuGB0/yulvrrhrn2T5IXElLa/tkqVSl12u3SzR4TtlWc
         VS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793721461; x=1794326261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uQcKwX3BnP45/pu0JqkDovrGfy/j7hh8EiRyeDKnHpI=;
        b=n1/gGw9xo0Z/9VlTmkReeioNheuGjlMea6FrrddvQetT2PJNGdTwSSDGpaskwcwC1F
         v4w+DDuB39X6Z+zETyJIas0qpZw9Ga+hAfnQUftL4asirJjpEMRK/hFMrQTTSSIkG10I
         unml1RMSi2pOFg0c6dTpckefL800kNmKrR/+OtOwdr4RTJHWmxsMJaDmQjjiH4jMroTU
         23VdzF9km0s+hG8zjkYBz9Yy8qxj7/cc5C5V9BhFS9xguhlojkFjnPtU2x4QDxqDHmFP
         xAK7Uq8YutSD+DUSpO1IKvo9VMFSjDkx2+ZJSWN5KLg0+pGTuyCrCZez/L9/pVsly3P7
         NHHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxSWW2WkgG18oKqoQ5/5SoFATc5FASrKvMAP6P+zxVxi47DodsV0E2YjL5CPG+MXIC0L2CVgT0la6ji4jJPiqUX@vger.kernel.org
X-Gm-Message-State: APuU4Z8JYmWdxHSKGaZhA8WpDBxNxKNECPcwMlGb1LgXoxNpTI8YDlSy
	r3ZUUUiDKT9yeqGEcWUTyyCp5HZDkcwg4O+LHDAp3tecLrhaOdQAYcww5rh/eWDoig==
X-Gm-Gg: AYBFou1J7i++8UrbElWVxnCbi/KL87i8sUDgJnRHRcmvGoZN3wjeIJhbd6s8yC6EHfP
	qJOADFao45veYHAIqzI41Fh9BcWk2TBhdi8CcGpcrTjiIxadhCfeOQIQWBPGO4EvVyfqbJctEsY
	PBCDPzI6YKHxpMgCVnzSe9B3uBimqsHDhKxdk24haX9ONvXoTujdFVmH9yJIL52zugJidsB7YzO
	nvQshuT36ZQwizNVnUOGd2HyJnjfv+04YzNhAO8lkMxEF6PJtTgo/RcGj5jVSzKgafHHnCHWZRb
	EILA6A7/Ems+iF5RzV5owou98NSFMEiGkvzxcjH602TbAaPuKL5pu2Ko2koN9vih9bksxI7HIcP
	/HIoLIc/rsDNGX2cJBgR+MQVM4by8xuPMI9t0TFB2yeUrOC0Jz0aXZhgQFECe2VMBpstt/ZbaVa
	HqDRelQ1m4OtcALPlE4AsNzN75xWIADVZXmw8M/xZaYb+4x1jPSAaVtBLgVdGfkxsvk7ycLFW2J
	Q1t6EmaEr/BZDi2D8w0gGX0pgQnRD5LAjS+udCcGfVJXXXljS0TOupuxRnP0I6XvDVRl2UHp8AF
	hlEXpJu99itpXSGpHbQepNKh6dUMEfUwGx1ZpuYo9puV/zRRfx9uEfdne2OQuH1dp3a5fk/wwfB
	D0MILD3jm2BuuL5kNPU82QQ==
X-Received: by 2002:a05:620a:4409:b0:93e:f97f:f245 with SMTP id af79cd13be357-9442173e65fmr2148312785a.30.1793721461229;
        Tue, 03 Nov 2026 07:57:41 -0800 (PST)
Received: from flag-System-Product-Name.tail132f98.ts.net ([136.61.118.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425a7195esm1113191985a.27.2026.11.03.07.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:57:40 -0800 (PST)
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
Subject: [PATCH v4 3/3] perf annotate: Resolve C++ virtual function calls in x86 insn tracking
Date: Tue,  3 Nov 2026 10:56:50 -0500
Message-ID: <20261103155650.269973-4-yzhao62@ncsu.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103155650.269973-1-yzhao62@ncsu.edu>
References: <20261103155650.269973-1-yzhao62@ncsu.edu>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
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

A load or a call with an index register (multi_regs) is not handled as
the offset alone doesn't tell the member or the vtable slot.  It's what
a call through a pointer to member function looks like.

To let the call handler see the target operand, call__parse() saves
the operand of an indirect call (without the leading '*') to
ops->target.raw so that annotate_get_insn_location() can extract the
register and offset for both '*0x8(%rax)' and '*%rax'.  It also sets
ops->target.multi_regs so that a call with an index register like
'*0x8(%rax,%rcx,8)' can be told apart.

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
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
---
Changes in v4:
- Rebase onto the current perf-tools-next: use the common
  invalidate_reg_state() helper and keep the TSR_KIND_CONST and
  TSR_KIND_GLOBAL_ADDR handling in set_stack_state() alongside the new
  pointer kinds.  No functional change.  Add Reviewed-by from Namhyung.

Changes in v3:
- Check !src->multi_regs when loading a function pointer from the
  vtable, since the offset doesn't tell the slot with an index
  register (Sashiko, Namhyung).  Do the same when marking a register
  as the vtable pointer.
- Set ops->target.multi_regs in call__parse() for an indirect call.
  It was never set for calls, so the !dst->multi_regs check in the
  call handler had no effect and 'call *0x8(%rax,%rcx,8)' was resolved
  as the slot 1 by the displacement.

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
 tools/perf/util/annotate-arch/annotate-x86.c | 77 +++++++++++++++++++-
 tools/perf/util/annotate-data.c              | 15 +++-
 tools/perf/util/annotate-data.h              |  4 +
 tools/perf/util/disasm.c                     |  7 ++
 4 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index 3a6ea7e978e0..e38a4e7a54d5 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -207,6 +207,29 @@ static int x86__cpuid_parse(struct arch *arch, const char *cpuid)
 }
 
 #ifdef HAVE_LIBDW_SUPPORT
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
@@ -227,6 +250,7 @@ static void update_insn_state_x86(struct type_state *state,
 		struct symbol *func = dl->ops.target.sym;
 		const char *call_name;
 		u64 call_addr;
+		bool has_rettype = false;
 
 		/* Try to resolve the call target name */
 		if (func)
@@ -243,6 +267,26 @@ static void update_insn_state_x86(struct type_state *state,
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
@@ -258,7 +302,10 @@ static void update_insn_state_x86(struct type_state *state,
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
@@ -615,13 +662,39 @@ static void update_insn_state_x86(struct type_state *state,
 			}
 			pr_debug_type_name(&tsr->type, tsr->kind);
 		}
+		/* Load a function pointer from the vtable (for 'call *%reg') */
+		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
+			 state->regs[sreg].kind == TSR_KIND_VTABLE_PTR &&
+			 !src->multi_regs &&
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
+			if (!src->multi_regs && die_is_vtbl_ptr_type(&type_die) &&
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
index 6814b521b607..67d3310a8b49 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -68,6 +68,14 @@ void pr_debug_type_name(Dwarf_Die *die, enum type_state_kind kind)
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
@@ -730,8 +738,11 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 			    Dwarf_Die *type_die, int ptr_offset, u64 imm_value)
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
@@ -745,7 +756,7 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 	stack->kind = kind;
 	stack->imm_value = imm_value;
 
-	if (kind == TSR_KIND_POINTER || kind == TSR_KIND_CONST ||
+	if (is_pointer || kind == TSR_KIND_CONST ||
 	    kind == TSR_KIND_GLOBAL_ADDR) {
 		stack->compound = false;
 		return;
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index eee1f8dae3dc..184262c73562 100644
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
 	TSR_KIND_GLOBAL_ADDR,
 };
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 7c289b67b5bd..ca478191813c 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -53,6 +53,7 @@ const struct ins_ops arithmetic_ops;
 static void ins__sort(struct arch *arch);
 static int disasm_line__parse(char *line, const char **namep, char **rawp);
 static int disasm_line__parse_powerpc(struct disasm_line *dl, struct annotate_args *args);
+static bool check_multi_regs(const struct arch *arch, const char *op);
 
 static __attribute__((constructor)) void symbol__init_regexpr(void)
 {
@@ -300,6 +301,12 @@ static int call__parse(const struct arch *arch, struct ins_operands *ops, struct
 	if (tok != NULL) {
 		endptr++;
 
+		/* Save the operand (without '*') to extract register and offset */
+		ops->target.raw = strdup(tok + 1);
+		if (ops->target.raw == NULL)
+			return -1;
+		ops->target.multi_regs = check_multi_regs(arch, ops->target.raw);
+
 		/* Indirect call can use a non-rip register and offset: callq  *0x8(%rbx).
 		 * Do not parse such instruction.  */
 		if (strstr(endptr, "(%r") == NULL)
-- 
2.53.0

