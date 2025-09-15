Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2754E1B7F4;
	Mon, 15 Sep 2025 00:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757895290; cv=none; b=Qypj8fyZbHbDLcA4A3YoNlqEwp0TvCeFoW9zcLJr3YR9s5fXqotGbW6dVOMkyod2sfNBCQ+dv/72aUWgm1ur0JZuYPKowkHh2BBqk5egvoUqbq9Cc1l0efSqVCl24JngaTs1JBXeGvgx7sRpK2dVwiziKS5mAa1rayJkpu0E16M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757895290; c=relaxed/simple;
	bh=0F9Yp4zNl0AucLaX6oAKMyZWSX8vhjlpCLDzKaOBEd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLeND70oJODjc7SWnMayjr+qPqUuqpa1l4zL1DRh7GrXBargwAEPxDVVJLRzWWRp4daINI1HnQgCU6dtc14GfTvasf0h1eiN27GV+yiSGB98hp7WUczyJiSS/Mt5mFKUzAU4wahrE9EHLs5sZ9IfYuvB7kNx08oL0A54B+kduKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O5n1QXv9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O5n1QXv9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=VUsMzAXAbgmvKmfkMAHLRN/OrGD90gmMBytN0Ftnky0=; b=O5n1QXv9rSXJ9CbDyQ9L4Ocs1q
	1tGd//FycPbea4oGqRJ9UsAF9AF95bQw2ZQwROmquBrYaF4074k0BOZYxLhyrY24Q1RqmaUJ2u1rh
	lQEm7iftW/mIUQM4Snr+jtq2GRL/e7+qpareMjy1zbvVIidEJ5pSaq6yH43vo6VM4wAtocMC4aNDg
	vJuP1Yi+w/86DD516+MY6/tCbFbFD34kfFfbSg0rfV/Uc+bB3mPYpUeA2UKDdnICPDg13nwHSUaYA
	E8bgxkf0y1G5atJVXN1gMf1OHJazPI7tg84AKF/1PZEdahKQJKUPe5u+pgtXxFeaEjTrI9UIBPxte
	YJapVfKQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxwrf-00000002Ooa-2CYC;
	Mon, 15 Sep 2025 00:14:39 +0000
Message-ID: <014136d2-8599-4a1f-ab8e-c5be4f522e5a@infradead.org>
Date: Sun, 14 Sep 2025 17:14:37 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] tracing: wprobe: Add watchpoint probe event based
 on hardware breakpoint
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <175785897434.234168.6798590787777427098.stgit@devnote2>
 <175785898586.234168.14883193853242691280.stgit@devnote2>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <175785898586.234168.14883193853242691280.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/14/25 7:09 AM, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add a new probe event for the hardware breakpoint called wprobe-event.
> This wprobe allows user to trace (watch) the memory access at the
> specified memory address.
> The new syntax is;
> 
>  w[:[GROUP/]EVENT] [r|w|rw]@[ADDR|SYM][:SIZE] [FETCH_ARGs]
> 
> User also can use $addr to fetch the accessed address. But no other
> variables are supported. To record updated value, use '+0($addr)'.
> 
> For example, tracing updates of the jiffies;
> 
>  /sys/kernel/tracing # echo 'w:my_jiffies w@jiffies' >> dynamic_events
>  /sys/kernel/tracing # cat dynamic_events
>  w:wprobes/my_jiffies w@jiffies:4
>  /sys/kernel/tracing # echo 1 > events/wprobes/my_jiffies/enable
>  /sys/kernel/tracing # head -n 20 trace | tail -n 5
>  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>  #              | |         |   |||||     |         |
>           <idle>-0       [000] d.Z1.   206.547317: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
>           <idle>-0       [000] d.Z1.   206.548341: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
>           <idle>-0       [000] d.Z1.   206.549346: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
> 
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v3:
>    - Enclose the register-API dependent code in trace_probe.c with
>      CONFIG_HAVE_FUNCTION_ARG_ACCESS_API.
> ---
>  Documentation/trace/index.rst       |    1 
>  Documentation/trace/wprobetrace.rst |   69 ++++
>  include/linux/trace_events.h        |    2 
>  kernel/trace/Kconfig                |   14 +
>  kernel/trace/Makefile               |    1 
>  kernel/trace/trace.c                |    9 
>  kernel/trace/trace.h                |    5 
>  kernel/trace/trace_probe.c          |   22 +
>  kernel/trace/trace_probe.h          |    8 
>  kernel/trace/trace_wprobe.c         |  685 +++++++++++++++++++++++++++++++++++
>  10 files changed, 813 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/trace/wprobetrace.rst
>  create mode 100644 kernel/trace/trace_wprobe.c
> 


> diff --git a/Documentation/trace/wprobetrace.rst b/Documentation/trace/wprobetrace.rst
> new file mode 100644
> index 000000000000..9774f57e2947
> --- /dev/null
> +++ b/Documentation/trace/wprobetrace.rst
> @@ -0,0 +1,69 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================================
> +Watchpoint probe (wprobe) Event Tracing
> +=======================================
> +
> +.. Author: Masami Hiramatsu <mhiramat@kernel.org>
> +
> +Overview
> +--------
> +
> +Wprobe event is a dynamic event based on the hardware breakpoint, which is
> +similar to other probe events, but it is for watching data access. It allows
> +you to trace which code accesses a specified data.
> +
> +As same as other dynamic events, wprobe events are defined via
> +`dynamic_events` interface file on tracefs.
> +
> +Synopsis of wprobe-events
> +-------------------------
> +::
> +
> +  w:[GRP/][EVENT] SPEC [FETCHARGS]                       : Probe on data access
> +
> + GRP            : Group name for wprobe. If omitted, use "wprobes" for it.
> + EVENT          : Event name for wprobe. If omitted, an event name is
> +                  generated based on the address or symbol.
> + SPEC           : Breakpoint specification.
> +                  [r|w|rw]@<ADDRESS|SYMBOL[+|-OFFS]>[:LENGTH]
> +
> +   r|w|rw       : Access type, r for read, w for write, and rw for both.
> +                  Use rw if omitted.

		     Default is rw if omitted.

> +   ADDRESS      : Address to trace (hexadecimal).
> +   SYMBOL       : Symbol name to trace.
> +   LENGTH       : Length of the data to trace in bytes. (1, 2, 4, or 8)
> +
> + FETCHARGS      : Arguments. Each probe can have up to 128 args.
> +  $addr         : Fetch the accessing address.
> +  @ADDR         : Fetch memory at ADDR (ADDR should be in kernel)
> +  @SYM[+|-offs] : Fetch memory at SYM +|- offs (SYM should be a data symbol)
> +  +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*1)(\*2)
> +  \IMM          : Store an immediate value to the argument.
> +  NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
> +  FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
> +                  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
> +                  (x8/x16/x32/x64), "char", "string", "ustring", "symbol", "symstr"
> +                  and bitfield are supported.
> +
> +  (\*1) this is useful for fetching a field of data structures.
> +  (\*2) "u" means user-space dereference.
> +
> +For the details of TYPE, see :ref:`kprobetrace documentation <kprobetrace_types>`.
> +
> +Usage examples
> +--------------
> +Here is an example to add a wprobe event on a variable `jiffies`.
> +::
> +
> +  # echo 'w:my_jiffies w@jiffies' >> dynamic_events
> +  # cat dynamic_events
> +  w:wprobes/my_jiffies w@jiffies
> +  # echo 1 > events/wprobes/enable
> +  # cat trace | head
> +  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> +  #              | |         |   |||||     |         |
> +           <idle>-0       [000] d.Z1.  717.026259: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
> +           <idle>-0       [000] d.Z1.  717.026373: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
> +
> +You can see the code which writes to `jiffies` is `do_timer()`.

I'm having trouble getting from tick_do_update_jiffies64+0xbe/0x130,
which I expect is
	jiffies_64 += ticks;
in that function, over to do_timer(), which also updates jiffies_64,
but is not called by tick_do_update_jiffies64(). AFAICT, there are
no calls to do_timer() in the file (kernel/time/tick-sched.c).

Can you explain, please?



> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index d2c79da81e4f..dd8919386425 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -807,6 +807,20 @@ config EPROBE_EVENTS
>  	  convert the type of an event field. For example, turn an
>  	  address into a string.
>  
> +config WPROBE_EVENTS
> +	bool "Enable wprobe-based dynamic events"
> +	depends on TRACING
> +	depends on HAVE_HW_BREAKPOINT
> +	select PROBE_EVENTS
> +	select DYNAMIC_EVENTS
> +	default y

Wny default y?

> +	help
> +	  This allows the user to add watchpoint tracing events based on
> +	  hardware breakpoints on the fly via the ftrace interface.
> +
> +	  Those events can be inserted wherever hardware breakpoints can be
> +	  set, and record various register and memory values.
> +
>  config BPF_EVENTS
>  	depends on BPF_SYSCALL
>  	depends on (KPROBE_EVENTS || UPROBE_EVENTS) && PERF_EVENTS


thanks.
-- 
~Randy

