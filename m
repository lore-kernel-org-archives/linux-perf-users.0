Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87FB34A78E;
	Fri, 21 Aug 2026 03:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787283992; cv=none; b=oUAUMrmkU4ovd0rt+KsobRzciQWPDd8gK7BeemMLzRLC6HHv3R/FCsDQMUhcPgMM7BXDp8OdHQjYl7S5tgk0AYULvtlaIEsrlf+OMaDwUJfYziAlYzzVOvmBo/CW1AdRCkzxTbpVs+TnoZNQda4eElCkNyGAH1zcOpbF2QD+wzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787283992; c=relaxed/simple;
	bh=SS5M8CazTi4QpGApjTon0QW7PKmUebZlkE1DSZq1Ap8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=j57EKLsU5HJMKHt2olUbjxNHoJPSV6j/YZA669EDOfdrLSN0mSyauEpHMe6CPtfaMjbW1wnc5MFw/c5wgDCHV4/Ie1faHov8nzrfbtwEJRVIZVvVVKcUO21lawLI3QeA1O/BYZq56orkzvc0Zu24yzpe9tiIrYXpFEv6ZPpnu4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RB7XZM63; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RB7XZM63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FD61F000E9;
	Fri, 21 Aug 2026 03:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787283988;
	bh=onJjp9ppWSy/QNCetSyBA0MLXByIviSrOmy5FMS2SjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RB7XZM63NJVN6o2vXSy9HZPDh2CXSKmTVDUBZZGgrtYxqaq4NriL0pPWjiRXIzu7d
	 3dKIh01AI8qLJ2gOkeh0p7oy1/4E10PYCsKmAabYbOCrtlKzjYK1WyqdRpFD3XyJFA
	 qQYs5B29XJB83bLdfIyynRtXPnIgrJq7PozO+Z4Fq1N8XJ0SRhJ+ow4tVTvIiuXi6K
	 9Dt+c9pjQXwyyjxKbI+e3iy2FyRJoYNXfSU752IXliLnv8TQHRDgiqE61Dg+fFdvhO
	 JWAi2Qhw3VePmCSpCMlYzavP3grAn8tKD3hnWky1DoWRIAtMJdmwib3mzvjPfbRcMO
	 VMA9QwF2HxDZg==
Date: Fri, 21 Aug 2026 12:46:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v12 08/11] tracing/wprobe: Add set_wprobe and
 clear_wprobe event triggers
Message-Id: <20260821124625.4c7b9794e950aeac38252ce2@kernel.org>
In-Reply-To: <20260807155440.66C461F000E9@smtp.kernel.org>
References: <178611679753.237811.10190793347982785419.stgit@devnote2>
	<178611688737.237811.17143803996766057381.stgit@devnote2>
	<20260807155440.66C461F000E9@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 07 Aug 2026 15:54:39 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] Mixing scope-based cleanup (`__free()`) with explicit resource management causes double-frees and memory leaks.
> - [High] Hardware breakpoint fallback address spans adjacent kernel variables, causing NMI storms.
> - [High] Double initialization of the event trigger reference count causes unconditional memory leaks.
> - [Medium] Trigger `count` is double-decremented, breaking the `:count=1` feature.
> - [Medium] The `clear_wprobe` trigger fails to parse its documented optional FIELD parameter.
> --
> 
> --- Patch [8]: [PATCH v12 08/11] tracing/wprobe: Add set_wprobe and clear_wprobe event triggers ---
> commit cb59d7e61a8c78c308ca9ae32e1de403900f7a05
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Subject: tracing/wprobe: Add set_wprobe and clear_wprobe event triggers
> 
> This commit adds set_wprobe and clear_wprobe event triggers to dynamically
> attach and detach hardware breakpoint address monitoring based on event field
> contents.
> 
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com/
> 
> > diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> > --- a/kernel/trace/trace_wprobe.c
> > +++ b/kernel/trace/trace_wprobe.c
> 
> [ ... ]
> 
> > +static int wprobe_trigger_global_enabled;
> > +
> > +#define SET_WPROBE_STR		"set_wprobe"
> > +#define CLEAR_WPROBE_STR	"clear_wprobe"
> > +#define WPROBE_DEFAULT_CLEAR_ADDRESS ((unsigned long)&wprobe_trigger_global_enabled)
> 
> [Severity: High]
> Will this 4-byte fallback variable safely accommodate 8-byte hardware
> breakpoints? 
> 
> When a wprobe is temporarily disabled, its hardware breakpoint is pointed here
> at WPROBE_DEFAULT_CLEAR_ADDRESS, but it retains its configured length (e.g., 8
> bytes for a 64-bit pointer). 
> 
> Could this cause the breakpoint to monitor the 4-byte variable plus 4 adjacent
> bytes in the .bss section, potentially triggering NMI storms if a frequently
> accessed kernel variable happens to reside in those adjacent bytes?

Ah, indeed. This should be fixed.

> 
> [ ... ]
> 
> > +static void wprobe_trigger(struct event_trigger_data *data,
> > +			   struct trace_buffer *buffer,  void *rec,
> > +			   struct ring_buffer_event *event)
> > +{
> [ ... ]
> > +	/* count < 0 means endless, 0 means trigger count exhausted */
> > +	if (!data->count)
> > +		goto out;
> [ ... ]
> > +	if (changed) {
> > +		if (data->count > 0)
> > +			data->count--;
> 
> [ ... ]
> 
> > +static struct event_command trigger_wprobe_set_cmd = {
> > +	.name			= SET_WPROBE_STR,
> [ ... ]
> > +	.trigger		= wprobe_trigger,
> > +	.count_func		= event_trigger_count,
> 
> [Severity: Medium]
> Does this manual decrement in wprobe_trigger() conflict with the core
> event_trigger_count decrement function? 
> 
> The trigger commands are assigned .count_func = event_trigger_count, which
> unconditionally executes before the main .trigger callback and pre-decrements
> the count. 
> 
> If a user specifies :count=1, the core framework reduces it to 0. 
> wprobe_trigger() will then see a count of 0 and abort immediately. Does this
> render a single-count trigger completely non-functional?

Ah, good catch! OK, let's use the standard one at this point.

> 
> [ ... ]
> 
> > +static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
> > +				    struct trace_event_file *file,
> > +				    char *glob, char *cmd,
> > +				    char *param_and_filter)
> > +{
> > +	/*
> > +	 * set_wprobe:EVENT:FIELD[+OFFS]
> > +	 * clear_wprobe:EVENT[:FIELD[+OFFS]]
> > +	 */
> > +	struct wprobe_trigger_data *wprobe_data __free(free_wprobe_trigger_data) = NULL;
> > +	struct event_trigger_data *trigger_data __free(kfree) = NULL;
> 
> [ ... ]
> 
> > +	/* clear_wprobe does not need field. */
> > +	if (!clear) {
> > +		char *offs;
> 
> [Severity: Medium]
> Does skipping the field parsing here break the documented optional FIELD
> parameter for clear_wprobe? 
> 
> The documentation claims clear_wprobe:WPEVENT[:FIELD] conditionally clears a
> watchpoint, but if clear is true, the parsing code skips extracting the field
> string. 
> 
> It looks like the unparsed string is then passed to event_trigger_parse_num(),
> which expects a numeric string and fails with -EINVAL.

Yeah, I think we can just drop FIELD support for clear_wprobe.

> 
> [ ... ]
> 
> > +	ret = event_trigger_parse_num(param, trigger_data);
> > +	if (ret) {
> > +		wprobe_trigger_log_err(file, glob, param - glob, BAD_IMM);
> > +		return ret;
> > +	}
> 
> [Severity: High]
> Can this early error path leak memory? 
> 
> The trigger_data uses __free(kfree), which performs a shallow free. If
> event_trigger_parse_num() fails and returns early, does this permanently leak
> internal allocations like data->name?

Oops, let me fix it.

> 
> [ ... ]
> 
> > +	event_trigger_init(trigger_data);
> > +
> > +	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
> 
> [Severity: High]
> Will this result in a double initialization of the reference count? 
> 
> We call event_trigger_init(trigger_data) explicitly here, which increments the
> reference count. Then event_trigger_register() calls the .reg callback
> wprobe_register_trigger(), which executes data->cmd_ops->init(data) and
> increments the reference count a second time. 
> 
> When the trigger is later unregistered, wprobe_trigger_free() decrements the
> count by only 1, leaving a permanent reference and memory leak.

OK, this refcounter updates seems to related to the below error path.

> 
> > +	if (ret) {
> > +		event_trigger_reset_filter(cmd_ops, trigger_data);
> > +		trace_event_enable_disable(wprobe_file, 0, 1);
> > +		trace_event_put_ref(wprobe_file->event_call);
> > +		tracepoint_synchronize_unregister();
> > +		event_trigger_free(trigger_data);
> > +		return ret;
> > +	}
> 
> [Severity: High]
> Can this late error path cause a double-free? 
> 
> Both trigger_data and wprobe_data are declared with scope-based cleanup
> (__free). If event_trigger_register() fails, the code manually calls
> event_trigger_free(trigger_data), freeing both objects. 
> 
> When the function returns, the __free macros will execute and attempt to free
> them a second time.

Let me fix both cases.

Thank you!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
