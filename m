Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279F5474F;
	Tue, 18 Aug 2026 22:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787092563; cv=none; b=saUBUNQTNy0ug0ZqpWOrUdVvFlEWYwI88d1paO5BVNuKUhpCHt84p20v2SyKdolM5UJn3KDld/sBir7PbLShZ0OTNOvf05e7Xh0OF5gzB0qQCcOwT9LC58LQXl/WYFB5XO5q6JS26JIvi5g0Lmo8SIoN5tfQAeCp7BvxsYonSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787092563; c=relaxed/simple;
	bh=p0pVl4RHAFDtpkAW8ycW1qAwl5+UQE7YH/xyNFog7yc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Izgf0QW+uZUxQgHXVwSIUxC83bfhkUEwMpYeLSKviHAdgtgRfh4a2oZqC8z0hvvAIAgDBNGHqjA67yt7aT5TjN7FUcEcwgabuabVxSESNrbuEPniUOE5JOU9n6thJvrkqSbebBrs6SlyyJ7rHYmMC68uwwvpLF2YUO8DoVFgArc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TviWhsMe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TviWhsMe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D91E1F000E9;
	Tue, 18 Aug 2026 22:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787092561;
	bh=mooCpwdivODcsxjJtipvJTFeDrXeFUytmXSLwgTfTDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TviWhsMezOQw/PtdIqDrJUXONka84O/XnmU8/JEhhILJrGlzGgsqzREWBk2LTB8oc
	 9ZXQhPtu/RPDbNrje6+abU73dU/J4kHiBY9xfivmSUwIUuMTDQne00MtJNDRD2NHQV
	 wgm5TE2YhGerTizRNYJ9Ppc3kuka+PeilWpqkscLOm+oio1Zw95V3sr4pqKV8QevVN
	 D8ybdRS4PsX/VLX63pFl87LnLuwiyBHziy+j1dseMl98eZ4MvU5MIBcBp83RWSRerT
	 zO9h6VnuME5iM295zcPhtxjRrGInCEytdTcbQ+UUwDRVFeEP9Ifcm2g7001G+UzdvS
	 /s/iqpIOGkgaw==
Date: Wed, 19 Aug 2026 07:35:55 +0900
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
Subject: Re: [PATCH v12 04/11] tracing/wprobe: Add wprobe (watchpoint probe)
 trace event support
Message-Id: <20260819073555.751f8d6a0772c84cfb21044c@kernel.org>
In-Reply-To: <77a90576-7142-4537-9e24-6fcefb0c6dde@gmail.com>
References: <178611679753.237811.10190793347982785419.stgit@devnote2>
	<178611684231.237811.7919346786503289720.stgit@devnote2>
	<77a90576-7142-4537-9e24-6fcefb0c6dde@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 19:51:22 +0800
Jinchao Wang <wangjinchao600@gmail.com> wrote:

[...]
> > +Synopsis of wprobe-events
> > +-------------------------
> > +::
> > +
> > +  w:[GRP/][EVENT] SPEC [FETCHARGS]                       : Probe on data access
> > +
> > + GRP            : Group name for wprobe. If omitted, use "wprobes" for it.
> > + EVENT          : Event name for wprobe. If omitted, an event name is
> > +                  generated based on the address or symbol.
> > + SPEC           : Breakpoint specification.
> > +                  [r|w|rw]@<ADDRESS|SYMBOL[[+|-]OFFS]>[:LENGTH]
> > +
> > +   r|w|rw       : Access type, r for read, w for write, and rw for both.
> > +                  Default is rw if omitted.
> > +   ADDRESS      : Address to trace (hexadecimal). MUST be in kernel space.
> > +   SYMBOL       : Symbol name to trace.
> > +   LENGTH       : Length of the data to trace in bytes. (1, 2, 4, or 8)
> 
> Should it show default value 4?

Ah, good catch!

> > +
> > +  FETCHARGS      : Arguments. Each probe can have up to 128 args.
> > +   $addr         : Fetch the accessing address.
> > +   $value        : Fetch the memory value at the accessing address (same as +0($addr)).
> > +   @ADDR         : Fetch memory at ADDR (ADDR should be in kernel)
> > +  @SYM[+|-offs] : Fetch memory at SYM +|- offs (SYM should be a data symbol)
> > +  +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*1)(\*2)
> > +  \IMM          : Store an immediate value to the argument.
> > +  NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
> > +  FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
> > +                  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
> > +                  (x8/x16/x32/x64), "char", "string", "ustring", "symbol", "symstr"
> > +                  and bitfield are supported.
> 
> FETCHARGS block is not aligned.

OK.

> 
> > +
> > +  (\*1) this is useful for fetching a field of data structures.
> > +  (\*2) "u" means user-space dereference.
> > +
> > +For the details of TYPE, see :ref:`kprobetrace documentation <kprobetrace_types>`.
> > +
> > +Usage examples
> > +--------------
> > +Here is an example to add a wprobe event on a variable `jiffies`.
> > +::
> > +
> > +  # echo 'w:my_jiffies w@jiffies' >> dynamic_events
> > +  # cat dynamic_events
> > +  w:wprobes/my_jiffies w@jiffies
> > +  # echo 1 > events/wprobes/enable
> > +  # cat trace | head
> > +  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > +  #              | |         |   |||||     |         |
> > +           <idle>-0       [000] d.Z1.  717.026259: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
> > +           <idle>-0       [000] d.Z1.  717.026373: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
> > +
> > +You can see the code which writes to `jiffies` is `tick_do_update_jiffies64()`.
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > index 5cbd09c8be8d..43ffd9a76d88 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -337,6 +337,7 @@ enum {
> >  	TRACE_EVENT_FL_UPROBE_BIT,
> >  	TRACE_EVENT_FL_EPROBE_BIT,
> >  	TRACE_EVENT_FL_FPROBE_BIT,
> > +	TRACE_EVENT_FL_WPROBE_BIT,
> >  	TRACE_EVENT_FL_CUSTOM_BIT,
> >  	TRACE_EVENT_FL_TEST_STR_BIT,
> >  };
> > @@ -367,6 +368,7 @@ enum {
> >  	TRACE_EVENT_FL_UPROBE		= (1 << TRACE_EVENT_FL_UPROBE_BIT),
> >  	TRACE_EVENT_FL_EPROBE		= (1 << TRACE_EVENT_FL_EPROBE_BIT),
> >  	TRACE_EVENT_FL_FPROBE		= (1 << TRACE_EVENT_FL_FPROBE_BIT),
> > +	TRACE_EVENT_FL_WPROBE		= (1 << TRACE_EVENT_FL_WPROBE_BIT),
> >  	TRACE_EVENT_FL_CUSTOM		= (1 << TRACE_EVENT_FL_CUSTOM_BIT),
> >  	TRACE_EVENT_FL_TEST_STR		= (1 << TRACE_EVENT_FL_TEST_STR_BIT),
> >  };
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index 0ab5916575a9..b58c2565024f 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -862,6 +862,19 @@ config EPROBE_EVENTS
> >  	  convert the type of an event field. For example, turn an
> >  	  address into a string.
> >  
> > +config WPROBE_EVENTS
> > +	bool "Enable wprobe-based dynamic events"
> > +	depends on TRACING
> > +	depends on HAVE_HW_BREAKPOINT
> > +	select PROBE_EVENTS
> > +	select DYNAMIC_EVENTS
> > +	help
> > +	  This allows the user to add watchpoint tracing events based on
> > +	  hardware breakpoints on the fly via the ftrace interface.
> > +
> > +	  Those events can be inserted wherever hardware breakpoints can be
> > +	  set, and record accessed memory address and values.
> > +
> >  config BPF_EVENTS
> >  	depends on BPF_SYSCALL
> >  	depends on (KPROBE_EVENTS || UPROBE_EVENTS) && PERF_EVENTS
> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > index f934ff586bd4..141c8323de20 100644
> > --- a/kernel/trace/Makefile
> > +++ b/kernel/trace/Makefile
> > @@ -126,6 +126,7 @@ obj-$(CONFIG_FTRACE_RECORD_RECURSION) += trace_recursion_record.o
> >  obj-$(CONFIG_FPROBE) += fprobe.o
> >  obj-$(CONFIG_RETHOOK) += rethook.o
> >  obj-$(CONFIG_FPROBE_EVENTS) += trace_fprobe.o
> > +obj-$(CONFIG_WPROBE_EVENTS) += trace_wprobe.o
> >  
> >  obj-$(CONFIG_TRACEPOINT_BENCHMARK) += trace_benchmark.o
> >  obj-$(CONFIG_RV) += rv/
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 19cc07360005..4ebece96d8b7 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -4294,8 +4294,12 @@ static const char readme_msg[] =
> >  	"  uprobe_events\t\t- Create/append/remove/show the userspace dynamic events\n"
> >  	"\t\t\t  Write into this file to define/undefine new trace events.\n"
> >  #endif
> > +#ifdef CONFIG_WPROBE_EVENTS
> > +	"  wprobe_events\t\t- Create/append/remove/show the hardware breakpoint dynamic events\n"
> > +	"\t\t\t  Write into this file to define/undefine new trace events.\n"
> > +#endif
> >  #if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS) || \
> > -    defined(CONFIG_FPROBE_EVENTS)
> > +    defined(CONFIG_FPROBE_EVENTS) || defined(CONFIG_WPROBE_EVENTS)
> >  	"\t  accepts: event-definitions (one definition per line)\n"
> >  #if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS)
> >  	"\t   Format: p[:[<group>/][<event>]] <place> [<args>]\n"
> > @@ -4305,6 +4309,9 @@ static const char readme_msg[] =
> >  	"\t           f[:[<group>/][<event>]] <func-name>[%return] [<args>]\n"
> >  	"\t           t[:[<group>/][<event>]] <tracepoint> [<args>]\n"
> >  #endif
> > +#ifdef CONFIG_WPROBE_EVENTS
> > +	"\t           w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]\n"
> 
> missing [<args>]

Oops, let me fix it.

Thanks!

> 
> > +#endif
> >  #ifdef CONFIG_HIST_TRIGGERS
> >  	"\t           s:[synthetic/]<event> <field> [<field>]\n"
> >  #endif
> 
> Thanks,
> Jinchao
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
