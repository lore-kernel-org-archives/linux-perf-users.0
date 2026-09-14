Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44200378838;
	Mon, 14 Sep 2026 05:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789362803; cv=none; b=lYMAFpaDGHSbMJinDAw/rb+gCO39x9jT5Dmo0SUJvPeIhxYLNhf/J3ZbnOQ3uevgdshMLdZoU/U0cMMezOxIrKpnKPKB5ABsG4l+eP9xJSTY3LoDgFHIw76SIbC0S0vJiO7yD1UL9zyr5Y9gV8HjlWogdyNdWooqMuMK2vaY1v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789362803; c=relaxed/simple;
	bh=ShlXuzxZadkMUnumu1QyerviMgXXNhLujivlqa0nfII=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=enxOt+Rk3PbX0RdkndO+311YFaLRq2HWR0aNrmTypG+gGoKpHifV/cLHjyzcU7qZDcclIppU53iKO0nMi/1dX6s1y7i9Xo2hwwkin/xBgpP6nLl3kEuCw9dHE6wYxTmqoJ2Q4hjRbCroo0X8w2+/+klhJYDoj+QiX+63G7iAKl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ9jmaGX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ9jmaGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6D91F000FF;
	Mon, 14 Sep 2026 05:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789362801;
	bh=n3wP1PcBp2+a+o/VLRpTfm9jZUMQauV7lmYuzs9dqlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fZ9jmaGXC6Fa8AdCItt5L/gUqwfke2JU82ubnyPzu7aUUbaR9Z1AaTjLwaECFOUU4
	 GyH9FTHtOOmrIdqxuXgXM7KW/+5SSOXd56YX8Zd7xAhs++D7VVIPV8h4rp2XzRXFow
	 5FbzzDXwZNkbk/3OkjpMIvZ4wbDCzJvJ87lWTtBBLSxGrm3VbaTzue7GlRqneur3RF
	 jnJPgGT8v7XW1WEr5uSfPBoWzYp5XgPsQFIRjCniRem79V1nXXKxPLhn7r2MVeMfU+
	 HkM3Cpf9w9wN/ixoj2xZfP0j3t2euVILeqx0iGwTxLXXJtUBVg2vVg7aDmeQl3VMXq
	 1OYBrjv5sdNEQ==
Date: Mon, 14 Sep 2026 14:13:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v15 03/12] x86/hw_breakpoints: Add
 arch_modify_local_hw_breakpoint_addr() API
Message-Id: <20260914141318.0a8d12d9cceb3a50bb3d36f5@kernel.org>
In-Reply-To: <20260907040203.BA2941F00A3A@smtp.kernel.org>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
	<178875281237.93794.4844650709915505895.stgit@devnote2>
	<20260907040203.BA2941F00A3A@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 07 Sep 2026 04:02:03 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Modifying a debug address register while the breakpoint is enabled in DR7 violates the Intel SDM. This can occur due to a race condition with an NMI because the `cpu_dr7` shadow state is not temporarily updated.
> --
> 
> commit ca38cc4e9ed0533dfe16175c78dba60903420a8b
> Author: Jinchao Wang <wangjinchao600@gmail.com>
> 
> x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API
> 
> Wprobe needs to move an active per-CPU watchpoint without releasing and
> reserving its hardware slot.
> 
> Add arch_modify_local_hw_breakpoint_addr() as the architecture backend for
> modify_local_hw_breakpoint_addr(). It validates the new address, finds the
> installed local slot, and updates the hardware debug register and per-CPU
> shadow register.
> 
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com/
> 
> > diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> > index 312550be3ad2b..99f0926298a85 100644
> > --- a/arch/x86/kernel/hw_breakpoint.c
> > +++ b/arch/x86/kernel/hw_breakpoint.c
> [ ... ]
> > @@ -129,6 +129,62 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
> [ ... ]
> > +	do {
> > +		seq = this_cpu_inc_return(cpu_dr7_seq);
> > +
> > +		/* Disable breakpoint in DR7 before updating address register */
> > +		dr7 = this_cpu_read(cpu_dr7);
> > +		set_debugreg((dr7 & ~__encode_dr7(i, info->len, info->type)) | DR7_FIXED_1, 7);
> 
> [Severity: High]
> Does arch_modify_local_hw_breakpoint_addr() need to clear the breakpoint in
> the shadow cpu_dr7 state as well?

Ah, OK, let's update cpu_dr7 too.

> 
> Since the breakpoint isn't cleared in the cpu_dr7 shadow state, could an NMI
> that interrupts execution here inadvertently re-enable the breakpoint
> prematurely?
> 
> If an NMI handler (such as kgdb or perf) modifies breakpoints, it increments
> cpu_dr7_seq and invokes local_db_save() and local_db_restore(). When the NMI
> completes, local_db_restore() detects the sequence mismatch and restores
> hardware DR7 using the cpu_dr7 shadow cache. Because cpu_dr7 still has this
> breakpoint enabled, the target breakpoint gets re-enabled in hardware DR7
> before the execution below resumes.
> 
> > +		barrier();
> > +
> > +		this_cpu_write(cpu_debugreg[i], addr);
> > +		barrier();
> > +		set_debugreg(addr, i);
> 
> [Severity: High]
> If an NMI prematurely restored DR7 as described above, won't this modify the
> debug address register while the breakpoint is enabled in DR7?

This also needs to update cpu_dr7.

Thank you,

> 
> Modifying a debug address register while its corresponding DR7 enable bit is
> set violates the Intel SDM and causes spurious #DB exceptions.
> 
> While the sequence loop retry mechanism will catch the mismatch, it only does
> so after this instruction has already executed, which is too late to prevent
> the spurious exception.
> 
> > +		barrier();
> > +
> > +		/* Re-enable breakpoint in DR7 */
> > +		set_debugreg(this_cpu_read(cpu_dr7) | DR7_FIXED_1, 7);
> > +		barrier();
> > +	} while (seq != this_cpu_read(cpu_dr7_seq));
> > +
> > +	return 0;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/178875277830.93794.14247844688761142429.stgit@devnote2?part=3


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
