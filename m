Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FFB379966;
	Wed, 19 Aug 2026 23:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787183701; cv=none; b=NAFyHHN47VPtORi2SM3gfZBaBC94laaplPM0tY5u0oErBkfcvBIfdvGl49bww9Hay7NuDs7OT93FOjbsXZkkkgcchw1j6emf3C3ecb4dt3jefbQGgbhUydezkzA05U9wzvjRb4cSh+YactAIZUQft3SiFdZ5WhtVnOpQgOMsUpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787183701; c=relaxed/simple;
	bh=gs9hvltnsfszTrvLTk7QgFw8EQK8T2X6k/hezkhhHlg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P6iy3NAsMRgvWPwsfzDdZKu8GhjasuAD7cMzcR+Ry/q1RLZVebSd2lyeYQ5slrDLse52DwLuF6MWGCbknDlCXRc/Ts3LNUMQVEPYKdqr5iCVuU1sejz/bbN7PVt/3hy/mJlahD/9uhCGFJIL3xmLGq0lHDdxCIdiZh0Qt8Mw05s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9S4S5ul; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9S4S5ul"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A777F1F000E9;
	Wed, 19 Aug 2026 23:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787183699;
	bh=B0ytyDnWFNUv0OEEnTR1U8wLe6Cq77wdZFOAEOYvuTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=W9S4S5ulezMkDW3twRMJ6dVHmet+74EZ0y64hXJqtZjXzbyvsaLmeloiBNuLV/sF5
	 7isx1slQBEj+7YRD4LUQRT9lgZaN1JQpkSP/H743NllLAqP686sH6WocrqiWJLGBip
	 8WkykqwQJn5pHh+GW9MfPoVTWZsOtChXKA6j9fIWpGER34E/asNya9egph7jBKNtxi
	 p2KTRQcinD3gSacmemoolPUK7qtsmUdI1uaGMWNaHFQcdE1iKrD+qoCMyvTbrvWrz6
	 6g18H39P62BlXTgDA2z+1YKAz1MO/HVk8phqXlg0KQewAjaQaQ5Ga1vdXeqFqM4+yc
	 zNDMQ2q9OXXPg==
Date: Thu, 20 Aug 2026 08:54:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v12 02/11] x86/hw_breakpoints: Add
 arch_modify_local_hw_breakpoint_addr() API
Message-Id: <20260820085456.c9f2f51135d03093692feace@kernel.org>
In-Reply-To: <20260807155051.528FB1F000E9@smtp.kernel.org>
References: <178611679753.237811.10190793347982785419.stgit@devnote2>
	<178611682030.237811.16459191503595231339.stgit@devnote2>
	<20260807155051.528FB1F000E9@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 07 Aug 2026 15:50:50 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] arch_modify_local_hw_breakpoint_addr updates the hardware and shadow registers but fails to update the perf_event's canonical software state, leading to silent hardware reverts and incorrect event samples.
> --
> 
> --- Patch [2]: [PATCH v12 02/11] x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API ---
> commit bbc277e839d1fd31bb4bfa9d695721e5b6899bf6
> Author: Jinchao Wang <wangjinchao600@gmail.com>
> 
> x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API
>     
> Wprobe needs to move an active per-CPU watchpoint without releasing and
> reserving its hardware slot.
>     
> Add arch_modify_local_hw_breakpoint_addr() to find the installed local
> slot and update only its address shadow and hardware debug address
> register. Publish the shadow first so hw_breakpoint_restore() observes
> the new address if an NMI interrupts the update.
> 
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com/
> 
> > diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> > index 9ef24b55737f8..c89f6e71c3a91 100644
> > --- a/arch/x86/kernel/hw_breakpoint.c
> > +++ b/arch/x86/kernel/hw_breakpoint.c
> 
> [ ... ]
> 
> > @@ -128,6 +128,39 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
> >  	return 0;
> >  }
> >  
> > +int arch_modify_local_hw_breakpoint_addr(struct perf_event *bp,
> > +					  unsigned long addr)
> > +{
> > +	struct arch_hw_breakpoint hw;
> > +	struct perf_event_attr attr = bp->attr;
> > +	unsigned int seq;
> > +	int i, ret;
> > +
> > +	lockdep_assert_irqs_disabled();
> > +
> > +	attr.bp_addr = addr;
> > +	ret = hw_breakpoint_arch_parse(bp, &attr, &hw);
> > +	if (ret)
> > +		return ret;
> 
> [Severity: High]
> Does this discard the validated software state?
> 
> The new address configuration is successfully validated into the local 'hw'
> struct, but neither the architecture-specific state (counter_arch_bp(bp))
> nor the core attribute (bp->attr.bp_addr) are updated.

Yes, if it is sololy used. But in the 3rd patch, this function is only
called from modify_local_hw_breakpoint_addr(), which updates
counter_arch_bp(bp)->address. I will add this as a comment.

> 
> If the breakpoint is later re-installed (e.g., during CPU offline/online or
> PMU scheduling), arch_install_hw_breakpoint() will read the stale address:
> 
>     struct arch_hw_breakpoint *info = counter_arch_bp(bp);
>     ...
>     this_cpu_write(cpu_debugreg[i], info->address);
>     barrier();
>     set_debugreg(info->address, i);
> 
> Could this silently revert the hardware register back to the old address?
> 
> Also, if a watchpoint fires, perf_bp_event() initializes the sample record
> using the unmodified bp->attr.bp_addr. Could this result in reporting
> incorrect addresses in the trace output?

trace_wprobe ensures the hit address and modified bp->attr.bp_addr are the
same. So there should be no problem.

Thanks,

> 
> > +
> > +	for (i = 0; i < HBP_NUM; i++) {
> > +		if (this_cpu_read(bp_per_reg[i]) == bp)
> > +			break;
> > +	}
> > +
> > +	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
> > +		return -ENOENT;
> > +
> > +	do {
> > +		seq = this_cpu_inc_return(cpu_dr7_seq);
> > +		this_cpu_write(cpu_debugreg[i], addr);
> > +		barrier();
> > +		set_debugreg(addr, i);
> > +	} while (seq != this_cpu_read(cpu_dr7_seq));
> > +
> > +	return 0;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/178611679753.237811.10190793347982785419.stgit@devnote2?part=2


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
