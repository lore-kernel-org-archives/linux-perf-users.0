Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64732DAFA2;
	Wed, 17 Sep 2025 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118493; cv=none; b=gn/VFT+gopqEHxRZl50FFvhKzYDN+WTtlVqr9oiNM3W6iWQDGVqvcyH49YJGaFQ6WPaeertVaYtlpfIZW8taf2U/2JVXbuk3s/WiTMHQdjQBl/s7er22e0pYDoD6ELBtBFDduNLBrruCfeH5ciOSKL8g0vLATlGHUbw13bFQUb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118493; c=relaxed/simple;
	bh=SYBZyU3y6PssYgKC8Xcv0Pcmj91XU5r/G3PYMmPrA7M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cXVPIHQ72bmffwHXTyN42T/fl6M6/gXgojrsl1m2VHhaCoya/UCOepQ3BEiLfyV9nsyQkJuZ0knTotu2JM3vAEn+FHeAXetc92ZFxhKoUxkiZYxo49xk6j+skWBdQxtePkgGi3uA4xqWI/6Qz1tjd9Z+jbjLGWK1bIAktkiI39w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbWy3rTc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbWy3rTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71F9C4CEF5;
	Wed, 17 Sep 2025 14:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758118492;
	bh=SYBZyU3y6PssYgKC8Xcv0Pcmj91XU5r/G3PYMmPrA7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kbWy3rTcFfNWdTtWf3G0kn49VE1k7f+lU/C8PK4M6fjQelFRiFAziF/+Xr8+DTamf
	 8u6Jdm8nYpqrUJTb95O292jWd+jhivf19IwAwtlYR1Sf5xDsUnhy7mBQ0F9PRf3r/B
	 jynB4hGEfCDrq00t3FUJoSdrLQ2jz1F0ZMNi79+wvH26yrpVDV3cY1CAKSZqsy7kOh
	 wK2oBzrFsG0JwznNR+Z9ZJitoEmxdOFFYpYftxD3qcFId3wUXNB9Wcjoa2kwfoBOC/
	 A80cl8/m8uazfZA3/Au40z7bP6SxeLycczxm+H4+qCyrrsExUXPTq0bxbaY05+4Bs7
	 hAi2zjQqHgXbA==
Date: Wed, 17 Sep 2025 23:14:46 +0900
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
Subject: Re: [PATCH v4 5/8] tracing: wprobe: Add wprobe event trigger
Message-Id: <20250917231446.670b2c9cac245c81b268b5b2@kernel.org>
In-Reply-To: <fadb37f2-543a-4c4c-9cde-5ee7928edbe4@infradead.org>
References: <175785897434.234168.6798590787777427098.stgit@devnote2>
	<175785903073.234168.11080771050255081365.stgit@devnote2>
	<fadb37f2-543a-4c4c-9cde-5ee7928edbe4@infradead.org>
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

On Sun, 14 Sep 2025 17:25:19 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> 
> 
> On 9/14/25 7:10 AM, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add wprobe event trigger to set and clear the watch event dynamically.
> > This allows us to set an watchpoint on a given local variables and
> > a slab object instead of static objects.
> > 
> > The trigger syntax is below;
> 
>                         below:
> (just a nit :)

OK.

> 
> > 
> >   - set_wprobe:WPROBE:FIELD[+OFFSET] [if FILTER]
> >   - clear_wprobe:WPROBE[:FIELD[+OFFSET]] [if FILTER]
> > 
> > set_wprobe sets the address pointed by FIELD[+offset] to the WPROBE
> > event. The FIELD is the field name of trigger event.
> > clear_wprobe clears the watch address of WPROBE event. If the FIELD
> > option is specified, it clears only if the current watch address is
> > same as the given FIELD[+OFFSET] value.
> > 
> > The set_wprobe trigger do not change type and length. That should be
> 
>                          does                             should be done
> ?

OK.

> 
> > set when a new wprobe is created.
> > 
> > Also, the WPROBE event must be disabled when setting the new trigger
> > and it will be busy afterwards. Recommended usage is to add a new
> > wprobe at NULL address and keep disabled.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v3:
> >   - Add FIELD option support for clear_wprobe and update document.
> >   - Fix to unregister/free event_trigger_data on file correctly.
> >   - Fix syntax comments.
> >  Changes in v2:
> >   - Getting local cpu perf_event from trace_wprobe directly.
> >   - Remove trace_wprobe_local_perf() because it is conditionally unused.
> >   - Make CONFIG_WPROBE_TRIGGERS a hidden config.
> > ---
> >  Documentation/trace/wprobetrace.rst |   88 +++++++
> >  include/linux/trace_events.h        |    1 
> >  kernel/trace/Kconfig                |   10 +
> >  kernel/trace/trace_wprobe.c         |  430 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 529 insertions(+)
> > 
> > diff --git a/Documentation/trace/wprobetrace.rst b/Documentation/trace/wprobetrace.rst
> > index 9774f57e2947..a1812a8ac491 100644
> > --- a/Documentation/trace/wprobetrace.rst
> > +++ b/Documentation/trace/wprobetrace.rst
> > @@ -67,3 +67,91 @@ Here is an example to add a wprobe event on a variable `jiffies`.
> >             <idle>-0       [000] d.Z1.  717.026373: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
> >  
> >  You can see the code which writes to `jiffies` is `do_timer()`.
> > +
> > +Combination with trigger action
> > +-------------------------------
> > +The event trigger action can extend the utilization of this wprobe.
> > +
> > +- set_wprobe:WPEVENT:FIELD[+|-ADJUST]
> > +- clear_wprobe:WPEVENT[:FIELD[+|-]ADJUST]
> > +
> > +Set these triggers to the target event, then the WPROBE event will be
> > +setup to trace the memory access at FIELD[+|-ADJUST] address.
> > +When clear_wprobe is hit, if FIELD is NOT specified, the WPEVENT is
> > +forcibly cleared. If FIELD[[+|-]ADJUST] is set, it clears WPEVENT only
> > +if its watching address is the same as the FIELD[[+|-]ADJUST] value.
> > +
> > +Notes:
> > +The set_wprobe trigger do not change type and length. That should be
>                           does not                          should be done

OK.

> 
> 
> > +set when a new wprobe is created.
> > +
> > +The WPROBE event must be disabled when setting the new trigger
> > +and it will be busy afterwards. Recommended usage is to add a new
> > +wprobe at NULL address and keep disabled.
> > +
> > +
> > +For example, trace the first 8 byte of the dentry data structure passed
> 
>                                   bytes

OK

> 
> > +to do_truncate() until it is deleted by __dentry_kill().
> > +(Note: all tracefs setup uses '>>' so that it does not kick do_truncate())
> > +
> > +  # echo 'w:watch rw@0:8 address=$addr value=+0($addr)' > dynamic_events
> 
> Just using '>' here is OK?

Yes, until this, no probe hooks do_truncate, so it should not kick any
events. But maybe it is better to use '>>' to avoid confusing.

> 
> > +
> > +  # echo 'f:truncate do_truncate dentry=$arg2' >> dynamic_events
> > +  # echo 'set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger
> > +
> > +  # echo 'f:dentry_kill __dentry_kill dentry=$arg1' >> dynamic_events
> > +  # echo 'clear_wprobe:watch:dentry' >> events/fprobes/dentry_kill/trigger
> > +
> > +  # echo 1 >> events/fprobes/truncate/enable
> > +  # echo 1 >> events/fprobes/dentry_kill/enable
> > +
> > +  # echo aaa > /tmp/hoge
> > +  # echo bbb > /tmp/hoge
> > +  # echo ccc > /tmp/hoge
> > +  # rm /tmp/hoge
> > +
> > +Then, the trace data will show;
> 
> Usually that should be:      show:
> 
> but in .rst it might need to be    show::

Ah,, yes, that's right. I missed that.

Thank you!

> 
> I don't know. Haven't tested it.
> 
> 
> -- 
> ~Randy
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
