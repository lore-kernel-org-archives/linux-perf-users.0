Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902816;
	b=ELIAiQy/ansuUZgKi4rPedQ6LI5aESTaSB8/q4L1H8uh8WmYpaSkcWW0725Rn4XLeRYf
	 PvxBhAm95oGHXnW94JxOVgBkoBR+NV518box6/08c88UaCwF40BpzZ9rwfPa/bXmhqkEu
	 UkTI0/p+VP5TRCiUCwqDK9Ctd6nl5dPxkD5aOQRP9lf3OTlL1rqYMuWoYj2K/AOObfHwf
	 rWY5ciGGOvT/+B0nxZEiiYYxS/GY2l38qk9FlRqoAfg7S/mEzJ48B+t1otUNNK7u//lwq
	 H5hhmW6CwSBTCxrtliLN8Y1jecMdcYpOOzqdA0TMMdnAtt+B/WCUr2kV5Mz/4i7urYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VlTcY/jeMah1dUcG7MHGVMVxxZ3/rar+3iI4qnWLjrI=;
	b=QrU86IvboouVMkIgWkYz0ZN6N8xWE07tS9O3jt+gicRby90IxXVmBwKjgHvXuxHurxiw
	 cyp8sW/qAoRMJi2dEh9ADN9i1+8819i379wv+rU93eHdkwy0BTBqq/YqNri2uM/4wQfyW
	 zqkE29tw6XdkwOoqAluJzPaL1gqTR/Icht+p8Swc80eX/kFMRw9WqfYySfVByTycu8z9I
	 F2YHdm9/fxOueivV57fzhHBna1cTcGDho+GXYUIgRgS3psBnPTKMfOjhMEUQLBBLvcbPE
	 r0z9pPOveNheAeRjN+O1Luq5ufOt3ep3W5qXZt1U7+o6GdCx7NLtUCPpXSeKERGTgug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ncsu.edu;
	spf=pass smtp.mailfrom=ncsu.edu;
	dkim=pass header.d=ncsu.edu header.i=@ncsu.edu header.a=rsa-sha256 header.s=google header.b="H9pnZZ/U";
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C273606A32E
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 18:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C273606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ncsu.edu header.i=@ncsu.edu header.a=rsa-sha256 header.s=google header.b=H9pnZZ/U
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b31ca7e0bcso22248707b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 10:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1793902809; x=1794507609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VlTcY/jeMah1dUcG7MHGVMVxxZ3/rar+3iI4qnWLjrI=;
        b=H9pnZZ/UwC0Cg9HOtXwiHaL/V/ZQd6dQHmBxK0f0VXobTAgvjvGIgoeEz8LI6b6UPI
         J81iCGpuEGOSeq6QjbDswgUaILZ4c4qAZFiYHMv4YiPTM/s3nxLV5HJpyy6XBIc7Rxkk
         Na1JiBXalRE9V2qDbD6wrTB6j//EAP9LNHQfiBikU+XLEN19h0wGZKaByNIBKs+OpK0N
         u3Cc/fp0daiQDv8+m/wZi/DG0gsAajMtPcM4XpFwkJjPdd6WlI3YTDx+Osu10O5dI+If
         VOMmGkSQ7U8l3ItPQpFVhq521xmZIwPxyDzuCHiXna4G61iB8INBILizKhOCoMAUXT6Z
         RIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793902809; x=1794507609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VlTcY/jeMah1dUcG7MHGVMVxxZ3/rar+3iI4qnWLjrI=;
        b=gG1DoIcw1PMBn0AFwwDQ6KaQ9mCMtCvYdWBDHSJjWOw2og+BgD6GLy0r/gyjxOkPNy
         fowlkZBfTuaNUMDXgVgG8peZRI9BFEzP+br8UWZwHWcjhwSRtxj+H1Rnco4wxtummYiv
         heUyi9BoxzYL+AbVBTgFkl/GjMGSdAgZ+p8HAV2/f0x9bMdGT7yrkKtJKY5xU92zXnH2
         hFa7yCXyH6Wt9hqJso0MrI9+p7ywE67tLQUqidKf6B/PCloR8g8iF8odm3JY3qJw2sat
         YgmuYzK5Pvnui/hmezYHrXyBEONIDg7+vhlaLhnjOu7USXrYdxJYwBBgdCbVPgZ2AOUq
         gHgg==
X-Forwarded-Encrypted: i=1; AL+hErHfIPHgJk5tkgbZhZ2KI26ItH8htynov2i3ub8SfwL136r3ZnxD0OfOYcXGbscgBVgnEA6PaT3k5sivpfiPADep@vger.kernel.org
X-Gm-Message-State: APuU4Z/3NmqMyiksawuFq4fefqw09ym981hnpRR62pIUU72FZxzCCH3C
	rMj1SOAx+effV6PCtR0I6E+e+F3Lq5I0pZMTMafKeN2qB58ioCHjasr8jHQqlXGd7w==
X-Gm-Gg: AYBFou2PQGTJpn7QyXCdp3paRhrgG9Lq3RG9pRGv4tRa1Ezb9m3zIOPwDhegxHgBY9e
	eQH7zYtnkof8j2Hw5VGJCaFDIbp9MUiFPk/gCSc0drBBnB2f5SWcBRRg8evJW9u/VEJqGgP21JP
	BkveZUfK6jbxbXrosm9ImDmdOm5dI5xAXQTSQ4UxyhF0ae28yFY6n701Hk49HNe8BjEtGEjRZV9
	6t49RI3OfHH/eUct7J/ZulKxuxEoiAahdnnQ5UtZTfCD66VXPb7tJ7vqM9W+dqilA7O4zns28Aq
	PsKz7g/+IySD5dlNI9nzk+FZmxQL+WpJk1WZJj1akyVSV+aJaBlCLgPc32NZM1KD4K81JVG4no7
	t7Wcn+0cBhgJApA629gSlwhDsB1ptBjvzPAQ4GQFx944NZfPKiHv3NnsiXxabgGLBKo38Zcrpfd
	cZwA5hvuYzSNhQtxPlpEBsNRgDAl2Lnpr8VGvW7LH/D/XQR5Jm2/hdMozdzNoiel+z6us7VWp3S
	rMAlDAnRxsON/twygoyN/nn8wDE13jHjMG1Gn2025W5/o4LgegSjT+2MptRScrY1OvLSXL2pfG9
	Ef0IAWNfzbv3XbQ0XrxDwCzSEqbP1pFgvJKXf05J353kHGHlvRAUVJJGsHQdF3GPc3Cnu18G2bn
	Dk4cEk64J6rLCO8K8Jjry
X-Received: by 2002:a05:690c:e090:b0:8b3:3caf:11a with SMTP id 00721157ae682-8b33caf0195mr3902717b3.4.1793902809206;
        Thu, 05 Nov 2026 10:20:09 -0800 (PST)
Received: from flag-System-Product-Name.tail132f98.ts.net ([136.61.118.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f5f2d5dsm1492287b3.2.2026.11.05.10.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:20:07 -0800 (PST)
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
Subject: [PATCH v5 3/3] perf annotate: Resolve C++ virtual function calls in x86 insn tracking
Date: Thu,  5 Nov 2026 13:19:49 -0500
Message-ID: <20261105181949.43198-4-yzhao62@ncsu.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105181949.43198-1-yzhao62@ncsu.edu>
References: <20261105181949.43198-1-yzhao62@ncsu.edu>
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
Changes in v5:
- No change.

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
index 6597de34dd6e..dd9c1d7b2da8 100644
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

