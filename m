Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78143E92B5
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786967496; cv=none; b=EG0sT8WX5fEnDASkE+qJ42FfWrLBBb4S8xfmxRdZTr6J9NM7s1aSVQH5B51ELdQBfUrF8SUjEFocUgvPIQtq+0EuaHJc3i21AbYUigVOAxP7n6hHR2M21GW1ceIBewtWb+OHYsz5ku1Fx0O3EGb8tbEKqU3bnITbPqau4tWrscY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786967496; c=relaxed/simple;
	bh=JW/OUHm0+iHvEZgreUAX7GG5l6sE3x+M8wliXF9FvFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcFZ5rdtRUoGtEOAJT3KQIZQibV5mB0J/N27PEjkD2o2fIf8wRQOf2xhccW9KlRX3TCMqQUtUImRWW8fAwXQZmeoFAMeEscK8Lej7ji7G3aVCIH830PBMjV9SsyjGpdOmp32LDtkeaA9Yt/q7A2AcOa7qFopP7vcDWXIFsJm6Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8CKmQT5; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8CKmQT5"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6b0b7464c99so2070087eaf.3
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 04:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786967492; x=1787572292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DVdBgZgiFXGDjbJpuNlt9gLYnAgItSA9haLa1Vijdyg=;
        b=j8CKmQT5ymAs/w2KaE9/fLu43OGrrZiIdhNC7n4fuoBiyM2KMAYsj4Ggo4OU2WxO10
         bRO9hTEdv/c5bOn4AvTx2abw97xMOeobpa209OyeBEKPTt/iVQLVpEjmR1rAxFjdePwE
         mUqluDWOSpKT7LbS+zBaLiAKJkvgfpauIZZe3BvVpkMH84QFv+EvE4qLP/0aS64jnS2Y
         PMu2WVeziEUPOB7b7fx0DdUClnKgFMZpVYu9foosKhq5QJPblIDwCQ2N1wiTmJnFq08P
         0OL09sbfoAmotZOjOGi6owWe9LH1fq7RM/d5wZDegt5K0BESkKR0H0CwU8BXXv3yURnz
         5I7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786967492; x=1787572292;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DVdBgZgiFXGDjbJpuNlt9gLYnAgItSA9haLa1Vijdyg=;
        b=bYNOh7IZ/cf8rUhIf32k3kP+4Bj7dn3PRXHcGt3G9o+OHy4rxF1TY6R2L27VlRd3ze
         ODo9k8p2cis0PUvSVcv5mqvJ9DeG0zcJO0rKi1IaUDqdRI6N+6Fg7k5ePSnq09nu9Qc2
         ZGY9yg3UUnuRwb1IcMd4A9sjcd2YfKopuhr7H6hxpg/azT2f6FIiJZoXZJB9YSPBgH1D
         wsEMl3Poeo04AybveuMpMgcs0XXewhewsRSIrF8QntJi1QuRA518Omo1ibcl+zZs+fc5
         U8FIRmqAaHAzEmcOYUF9ml3754pk93RlfEHVVYeuqSLMAkbzYjc64uPrhqLnE8mx+V2W
         Ig/A==
X-Forwarded-Encrypted: i=1; AHgh+RpIcPeNP5ugZ5MWZXdSlveRCpUAjivj/O8AdkQ6rGPnMAdYj17dTzOPLMu0+8xPuOlO44PrCsknhp0R4vEBhIn5@vger.kernel.org
X-Gm-Message-State: AOJu0YxoY+SfwI/m+9yRcDUWBxEsJWHahSzyOFV5S0PdRMPIlSVLIKcq
	EH6sODNRGrtuywZeO13ppb4X1UeBhMCauyTaslVp3BUuhBcj4Bzvnaaq
X-Gm-Gg: AR+sD10/INa2iPZl+7zfnchVLuj0s+harggqXWuRvFwqT2dAbzjYtqbnxM/T4rrOUWM
	bLRn4qRKxdx8dMbZj8uW6DO4zPcm39VAiSDTb/D5ZKyybB158gr4y05L6leMNx8D3Ic8cpOruJm
	MA2T/ejlAOVgp4JDs6yXDCAuDaBZlYtOebcb7SDmH/YrZAzBzUOWmAC//JDBuQOlFcNjbVs5kzI
	Ppn0mYW+XYyI2jGS8vX5wB/N+OoRxYEXp0XKAalbjwyHKlf9b91QjSTp5EGONcZjgq1xn7kpW8o
	Rbz1Vx+PnE9mlOwKxf9yZJb7F9Y5WPRQ3L7iRMA+tQlwuU3x9pzIrfrNSTSGCO1LnzSxa44Dewu
	WRlrTsYKrR2atRdKaAsyOheFQTTWP9jObY1K2c8LcPmxM1o+OHAmoZLXLZ0o86ZNbNRCpc9RFBc
	WA9GWVwzbOzny+inNrtXl0Fwtye7uVm0nr/5pjgkPGhfxLp+1ms4VQFpKZaKjP3g==
X-Received: by 2002:a4a:edc9:0:b0:6a3:7af2:90ef with SMTP id 006d021491bc7-6b0d5fdc3a6mr23600155eaf.6.1786967491410;
        Mon, 17 Aug 2026 04:51:31 -0700 (PDT)
Received: from [127.0.0.1] ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45f22d73a34sm881100fac.9.2026.08.17.04.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 04:51:30 -0700 (PDT)
Message-ID: <77a90576-7142-4537-9e24-6fcefb0c6dde@gmail.com>
Date: Mon, 17 Aug 2026 19:51:22 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/11] tracing/wprobe: Add wprobe (watchpoint probe)
 trace event support
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <178611679753.237811.10190793347982785419.stgit@devnote2>
 <178611684231.237811.7919346786503289720.stgit@devnote2>
Content-Language: en-US
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <178611684231.237811.7919346786503289720.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/2026 11:34 PM, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add hardware-breakpoint-based dynamic trace event support (wprobe).
> Wprobe creates a dynamic event on data read/write accesses using
> hardware breakpoints and logs the access context and fetchargs.
> 
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com/
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
> Changes in v12:
>  - Fix syntax comment typo ('b' to 'w') and remove dead 'ret = 0'
>    initialization in __trace_wprobe_create().
>  - Fix documentation notation to SYMBOL[[+|-]OFFS].
> Changes in v11:
>  - Add trace_wprobe_is_busy() to prevent releasing busy events.
> Changes in v9:
>  - Use kzalloc_flex for alloc_trace_wprobe.
> ---
>  Documentation/trace/index.rst       |    1 
>  Documentation/trace/wprobetrace.rst |   70 +++
>  include/linux/trace_events.h        |    2 
>  kernel/trace/Kconfig                |   13 +
>  kernel/trace/Makefile               |    1 
>  kernel/trace/trace.c                |    9 
>  kernel/trace/trace.h                |    5 
>  kernel/trace/trace_probe.c          |   21 +
>  kernel/trace/trace_probe.h          |   10 
>  kernel/trace/trace_wprobe.c         |  765 +++++++++++++++++++++++++++++++++++
>  10 files changed, 893 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/trace/wprobetrace.rst
>  create mode 100644 kernel/trace/trace_wprobe.c
> 
> diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
> index 5d9bf4694d5d..2f04f32001ed 100644
> --- a/Documentation/trace/index.rst
> +++ b/Documentation/trace/index.rst
> @@ -36,6 +36,7 @@ the Linux kernel.
>     kprobes
>     kprobetrace
>     fprobetrace
> +   wprobetrace
>     eprobetrace
>     fprobe
>     ring-buffer-design
> diff --git a/Documentation/trace/wprobetrace.rst b/Documentation/trace/wprobetrace.rst
> new file mode 100644
> index 000000000000..ad5f089b5ef5
> --- /dev/null
> +++ b/Documentation/trace/wprobetrace.rst
> @@ -0,0 +1,70 @@
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
> +                  [r|w|rw]@<ADDRESS|SYMBOL[[+|-]OFFS]>[:LENGTH]
> +
> +   r|w|rw       : Access type, r for read, w for write, and rw for both.
> +                  Default is rw if omitted.
> +   ADDRESS      : Address to trace (hexadecimal). MUST be in kernel space.
> +   SYMBOL       : Symbol name to trace.
> +   LENGTH       : Length of the data to trace in bytes. (1, 2, 4, or 8)

Should it show default value 4?
> +
> +  FETCHARGS      : Arguments. Each probe can have up to 128 args.
> +   $addr         : Fetch the accessing address.
> +   $value        : Fetch the memory value at the accessing address (same as +0($addr)).
> +   @ADDR         : Fetch memory at ADDR (ADDR should be in kernel)
> +  @SYM[+|-offs] : Fetch memory at SYM +|- offs (SYM should be a data symbol)
> +  +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*1)(\*2)
> +  \IMM          : Store an immediate value to the argument.
> +  NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
> +  FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
> +                  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
> +                  (x8/x16/x32/x64), "char", "string", "ustring", "symbol", "symstr"
> +                  and bitfield are supported.

FETCHARGS block is not aligned.

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
> +You can see the code which writes to `jiffies` is `tick_do_update_jiffies64()`.
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 5cbd09c8be8d..43ffd9a76d88 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -337,6 +337,7 @@ enum {
>  	TRACE_EVENT_FL_UPROBE_BIT,
>  	TRACE_EVENT_FL_EPROBE_BIT,
>  	TRACE_EVENT_FL_FPROBE_BIT,
> +	TRACE_EVENT_FL_WPROBE_BIT,
>  	TRACE_EVENT_FL_CUSTOM_BIT,
>  	TRACE_EVENT_FL_TEST_STR_BIT,
>  };
> @@ -367,6 +368,7 @@ enum {
>  	TRACE_EVENT_FL_UPROBE		= (1 << TRACE_EVENT_FL_UPROBE_BIT),
>  	TRACE_EVENT_FL_EPROBE		= (1 << TRACE_EVENT_FL_EPROBE_BIT),
>  	TRACE_EVENT_FL_FPROBE		= (1 << TRACE_EVENT_FL_FPROBE_BIT),
> +	TRACE_EVENT_FL_WPROBE		= (1 << TRACE_EVENT_FL_WPROBE_BIT),
>  	TRACE_EVENT_FL_CUSTOM		= (1 << TRACE_EVENT_FL_CUSTOM_BIT),
>  	TRACE_EVENT_FL_TEST_STR		= (1 << TRACE_EVENT_FL_TEST_STR_BIT),
>  };
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 0ab5916575a9..b58c2565024f 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -862,6 +862,19 @@ config EPROBE_EVENTS
>  	  convert the type of an event field. For example, turn an
>  	  address into a string.
>  
> +config WPROBE_EVENTS
> +	bool "Enable wprobe-based dynamic events"
> +	depends on TRACING
> +	depends on HAVE_HW_BREAKPOINT
> +	select PROBE_EVENTS
> +	select DYNAMIC_EVENTS
> +	help
> +	  This allows the user to add watchpoint tracing events based on
> +	  hardware breakpoints on the fly via the ftrace interface.
> +
> +	  Those events can be inserted wherever hardware breakpoints can be
> +	  set, and record accessed memory address and values.
> +
>  config BPF_EVENTS
>  	depends on BPF_SYSCALL
>  	depends on (KPROBE_EVENTS || UPROBE_EVENTS) && PERF_EVENTS
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index f934ff586bd4..141c8323de20 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -126,6 +126,7 @@ obj-$(CONFIG_FTRACE_RECORD_RECURSION) += trace_recursion_record.o
>  obj-$(CONFIG_FPROBE) += fprobe.o
>  obj-$(CONFIG_RETHOOK) += rethook.o
>  obj-$(CONFIG_FPROBE_EVENTS) += trace_fprobe.o
> +obj-$(CONFIG_WPROBE_EVENTS) += trace_wprobe.o
>  
>  obj-$(CONFIG_TRACEPOINT_BENCHMARK) += trace_benchmark.o
>  obj-$(CONFIG_RV) += rv/
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 19cc07360005..4ebece96d8b7 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4294,8 +4294,12 @@ static const char readme_msg[] =
>  	"  uprobe_events\t\t- Create/append/remove/show the userspace dynamic events\n"
>  	"\t\t\t  Write into this file to define/undefine new trace events.\n"
>  #endif
> +#ifdef CONFIG_WPROBE_EVENTS
> +	"  wprobe_events\t\t- Create/append/remove/show the hardware breakpoint dynamic events\n"
> +	"\t\t\t  Write into this file to define/undefine new trace events.\n"
> +#endif
>  #if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS) || \
> -    defined(CONFIG_FPROBE_EVENTS)
> +    defined(CONFIG_FPROBE_EVENTS) || defined(CONFIG_WPROBE_EVENTS)
>  	"\t  accepts: event-definitions (one definition per line)\n"
>  #if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS)
>  	"\t   Format: p[:[<group>/][<event>]] <place> [<args>]\n"
> @@ -4305,6 +4309,9 @@ static const char readme_msg[] =
>  	"\t           f[:[<group>/][<event>]] <func-name>[%return] [<args>]\n"
>  	"\t           t[:[<group>/][<event>]] <tracepoint> [<args>]\n"
>  #endif
> +#ifdef CONFIG_WPROBE_EVENTS
> +	"\t           w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]\n"

missing [<args>]

> +#endif
>  #ifdef CONFIG_HIST_TRIGGERS
>  	"\t           s:[synthetic/]<event> <field> [<field>]\n"
>  #endif

Thanks,
Jinchao


