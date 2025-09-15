Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CF7189F3B;
	Mon, 15 Sep 2025 00:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757895926; cv=none; b=IrHysMw8ru1lQgye9rRt+hE/r0ucFHPdz1rR+xKTvWA2inr3v/Z3WgsmfP+JNqiA8FDy1Jcbw7QE2ZYJszy+3Z9D2DnyulHFYK5ZL+ml6mRVV5/ZFy7yHGbFLI4ScMDlumyLEfNRK6HtAqt5b8lvsmb8pTUYDEKrBPUNjnGxB4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757895926; c=relaxed/simple;
	bh=zEoptxqfKZSCEk17+Y0MDsXZEX03H+Xf2g82b3gPamU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhIr16kwvo/lIpYPiwwmAa9SPXMZcX8BEeaMl4m0f1mnaj9vAZXFLl6v0WNF86VEfYmcoYEwtJsXe56v8H8bdn2z/tPj0kUlXMoNTXL0xaHSYxUU34qYYhbWiHRXU4wZJqjaho8W9/UHNiUZVgG9YDDCbHIrXI2eyNz3Wmr3eOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C4Vr9g9t; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C4Vr9g9t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=u8zMQpdMOqIdURPi9uNy67Biru0axdnayB3aNUPVnFg=; b=C4Vr9g9tXs0Oc6zzKbFOONNmS8
	eSq7F7barvctskieUIp02HEyGQ5xs95vT4cQdN8GL8v8pFooUt4jO90o9jRdZN2qTWgLbANdIQHVg
	7yWqDbMse/xbhrClylogg0mkrBD+sfMojfAxlRUKqoUYxmVvZQhc49T5CYv+u4+BMbsZw1Mmn9hDt
	QLFtLpVkchQJYQzd33HRUXm7OQC2+puMAgjlu+FJx10HXRXGHMPK1PZazbc18iKT52RKB5O5dIz3G
	2tUV2HN5Ickg8XzW7+WYHGD4fWqQpAyB7ji5nbaGvb6R+RwmoHRSuvx8XxoDlqQJBsrG8uFyWfaTs
	iVhfy0+w==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxx20-00000002PjJ-0sg7;
	Mon, 15 Sep 2025 00:25:20 +0000
Message-ID: <fadb37f2-543a-4c4c-9cde-5ee7928edbe4@infradead.org>
Date: Sun, 14 Sep 2025 17:25:19 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] tracing: wprobe: Add wprobe event trigger
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
 <175785903073.234168.11080771050255081365.stgit@devnote2>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <175785903073.234168.11080771050255081365.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/14/25 7:10 AM, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add wprobe event trigger to set and clear the watch event dynamically.
> This allows us to set an watchpoint on a given local variables and
> a slab object instead of static objects.
> 
> The trigger syntax is below;

                        below:
(just a nit :)

> 
>   - set_wprobe:WPROBE:FIELD[+OFFSET] [if FILTER]
>   - clear_wprobe:WPROBE[:FIELD[+OFFSET]] [if FILTER]
> 
> set_wprobe sets the address pointed by FIELD[+offset] to the WPROBE
> event. The FIELD is the field name of trigger event.
> clear_wprobe clears the watch address of WPROBE event. If the FIELD
> option is specified, it clears only if the current watch address is
> same as the given FIELD[+OFFSET] value.
> 
> The set_wprobe trigger do not change type and length. That should be

                         does                             should be done
?

> set when a new wprobe is created.
> 
> Also, the WPROBE event must be disabled when setting the new trigger
> and it will be busy afterwards. Recommended usage is to add a new
> wprobe at NULL address and keep disabled.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v3:
>   - Add FIELD option support for clear_wprobe and update document.
>   - Fix to unregister/free event_trigger_data on file correctly.
>   - Fix syntax comments.
>  Changes in v2:
>   - Getting local cpu perf_event from trace_wprobe directly.
>   - Remove trace_wprobe_local_perf() because it is conditionally unused.
>   - Make CONFIG_WPROBE_TRIGGERS a hidden config.
> ---
>  Documentation/trace/wprobetrace.rst |   88 +++++++
>  include/linux/trace_events.h        |    1 
>  kernel/trace/Kconfig                |   10 +
>  kernel/trace/trace_wprobe.c         |  430 +++++++++++++++++++++++++++++++++++
>  4 files changed, 529 insertions(+)
> 
> diff --git a/Documentation/trace/wprobetrace.rst b/Documentation/trace/wprobetrace.rst
> index 9774f57e2947..a1812a8ac491 100644
> --- a/Documentation/trace/wprobetrace.rst
> +++ b/Documentation/trace/wprobetrace.rst
> @@ -67,3 +67,91 @@ Here is an example to add a wprobe event on a variable `jiffies`.
>             <idle>-0       [000] d.Z1.  717.026373: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
>  
>  You can see the code which writes to `jiffies` is `do_timer()`.
> +
> +Combination with trigger action
> +-------------------------------
> +The event trigger action can extend the utilization of this wprobe.
> +
> +- set_wprobe:WPEVENT:FIELD[+|-ADJUST]
> +- clear_wprobe:WPEVENT[:FIELD[+|-]ADJUST]
> +
> +Set these triggers to the target event, then the WPROBE event will be
> +setup to trace the memory access at FIELD[+|-ADJUST] address.
> +When clear_wprobe is hit, if FIELD is NOT specified, the WPEVENT is
> +forcibly cleared. If FIELD[[+|-]ADJUST] is set, it clears WPEVENT only
> +if its watching address is the same as the FIELD[[+|-]ADJUST] value.
> +
> +Notes:
> +The set_wprobe trigger do not change type and length. That should be
                          does not                          should be done


> +set when a new wprobe is created.
> +
> +The WPROBE event must be disabled when setting the new trigger
> +and it will be busy afterwards. Recommended usage is to add a new
> +wprobe at NULL address and keep disabled.
> +
> +
> +For example, trace the first 8 byte of the dentry data structure passed

                                  bytes

> +to do_truncate() until it is deleted by __dentry_kill().
> +(Note: all tracefs setup uses '>>' so that it does not kick do_truncate())
> +
> +  # echo 'w:watch rw@0:8 address=$addr value=+0($addr)' > dynamic_events

Just using '>' here is OK?

> +
> +  # echo 'f:truncate do_truncate dentry=$arg2' >> dynamic_events
> +  # echo 'set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger
> +
> +  # echo 'f:dentry_kill __dentry_kill dentry=$arg1' >> dynamic_events
> +  # echo 'clear_wprobe:watch:dentry' >> events/fprobes/dentry_kill/trigger
> +
> +  # echo 1 >> events/fprobes/truncate/enable
> +  # echo 1 >> events/fprobes/dentry_kill/enable
> +
> +  # echo aaa > /tmp/hoge
> +  # echo bbb > /tmp/hoge
> +  # echo ccc > /tmp/hoge
> +  # rm /tmp/hoge
> +
> +Then, the trace data will show;

Usually that should be:      show:

but in .rst it might need to be    show::

I don't know. Haven't tested it.


-- 
~Randy

