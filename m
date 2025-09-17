Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D780B1EF363;
	Wed, 17 Sep 2025 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119905; cv=none; b=JTLUFwA4DIDUs/TWlZ5pRJ4AZqHX9QU3ny4oPeIPy48pvUE6/Y+T9OZqJspiNaLbu+SuaPxiFzK7XucPsVYUnMnikp8Q26q4/z+OVSTmHDE/65jwYNxpNxHFAn5Dw02IlFg4Gjmi8kPyZTZZCvaKO6Enq5QBVrIsi2BS6jxk1Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119905; c=relaxed/simple;
	bh=JUOAYdT860eucBNczbVANNdcaqnUWi74UuVf01tr4rg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SSX6ByS14W4zqz4HGRebNWtx7JXvcZr6Kf1ZIuPKR5oVBDdFp5jyjP2nEoqyJ2Fc8thikYBw9JEK2d4t5LwsOHW+ecGQ6UHxA2Lmf8E4YJzrJZOypYxAmq8YQX41Upt7Y3FdTeoeHZvmzfENJAcYw+gh8LX/vGUrtKw6dSFhCVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edYel4cY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edYel4cY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8FFC4CEE7;
	Wed, 17 Sep 2025 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758119904;
	bh=JUOAYdT860eucBNczbVANNdcaqnUWi74UuVf01tr4rg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=edYel4cYDGAgEtEFofgM90xqvX8MYZTmQlkOdEznPSp7tEbYOqf/of3DfJhpGFICg
	 AG2Ff/WETrM1UAfpQuyACeE72peP8+fDkK2DNo+rrTRSIFpbnpVKe5WBSj7nyRcUd5
	 aTwAlm3s0evW7WcGqHWDKxNh8GDXze/2+qrCTMZk3jz5NtSKMa4I1Zscjxd+ZUl/bT
	 mkjn6kOKYXqlXxWyzZrz8xZxFgrgREGamJ3rGUIZtGztnAg8QAZSVfa01OldMfBXgH
	 md6Pf911vriZEDztQUjb5jL9J6wVxZT4L3654czOdOToJJQorQBEiPw9y96bc3bKgG
	 W5GLADbztm9Zw==
Date: Wed, 17 Sep 2025 23:38:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
 Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 1/8] tracing: wprobe: Add watchpoint probe event
 based on hardware breakpoint
Message-Id: <20250917233818.71678d0164a6fc2d11fa6e38@kernel.org>
In-Reply-To: <014136d2-8599-4a1f-ab8e-c5be4f522e5a@infradead.org>
References: <175785897434.234168.6798590787777427098.stgit@devnote2>
	<175785898586.234168.14883193853242691280.stgit@devnote2>
	<014136d2-8599-4a1f-ab8e-c5be4f522e5a@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Randy,

On Sun, 14 Sep 2025 17:14:37 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:
> > +  w:[GRP/][EVENT] SPEC [FETCHARGS]                       : Probe on data access
> > +
> > + GRP            : Group name for wprobe. If omitted, use "wprobes" for it.
> > + EVENT          : Event name for wprobe. If omitted, an event name is
> > +                  generated based on the address or symbol.
> > + SPEC           : Breakpoint specification.
> > +                  [r|w|rw]@<ADDRESS|SYMBOL[+|-OFFS]>[:LENGTH]
> > +
> > +   r|w|rw       : Access type, r for read, w for write, and rw for both.
> > +                  Use rw if omitted.
> 
> 		     Default is rw if omitted.

OK.

> 
> > +   ADDRESS      : Address to trace (hexadecimal).
> > +   SYMBOL       : Symbol name to trace.
> > +   LENGTH       : Length of the data to trace in bytes. (1, 2, 4, or 8)
> > +
> > + FETCHARGS      : Arguments. Each probe can have up to 128 args.
> > +  $addr         : Fetch the accessing address.
> > +  @ADDR         : Fetch memory at ADDR (ADDR should be in kernel)
> > +  @SYM[+|-offs] : Fetch memory at SYM +|- offs (SYM should be a data symbol)
> > +  +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*1)(\*2)
> > +  \IMM          : Store an immediate value to the argument.
> > +  NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
> > +  FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
> > +                  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
> > +                  (x8/x16/x32/x64), "char", "string", "ustring", "symbol", "symstr"
> > +                  and bitfield are supported.
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

Note, I also found this is not head, but combined with tail,
e.g. `cat trace | head -n 15 | tail -n 5`

> > +  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > +  #              | |         |   |||||     |         |
> > +           <idle>-0       [000] d.Z1.  717.026259: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
> > +           <idle>-0       [000] d.Z1.  717.026373: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
> > +
> > +You can see the code which writes to `jiffies` is `do_timer()`.
> 
> I'm having trouble getting from tick_do_update_jiffies64+0xbe/0x130,
> which I expect is
> 	jiffies_64 += ticks;
> in that function, over to do_timer(), which also updates jiffies_64,
> but is not called by tick_do_update_jiffies64(). AFAICT, there are
> no calls to do_timer() in the file (kernel/time/tick-sched.c).
> 
> Can you explain, please?

Hmm, in my code base

static void tick_do_update_jiffies64(ktime_t now)
{
	...
	} else {
		last_jiffies_update = ktime_add_ns(last_jiffies_update,
						   TICK_NSEC);
	}

	/* Advance jiffies to complete the 'jiffies_seq' protected job */
	jiffies_64 += ticks;

	...

So this function seems correctly update the jiffies_64.
If you ask about where it comes from, I can also enable stacktrace on
that event. (echo 1 >> options/stacktrace)

             cat-124     [005] d.Z1.   537.689753: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
             cat-124     [005] d.Z1.   537.689762: <stack trace>
 => tick_do_update_jiffies64
 => tick_nohz_handler
 => __hrtimer_run_queues
 => hrtimer_interrupt
 => __sysvec_apic_timer_interrupt
 => sysvec_apic_timer_interrupt
 => asm_sysvec_apic_timer_interrupt

So it came from hrtimer_interrupt().

> 
> 
> 
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index d2c79da81e4f..dd8919386425 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -807,6 +807,20 @@ config EPROBE_EVENTS
> >  	  convert the type of an event field. For example, turn an
> >  	  address into a string.
> >  
> > +config WPROBE_EVENTS
> > +	bool "Enable wprobe-based dynamic events"
> > +	depends on TRACING
> > +	depends on HAVE_HW_BREAKPOINT
> > +	select PROBE_EVENTS
> > +	select DYNAMIC_EVENTS
> > +	default y
> 
> Wny default y?

No big reason. This is just a dynamic event and unless the super user
adds this event this does not work on the system. I can make it N so
developer can enable it when builds their kernel.

Thank you,

> 
> > +	help
> > +	  This allows the user to add watchpoint tracing events based on
> > +	  hardware breakpoints on the fly via the ftrace interface.
> > +
> > +	  Those events can be inserted wherever hardware breakpoints can be
> > +	  set, and record various register and memory values.
> > +
> >  config BPF_EVENTS
> >  	depends on BPF_SYSCALL
> >  	depends on (KPROBE_EVENTS || UPROBE_EVENTS) && PERF_EVENTS
> 
> 
> thanks.
> -- 
> ~Randy
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
