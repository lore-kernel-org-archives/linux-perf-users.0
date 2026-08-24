Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C38E377ECF;
	Mon, 24 Aug 2026 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787605743; cv=none; b=C/MTtUJmYhKtuxyjPYdQ0fiZO2qVRDpH7I2+Uk8mguVoDjczhJ7KqJ0/rFTmuCVIawTe2CcluFXyKx8oQspz+AGUpFVIuNf9C9J1yvdt4Pivpna4evirvfJKKMjrtF4t7aNomW+ne+cauGjejwMOS3HBY5EmpnaVPjVEGhuj0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787605743; c=relaxed/simple;
	bh=4Z6T+8p971c8y+Ev+9deWmXjqhbOGuj3ql8TnE4soE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+5llWrx/CpZSj8IUGW2DQDUdVZITCoDv+GVz3IH9+tiYeNkUck63BMgcMliatW5pvpR8URy3SfOqnhCzrbug5mZbkvjvsVfK5nd56gz4lCzLgs2wlOEpiL9Q1gaZpoKkHvEc/MKzzT9k79mOGBl1J9BuHtA/SDfDG/yN7sNHHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9TAreku; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9TAreku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42FD1F000E9;
	Mon, 24 Aug 2026 21:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787605741;
	bh=bOHWU6sBOqBbLUjH8SrdI4yuNGuHJ4r63BVwQcxCdKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l9TAreku8Znf1qHanmTIQBQyVamtTi3a1UGJwIaAb00NKQOeK3P5Gf2rKtRYwgw04
	 Saf1Ea9cJl6F4UqF99o+twSBdl/Cpx1Q4CLuKBgfc6UIKRoJgqWx9rOhOrdf31Rji2
	 o/LIi53oB3d/lkGwzEqPUokJCE5DU5Iwy6vWdGhoXVOxJbmgEBxKFADx/xM7gDcbeV
	 K6mN6gwPqgeF57d2NqBq9lZ/kf7OpyQ3SWPhLIGsGpoPrQJuLGZpX6/4eX7menFsyE
	 qYm26pDNSwGb2vPCpPuD7K3o75if/hXMgfsrR5YuJXpH8roQ2TtV8oLZUDruPetcbO
	 wfYOAxDvESwnA==
Date: Mon, 24 Aug 2026 14:09:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Yanbo Zhao <yzhao62@ncsu.edu>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/3] perf disasm & annotate x86: Track C++ vptr and
 resolve virtual function calls
Message-ID: <aoyy7FrJsdtnscUi@google.com>
References: <20260821050207.4517-1-yzhao62@ncsu.edu>
 <20260821050207.4517-4-yzhao62@ncsu.edu>
 <20260821052652.883241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821052652.883241F000E9@smtp.kernel.org>

On Fri, Aug 21, 2026 at 05:26:52AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] Dead code and conceptually flawed receiver type tracking for C++ virtual calls
> - [Medium] Indirect calls through registers (e.g., `*%rax`) bypass operand extraction logic
> - [Medium] Virtual functions returning `void` silently abort receiver tracking
> --
> 
> --- Patch [3]: [PATCH 3/3] perf disasm & annotate x86: Track C++ vptr and resolve virtual function calls ---
> commit 5fa55e70aac42c5267a1e3215b8634a1d2a5ae9b
> Author: Yanbo Zhao <yzhao62@ncsu.edu>
> 
> perf disasm & annotate x86: Track C++ vptr and resolve virtual function calls
> 
> This commit implements disassembler and type profiling support in perf for
> C++ virtual dispatch and indirect call resolution on x86. It introduces
> tracking for vtable pointers, resolves virtual function calls via DWARF
> information, and updates register states for the receiver pointer upon
> virtual call resolution.
> 
> > diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
> > --- a/tools/perf/util/annotate-arch/annotate-x86.c
> > +++ b/tools/perf/util/annotate-arch/annotate-x86.c
> 
> [ ... ]
> 
> > @@ -234,6 +236,11 @@ static void update_insn_state_x86(struct type_state *state,
> >  		struct symbol *func = dl->ops.target.sym;
> >  		const char *call_name;
> >  		u64 call_addr;
> > +		Dwarf_Die target_func_die;
> > +		bool resolved_statically = false;
> > +		Dwarf_Die class_die;
> > +		bool has_class_die = false;
> > +		struct annotated_op_loc *target_op;
> >  
> >  		/* Try to resolve the call target name */
> >  		if (func)
> > @@ -245,12 +252,42 @@ static void update_insn_state_x86(struct type_state *state,
> >  		if (call_name && !strcmp(call_name, "__fentry__"))
> >  			return;
> >  
> > +		/*
> > +		 * 1. Resolve target statically (virtual call fallback) FIRST
> > +		 * (before invalidation)
> > +		 */
> > +		target_op = &loc.ops[INSN_OP_TARGET];
> > +
> > +		if (target_op->mem_ref && has_reg_type(state, target_op->reg1)) {
> > +			struct type_state_reg *reg = &state->regs[target_op->reg1];
> > +
> > +			if (reg->ok && reg->kind == TSR_KIND_VTABLE_PTR) {
> > +				/* TODO: handle multiple inheritance (non-primary vtables) */
> > +				int vtable_index = target_op->offset / 8;
> > +				Dwarf_Die target_class_die = reg->type;
> > +
> > +				if (die_find_virtual_func(&target_class_die, vtable_index,
> > +							  &target_func_die) &&
> > +				    die_get_type(&target_func_die, &type_die)) {
> 
> [Severity: Medium]
> Will die_get_type() return NULL for virtual functions returning void since
> they lack a DW_AT_type attribute?
> 
> If it returns NULL, it seems this would leave resolved_statically as false and
> completely bypass the subsequent block that tracks the receiver's C++ class
> type.

If the return type is void, no type info will be returned so we can
simply ignore the result.

> 
> > +					resolved_statically = true;
> > +					class_die = target_class_die;
> > +					has_class_die = true;
> > +				}
> > +			}
> > +		}
> 
> [ ... ]
> 
> > -		/* Invalidate caller-saved registers after call */
> > +		/* 2. Invalidate caller-saved registers after we read them for resolution */
> >  		call_addr = map__rip_2objdump(dloc->ms->map,
> >  					      dloc->ms->sym->start + dl->al.offset);
> >  		for (unsigned i = 0; i < ARRAY_SIZE(state->regs); i++) {
> > @@ -264,8 +301,8 @@ static void update_insn_state_x86(struct type_state *state,
> >  			invalidate_reg_state(reg);
> >  		}
> 
> [ ... ]
> 
> > @@ -275,6 +312,20 @@ static void update_insn_state_x86(struct type_state *state,
> >  			pr_debug_dtp("call [%x] return -> reg%d",
> >  				     insn_offset, state->ret_reg);
> >  			pr_debug_type_name(&type_die, tsr->kind);
> > +
> > +			/* Update receiver ('this' pointer) register if C++ */
> > +			if (has_class_die && cu_is_cplusplus(cu_die)) {
> > +				struct type_state_reg *recv_tsr = &state->regs[state->arg0_reg];
> > +
> > +				if (recv_tsr->ok &&
> > +				    (recv_tsr->kind == TSR_KIND_TYPE ||
> > +				     recv_tsr->kind == TSR_KIND_POINTER)) {
> 
> [Severity: Medium]
> Is it possible for recv_tsr->ok to be true here?
> 
> Since arg0_reg (%rdi) is a caller-saved register, the loop right before this
> block unconditionally invalidates all caller-saved registers, setting reg->ok
> to false. This appears to make the condition structurally impossible to meet.

Looks like so.

> 
> Additionally, does it make sense to update the receiver type of a caller-saved
> register after the call? Since the callee could have clobbered it per the ABI,
> wouldn't the tool end up tracking a garbage value instead of the 'this'
> pointer?

I'm curious why do you want to keep the 'this' pointer after calls.
Maybe there's another way to get the type of the containing class, no?

Thanks,
Namhyung

> 
> > +					recv_tsr->type = class_die;
> > +					pr_debug_dtp("call [%x] update receiver reg%d to C++ class",
> > +						     insn_offset, state->arg0_reg);
> > +					pr_debug_type_name(&class_die, recv_tsr->kind);
> > +				}
> > +			}
> >  		}
> >  		return;
> >  	}
> 
> [ ... ]
> 
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -2486,6 +2486,10 @@ static int extract_reg_offset(const struct arch *arch, const char *str,
> >  	if (arch->objdump.register_char == 0)
> >  		return -1;
> >  
> > +	/* Skip leading '*' for indirect call/jmp operands (e.g. *%rax) */
> > +	if (*str == '*')
> > +		str++;
> > +
> 
> [Severity: Medium]
> Is this logic reachable for direct register indirect calls like *%rax?
> 
> Looking at annotate_get_insn_location() where this gets called:
> 
> 	} else if (strchr(insn_str, arch->objdump.memory_ref_char)) {
> 		op_loc->mem_ref = true;
> 		op_loc->multi_regs = multi_regs;
> 		extract_reg_offset(arch, insn_str, op_loc);
> 	} else {
> 
> Since *%rax lacks a memory reference character (like '('), it seems it
> would bypass extract_reg_offset() entirely and fall into the else block.
> This would fail to track the target register type because the '*' prefix
> is not expected by the fallback code.
> 
> >  	/*
> >  	 * It should start from offset, but it's possible to skip 0
> >  	 * in the asm.  So 0(%rax) should be same as (%rax).
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260821050207.4517-1-yzhao62@ncsu.edu?part=3
