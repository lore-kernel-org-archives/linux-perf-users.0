Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8645D431E74
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044960; cv=none; b=emGXbCZmBePhyV4zG0zUEPSRvJMuOaMQv3KiIpVz0g13RrQppOjcwH0rz3112SzSz8WHLZQPpEKs8JjvscsroVy9tSrUEuQqISv0To8T22S4NA5oQ6oGq2tjUXpTfVPZop52zkHmSXMMEAeP4D4ubF29l6y+apY2omB3tq16jro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044960; c=relaxed/simple;
	bh=rWGvV6RH4tfNJQkB60DUu3/OAoscpTL4+4KSJdvssmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWN+DvkKcLouHyO9+fLARFbC64WVFxuWkQa4G5i/ZlXV9fcDU//cS3I7nnNcHT89wcdlmzTfg5Sy0hSnzNsh5AgeftYV0RW/OkhTwaYJBClP5CIInAUNviV2TYXEOEEJ5pdcPdhp182vJzSIHQYKsQNvWBII62Tc7qmg7W3Tv5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAbMqWiZ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAbMqWiZ"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9f1f24cbcso727716a34.0
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 02:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787044956; x=1787649756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v7Kv1tYbrkVXERJ81NQKIW3So0Xg9hhEFLDYBfxt8VI=;
        b=lAbMqWiZlZWdl6s+h1My32N0OFhPhqqhLMIaUvt7+JKCi969z/CwB9RXuIrP/wkjfS
         d+PpFcafmigtE2McakHHYnkO0bg8hEhXQEfYMt21hgLiu3yaCeDLWQMkR9HiG+YypJUU
         bykoBQUTNO5WVJG/N1+A2N6pV/ko9abG6IIQ6aThF9wQEwvjy2Q/qNNPyDj4cyXoYAmL
         CBNpOYyZsQ2AZ9z1p4PjqncjH+sFF7G6AadVwhqi0m4cu3m3v38eRC7dkjTUM2U27jdT
         CbvCmiJbOSRbiD8SeHgBPmrQhB0KhZRaGbp9XBN0DbZ5A1y/5vRAcxTES+1P+aMU+iB7
         s08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787044956; x=1787649756;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v7Kv1tYbrkVXERJ81NQKIW3So0Xg9hhEFLDYBfxt8VI=;
        b=l7rFa57klMXv728pOCK0Ev8vq1bIpFmyUOedD8Yg7j/NneOtxIT4LlDrd597NSO3JC
         xF1cMWZtFcLaCQplnKkaCmysFjrFlhwZ2dg7NgIkdan5CbJV4biD7HJRCMnqpTlmeFYM
         Phqw11VIz+CjCFERXQjLA9OVWDwu/GFjuX3PMm/6o+zcGkBdlgZpmhUr5aMmpA0rudPw
         0/wehgngQe7m8oF53+5AyshgNSao0EorF/q5JI7wZAghC8eEjEBCXehUU1QHat4rqmfr
         3AcVw56LqLBJdsKKj2cZVDcTVZHCbNkkq8uaylyf+mnxYdrOVthS35JTdOMV7tKa08kX
         xN2g==
X-Forwarded-Encrypted: i=1; AHgh+RqqBbi6jYcGODNf777fGWZzQpIJ9raxlsvC8tTl87U3HowL+dWh33RIoWH4cKIjFXMEH4dBYoOlqMBne6hV8rac@vger.kernel.org
X-Gm-Message-State: AOJu0YzZOOZ3mwZqUPIltu6m6UBgU1M0hGnDwf0xMf9yTgkdSa++drNT
	Yo/h0cp3f6kkvbRn2wLYukduP7908Y3Biy4K7l6SHYvChEMwk0OjRRlU
X-Gm-Gg: AR+sD12HvI2cAQyKhiqVbi8OD/MyiHbHpocTZUjnUdLISBVjV0+1UC+9fbJxMOL4/6M
	I3AKLJl+oC/Oy5/ZJXH48XSOg9UDOkWk3tI7Tn5J0qjTYpT6fGhhvpf/Ths7eiERaLpBtud2vqt
	G2qDProhDw4lQAQw0x98aBvl3cLTpXL/Hz5IWhz0007232kGDGCMlxSO4hm+jkQeg8Y9o7XTy2t
	D6K4vGx4KuCavKxoRC0Pd54sARoWMuPw9BrUm4Z+2tpCev/VVB1neCn2dXwNM5y7tpzwxXAflKF
	PIJ+8Xh/9BV4Gp9wOeORzrJ/D7LawW1KY+Zv0hXx/Fyu7hFkj3GtjQOOBe6kvxPJeX4DMDTM0qT
	8xY1MO+bZhY8ZbR45Qy6Z1Paxr4DzvhqekOMrVLbwVYfOSwIxSKnk+hWBDipLIonrZySnX4XLyt
	VmUXgmCuWSglcrEhAqANg/oEfBs9c9n4MhZ7v5/3luQ5KX4MvNtnzwnrqqGzYwgmVvs9dgMa98
X-Received: by 2002:a05:6830:3897:b0:7e7:24f9:55c8 with SMTP id 46e09a7af769-7f4290949a9mr2972823a34.5.1787044956325;
        Tue, 18 Aug 2026 02:22:36 -0700 (PDT)
Received: from [127.0.0.1] ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f41c12b683sm3958040a34.26.2026.08.18.02.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 02:22:35 -0700 (PDT)
Message-ID: <d833b191-ced9-4cf6-ac37-fc593d06191b@gmail.com>
Date: Tue, 18 Aug 2026 17:22:27 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 08/11] tracing/wprobe: Add set_wprobe and clear_wprobe
 event triggers
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
 <178611688737.237811.17143803996766057381.stgit@devnote2>
Content-Language: en-US
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <178611688737.237811.17143803996766057381.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/2026 11:34 PM, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add set_wprobe and clear_wprobe event triggers to dynamically attach
> and detach hardware breakpoint address monitoring based on event field
> contents.
> 

This patch does not build with wprobe enabled.

> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com/
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
> Changes in v12:
>  - Decrement trigger data->count only when watchpoint state is actually changed.
>  - Remove dyn_event_ops_mutex to fix lockdep circular dependency deadlock.
>  - Add event_trigger_init() call to prevent premature freeing of trigger_data.
>  - Use WRITE_ONCE() when modifying tw->addr to pair with READ_ONCE().
>  - Add missing braces to else-block in wprobe_trigger_print().
>  - Initialize tw->addr only after trace_event_enable_disable() succeeds.
>  - Counter counts only if the trigger is actually working.
> Changes in v11:
>  - Soft-enable (register) wprobe event on WPROBE_DEFAULT_CLEAR_ADDRESS.
>  - Add work_pending check before updating tw->addr.
> ---
>  Documentation/trace/wprobetrace.rst |   98 +++++++
>  include/linux/trace_events.h        |    1 
>  kernel/trace/Kconfig                |   10 +
>  kernel/trace/trace.h                |    1 
>  kernel/trace/trace_dynevent.h       |    1 
>  kernel/trace/trace_events_trigger.c |    2 
>  kernel/trace/trace_probe.c          |    2 
>  kernel/trace/trace_probe.h          |    9 +
>  kernel/trace/trace_wprobe.c         |  527 +++++++++++++++++++++++++++++++++++
>  9 files changed, 648 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/trace/wprobetrace.rst b/Documentation/trace/wprobetrace.rst
> index ad5f089b5ef5..a579347735d2 100644
> --- a/Documentation/trace/wprobetrace.rst
> +++ b/Documentation/trace/wprobetrace.rst
> @@ -68,3 +68,101 @@ Here is an example to add a wprobe event on a variable `jiffies`.
>             <idle>-0       [000] d.Z1.  717.026373: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
>  
>  You can see the code which writes to `jiffies` is `tick_do_update_jiffies64()`.
> +
> +Combination with trigger action
> +-------------------------------
> +The event trigger action can extend the utilization of this wprobe.
> +
> +- set_wprobe:WPEVENT:FIELD[+|-ADJUST]
> +- clear_wprobe:WPEVENT[:FIELD[+|-]ADJUST]

Both forms accept an optional [:COUNT] which is not documented here.

> +
> +Set these triggers to the target event, then the WPROBE event will be
> +setup to trace the memory access at FIELD[+|-ADJUST] address.
> +When clear_wprobe is hit, if FIELD is NOT specified, the WPEVENT is
> +forcibly cleared. If FIELD[[+|-]ADJUST] is set, it clears WPEVENT only
> +if its watching address is the same as the FIELD[[+|-]ADJUST] value.

Two forms of adjust:
[+|-ADJUST]
[+|-]ADJUST


> +
> +Notes:
> +The set_wprobe trigger does not change the type and length, these
> +must be set when creating a new wprobe.
> +
> +The WPROBE event must be disabled when setting the new trigger
> +and it will be busy afterwards. Recommended usage is to add a new
> +wprobe at NULL address and keep disabled.
> +

> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index d9b6fa5c35d9..5fd8ed63c516 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -876,6 +876,16 @@ config WPROBE_EVENTS
>  	  Those events can be inserted wherever hardware breakpoints can be
>  	  set, and record accessed memory address and values.
>  
> +config WPROBE_TRIGGERS
> +	depends on WPROBE_EVENTS
> +	depends on HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR
> +	bool
> +	default y
> +	help
> +	  This adds an event trigger which will set the wprobe on a specific
> +	  field of an event. This allows user to trace the memory access of
> +	  an address pointed by the event field.
> +
>  config BPF_EVENTS
>  	depends on BPF_SYSCALL
>  	depends on (KPROBE_EVENTS || UPROBE_EVENTS) && PERF_EVENTS
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 64851a8d021f..a789a722bc8b 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1983,6 +1983,7 @@ trigger_data_alloc(struct event_command *cmd_ops, char *cmd, char *param,
>  		   void *private_data);
>  extern void trigger_data_free(struct event_trigger_data *data);
>  extern int event_trigger_init(struct event_trigger_data *data);
> +extern void event_trigger_free(struct event_trigger_data *data);
>  extern int trace_event_trigger_enable_disable(struct trace_event_file *file,
>  					      int trigger_enable);
>  extern void update_cond_flag(struct trace_event_file *file);
> diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
> index beee3f8d7544..77c2c84dcdb5 100644
> --- a/kernel/trace/trace_dynevent.h
> +++ b/kernel/trace/trace_dynevent.h
> @@ -64,6 +64,7 @@ struct dyn_event {
>  };
>  
>  extern struct list_head dyn_event_list;
> +extern struct mutex dyn_event_ops_mutex;

dyn_event_ops_mutex is not needed anymore.

>  
>  static inline
>  int dyn_event_init(struct dyn_event *ev, struct dyn_event_operations *ops)
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index ad83419cb420..fa409ebd73c2 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -589,7 +589,7 @@ int event_trigger_init(struct event_trigger_data *data)
>   * Usually used directly as the @free method in event trigger
>   * implementations.
>   */
> -static void
> +void
>  event_trigger_free(struct event_trigger_data *data)
>  {
>  	if (WARN_ON_ONCE(data->ref <= 0))
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 9f4cad18977a..36e07275a04d 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -20,7 +20,7 @@
>  #undef C
>  #define C(a, b)		b
>  
> -static const char *trace_probe_err_text[] = { ERRORS };
> +const char *trace_probe_err_text[] = { ERRORS };
>  
>  static const char *reserved_field_names[] = {
>  	"common_type",
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 6543d4c2cda5..e08f17c99138 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -634,7 +634,12 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
>  	C(TYPECAST_SYM_OFFSET,	"@SYM+/-OFFSET with typecast needs parentheses"),	\
>  	C(USED_ARG_NAME,	"This argument name is already used"),		\
>  	C(WPROBE_NO_MAXACT,	"Watchpoint probe does not support maxactive"),	\
> -	C(WPROBE_NO_SIBLING,	"Watchpoint probe does not support sibling probes"),
> +	C(WPROBE_NO_SIBLING,	"Watchpoint probe does not support sibling probes"), \
> +	C(WPROBE_ON_KPROBE,	"Wprobe trigger is not supported on kprobe event"), \
> +	C(WPROBE_NOT_FOUND,	"Target wprobe event is not found"),		\
> +	C(WPROBE_BUSY,		"Target wprobe event is already enabled"),	\
> +	C(WPROBE_NEED_FIELD,	"Wprobe trigger requires a target field"),	\
> +	C(WPROBE_BAD_FIELD,	"Target field must be pointer size"),
>  
>  #undef C
>  #define C(a, b)		TP_ERR_##a
> @@ -658,6 +663,8 @@ void __trace_probe_log_err(int offset, int err);
>  
>  DEFINE_FREE(trace_probe_log_clear, const char *, if (_T) trace_probe_log_clear())
>  
> +extern const char *trace_probe_err_text[];
> +
>  #define trace_probe_log_err(offs, err)	\
>  	__trace_probe_log_err(offs, TP_ERR_##err)
>  
> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> index df592d9280a4..c64bbdc90a40 100644
> --- a/kernel/trace/trace_wprobe.c
> +++ b/kernel/trace/trace_wprobe.c
> @@ -6,7 +6,9 @@
>   */
>  #define pr_fmt(fmt)	"trace_wprobe: " fmt
>  
> +#include <linux/atomic.h>
>  #include <linux/compiler.h>
> +#include <linux/errno.h>
>  #include <linux/hw_breakpoint.h>
>  #include <linux/kallsyms.h>
>  #include <linux/list.h>
> @@ -15,11 +17,16 @@
>  #include <linux/perf_event.h>
>  #include <linux/rculist.h>
>  #include <linux/security.h>
> +#include <linux/spinlock.h>
>  #include <linux/tracepoint.h>
>  #include <linux/uaccess.h>
> +#include <linux/workqueue.h>
> +#include <linux/irq_work.h>
> +#include <linux/preempt.h>
>  
>  #include <asm/ptrace.h>
>  
> +#include "trace.h"
>  #include "trace_dynevent.h"
>  #include "trace_probe.h"
>  #include "trace_probe_kernel.h"
> @@ -50,6 +57,17 @@ struct trace_wprobe {
>  	int			len;
>  	int			type;
>  	const char		*symbol;
> +	raw_spinlock_t		lock;
> +	struct irq_work		irq_work;
> +	struct work_struct	work;
> +	atomic_t		missed;

Is `missed`  read somewhere?
I searched this file, only found set and inc.



