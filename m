Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EF3396588;
	Thu,  9 Jul 2026 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581119; cv=none; b=A1936x92p0x6Iv/fHkbHFwxDUbPxbYFSXHBdLEoVwlBmIMaBQ7BD2mW/NDQNIv7SffmypIdeJ51n5IFqyhNrtGqDKA7ofX9CJ4rzy3nYxjiCFkip3mP7KEWZ7VjBDVcBGrb6ITV18HwuA4D0mNJtF8M2xeS53xBJbamrk+sXZ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581119; c=relaxed/simple;
	bh=1bFrl0vlltxeAap/2rx9ASRmCqfX14/3dXfXo+34v5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiFWz8rOwx5k32OrixMxayCG5BNkbnyIVo39ju/YAGQ2EuQGu5P1o8yvHHm+2xYzNVGf303fZR6D2zYWFQlqurW9N5svseNTCgcKPylgo+82qRuTHFJnMjEze0DroCb6YjCmTbbDL02ARMYXN/hYe8xX4zX/nnZqyG3xN2Y6AsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hegS0QMH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hegS0QMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8180C1F000E9;
	Thu,  9 Jul 2026 07:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783581117;
	bh=DpiuIY+i0+5VHAO+YolzyXVb4B+73lrHLlUgE3fFKfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hegS0QMHfmHqyD1SVSULKH2TvjcUZ43IvcINseRRD7rRdLat19kjytmFiWm0eNYrp
	 W+HTUUb2fdr+uAwTgxnEn/C+hbIYZfE28UeiVOO8eDFX3ViP6qntum3aUTvb/sTfA3
	 msEZAcFVLVwa+okviIHbCeLGiNMzuyRdDtR8nwyNQIFc50uV6NsxPHyL5naMS9ndNj
	 06h5PuTt0O5YUkj/i8M0BQeFqrGAauQx+M/65WTi2arM9SXlAP4byscEyXK+8/LvfF
	 DHsMNRGqDb+1DRwuXuXFhr9aeAxe5Gb+lUe3e88bjEH+PoEnx0SUNgZvCYbT8bsS4w
	 N+U7hkIY8PGBw==
Date: Thu, 9 Jul 2026 00:11:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 16/21] perf annotate-arm64: Support stack variable
 tracking
Message-ID: <ak9JvKYdnyI6N-ba@z2>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-17-wutengda@huaweicloud.com>
 <20260701041647.81CE41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701041647.81CE41F000E9@smtp.kernel.org>

On Wed, Jul 01, 2026 at 04:16:47AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [Medium] Incomplete handling of ARM64 load/store pair instructions (ldp/stp) causes type tracking corruption by ignoring the second register.
> - [Medium] Missing invalidation of destination register when type resolution fails during a memory load.
> - [Medium] Missing invalidation of stack state when storing an unknown register type.
> - [Medium] Incorrect stack offset calculation when accessing memory via the stack pointer while a different frame base register is active.
> --
> 
> commit 3e734515747646c2063edf487f47005c1433cf1a
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Support stack variable tracking
> 
> This commit extends update_insn_state() for arm64 to track data types
> stored on the stack. It handles stack loads and stores to update the
> register's type state or stack state. This allows 'perf annotate' to
> maintain type information for local variables as they move between registers
> and memory.
> 
> > diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> > index f283596bb0589..255ccaf331309 100644
> > --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> > +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> [ ... ]
> > @@ -368,6 +371,8 @@ static void update_load_insn_state(struct type_state *state,
> >  	int reg_offset;
> >  	int sreg = src->reg1;
> >  	int dreg = dst->reg1;
>         ^^^^^^^^^^^^^^^^^^^^
> [Severity: Medium]
> When handling ARM64 load pair instructions (ldp), does this code ignore the
> second destination register (dst->reg2)? The second register of a load pair
> could retain its stale type instead of being updated, which might lead to
> false type propagation.

Splitting "ldp" case would prevent this kind of issue.

> 
> > +	int fbreg = dloc->fbreg;
> > +	int fboff = 0;
> >  
> >  	if (!has_reg_type(state, dreg))
> >  		goto out_adjust;
> > @@ -375,7 +380,52 @@ static void update_load_insn_state(struct type_state *state,
> >  	tsr = &state->regs[dreg];
> >  	tsr->copied_from = -1;
> >  
> > +	if (dloc->fb_cfa) {
> > +		u64 ip = dloc->ms->sym->start + dl->al.offset;
> > +		u64 pc = map__rip_2objdump(dloc->ms->map, ip);
> > +
> > +		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
> > +			fbreg = -1;
> > +	}
> > +
> >  retry:
> > +	/* Check stack variables with offset */
> > +	if (sreg == fbreg || sreg == state->stack_reg) {
> > +		struct type_state_stack *stack;
> > +		int offset = src->offset - fboff;
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> [Severity: Medium]
> Will this subtract the frame base offset even when the access is relative to
> the stack pointer (when sreg == state->stack_reg)? If the stack pointer is
> used and fbreg is different (e.g., x29), this could yield an incorrect
> internal stack offset and lose type information.

I think it's a common issue that can happen on other arch.  On x86, I
never saw where stack pointer is used when fbreg is RBP.  Generally I
think it won't generate code to use RSP for memory access when frame
base register is set to RBP.

Thanks,
Namhyung

> 
> > +
> > +		stack = find_stack_state(state, offset);
> [ ... ]
> > @@ -413,6 +463,70 @@ static void update_load_insn_state(struct type_state *state,
> >  	adjust_reg_index_state(state, src, "ldr", insn_offset);
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> [Severity: Medium]
> Is the destination register left uninvalidated if type resolution fails
> during a memory load and the code falls through the multi-regs retry logic
> to the out_adjust label? The destination register could retain its prior type
> instead of being invalidated, even though its value was overwritten by an
> unknown memory load.
> 
> >  }
> >  
> > +static void update_store_insn_state(struct type_state *state,
> > +				    struct data_loc_info *dloc,
> > +				    struct disasm_line *dl,
> > +				    struct annotated_op_loc *src,
> > +				    struct annotated_op_loc *dst)
> > +{
> > +	struct type_state_reg *tsr;
> > +	u32 insn_offset = dl->al.offset;
> > +	int sreg = src->reg1;
> > +	int dreg = dst->reg1;
>         ^^^^^^^^^^^^^^^^^^^^
> [Severity: Medium]
> Similar to the load instructions, does this logic ignore the second source
> register (src->reg2) for ARM64 store pair instructions (stp)? The second
> register of a store pair wouldn't be saved to the stack.
> 
> > +	int fbreg = dloc->fbreg;
> > +	int fboff = 0;
> > +
> > +	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok)
> > +		goto out_adjust;
>         ^^^^^^^^^^^^^^^^
> [Severity: Medium]
> By skipping the rest of the function here, are we bypassing the invalidation
> of the stack state? If an untracked register is stored into a stack slot that
> previously held a tracked type, the stale type might persist on the stack.
> 
> > +
> > +	if (dloc->fb_cfa) {
> > +		u64 ip = dloc->ms->sym->start + dl->al.offset;
> > +		u64 pc = map__rip_2objdump(dloc->ms->map, ip);
> > +
> > +		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
> > +			fbreg = -1;
> > +	}
> > +
> > +	/* Check stack variables with offset */
> > +	if (dreg == fbreg || dreg == state->stack_reg) {
> > +		struct type_state_stack *stack;
> > +		int offset = dst->offset - fboff;
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> [Severity: Medium]
> Could this calculation yield an incorrect internal stack offset by
> subtracting the frame base offset even when the access is relative to the
> stack pointer? This could happen if the frame base register is different from
> the stack pointer.
> 
> > +
> > +		tsr = &state->regs[sreg];
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260701035355.752944-1-wutengda@huaweicloud.com?part=16
