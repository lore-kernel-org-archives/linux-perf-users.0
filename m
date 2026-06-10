Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B409411679;
	Wed, 10 Jun 2026 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102934; cv=none; b=lhWayH/ZBz4rabKyF+bJkbNzb3+R1SBzpiPbBRV6RGgumNWTv34HwcDiLSZnZn/SQFcpogEtpbn3kClqvmFJAQibgBhr+Cn3IG3OF30ddKzcuq+p3pxolbqd41m3a+2TZ/OtZa9FECd920p0o9e1P2f2m11aTjjE9vg890fS33E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102934; c=relaxed/simple;
	bh=6KVGFvjXzn/3suHxgT/lA8KkLuLGsAy5FT+PGrr2x8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JONqYKG+4CHhi4Lq+rG+c1rt34G/FZg7BVI4zDKZHincpADIHyfHISZO6p0YdTP2lWeY4W/zq//Pxtxf9M6+G8/r5lEsN4tIoC3eWOIkI8ou17tIoIt9hKrxozfgP5Ul5Xz6vNEu9CXrAsrq5CeP8KniBqnx7Lg1GugTqSj42wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=tqihnZXU; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="tqihnZXU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=byX1TMsTMcqZpntllWo67o7uN1TgSsfIijpcakg/qXo=; b=tqihnZXU2rwiODhgNij7AhC5P3
	7/Jxwsx1PZVw0TpLOGQAM7kBp/dE7Ia0H28N9YHsuYAoA2HyMcLAiTcGWywSfwrwqwdkGDMPh9IHQ
	wx26a9DgIWP80335gpR7KMbGUG8FqT6Uo9fNIiX4GZ1E/+fohP+ggiMgMZz3Jqt32b3mHVDnbr6e8
	mzVn+PisywHYQ4rlAMX0OAnUFnsoJJH+T3oM+xR7FloIK+TWXognDRnflK88/F7V6AhRGNaPjaWAv
	UEww1h7ZuiEQHX6Y8WNexzi8PreFvTM17LOaXQm16MW3JuNZJ5PIj/bPZCEINoY7CHgVtjgBHlGZf
	VCqv4AwQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wXKEW-009GNH-2X;
	Wed, 10 Jun 2026 14:48:45 +0000
Date: Wed, 10 Jun 2026 07:48:39 -0700
From: Breno Leitao <leitao@debian.org>
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Pratyush Anand <panand@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	clm@meta.com, leo.bras@arm.com, kernel-team@meta.com
Subject: Re: [PATCH] arm64/hw_breakpoint: reject unaligned watchpoints that
 would truncate BAS
Message-ID: <ail38x6jVAAU84AI@gmail.com>
References: <20260430-arm64_bas-v1-1-c6ab2b15aec0@debian.org>
 <ahmohv6vQGxY-asL@willie-the-truck>
 <aiaqbmQSksKB6dTZ@gmail.com>
 <ailY2UgqiQNYxoZG@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ailY2UgqiQNYxoZG@willie-the-truck>
X-Debian-User: leitao

On Wed, Jun 10, 2026 at 01:30:17PM +0100, Will Deacon wrote:
> On Mon, Jun 08, 2026 at 05:14:22AM -0700, Breno Leitao wrote:
> > On Fri, May 29, 2026 at 03:53:58PM +0100, Will Deacon wrote:

> > > and it looks like the aarch64_align_watchpoint() function does try to
> > > spill into multiple watchpoints, so perhaps your patch is ok. I'd
> > > appreciate your opinion, though.
> > 
> > It won't, for two independent reasons.
> 
> Sorry, not sure I understand you here when you say "it won't". GDB won't
> spill or something else?
> 
> > The new -EINVAL is unreachable from GDB; only a raw perf_event_open() passing
> > an unaligned base with an oversized bp_len hits it, which is the bug.
> 
> Why isn't it reachable via hw_break_set() => {ptrace_hbp_set_addr(),
> ptrace_hbp_set_ctrl()} ?

Sorry. What I should have said is: GDB handles that -EINVAL. From
gdb/nat/aarch64-linux-hw-point.c:


 void
 aarch64_linux_set_debug_regs (struct aarch64_debug_reg_state *state,
                   int tid, int watchpoint)
 {
   int i, count;
   struct iovec iov;
   struct user_hwdebug_state regs;
   const CORE_ADDR *addr;
   const unsigned int *ctrl;
 
   memset (&regs, 0, sizeof (regs));
   iov.iov_base = &regs;
   count = watchpoint ? aarch64_num_wp_regs : aarch64_num_bp_regs;
   addr = watchpoint ? state->dr_addr_wp : state->dr_addr_bp;
   ctrl = watchpoint ? state->dr_ctrl_wp : state->dr_ctrl_bp;
   if (count == 0)
     return;
   iov.iov_len = (offsetof (struct user_hwdebug_state, dbg_regs)
          + count * sizeof (regs.dbg_regs[0]));
 
   for (i = 0; i < count; i++)
     {
       regs.dbg_regs[i].addr = addr[i];
       regs.dbg_regs[i].ctrl = ctrl[i];
     }
 
   if (ptrace (PTRACE_SETREGSET, tid,
           watchpoint ? NT_ARM_HW_WATCH : NT_ARM_HW_BREAK,
           (void *) &iov))
     {
       /* Handle Linux kernels with the PR external/20207 bug.  */
       if (watchpoint && errno == EINVAL
       && kernel_supports_any_contiguous_range)
     {
       kernel_supports_any_contiguous_range = false;
       aarch64_downgrade_regs (state);
       aarch64_linux_set_debug_regs (state, tid, watchpoint);
       return;
     }
       error (_("Unexpected error setting hardware debug registers"));
     }
 }

From: https://fossies.org/linux/gdb/gdb/nat/aarch64-linux-hw-point.c

aarch64_downgrade_regs() rounds the BAS up to the nearest legacy
0x01/0x03/0x0f/0xff mask and aligns the base down with
align_down(..., AARCH64_HWP_ALIGNMENT)

The retry then succeeds. So a ptrace NT_ARM_HW_WATCH with an unaligned
base and an oversized BAS will, after this patch, go:

   set -> -EINVAL -> downgrade -> set -> ok
> > GDB in fact downgrades on the current kernel independently of this patch, so
> > behaviour is unchanged for it.
> 
> That sounds like a bug?

On an unpatched kernel GDB does NOT downgrade for the exact case this patch
fixes, precisely because the kernel returns 0 (with a truncated BAS) instead of
-EINVAL.

So the real behaviour delta this patch introduces for GDB is:

  - Before: unaligned-base + oversized-len watchpoint silently watches
    fewer bytes than requested. GDB never notices; user sees missed
    events.
  - After:  same request returns -EINVAL, GDB's existing PR-20207
    fallback engages, watchpoint is reinstalled with a legacy mask, and every
    requested byte is covered (possibly with a few extra).

