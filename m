Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698E9470E9C
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 23:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763157; cv=none; b=q9oX4GXcU1qZTl244JPrnF7aIthryYY/3eJb4OMivMZE7uSDdDzL3/7v0it61nDtlHllTQbf24MxQdCtJ8akRRTrTmyCXsl4Btz40vNLZXi47ii4sOb4Vp9qMzFKaJYCOX4nIrDC58DGwL3TWzm+MW00Ry9SMzx3HZ/cd5KxNh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763157; c=relaxed/simple;
	bh=0BlhSweqoDmv8DJ8tZBIhl/hvHSb+oakHmYM6Nn2lNk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T0RdUil2Lnz4MJQM518ibD0F5VlGC7BgQeMIvPEaCAe7b027gCPPUJFsFSHEYhfrYBEdWyQMieKFtKTGr/Xe/qk/Hwg9Tgw8452UQv6BpG0y/CbnfmLJb+b5uDDOJcHXWRfsIYzFBouDwLIer9CiyN1ayvyYHbmE4ELVP8zj/2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyAbIpJG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyAbIpJG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D141F000E9;
	Wed, 22 Jul 2026 23:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784763156;
	bh=BjbZu+z0sJiDJw9FVw8YxRHotOh7l3whb15Y/XfvTyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZyAbIpJGTix3pV3RhSupwb72G75Bq7acnhdAJKPpaU3LDmjDk+f54fkvkw9ay1M9L
	 aWeKBHgybiXwnx++a7wf370xn8JT1VxJ2D6Zk0zN27rRuj6eEzKmHPv5gnsoMls6u6
	 EZevhYJrX89SsiYi/xU6WDQ9zNd9KsxM25ya4TaXOeUG59O4N48hl0ejP0gt7bKevo
	 V1cA1S3X7wlNn0DjCQW4YVUBVd6QxmQZ/GQtlbqkAO62+i3Mmv5EHGSk8db/Wotax/
	 aiNQgatdn2ykuck0LrtxDDwRHEPDk3Xn4NwonX2XQHyYGneNeZwt7gjxUFWWgK6uE8
	 4Qzlm6pT1H62A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 01/11] tracing: wprobe: Add watchpoint probe event
 based on hardware breakpoint
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178476135985.26117.13000026917772873088.stgit@devnote2>
References: <178476134787.26117.10094977293012760490.stgit@devnote2>
 <178476135985.26117.13000026917772873088.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:32:35 +0000
Message-Id: <20260722233235.E2D141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Missing infrastructure for dynamic address updates leaves checks=
 as dead code.
- [Low] Misleading error message returned for malformed wprobe definitions.
- [Low] Comment refers to non-existent 'set_wprobe/clear_wprobe' triggers.
--

--- Patch [1]: [PATCH v10 01/11] tracing: wprobe: Add watchpoint probe even=
t based on hardware breakpoint ---
commit d872c73e586c2b750b29132ee2dfc4a1052ce6d8
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing: wprobe: Add watchpoint probe event based on hardware breakpoint

Add a new probe event for the hardware breakpoint called wprobe-event.
This wprobe allows user to trace (watch) the memory access at the
specified memory address.

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> new file mode 100644
> --- /dev/null
> +++ b/kernel/trace/trace_wprobe.c
> @@ -0,0 +1,746 @@

[ ... ]

> +static void wprobe_trace_handler(struct trace_wprobe *tw,
> +				 unsigned long addr,
> +				 struct pt_regs *regs,
> +				 struct trace_event_file *trace_file)
> +{
> +	struct wprobe_trace_entry_head *entry;
> +	struct trace_event_call *call =3D trace_probe_event_call(&tw->tp);
> +	struct trace_event_buffer fbuffer;
> +	int dsize;
> +
> +	if (WARN_ON_ONCE(call !=3D trace_file->event_call))
> +		return;
> +
> +	if (trace_trigger_soft_disabled(trace_file))
> +		return;
> +
> +	if (READ_ONCE(tw->addr) !=3D addr)
> +		return;

[Severity: Medium]
The changelog states this uses READ_ONCE(tw->addr) to safely check
dynamically updated addresses. Does this patch actually include the
infrastructure to update tw->addr dynamically?

It appears tw->addr is only set during initialization, and the SMP/IRQ
work update functions are absent. Does this make the check against addr
effectively constant?

> +
> +	dsize =3D __get_data_size(&tw->tp, (void *)addr, NULL);

[ ... ]

> +static int register_trace_wprobe_event(struct trace_wprobe *tw)
> +{
> +	struct trace_wprobe *old_tw;
> +	int ret;
> +
> +	guard(mutex)(&event_mutex);
> +
> +	old_tw =3D find_trace_wprobe(trace_probe_name(&tw->tp),
> +				   trace_probe_group_name(&tw->tp));
> +	if (old_tw) {
> +		/*
> +		 * Wprobe does not support sibling probes because the event
> +		 * trigger (set_wprobe/clear_wprobe) identifies the target
> +		 * wprobe by its event name. Having multiple wprobes sharing
> +		 * the same event name would make the target ambiguous.
> +		 */

[Severity: Low]
This isn't a bug, but the comment references 'set_wprobe/clear_wprobe'
triggers. Do these triggers actually exist in the tracing subsystem, or
should this refer to standard triggers like enable_event/disable_event?

> +		trace_probe_log_set_index(0);
> +		trace_probe_log_err(0, WPROBE_NO_SIBLING);
> +		return -EBUSY;
> +	}

[ ... ]

> +static int __trace_wprobe_create(int argc, const char *argv[])
> +{

[ ... ]

> +	if (argv[0][1] !=3D '\0') {
> +		if (argv[0][1] !=3D ':') {
> +			trace_probe_log_set_index(0);
> +			trace_probe_log_err(1, BAD_MAXACT_TYPE);
> +			return -EINVAL;
> +		}

[Severity: Low]
If a user provides an invalid prefix (like w10:event), this will return a
BAD_MAXACT_TYPE error.

Since hardware watchpoints do not support maxactive, will logging
"Maxactive is only for function exit" be misleading to users debugging
their probe definitions?

> +		event =3D &argv[0][2];
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178476134787.26117.=
10094977293012760490.stgit@devnote2?part=3D1
