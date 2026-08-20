Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCB564A8C;
	Thu, 20 Aug 2026 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787184887; cv=none; b=nAJBwbYiN8IpmO5JAY+gH1eIDs2pe3UP9ZJhRirQfLbYoFRPBWIqT749iJ1HYoGeU8/0vKANHH6NYIYm4k/MOgp09G/+eDlKeE7QwXbx1s5pLpfr88BdN+OlEGNRBxBKi5Vy0e4NMXPtZfp2Tc5tbc44UkLFKv4enG1Jmd4fDjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787184887; c=relaxed/simple;
	bh=uF+4W7ihf4QY4qxmMVgCFnBo4A4pgmWvyKa93QT5OjA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=prpQ0Zu92J7vG4E/h8DEHQ06WUXPmUque6oZ9wM6xoWc2CyoQSI4vAjGbiBRW7QxGNHnFTo245tTI0BdWzPZj+dCw60dkkSvQl3oU6O15FIgwZu9KD6RFDG2oDRuC/eOPtQnXOSNlJ8oiQMndB+f5O35oto5aq7cwcH4yH2GuEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWqO/2ie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWqO/2ie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FDD1F00A3A;
	Thu, 20 Aug 2026 00:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787184886;
	bh=W92QFFwro4YYwgtNSKtCKIiG4RzKCdA0G761pKY35d4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FWqO/2ieDeAq6V5Gd+kV61JA33qDj16RSHvWlswI8nu9vwXFJDNtEK57twGh0b21N
	 SV2sChM8FJHNCsVw37HegnJ/clD4vfjphaJqGdsK9GeUEKYIX2fYOPL8gLt2LD3z5u
	 bWe+PmkwDEZktMU+AodQ++XHcwvlxVw+Ia7Ql842PnLdYV93QU0eKxDO3+hAHplCC+
	 XrbRKWQrZEpy0sT5+qHgHYLW5mBc2iC23cJhKEBa4/CwgdBRqXs2HsSsPqUdeBkOim
	 AJfGZk1oA18HG2lvdfpdMFI/2kLKOkkpS75FGrbz00fGACaMnS3bqB6JifW2FT3Hu/
	 89WLlPmblmdUA==
Date: Thu, 20 Aug 2026 09:14:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v12 03/11] HWBP: Add modify_local_hw_breakpoint_addr()
 API
Message-Id: <20260820091443.f839ba0d307a810714ea8f27@kernel.org>
In-Reply-To: <20260807155802.F06041F000E9@smtp.kernel.org>
References: <178611679753.237811.10190793347982785419.stgit@devnote2>
	<178611683120.237811.15904891776099424430.stgit@devnote2>
	<20260807155802.F06041F000E9@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 07 Aug 2026 15:58:01 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Modifying hardware debug address registers (DR0-DR3) while they are still enabled in DR7 violates the x86 architectural guidelines and can cause unpredictable hardware behavior.

It uses local_db_save/restore() to atomically update it. So it should be safe.

> - [Medium] Temporary invalid software state in `bp->attr.bp_addr` before validation causes incorrect perf samples if interrupted by an NMI.

Note that this is only used from wprobe, which checks the address is correct.
Anyway, I will add a comment about that.

> 
> Pre-existing issues:
> - [High] Lockless traversal of `kprobe_blacklist` can lead to Use-After-Free during module unload.

This seems a funny hallucination... why have you pointed unrelated kprobe things??

> --
> 
> --- Patch [3]: [PATCH v12 03/11] HWBP: Add modify_local_hw_breakpoint_addr() API ---
> commit 894126e474a8f66ca7e12e6c727a417646ec68a9
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> HWBP: Add modify_local_hw_breakpoint_addr() API
> 
> This adds modify_local_hw_breakpoint_addr() to update the watched address
> of an installed hardware breakpoint on the local CPU without releasing and
> reserving its hardware slot. It is available when architectures select
> HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR.
> 
> Link: https://lore.kernel.org/all/f9c49dfa49bdc57ba8c0574bc9981c1e581acf92.1785067572.git.wangjinchao600@gmail.com/
> 
> > diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> > index 789add0c185a0..7d3a7bc050a40 100644
> > --- a/kernel/events/hw_breakpoint.c
> > +++ b/kernel/events/hw_breakpoint.c
> 
> [ ... ]
> 
> > @@ -888,6 +888,46 @@ void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)
> >  }
> >  EXPORT_SYMBOL_GPL(unregister_wide_hw_breakpoint);
> >  
> > +/**
> > + * modify_local_hw_breakpoint_addr - update a local breakpoint address
> > + * @bp: the hwbp perf event for this CPU
> > + * @addr: the new address for @bp
> > + *
> > + * Update only the address of an installed breakpoint on the local CPU without
> > + * releasing and reserving its hardware slot. The caller must update other CPUs.
> > + * Return 0, or -EOPNOTSUPP if the architecture does not support this operation.
> > + */
> > +#ifdef CONFIG_HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR
> > +int modify_local_hw_breakpoint_addr(struct perf_event *bp,
> > +				    unsigned long addr)
> > +{
> > +	unsigned long old_addr;
> > +	int ret;
> > +
> > +	lockdep_assert_irqs_disabled();
> > +
> > +	old_addr = bp->attr.bp_addr;
> > +	counter_arch_bp(bp)->address = addr;
> > +	bp->attr.bp_addr = addr;
> 
> [Severity: Medium]
> Could this early update of bp->attr.bp_addr lead to incorrect perf samples?
> 
> If an NMI triggers the hardware breakpoint on the old address before the
> hardware registers are updated and validated, the NMI handler might locklessly
> read the temporarily overwritten bp->attr.bp_addr. Would this attribute the
> sample to the new, potentially invalid address instead of the old one?
> 
> > +
> > +	ret = arch_modify_local_hw_breakpoint_addr(bp, addr);
> 
> [Severity: High]
> Does modifying the hardware debug address register without clearing the DR7
> enable bits violate x86 architectural guidelines?
> 
> When arch_modify_local_hw_breakpoint_addr() is called for x86:
> 
> arch/x86/kernel/hw_breakpoint.c:arch_modify_local_hw_breakpoint_addr() {
>     ...
>     do {
>         seq = this_cpu_inc_return(cpu_dr7_seq);
>         this_cpu_write(cpu_debugreg[i], addr);
>         barrier();
>         set_debugreg(addr, i);
>     } while (seq != this_cpu_read(cpu_dr7_seq));
>     ...
> }
> 
> Could this cause unpredictable hardware behavior since the Intel manual
> dictates that DR0-DR3 should only be modified when their corresponding
> enable bits in DR7 are clear?
> 
> [Severity: High]
> This is a pre-existing issue, but can the lockless traversal in the
> blacklist check lead to a use-after-free during module unload?
> 
> When parsing the breakpoint, the call chain goes through:
> arch_modify_local_hw_breakpoint_addr() -> hw_breakpoint_arch_parse() ->
> arch_build_bp_info() -> within_kprobe_blacklist()
> 
> kernel/kprobes.c:__within_kprobe_blacklist() {
>     ...
>     list_for_each_entry(ent, &kprobe_blacklist, list) {
>         if (addr >= ent->start_addr && addr < ent->end_addr)
>             return true;
>     }
>     ...
> }
> 
> If a module is unloaded concurrently, kprobe_remove_area_blacklist() deletes
> entries and immediately frees them with kfree(). Would a concurrent hardware
> breakpoint modification dereference freed memory here since kprobe_mutex
> is not held and RCU protection is not used?
> 
> > +	if (ret) {
> > +		counter_arch_bp(bp)->address = old_addr;
> > +		bp->attr.bp_addr = old_addr;
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/178611679753.237811.10190793347982785419.stgit@devnote2?part=3


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
