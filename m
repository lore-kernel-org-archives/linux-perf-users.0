Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FCB1F63D9;
	Tue, 18 Aug 2026 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787093793; cv=none; b=o6i/yzV4z1QDbjqyGJz132mYsIGWeB/ZGIi5rzPRODiU1epFOPDlrMHWrG5G8ujC9gGVNj6siKJe3Fb/MmIEjfZlqBbx1MmSgcHdAuwYalyMqMvA+bMZI0ZMy2gRshKJm93tID/ixduJhyv7goevjSe2D7bfVXTHnDfqZaKtdQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787093793; c=relaxed/simple;
	bh=faMKR1rbgxXHtkQpw5a1Tw5wko3xKGUPNA0L/xuNmts=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p6E3pSr92KU7Eeg79yA+RwyX/N0guwenB22IJI0M7oEw6TmmXtdqFYxPpQx+89ESBMQPe6/B/nDlwwxew/xol4GbX48yCMKHOf3USyIHXjEEKS9tDoUw83T2h+fEGEyko8zq578ufgBCzB5jUV1rnunkQJxGpFh8UbZL1vCstwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beOmcgFg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beOmcgFg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D0C1F000E9;
	Tue, 18 Aug 2026 22:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787093792;
	bh=a7AbzolX3oxsjZ/EW6/COzIpdkV3NkowEJ9wyZ/wdFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=beOmcgFgtoaRx5qshfXhaXkcd9gVYVvm0nBwlD4leVnBH6gzCsyKPKCnhvJyBDqEQ
	 QIomoXzSKEpqxGoxSu/JIHKx3jRCEMTiHbT7poX1ya5mhqUKAf/xmhedAn4Lagurqx
	 dOGwDmae5vdTDGGcML2kmOcAOXOz1OBvf6P3Vd2k03uXFCh79PgZPatK7QoezxFtx5
	 AR6Qe4OZjWryA4cWAIqpHTRFFAvFk+M8WmsBeph1t3/hdQqvJ/HD7+lzYi1B826wHE
	 WJOftSE/+adEBHOrNnQNkq2UiY68NdQR+ScwlcPSB64rs1D3hDgnDkTSUidUwofV2H
	 w1NKToGpHxQ4A==
Date: Wed, 19 Aug 2026 07:56:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers
 <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v12 05/11] x86: hw_breakpoint: Add a kconfig to clarify
 when a breakpoint fires
Message-Id: <20260819075626.84cdb95c8351c26de1ffc3ab@kernel.org>
In-Reply-To: <d80c8e99-7062-4d41-b47f-e45f1dde5745@gmail.com>
References: <178611679753.237811.10190793347982785419.stgit@devnote2>
	<178611685388.237811.14452013458905879452.stgit@devnote2>
	<d80c8e99-7062-4d41-b47f-e45f1dde5745@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 20:10:58 +0800
Jinchao Wang <wangjinchao600@gmail.com> wrote:

> On 8/7/2026 11:34 PM, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add CONFIG_HAVE_POST_BREAKPOINT_HOOK which indicates the hw_breakpoint
> > on that architecture fires after the target memory has been modified.
> > This is currently x86 only behavior.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v11:
> >   - Move select to alphabetically sorted place.
> > ---
> >  arch/Kconfig         |   10 ++++++++++
> >  arch/x86/Kconfig     |    1 +
> >  kernel/trace/Kconfig |    1 +
> >  3 files changed, 12 insertions(+)
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index bea383408e32..a096952987a8 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -457,6 +457,16 @@ config HAVE_MIXED_BREAKPOINTS_REGS
> >  	  Select this option if your arch implements breakpoints under the
> >  	  latter fashion.
> >  
> > +config HAVE_POST_BREAKPOINT_HOOK
> > +	bool
> > +	depends on HAVE_HW_BREAKPOINT
> > +	help
> > +	  Depending on the arch implementation of hardware breakpoints,
> > +	  some of them provide breakpoint hook after the target memory
> > +	  is modified.
> > +	  Select this option if your arch implements breakpoints overflow
> > +	  handler hooks after the target memory is modified.
> > +
> >  config HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR
> >  	bool
> >  	depends on HAVE_HW_BREAKPOINT
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 33908103d9a0..533010ab29a9 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -287,6 +287,7 @@ config X86
> >  	select MMU_GATHER_RCU_TABLE_FREE
> >  	select MMU_GATHER_MERGE_VMAS
> >  	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
> > +	select HAVE_POST_BREAKPOINT_HOOK
> >  	select HAVE_REGS_AND_STACK_ACCESS_API
> >  	select HAVE_RELIABLE_STACKTRACE		if UNWINDER_ORC || STACK_VALIDATION
> >  	select HAVE_FUNCTION_ARG_ACCESS_API
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index b58c2565024f..d9b6fa5c35d9 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -866,6 +866,7 @@ config WPROBE_EVENTS
> >  	bool "Enable wprobe-based dynamic events"
> >  	depends on TRACING
> >  	depends on HAVE_HW_BREAKPOINT
> > +	depends on HAVE_POST_BREAKPOINT_HOOK
> >  	select PROBE_EVENTS
> >  	select DYNAMIC_EVENTS
> >  	help
> > 
> Reviewed-by: Jinchao Wang <wangjinchao600@gmail.com>

Thank you for your review!

I'll update this series.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
