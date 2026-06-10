Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7F64071EB;
	Wed, 10 Jun 2026 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781094623; cv=none; b=qvQH0eL96LP+vNhGeHnS+rdVHOQ+bu0uTHwrU0NxtW1upmu6VBM+aFvhZqDa70OsrnSw1tdWom/ca1HW/+QXMTmS3GDGARHuQD4ctMf/0Qwo4nMb0tr3PTEP/1PTtBVmEBw0Z58rpq5e8pqgsiKo5S0vR41S8ioF098uzRfJW2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781094623; c=relaxed/simple;
	bh=YJDm4Z6bb6rQb05MPoj8/yq360g2nvdN8Pt5oAhsy7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYo3M+ulr8OuX47ac+hkZOr0q7kL9zuRq0/i8Z+U9OOKCNV+zWnnRqUp2+Fp0qDKQfjJ8f6f7I9B2vBEEYWqbq9YM48Fb27ttscmcV8VDVWEai2rmgfYhplfLoZhLdEpWvhPZWT/Q/DLFD+4QFsxFr6nMkZxX0dUVnftu5Fz55E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdOS8V2B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdOS8V2B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312941F00893;
	Wed, 10 Jun 2026 12:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781094622;
	bh=fNB2fCGGWn9cQHMjzpoICo+ljxC9XRzo0/nr5TF+lYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kdOS8V2BJ8P3fi5YFUDN2bhiEdWNOSPknOufzcyhtBhf/fvUQZ9rs+8rPtURUkzFo
	 WriDLw02pQhtVqegmhi4bhaANTvXvq+5j+pO9ROCrX2Y1/q+/4dpxL72iSEJC6MRG4
	 Yk0TV6gopolqt9yKEQrGpzp4TpRUFQ7JiAbIJ7GnWM21jzOe3pgWL7gh0LQYbFMoZU
	 ZOmPXf8L8IRWAs3J8yQF35aQMViAAIevUDSKp9SzELGseDK/mED5inSSleKqJ70ZrU
	 0uDEH7NRkW9XfhuIcW9tpk/jJw+ank3IU1+cHsF9YPGCo/xIPUBxIlm4dlxihqbTpW
	 Dq2R5fEqMBp+g==
Date: Wed, 10 Jun 2026 13:30:17 +0100
From: Will Deacon <will@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Pratyush Anand <panand@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	clm@meta.com, leo.bras@arm.com, kernel-team@meta.com
Subject: Re: [PATCH] arm64/hw_breakpoint: reject unaligned watchpoints that
 would truncate BAS
Message-ID: <ailY2UgqiQNYxoZG@willie-the-truck>
References: <20260430-arm64_bas-v1-1-c6ab2b15aec0@debian.org>
 <ahmohv6vQGxY-asL@willie-the-truck>
 <aiaqbmQSksKB6dTZ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiaqbmQSksKB6dTZ@gmail.com>

On Mon, Jun 08, 2026 at 05:14:22AM -0700, Breno Leitao wrote:
> On Fri, May 29, 2026 at 03:53:58PM +0100, Will Deacon wrote:
> > Hi Breno,
> > 
> > Thanks for sending this out.
> > 
> > On Thu, Apr 30, 2026 at 02:40:10AM -0700, Breno Leitao wrote:
> > > hw_breakpoint_arch_parse() positions the BAS bit pattern in
> > > hw->ctrl.len with
> > > 
> > > 	offset = hw->address & alignment_mask;	/* 0..7 */
> > > 	hw->ctrl.len <<= offset;
> > > 
> > > ctrl.len is an 8-bit bitfield (struct arch_hw_breakpoint_ctrl::len is
> > > u32 :8), so the shift silently drops any bits past bit 7.  For
> > > non-compat AArch64 watchpoints the offset is unbounded relative to
> > > ctrl.len: a perf_event_open(PERF_TYPE_BREAKPOINT) caller asking for
> > > HW_BREAKPOINT_W with bp_addr=page+1 and bp_len=HW_BREAKPOINT_LEN_8
> > > ends up with 0xff << 1 = 0x1fe, stored as 0xfe.  The kernel programs
> > > WCR.BAS=0xfe and the hardware watches bytes [1..7] instead of the
> > > requested [1..8] -- the eighth byte is silently dropped.  The
> > > syscall still returns success, leaving userspace to discover the
> > > gap by empirical probing.
> > > 
> > > The same class affects HW_BREAKPOINT_LEN_{2,4} when offset pushes the
> > > high BAS bit past bit 7 (e.g. LEN_4 with offset=5 yields 0xe0
> > > instead of 0x1e0).  No memory-safety impact -- the value is masked
> > > into 8 bits before encoding -- but debuggers and perf users observe
> > > missed events on bytes they thought they were watching.
> > > 
> > > The AArch32 branch immediately above already rejects unrepresentable
> > > (offset, len) combinations via an explicit switch.  Mirror that for
> > > the non-compat branch by checking that the shifted pattern fits in
> > > the BAS field, returning -EINVAL when it does not.
> > > 
> > > Reproducer:
> > > 
> > >   struct perf_event_attr a = {
> > >       .type = PERF_TYPE_BREAKPOINT, .size = sizeof(a),
> > >       .bp_type = HW_BREAKPOINT_W,
> > >       .bp_addr = (uintptr_t)(buf + 1),
> > >       .bp_len = HW_BREAKPOINT_LEN_8,
> > >       .exclude_kernel = 1, .exclude_hv = 1,
> > >   };
> > >   int fd = perf_event_open(&a, 0, -1, -1, 0);
> > >   /* before this fix: succeeds, watches 7 bytes (buf+1..buf+7)   */
> > >   /* after  this fix: fails with EINVAL                          */
> > > 
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > Fixes: b08fb180bb88 ("arm64: Allow hw watchpoint at varied offset from base address")
> > 
> > Oh man, this has been broken for nearly a decade :/
> > 
> > I think we probably should've stuck with the old behaviour of rejecting
> > unaligned base addresses, but it's too late now. Damn.
> > 
> > >  arch/arm64/kernel/hw_breakpoint.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> > > index ab76b36dce820..b8a1402119f3a 100644
> > > --- a/arch/arm64/kernel/hw_breakpoint.c
> > > +++ b/arch/arm64/kernel/hw_breakpoint.c
> > > @@ -559,6 +559,15 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
> > >  		else
> > >  			alignment_mask = 0x7;
> > >  		offset = hw->address & alignment_mask;
> > > +
> > > +		/*
> > > +		 * BAS is an 8-bit field in WCR/BCR; the shift below would
> > > +		 * silently drop the high bits of ctrl.len when offset + len
> > > +		 * exceeds 8, programming hardware to watch fewer bytes than
> > > +		 * the user requested.
> > > +		 */
> > > +		if (((u32)hw->ctrl.len << offset) > 0xff)
> > 
> > nit: Use ARM_BREAKPOINT_LEN_8 instead of 0xff
> > 
> > > +			return -EINVAL;
> > >  	}
> > 
> > I must confess, I'm very nervous about breaking userspace here. If GDB
> > is triggering this path, then this patch will change an unreliable
> > watchpoint into a hard error (which probably means GDB exits). Have you
> > looked to see what GDB and/or any other debuggers do?
> > 
> > I had a quick peek and found the bugzilla entry which motivated the
> > buggy change in the first place:
> > 
> > https://sourceware.org/bugzilla/show_bug.cgi?id=20207
> > 
> > and it looks like the aarch64_align_watchpoint() function does try to
> > spill into multiple watchpoints, so perhaps your patch is ok. I'd
> > appreciate your opinion, though.
> 
> It won't, for two independent reasons.

Sorry, not sure I understand you here when you say "it won't". GDB won't
spill or something else?

> The new -EINVAL is unreachable from GDB; only a raw perf_event_open() passing
> an unaligned base with an oversized bp_len hits it, which is the bug.

Why isn't it reachable via hw_break_set() => {ptrace_hbp_set_addr(),
ptrace_hbp_set_ctrl()} ?

> Second, even if a debugger did hand the kernel such a request, GDB
> already treats EINVAL on NT_ARM_HW_WATCH as a downgrade signal, not a
> fatal error. aarch64_linux_set_debug_regs() catches it, clears
> kernel_supports_any_contiguous_range, calls aarch64_downgrade_regs()
> (which rounds the BAS up to a legacy 0x01/03/0f/ff mask and aligns the
> base down), and retries. That fallback is exactly the PR-20207 path.
> 
> Confirmed on a Grace box: with the patch applied (under virtme-ng), the
> reproducer's unaligned LEN_8 now returns -EINVAL while aligned LEN_8
> still succeeds, and GDB still inserts the watchpoint and it still fires
> on every write.

Thanks for testing it, that's somewhat reassuring.

> GDB in fact downgrades on the current kernel independently of this patch, so
> behaviour is unchanged for it.

That sounds like a bug?

Will
