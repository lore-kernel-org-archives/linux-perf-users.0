Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1114A21;
	Mon, 14 Sep 2026 01:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789347735; cv=none; b=ND2rw0sAxziowlzzsOG8WZn+LEaWOQaMUk5Nhsplx4NcFdpwziB9f15q8j3DBRAh0tC797WF0jYgM0kehMJj2RvUj4qGbsQgXK4y0z4KuevZzQ32MSP1GhPRumsjUHbX6ewV4PpkWYYrlQlSFLuP4exKniUNh5MMqp8I1O1W3QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789347735; c=relaxed/simple;
	bh=Gh1tNRceTR/9E1sYC2KtixeffD/fmgrxC0umiZvOZco=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g2Mg7OAIaGoKj1cu1rh4p5TYV5WoAx+EnkkvcHyyfUxcdULC6GcniHzz80tzfoLLWy/kxmxw99sYMBKuUVqaEhcjoxhfnUZim2AwOWCcfskZs+B0wgcBoKIQkvxsPVqnARdSkmTCzjNdn7eOTCeRNn+EnONHKBUVoW44v3846IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7iHDRO1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7iHDRO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44521F000FF;
	Mon, 14 Sep 2026 01:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789347733;
	bh=G6pDCyxr3Ezs2auxm8Wz0goUjjmuLZIphq3F9Yov2TI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m7iHDRO1ZBHN+71W4p6Q5EcTg+fJaCBzCt8r4jBuA+L6GmLbmT+B6eBO6RqqMKIEq
	 U4dCP6UBKRbpnjbn3ycCUALB2qQ+yqC9JzituHO9fX71IV4VXnX0yDfSpxqLTS5a6c
	 JzIZNZpllIzLFZXQqQ6/6bYKmt+0PmWP2wVNKZ3vpuFBIazcdhg8J01RnqJz8aYtUw
	 3HlS4m1ywPIlei5ygLOQQoOykuqh4o+rioLskD1G0a0UYv7tj61l6QFdsZ0RBUenCR
	 r69YoH1dH0o94EFbHR7os0Rwcpj04s5kniIvk+WsljYqK2b0QEf9H9ch2H7wpnSrQo
	 QZoQkrGBF3aUQ==
Date: Mon, 14 Sep 2026 10:02:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v15 02/12] x86/hw_breakpoints: Make DR7 updates NMI safe
Message-Id: <20260914100210.02ef75318a3826dc609d9750@kernel.org>
In-Reply-To: <20260907040017.1983E1F00ACA@smtp.kernel.org>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
	<178875280112.93794.5857698342827027053.stgit@devnote2>
	<20260907040017.1983E1F00ACA@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 07 Sep 2026 04:00:16 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] local_db_restore() incorrectly uses dr7 == 0 to discard NMI-installed hardware breakpoints, permanently losing debug state and corrupting KVM guest debug registers.
> - [High] local_db_save() destructively clears hardware DR7 inside its sequence retry loop, permanently corrupting the restored state if a retry occurs.
> 
> Pre-existing issues:
> - [High] The early return in local_db_save() bypasses the sequence retry loop, leaving a race window where an NMI can leave hardware breakpoints enabled during critical exception handlers.
> --
> 
> commit 48808d0a31b45134e9ef897c90c0f96bd987d9ce
> Author: Jinchao Wang <wangjinchao600@gmail.com>
> 
> x86/hw_breakpoints: Make DR7 updates NMI safe
> 
> This commit introduces atomic per-CPU operations and sequence numbers to
> make DR7 hardware breakpoint updates NMI safe. It updates local_db_save()
> and local_db_restore() to use retry loops that detect NMI interruptions,
> preventing state corruption.
> 
> Link: https://lore.kernel.org/all/4ee0a2efc9e8387af83286b8495b7d490247e165.1785067572.git.wangjinchao600@gmail.com/
> 
> > diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
> > index 854d82b88ff4e..3399e166d3044 100644
> > --- a/arch/x86/include/asm/debugreg.h
> > +++ b/arch/x86/include/asm/debugreg.h
> [ ... ]
> > @@ -125,40 +126,66 @@ static __always_inline bool hw_breakpoint_active(void)
> >  
> >  extern void hw_breakpoint_restore(void);
> >  
> > -static __always_inline unsigned long local_db_save(void)
> > +static __always_inline void local_db_save(unsigned long *dr7,
> > +					  unsigned int *dr7_seq)
> >  {
> > -	unsigned long dr7;
> > +	do {
> > +		*dr7_seq = this_cpu_read(cpu_dr7_seq);
> > +		*dr7 = 0;
> >  
> > -	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) && !hw_breakpoint_active())
> > -		return 0;
> > -
> > -	get_debugreg(dr7, 7);
> > +		if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) &&
> > +		    !hw_breakpoint_active())
> > +			return;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but could this early return
> in local_db_save() bypass the sequence retry loop?
> 
> If an NMI hits exactly before the return instruction and installs a
> breakpoint, the function exits immediately. This leaves the newly installed
> hardware breakpoint active during exception handlers like MCE, which could
> trigger a recursive #DB exception and lead to a kernel panic.

Hmm, OK. But this should be fixed in this patch because this is for solving
this kind of NMI related issue.

Let me update checking cpu_dr7_seq is updated or not before returning.

> 
> >  
> > +		get_debugreg(*dr7, 7);
> >  
> > -	/* Architecturally set bit */
> > -	dr7 &= ~DR7_FIXED_1;
> > -	if (dr7)
> > -		set_debugreg(DR7_FIXED_1, 7);
> > +		/* Architecturally set bit */
> > +		*dr7 &= ~DR7_FIXED_1;
> > +		if (*dr7)
> > +			set_debugreg(DR7_FIXED_1, 7);
> 
> [Severity: High]
> Can this destructively overwrite the hardware DR7 state inside the sequence
> retry loop?
> 
> If an NMI interrupts execution between reading and clearing DR7, installs a
> breakpoint, and increments cpu_dr7_seq, this set_debugreg() call will
> overwrite the NMI's new hardware state with 0x400.
> 
> When the loop detects the sequence mismatch and retries, the next
> iteration's get_debugreg() will read this clobbered 0x400 value instead of
> the state installed by the NMI, permanently corrupting the restored state.

Ah, OK. Let me add sequence number check there and use cpu_dr7 instead of
raw dr7 value.

> 
> >  
> > -	/*
> > -	 * Ensure the compiler doesn't lower the above statements into
> > -	 * the critical section; disabling breakpoints late would not
> > -	 * be good.
> > -	 */
> > -	barrier();
> > +		/*
> > +		 * Ensure the compiler doesn't lower the above statements into
> > +		 * the critical section; disabling breakpoints late would not
> > +		 * be good.
> > +		 */
> > +		barrier();
> > +	} while (unlikely(*dr7_seq != this_cpu_read(cpu_dr7_seq)));
> >  }
> [ ... ]
> > -static __always_inline void local_db_restore(unsigned long dr7)
> > +static __always_inline void local_db_restore(unsigned long dr7,
> > +					     unsigned int dr7_seq)
> >  {
> > +	unsigned long val;
> > +	unsigned int seq;
> > +
> >  	/*
> >  	 * Ensure the compiler doesn't raise this statement into
> >  	 * the critical section; enabling breakpoints early would
> >  	 * not be good.
> >  	 */
> >  	barrier();
> > -	if (dr7)
> > -		set_debugreg(dr7, 7);
> > +
> > +	do {
> > +		seq = this_cpu_read(cpu_dr7_seq);
> > +		if (seq == dr7_seq) {
> > +			if (!dr7)
> > +				return;
> > +			val = dr7;
> > +		} else {
> > +			/*
> > +			 * If an NMI modified breakpoints while DR7 was saved as 0
> > +			 * (e.g. KVM guest entry), arch_install_hw_breakpoint()
> > +			 * clobbered hardware DR7. Restore val = 0 (DR7_FIXED_1)
> > +			 * to clean up the NMI's write and preserve guest isolation.
> > +			 * Otherwise, load the latest cpu_dr7 state.
> > +			 */
> > +			val = dr7 ? this_cpu_read(cpu_dr7) : 0;
> 
> [Severity: High]
> Does this logic permanently discard the hardware breakpoint installed by an
> NMI if dr7 was initially 0?
> 
> If dr7 was saved as 0, which happens when no host breakpoints were active,
> and an NMI subsequently installs a breakpoint, this logic evaluates to 0
> and ignores the new cpu_dr7 state.
> 
> It will then write 0x400 to hardware DR7, completely overriding the NMI
> update. Furthermore, if an NMI interrupts a KVM guest, the guest's DR7
> state is completely destroyed and replaced with 0x400.

OK, then I always use cpu_dr7 for value.

Thanks,

> 
> > +		}
> > +
> > +		set_debugreg(val | DR7_FIXED_1, 7);
> > +		barrier();
> > +	} while (unlikely(seq != this_cpu_read(cpu_dr7_seq)));
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/178875277830.93794.14247844688761142429.stgit@devnote2?part=2


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
