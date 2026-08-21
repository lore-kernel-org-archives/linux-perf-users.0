Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1939F2F8EB0;
	Fri, 21 Aug 2026 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787271717; cv=none; b=o8x+r/Fl6W28kwDVMRs5iyj/wsLeVKGuJwMz2O9Fgo7Nb9NsKbTYV73YzKuhVTs7/wFp3KaR5nZsW2sVDzdzhlPy5r2HGEjHGdkC/4jqf84a5X0iQIlQbfMAli1mIL4nmCo/ZTx1YmeF0IbOi3Hex4zoaNTUU14wg12+EfB6gj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787271717; c=relaxed/simple;
	bh=Jcz+0BWZDNWBQVICYjCSYnSxeHc4575FMCArO56Ha7I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=vBLagPmI3lu2xfjlfaQbM0e6LAOeflpIfdTo2Z8sUE2Kw/eo0RGtZ0R+u/agDr3TxocRz3dDETEjswRCa4Ecn+cI7Lcc3y7ORH+GwXXw0s2d3PnoxVcrWKPfCY0hqWpRD897vGlRIToGNu6ymnTqzRl2dnMCqLiYaoW07pvhEJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWOtq9XV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWOtq9XV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5121F000E9;
	Fri, 21 Aug 2026 00:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787271715;
	bh=exIqFMU7xCz5g9CvaeiP3JATBiFjTVCCue3XWsLnc2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CWOtq9XV+zL/Vy7zPqmHyxNq0Q78zHkaNe646R8Y1Q6hdakWyrWNHOPhlEreUcMjx
	 nIYXfSTgptxsLsLPx6g2JAJXPpqYsUZKnzZtTSMF1tt/8193jkTFzhm+AjjnmBvf/L
	 u18zPXgvhBO6cwwt6GqDdYb5ZbMeky1A2VwwrUNC6Am2y7zHbYtGo2OaXmwqAQ0xkp
	 ZSiMDTn3HBf3WuxmrtOnmVpT2HMGLgC/ZZQut8P61tyvCaEp0xaNkpJze44Hf+ThAF
	 T1PFXJ/3rWpIU0fg7AGx9CkQ1aht1FWrCtD1lly3I7zpapmKhOC8Z0hsFT2RzNhysJ
	 67hk48Zahou7w==
Date: Fri, 21 Aug 2026 09:21:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v12 04/11] tracing/wprobe: Add wprobe (watchpoint probe)
 trace event support
Message-Id: <20260821092152.7277764586f275edcd7bf09d@kernel.org>
In-Reply-To: <20260807155914.DDAD21F000E9@smtp.kernel.org>
References: <178611679753.237811.10190793347982785419.stgit@devnote2>
	<178611684231.237811.7919346786503289720.stgit@devnote2>
	<20260807155914.DDAD21F000E9@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 07 Aug 2026 15:59:14 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Hardware breakpoints are not synchronized with module unloads, leading to dangling breakpoints on reallocated memory.
> --
> 
> --- Patch [4]: [PATCH v12 04/11] tracing/wprobe: Add wprobe (watchpoint probe) trace event support ---
> commit 6f99af1ed7b9527ff7af700fbd99ed2a3d0632d9
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> tracing/wprobe: Add wprobe (watchpoint probe) trace event support
> 
> This commit adds wprobe, a hardware-breakpoint-based dynamic trace event.
> It allows users to monitor memory accesses by setting hardware breakpoints
> on specified addresses or symbols and logging the access context.
> 
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com/
> 
> > diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> > new file mode 100644
> > index 0000000000000..df592d9280a47
> > --- /dev/null
> > +++ b/kernel/trace/trace_wprobe.c
> [ ... ]
> > +static int __register_trace_wprobe(struct trace_wprobe *tw)
> > +{
> > +	struct perf_event_attr attr;
> > +	int i, ret;
> [ ... ]
> > +	hw_breakpoint_init(&attr);
> > +	attr.bp_addr = tw->addr;
> > +	attr.bp_len = tw->len;
> > +	attr.bp_type = tw->type;
> > +
> > +	tw->bp_event = register_wide_hw_breakpoint(&attr, wprobe_perf_handler, tw);
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> [Severity: Medium]
> When a watchpoint probe is created for a module symbol, does this leave a
> dangling hardware breakpoint if the module is later unloaded?
> 
> Since the wprobe subsystem doesn't seem to register a module notifier
> (unlike kprobes) to clean up when modules are unloaded, the breakpoint stays
> active on the raw virtual address. If that memory is freed and subsequently
> reallocated for a different module or vmalloc allocation, could this lead
> to spurious trace events and unintended performance overhead on the reused
> memory?

Yeah, but this wprobe is for debugging feature, so it will be used for
tracking UAF too. Thus I would like to keep this as it is now.
We can add module symbol support (e.g. :mod:sym instead of sym) but that
should be done as a different improvement.

Thanks,
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
