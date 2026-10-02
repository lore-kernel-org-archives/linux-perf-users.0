Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A0D38E8BE;
	Fri,  2 Oct 2026 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790981809; cv=none; b=fLHsITYFkM4GxBSEKP+5qqDQh9g+CVs3xiTEkRF0X6TV4CKi+ireJ5VPo3CASlhFajtlIHFdOzcilUY0Dj5GnE65xXWvlsF1rzGhlDDgdycS7qVNNI2VhVYzFw6WTam6+T0AMwGYxlmzJJjhCUQ0pVTjhhRC0crzHHcAPcS47vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790981809; c=relaxed/simple;
	bh=GFx/LeUutYGou8DsysigmeQmHVZsZ6+hH0tks7jO7Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7zFuZ2ajSOHLLCZQBzCtKYto0hoqyLrAQckN3bhMtUnOwUN5lt6DDk9wHuGhw7O6srPPtoZGdfwOfXPX6yEDHFbEx1Qqxf1RYvzr1DW7qFktOPUIhavXB+2UGDtouPL7lJKSGv+b9L8FgmBoKIRiUO1IUb9YUrdcZ96lTq5KVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8tUhLBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8tUhLBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D1C1F000FF;
	Fri,  2 Oct 2026 22:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790981808;
	bh=4ix/4A8+bmjpefCe0g2D3yU51PxoWBhvKoT6KgI83UQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A8tUhLBcScFLRNZn0CdsgC4NVThzvEkPAtm2D5cAzDzfyUXt1vLwEZVXUR5CT0+sh
	 FbejBpXVDS0iK8SRhPsHzxezLzXhB+VCcUQ6O3mzNvKUIDgO73Go2WAX9TUY/ynDlV
	 NsZUZwESApKt0yjW/opmN4ztKdp1bjrjFDinOT5tEsDrgzPQX6m3uo4J7W5RH78AKX
	 O/HOGmycUE9yBz98XQXHa8corPbjms2CWpCRluOGCOtEAt9A4aYV+9m5bqtMl5+oHv
	 TXKpXMkQMvD7ws+If+B9hhAhNlNt+VIsY/5CA7v6ZsE3ZT4Ylr5+DoOPBsnvSWwTsu
	 el/LpupsXgfSQ==
Date: Fri, 2 Oct 2026 15:56:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Yanbo Zhao <yzhao62@ncsu.edu>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/3] perf annotate: Resolve C++ virtual function calls
 in x86 insn tracking
Message-ID: <asA2rgBbNuwh-zR-@google.com>
References: <20260930210038.196928-1-yzhao62@ncsu.edu>
 <20260930210038.196928-4-yzhao62@ncsu.edu>
 <20260930211112.B2A431F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930211112.B2A431F000FF@smtp.kernel.org>

On Wed, Sep 30, 2026 at 09:11:12PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] perf: cross-platform analysis broken by hardcoded host pointer size
> - [Medium] perf: vtable pointer load ignores multi-register index
> --
> 
> commit a71181b28893b295ef8ae1558faf7b1c66e3593b
> Author: Yanbo Zhao <yzhao62@ncsu.edu>
> 
> perf annotate: Resolve C++ virtual function calls in x86 insn tracking
> 
> This commit introduces tracking of C++ virtual function calls by resolving
> vtable pointer loads and virtual function calls through the vtable in x86
> instruction state tracking. It enhances update_insn_state_x86() to handle
> TSR_KIND_VTABLE_PTR and TSR_KIND_VFUNC_PTR register states.
> 
> > diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
> > index 1acf31a2c7597..d21192b74b6bf 100644
> > --- a/tools/perf/util/annotate-arch/annotate-x86.c
> > +++ b/tools/perf/util/annotate-arch/annotate-x86.c
> 
> [ ... ]
> 
> > @@ -216,6 +216,29 @@ static void invalidate_reg_state(struct type_state_reg *reg)
> >  	reg->copied_from = -1;
> >  }
> >  
> > +/*
> > + * Get the return type of the C++ virtual function at the @offset in the
> > + * vtable of @class_die.  Returns false if it's not found or the function
> > + * returns void.
> > + */
> > +static bool vtable_get_rettype(Dwarf_Die *class_die, int offset,
> > +			       Dwarf_Die *type_die)
> > +{
> > +	Dwarf_Die func_die;
> > +	int index;
> > +
> > +	if (offset < 0)
> > +		return false;
> > +
> > +	/* TODO: arch-dependent pointer size */
> > +	index = offset / sizeof(void *);
> 
> [Severity: Medium]
> Will dividing the target's vtable byte offset by the host's sizeof(void *)
> compute an incorrect slot index when analyzing data from an architecture
> with a different pointer size?
> 
> Relying on host execution details like sizeof(void *) breaks
> cross-platform analysis (e.g., analyzing 32-bit x86 perf.data on a
> 64-bit host).

I think this is fine for now as we also have other places assuming the
host pointer size.  We'll fix it later.

> 
> > +
> > +	if (die_find_virtual_func(class_die, index, &func_die) == NULL)
> > +		return false;
> > +
> > +	return die_get_real_type(&func_die, type_die) != NULL;
> > +}
> > +
> >  static void update_insn_state_x86(struct type_state *state,
> 
> [ ... ]
> 
> > @@ -622,13 +669,38 @@ static void update_insn_state_x86(struct type_state *state,
> >  			}
> >  			pr_debug_type_name(&tsr->type, tsr->kind);
> >  		}
> > +		/* Load a function pointer from the vtable (for 'call *%reg') */
> > +		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
> > +			 state->regs[sreg].kind == TSR_KIND_VTABLE_PTR &&
> > +			 vtable_get_rettype(&state->regs[sreg].type, src->offset,
> > +					    &type_die)) {
> 
> [Severity: Medium]
> Does this query the wrong vtable slot by ignoring the index register when
> src->multi_regs is true?
> 
> If the operand is an indexed memory reference using multiple registers
> (e.g., mov 0x8(%rbx, %rcx, 8), %rax), src->offset contains only the
> static displacement part, not the dynamic index. Should this verify
> !src->multi_regs before querying the DWARF vtable with src->offset?

Multiple register is not handled well in the current code.  Dealing with
dynamic index would require more careful instruction tracking.

Anyway, it'd be safer to check !src->multi_regs here.

Thanks,
Namhyung

> 
> > +			tsr->type = type_die;
> > +			tsr->kind = TSR_KIND_VFUNC_PTR;
> > +			tsr->offset = 0;
> > +			tsr->ok = true;
> > +
> > +			pr_debug_dtp("mov [%x] %#x(reg%d) -> reg%d",
> > +				     insn_offset, src->offset, sreg, dst->reg1);
> > +			pr_debug_type_name(&tsr->type, tsr->kind);
> > +		}
> >  		/* And then dereference the pointer if it has one */
> 
> [ ... ]
> 
> > diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> > index 8a9d3f2eec4dc..e9bf76cc28633 100644
> > --- a/tools/perf/util/annotate-data.c
> > +++ b/tools/perf/util/annotate-data.c
> 
> [ ... ]
> 
> > @@ -715,8 +723,11 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
> >  			    Dwarf_Die *type_die, int ptr_offset)
> >  {
> >  	Dwarf_Word size;
> > +	bool is_pointer = (kind == TSR_KIND_POINTER ||
> > +			   kind == TSR_KIND_VTABLE_PTR ||
> > +			   kind == TSR_KIND_VFUNC_PTR);
> >  
> > -	if (kind == TSR_KIND_POINTER) {
> > +	if (is_pointer) {
> >  		/* TODO: arch-dependent pointer size */
> >  		size = sizeof(void *);
> >  	}
> 
> [Severity: Medium]
> Like the vtable_get_rettype() issue above, will hardcoding the host's
> pointer size here corrupt the stack state tracking for the target
> architecture?
> 
> [ ... ]
> 
> > diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> > index 5478c134e7e3b..5d96ee4c866b6 100644
> > --- a/tools/perf/util/disasm.c
> > +++ b/tools/perf/util/disasm.c
> 
> [ ... ]
> 
> > @@ -300,6 +300,11 @@ static int call__parse(const struct arch *arch, struct ins_operands *ops, struct
> >  	if (tok != NULL) {
> >  		endptr++;
> >  
> > +		/* Save the operand (without '*') to extract register and offset */
> > +		ops->target.raw = strdup(tok + 1);
> 
> [Severity: Low]
> This is a pre-existing issue, but this file calls strdup() without
> explicitly including <string.h>.
> 
> Can we add the explicit <string.h> include? The perf subsystem guide states
> that POSIX standard headers should be explicitly included to prevent musl
> compilation failures from missing implicit inclusions.
> 
> > +		if (ops->target.raw == NULL)
> > +			return -1;
> > +
> >  		/* Indirect call can use a non-rip register and offset: callq  *0x8(%rbx).
> >  		 * Do not parse such instruction.  */
> >  		if (strstr(endptr, "(%r") == NULL)
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260930210038.196928-1-yzhao62@ncsu.edu?part=3
