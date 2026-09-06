Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1853361950;
	Sun,  6 Sep 2026 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788708486; cv=none; b=VZZTPXnYrhfeBczDEwUSXR/Uacgip2gnO3Ivku0i6SGt/tiNBPM+WxGgSb29bbvLrOuiq9yLcy+9XBShqhqqEQATm6qvqTRfQd+Gks0TAB9s6cWSrzLaNWDg84BUyw1k/hcFc8Iopalkbw3Og1Rek0yrVO0Bo/CM7tJM8IZFKLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788708486; c=relaxed/simple;
	bh=EldEYWNRQbovvWpWdAkcKN7nPrrysstXIDhwWhHPkoo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HCFPmp4Y5vW2jSlwIC6UjCM6l5wZAF1+q30IAF4FSPqtxfFN2TPgOh6+5S66/edMPSDi/dAdoQUdByPMGgDTQlx/xM50LzI+6KfpYu1+6O7eux3Ju2Oi5n9f/ifJEPtF1qpWR1klwVLgIr1lUrw4GhQlkefAt9Gm96a59crNFw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCVdQu1V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCVdQu1V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D7B1F00A3A;
	Sun,  6 Sep 2026 15:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788708484;
	bh=Cepp1dP3j33Zql5xWt35duiNbPFrWRgNfLpZvo7wB9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JCVdQu1VJsyb4iAbgr099bFeDuD7NM1d5ysUqm4R6qkyzu4842kl8gqCNfu8pkN/G
	 u8ntHBwAOdpqUpI08IOYugM8oxxjDrozE71GWL1cTpiFK9KBBkryzWP9fDozGMyN2p
	 rItXLLaUAnXO2VEV6EUeDNbCRkHXulHIxsdW0Kyjnh7jYhgTkP1p4vTq0TLUCVBqtt
	 OdG6pjkAWzfG/1F4YWZ1dM9i4HjZD6RsDYHGn0JKgJCKI1xsTAkTEYHAItwsbleNSU
	 Bsls3OeKW6DjGP/I6RDLG7efww5QUfiuYp3Z0eYsNhpgjraL7csXNWHW3/26zN6u0m
	 U+zK5MILgQX/w==
Date: Mon, 7 Sep 2026 00:28:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v14 04/14] x86/hw_breakpoints: Make DR7 updates NMI safe
Message-Id: <20260907002800.8c66e05d98ad708740ade229@kernel.org>
In-Reply-To: <20260830144520.081FF1F000E9@smtp.kernel.org>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
	<178810005476.64882.15902865504188093281.stgit@devnote2>
	<20260830144520.081FF1F000E9@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 30 Aug 2026 14:45:19 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Preexisting race condition in `local_db_save()` leads to recursive exceptions. The function reads DR7, then checks if it was non-zero before disabling hardware breakpoints. If an NMI (e.g., KGDB) installs a breakpoint after DR7 is read but before the check, `local_db_save()` will falsely believe no breakpoints are active and skip disabling them. The exception handler (e.g., `#DB` or `#MC`) will then run with hardware breakpoints enabled, risking a recursive exception.
> - [High] The patch adds `if (!dr7) return;` in `local_db_restore()` to ostensibly prevent an NMI from overwriting an intentionally cleared hardware DR7 state (such as during KVM guest entry). However, if an NMI (e.g., from KGDB) installs a hardware breakpoint, `arch_install_hw_breakpoint()` directly overwrites the hardware DR7 register with `cpu_dr7`. By returning immediately when `dr7 == 0`, `local_db_restore()` fails to restore the hardware DR7 back to its cleared state (0x400). Consequently, KVM resumes the guest with the host's newly installed hardware breakpoint active.
> --
> 
> commit e145a86b764e63c7282dc5c5fb7c745db147953a
> Author: Jinchao Wang <wangjinchao600@gmail.com>
> 
> x86/hw_breakpoints: Make DR7 updates NMI safe
> 
> Hardware breakpoint installation and removal run with IRQs disabled, but
> an NMI can still enter the same code through KGDB. This patch uses cmpxchg
> and a per-CPU sequence number to make DR7 updates safe from NMI interruptions.
> 
> Link: https://lore.kernel.org/all/4ee0a2efc9e8387af83286b8495b7d490247e165.1785067572.git.wangjinchao600@gmail.com/
> 
> > diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
> > index a2c1f2d24b645..65e80cd62193f 100644
> > --- a/arch/x86/include/asm/debugreg.h
> > +++ b/arch/x86/include/asm/debugreg.h
> 
> [ ... ]
> 
> > @@ -125,18 +126,20 @@ static __always_inline bool hw_breakpoint_active(void)
> >  
> >  extern void hw_breakpoint_restore(void);
> >  
> > -static __always_inline unsigned long local_db_save(void)
> > +static __always_inline void local_db_save(unsigned long *dr7,
> > +					  unsigned int *dr7_seq)
> >  {
> > -	unsigned long dr7;
> > +	*dr7 = 0;
> > +	*dr7_seq = this_cpu_read(cpu_dr7_seq);
> >  
> >  	if (static_cpu_has(X86_FEATURE_HYPERVISOR) && !hw_breakpoint_active())
> > -		return 0;
> > +		return;
> >  
> > -	get_debugreg(dr7, 7);
> > +	get_debugreg(*dr7, 7);
> >  
> >  	/* Architecturally set bit */
> > -	dr7 &= ~DR7_FIXED_1;
> > -	if (dr7)
> > +	*dr7 &= ~DR7_FIXED_1;
> > +	if (*dr7)
> >  		set_debugreg(DR7_FIXED_1, 7);
> 
> [Severity: Critical]
> This is a pre-existing issue, but does this conditional check rely on a stale
> read of DR7?
> 
> If an NMI (e.g. KGDB) installs a breakpoint after DR7 is read via
> get_debugreg() but before this check, local_db_save() will evaluate the old 0
> and skip disabling DR7. Can this cause the exception handler (such as #DB or
> #MC) to run with hardware breakpoints still enabled, risking a recursive
> exception?

Ah, good catch. It also need to check cpu_dr7_seq is not bumped too.


> 
> >  
> >  	/*
> > @@ -145,20 +148,34 @@ static __always_inline unsigned long local_db_save(void)
> >  	 * be good.
> >  	 */
> >  	barrier();
> > -
> > -	return dr7;
> >  }
> >  
> > -static __always_inline void local_db_restore(unsigned long dr7)
> > +static __always_inline void local_db_restore(unsigned long dr7,
> > +					     unsigned int dr7_seq)
> >  {
> > +	unsigned int seq;
> > +
> >  	/*
> >  	 * Ensure the compiler doesn't raise this statement into
> >  	 * the critical section; enabling breakpoints early would
> >  	 * not be good.
> >  	 */
> >  	barrier();
> > -	if (dr7)
> > +
> > +	if (!dr7)
> > +		return;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but if an NMI interrupts a
> cleared DR7 state (such as during KVM guest entry), and the NMI installs
> a hardware breakpoint, doesn't this early return fail to restore the hardware
> DR7 back to its cleared state (0x400)?

Hmm, this was intended to avoid restoring cpu_dr7 over KVM's cleared state.
But if the NMI already overwrote hardware DR7 here, returning early leaves
the host breakpoint active when entering the guest.

OK, instead of an unconditional early return on "!dr7", local_db_restore()
should check if cpu_dr7_seq changed too...

Let me fix it.

> 
> Consequently, it looks like KVM would resume the guest with the host's
> newly installed hardware breakpoint active.
> 
> [ ... ]
> 
> > diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> > index f846c15f21ca1..3204e75dc4546 100644
> > --- a/arch/x86/kernel/hw_breakpoint.c
> > +++ b/arch/x86/kernel/hw_breakpoint.c
> 
> [ ... ]
> 
> > @@ -97,38 +100,31 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigned *len, unsigned *type)
> >  int arch_install_hw_breakpoint(struct perf_event *bp)
> >  {
> >  	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> > -	unsigned long *dr7;
> > +	unsigned int seq;
> >  	int i;
> >  
> >  	lockdep_assert_irqs_disabled();
> >  
> >  	for (i = 0; i < HBP_NUM; i++) {
> > -		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
> > -
> > -		if (!*slot) {
> > -			*slot = bp;
> > +		if (!this_cpu_cmpxchg(bp_per_reg[i], NULL, bp))
> >  			break;
> > -		}
> >  	}
> >  
> >  	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
> >  		return -EBUSY;
> >  
> > -	set_debugreg(info->address, i);
> > -	__this_cpu_write(cpu_debugreg[i], info->address);
> > -
> > -	dr7 = this_cpu_ptr(&cpu_dr7);
> > -	*dr7 |= encode_dr7(i, info->len, info->type);
> > -
> > -	/*
> > -	 * Ensure we first write cpu_dr7 before we set the DR7 register.
> > -	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> > -	 */
> > -	barrier();
> > -
> > -	set_debugreg(*dr7, 7);
> > -	if (info->mask)
> > -		amd_set_dr_addr_mask(info->mask, i);
> > +	do {
> > +		seq = this_cpu_inc_return(cpu_dr7_seq);
> > +		this_cpu_write(cpu_debugreg[i], info->address);
> > +		barrier();
> > +		set_debugreg(info->address, i);
> > +		if (info->mask)
> > +			amd_set_dr_addr_mask(info->mask, i);
> > +		this_cpu_or(cpu_dr7, encode_dr7(i, info->len, info->type));
> > +		barrier();
> > +		set_debugreg(this_cpu_read(cpu_dr7), 7);
> 
> [Severity: High]
> This is a pre-existing issue, but since arch_install_hw_breakpoint()
> unconditionally overwrites the hardware DR7 register inside the NMI,
> does this mean the KVM cleared state is already lost here before
> local_db_restore() is even called?

Yes, so checking the cpu_dr7_seq will avoid this issue too.

Thanks,

> 
> > +		barrier();
> > +	} while (seq != this_cpu_read(cpu_dr7_seq));
> >  
> >  	return 0;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/178810001186.64882.2161016469449127450.stgit@devnote2?part=4


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
