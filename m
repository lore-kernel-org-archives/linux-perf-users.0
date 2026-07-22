Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FA3388890
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762990; cv=none; b=Ae3zmE4Dn1CbHPa397033C3c1+3Ih0pmLGsnJf4EbQQ5AN5b+eu6vIkSob3po03sfBaDLCq4VzYSV7/Vn385SaX6Yli70xN83FATz9uLab1ETABpUQCC2y+tTrsFCb9O/vOY1jXj7g86nnx5h5es/wWHgCrnqFhB5XqjS7qGYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762990; c=relaxed/simple;
	bh=zdV2aaJckP16f9FWAE97Wx0og5Nfn4yLNaBhhfT4ppM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZZJdICu1nc/CoVGOl6p7ptXTbwjDn5YGLwp6lOkDOautoue9FwZbD886mr1hfdJJlHUgxSVPhMLAP19Mg6gQ0PmyjPfRWUUDO1N+3iY0oNCrhl3I2TmftX/isD/oOMWE22KbGcef8kHNOkL9vWYOY4WH3uNv6DXjyvCErDLvkw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GS/FDElJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GS/FDElJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F8C1F000E9;
	Wed, 22 Jul 2026 23:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784762988;
	bh=gjNuTptJLmrip3n+w0B+4kZP3mF1rpib9ndYLx9tUSU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GS/FDElJsjhzXQDAw2RTAxPEtaXvupek5nRLZbW2+d1YHOl/0MIYDbcLIzdGUpkeQ
	 5xTZpjDGDdsuSu901puGBXCyszDp5skU/+TDJTg20JbpGXpkKqMr/qASu7CNnE0Q9x
	 yinTubi2Zjx4amkOmCn0Kb5bvQzEtEeSmMfmZSz5mI4uTTJ2SoaLjQjRa/71fTGqvx
	 6kjQXE0mmO77tNrlmsvSYTERbyCmos48yLsbtc9tCYxNvc4RsLIvELVJsyMfTcJf2s
	 HQXSVBMjQ5bjTBNreCDQoAIdH1nLDvW/Q8nAms7WakmaGup5Q62fVGk5/9LKEjRcSG
	 t9yzYOEb82EJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 08/11] tracing: wprobe: Add wprobe event trigger
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178476144141.26117.8004746214529353062.stgit@devnote2>
References: <178476134787.26117.10094977293012760490.stgit@devnote2>
 <178476144141.26117.8004746214529353062.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:29:48 +0000
Message-Id: <20260722232948.B2F8C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Premature teardown of wprobe resources during trigger unregistrati=
on leads to a Use-After-Free and NULL pointer dereference in the deferred w=
orkqueue because RCU synchronization is missing.
- [High] Incorrect RCU synchronization primitive in `wprobe_trigger_cmd_par=
se()` error path leads to a Use-After-Free on faultable (syscall) tracepoin=
ts.
--

--- Patch [8]: [PATCH v10 08/11] tracing: wprobe: Add wprobe event trigger =
---
commit 7a3a7529186a14015a2ccb9a93108962a135a419
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing: wprobe: Add wprobe event trigger

Add wprobe event trigger to set and clear the watch event dynamically.
This allows us to set an watchpoint on a given local variables and
a slab object instead of static objects.

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> index 4c23c310a383e..1edfdddf241de 100644
> --- a/kernel/trace/trace_wprobe.c
> +++ b/kernel/trace/trace_wprobe.c
[ ... ]
> @@ -794,3 +794,391 @@ static __init int init_wprobe_trace(void)
>  }
>  fs_initcall(init_wprobe_trace);
> =20
> +#ifdef CONFIG_WPROBE_TRIGGERS
> +
> +static int wprobe_trigger_global_enabled;
> +
> +#define SET_WPROBE_STR		"set_wprobe"
> +#define CLEAR_WPROBE_STR	"clear_wprobe"
> +#define WPROBE_DEFAULT_CLEAR_ADDRESS ((unsigned long)&wprobe_trigger_glo=
bal_enabled)
> +
> +struct wprobe_trigger_data {
> +	struct rcu_head rcu;
> +	struct trace_event_file *file;
> +	struct trace_wprobe *tw;
> +	unsigned int		offset;
> +	long			adjust;
> +	const char		*field;
> +	bool			clear;
> +};
> +
> +static void wprobe_trigger(struct event_trigger_data *data,
> +			   struct trace_buffer *buffer,  void *rec,
> +			   struct ring_buffer_event *event)
> +{
> +	struct wprobe_trigger_data *wprobe_data =3D data->private_data;
> +	struct trace_wprobe *tw =3D wprobe_data->tw;
> +	unsigned long addr, flags;
> +	bool changed =3D false;
[ ... ]
> +	if (changed)
> +		irq_work_queue(&tw->irq_work);
> +
> +	raw_spin_unlock_irqrestore(&tw->lock, flags);
> +}
[ ... ]
> +static void wprobe_trigger_free(struct event_trigger_data *data)
> +{
> +	struct wprobe_trigger_data *wprobe_data =3D data->private_data;
> +
> +	if (WARN_ON_ONCE(data->ref <=3D 0))
> +		return;
> +
> +	data->ref--;
> +	if (!data->ref) {
> +		/* Remove the SOFT_MODE flag */
> +		trace_event_enable_disable(wprobe_data->file, 0, 1);

[Severity: High]
Does this disable the wprobe event synchronously before waiting for RCU
readers?=20

If an in-flight RCU reader is executing wprobe_trigger() when this is calle=
d,
trace_event_enable_disable() will trigger __unregister_trace_wprobe() which
nullifies tw->bp_event and allows tw to be concurrently freed.

The in-flight reader could then queue tw->irq_work in wprobe_trigger():

	if (changed)
		irq_work_queue(&tw->irq_work);

This work then executes trace_wprobe_update_local() which dereferences the
nullified tw->bp_event:

	struct perf_event *bp =3D *this_cpu_ptr(tw->bp_event);

Can this lead to a NULL pointer dereference or use-after-free since the
cleanup doesn't wait for the RCU readers to finish?

> +		trace_event_put_ref(wprobe_data->file->event_call);
> +		trigger_data_free(data);
> +	}
> +}
> +
> +static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
> +				    struct trace_event_file *file,
> +				    char *glob, char *cmd,
> +				    char *param_and_filter)
> +{
[ ... ]
> +	ret =3D event_trigger_register(cmd_ops, file, glob, trigger_data);
> +	if (ret) {
> +		event_trigger_reset_filter(cmd_ops, trigger_data);
> +		trace_event_enable_disable(wprobe_file, 0, 1);
> +		trace_event_put_ref(wprobe_file->event_call);
> +		synchronize_rcu();

[Severity: High]
Is synchronize_rcu() sufficient to wait for faultable tracepoint readers?

Faultable tracepoints (like syscall tracepoints) use RCU Tasks Trace for
protection, which synchronize_rcu() does not wait for. If this error path is
hit while attaching to a syscall tracepoint, the in-flight readers could st=
ill
be executing when the memory is freed via the __free() cleanup attributes at
the end of the function scope.

Should this use tracepoint_synchronize_unregister() instead to ensure it
waits for all tracepoint reader types?

> +		return ret;
> +	}
> +	/* Make it NULL to avoid freeing trigger_data and wprobe_data by __free=
() */
> +	wprobe_data =3D NULL;
> +	event_trigger_free(trigger_data);
> +	trigger_data =3D NULL;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178476134787.26117.=
10094977293012760490.stgit@devnote2?part=3D8
