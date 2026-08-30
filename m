Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002083F104C;
	Sun, 30 Aug 2026 05:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788068160; cv=none; b=kpaqV1bnqtiv0mfPpmxssa7LeruYDqT2QJb+He3ye0fH0sYwB9n7Ng4Diq6tXDliHF4iqyYIAdPnn4MTBKJqavEeapJtS1ACdddsIZKrwkmD07ahuDVWQS6jkQFWfAcuRrw2u+AKtPuJ6+EGuFLh2W3gy/nAf6Mhy0ILntmwM54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788068160; c=relaxed/simple;
	bh=KBYCAzTkDa/y8RhGGUhZ6FCO8BvSny9OqIgxThv0Qj4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OhqDbzNE/R+xP7lvYHQV27bTZOdUamxgv+FC4fVT9IBOxl618bZw4xp9lyFbWAzvNTuet5wqx5QJFKLxxJTXCeO6Fse9oaL2KnX+390SpoWlI4Tl+2rf+PaV05zoEcG/kDF36iKLX8sxZ+mO0HDUGc9+98hILXBSUIixi67/szM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE7ImTEh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE7ImTEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3131F000E9;
	Sun, 30 Aug 2026 05:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788068158;
	bh=ZMcSzHMOGkTxjDQ/kms1UD4eXR3thAanYtFKKrLlkJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YE7ImTEhZIJqIb2WKFgsRJuQ1+WCrRgHEQYXZ4aBNSgJJhsfB2BkQN9VVbpF8O7X+
	 GpPVk8El+0p6kCNWDgDGDaaaGaFCoU2C5Kx7UIbFR/yRoeyCybGdpFulsYz23vVSKB
	 PgDQ9IpjzOsxKXexSqcFuwpUrE8Y/PnQRUG5Xe8jGNnBz9qGhM4DmXiF/qtTSAqJg7
	 fx+5lYxwPRLhPwtjTp/o0MMfSFlzEgZBThIiVQql7IcD1PulGMbpaJyvfp9nlETPv8
	 qbZN0Eir/xH6oc3entCPitoBCuGGQE2YBuTy5XlGE6OlfED9O2CZvv79io+Rc5L6lp
	 n39AyAYnU3skg==
Date: Sun, 30 Aug 2026 14:35:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v13 09/12] tracing/wprobe: Add set_wprobe and
 clear_wprobe event triggers
Message-Id: <20260830143556.6faf869a7174b4fdded22f82@kernel.org>
In-Reply-To: <20260822094218.0C4491F000E9@smtp.kernel.org>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
	<178739069325.1520941.16954545333706545613.stgit@devnote2>
	<20260822094218.0C4491F000E9@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 22 Aug 2026 09:42:17 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] Leaked `trigger_data` and `wprobe_data` when trigger registration fails due to unbalanced reference counts.
> - [Medium] Hardware breakpoints are inadvertently left monitoring the initial wprobe address (unparked) instead of the parked dummy address upon enablement.
> - [Low] The `clear_wprobe` trigger cannot be removed by echoing its exact printed output if a trigger count is specified.
> --
> 
> --- Patch [9]: [PATCH v13 09/12] tracing/wprobe: Add set_wprobe and clear_wprobe event triggers ---
> commit e794ff7412c73348b335e9a50aceecbbd82d9a0c
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> tracing/wprobe: Add set_wprobe and clear_wprobe event triggers
> 
> Add set_wprobe and clear_wprobe event triggers to dynamically attach
> and detach hardware breakpoint address monitoring based on event field
> contents.
> 
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com/
> 
> > diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> > index a8543766a245b..acb15fd018e80 100644
> > --- a/kernel/trace/trace_wprobe.c
> > +++ b/kernel/trace/trace_wprobe.c
> 
> [ ... ]
> 
> > @@ -756,3 +827,501 @@ static __init int init_wprobe_trace(void)
> 
> [ ... ]
> 
> > +static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
> > +				    struct trace_event_file *file,
> > +				    char *glob, char *cmd,
> > +				    char *param_and_filter)
> > +{
> 
> [ ... ]
> 
> > +	} else if (param && (isalpha(param[0]) || param[0] == '_')) {
> > +		char *offs;
> > +
> > +		field_str = strsep(&param, ":");
> 
> [Severity: Low]
> Does this code prevent removing the clear_wprobe trigger if it has a count
> but no field?

Ah, indeed. The trigger shows ":count=N" or ":unlimited" for counter
instead of digit value.

> 
> If the user sets a count on a clear_wprobe trigger, wprobe_trigger_print()
> outputs the trigger as ending with ":count=N". When attempting to remove it
> by writing the exact string prepended with '!', this parser checks if the
> parameter starts with a letter.
> 
> Since "count=N" starts with a letter ('c'), it treats it as an event field
> name, and fails with -ENOENT in wprobe_trigger_field_parse(), preventing the
> trigger from being unregistered.

OK, let me fix it.

> 
> [ ... ]
> 
> > +	/* Soft-enable (register) wprobe event on WPROBE_DEFAULT_CLEAR_ADDRESS */
> > +	if (!trace_event_try_get_ref(wprobe_file->event_call)) {
> > +		ret = -ENODEV;
> > +		goto out_free_trigger;
> > +	}
> > +
> > +	ret = trace_event_enable_disable(wprobe_file, 1, 1);
> > +	if (ret < 0)
> > +		goto out_put;
> > +
> > +	if (!clear)
> > +		WRITE_ONCE(tw->addr, WPROBE_DEFAULT_CLEAR_ADDRESS);
> 
> [Severity: Medium]
> Should we update the target address before soft-enabling the event?

Ah, indeed. We also need to roll it back if soft-enable fails.

> 
> The documentation suggests initializing a new wprobe at address 0 and keeping
> it disabled. When we call trace_event_enable_disable(wprobe_file, 1, 1) here,
> it installs hardware breakpoints monitoring the current address (e.g., 0).
> 
> The parked dummy address WPROBE_DEFAULT_CLEAR_ADDRESS is only assigned to
> tw->addr afterwards, which means the hardware breakpoints are left actively
> monitoring address 0 and could generate spurious debug exceptions.
> 
> [ ... ]
> 
> > +out_disable:
> > +	trace_event_enable_disable(wprobe_file, 0, 1);
> > +out_put:
> > +	trace_event_put_ref(wprobe_file->event_call);
> > +out_free_trigger:
> > +	event_trigger_reset_filter(cmd_ops, trigger_data);
> > +	event_trigger_free(trigger_data);
> > +	return ret;
> 
> [Severity: Medium]
> Can this leak trigger_data and wprobe_data on the error path?
> 
> When wprobe_trigger_cmd_parse() executes, it increments the trigger_data
> refcount to 1 via event_trigger_init().
> 
> It then calls event_trigger_register() which calls wprobe_register_trigger()
> and increments the refcount to 2 via data->cmd_ops->init(data).
> 
> If trace_event_trigger_enable_disable() fails inside wprobe_register_trigger(),
> it returns an error without balancing the reference count:
> 
> kernel/trace/trace_wprobe.c:wprobe_register_trigger() {
> 	...
> 	ret = trace_event_trigger_enable_disable(file, 1);
> 	if (ret < 0) {
> 		list_del_rcu(&data->list);
> 		update_cond_flag(file);
> 	}
> 	return ret;
> }
> 
> The error path here then calls event_trigger_free(trigger_data), which only
> decrements the refcount from 2 to 1 and skips freeing the objects.

Ah, OK. It should call the data->cmd_ops->free() in failure path.

Thanks,

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/178739053919.1520941.17662338993878200834.stgit@devnote2?part=9


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
