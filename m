Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B1A2F3C3E
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 03:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784171553; cv=none; b=FtmqDt8AqpJgq+EJ3NkNNZD6y+14EypNe3i5WyUihMkLAYWPrjFSQZ8jYZJorPgWIL8KQFgnvamRUKwvo8R7O634k7wMfrEWM5LC9XlKTIz256wkWKLNR6WJ+U0j/+A7OrTZfaYDl+KuoWyr/1tAX9FGTxRJQ1SihCPlc61NgMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784171553; c=relaxed/simple;
	bh=YbCt6LKj1FQmRh4QYrgcEQjQ7bCtTFS01Tfp7MhhzPU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QqzR8pBW90M5jcHPWPJ8bbB7TIbSwLuIN7O6wIxQv/fLEDnFzNFGeGqtY+o04u39Bau+jWgl2Josdi/IR0ECPHBNcg+hsL/4UAwxqCqR87ApTv7YPlWVE4FFA11uEbBfYjfBNc2xLME2usU52/pY5emUysIvqQzQUliq5mH1wAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3MFZLEC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3MFZLEC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDDC1F000E9;
	Thu, 16 Jul 2026 03:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784171552;
	bh=7YeEjXoWAom5fcDn3g+0pK2S4iv+ulCGde7vaITayFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i3MFZLEC0gnSFTVQpxSWCvwr39FMXseWt61kgY5ZFavO+qd2X6TDlTo+xSaFueQKT
	 UFMs5ZS0YpqgvE9ZCSt8yLkbftEgTmSeG9nirWc9Dqsv5sTPUAyz2J6WYhLEXighyj
	 cITorjT6w/N6QlJ5sBxKlXiTpEzVXPcZk6l2XZ5diHtiSU5DESNPmFQNVbouORRPzG
	 aB/f5FNgv/MH9ixtguOD7pw5E5PcB5vLwHFlsmJALT/l0S3g+Gj8S73ItbiAyeTKfy
	 vRnNaU7aO2kK6jZi47iD9msto11RgzvH86tY4fRVeYdbqUO2ydE3fP+65GHBH+6Quw
	 Zpn1cLnJrmQnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 8/9] tracing: wprobe: Add wprobe event trigger
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178417042645.209165.11425022850599246231.stgit@devnote2>
References: <178417033089.209165.16717079876036408877.stgit@devnote2>
 <178417042645.209165.11425022850599246231.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 03:12:31 +0000
Message-Id: <20260716031231.EBDDC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Uncancelled asynchronous work causes NULL pointer dereference when=
 disabling wprobes.
- [High] State corruption in wprobe_trigger_cmd_parse when registering clea=
r_wprobe.
- [High] Use-After-Free in wprobe triggers due to incorrect RCU grace perio=
d handling.
- [Medium] Memory leak of trigger_data->filter on error path in wprobe_trig=
ger_cmd_parse.
- [Low] Build failure due to static declaration of event_trigger_free.
--

--- Patch [8]: [PATCH v8 8/9] tracing: wprobe: Add wprobe event trigger ---
commit aadb441dbb3ae8cb3459288e9388e6fa92216b82
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Date:   Thu Jul 16 02:53:46 2026 +0000

    tracing: wprobe: Add wprobe event trigger
   =20
    Add wprobe event trigger to set and clear the watch event dynamically.
    This allows us to set an watchpoint on a given local variables and
    a slab object instead of static objects.

> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 2f07c5c4ffc87..b4f964839350f 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1982,6 +1982,7 @@ trigger_data_alloc(struct event_command *cmd_ops, c=
har *cmd, char *param,
>  		   void *private_data);
>  extern void trigger_data_free(struct event_trigger_data *data);
>  extern int event_trigger_init(struct event_trigger_data *data);
> +extern void event_trigger_free(struct event_trigger_data *data);

[Severity: Low]
Does this code build successfully when CONFIG_WPROBE_TRIGGERS is enabled?

The patch declares event_trigger_free() as extern here and calls it from
trace_wprobe.c, but its definition in kernel/trace/trace_events_trigger.c
remains static.

>  extern int trace_event_trigger_enable_disable(struct trace_event_file *f=
ile,
>  					      int trigger_enable);
>  extern void update_cond_flag(struct trace_event_file *file);
> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> index 942ad2810d369..69ad48ac210c6 100644
> --- a/kernel/trace/trace_wprobe.c
> +++ b/kernel/trace/trace_wprobe.c
[ ... ]
> @@ -197,9 +208,42 @@ static void __unregister_trace_wprobe(struct trace_w=
probe *tw)
>  	}
>  }
> =20
> +static int trace_wprobe_update_local(struct trace_wprobe *tw, unsigned l=
ong addr)
> +{
> +	struct perf_event *bp =3D *this_cpu_ptr(tw->bp_event);

[Severity: High]
If a wprobe trigger has recently fired, tw->irq_work and tw->work may be qu=
eued.
If a user disables the wprobe, __unregister_trace_wprobe() clears tw->bp_ev=
ent
to NULL.

When tw->work runs concurrently and calls trace_wprobe_update_local(), will
this_cpu_ptr(tw->bp_event) calculate a garbage per-CPU offset from NULL and=
 cause
a panic when dereferencing bp?

Should the pending work be cancelled when the wprobe is unregistered?

> +	struct perf_event_attr attr =3D bp->attr;
> +
> +	attr.bp_addr =3D addr;
> +	return modify_wide_hw_breakpoint_local(bp, &attr);
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
> +		trace_event_put_ref(wprobe_data->file->event_call);
> +		trigger_data_free(data);
> +
> +		/* Wait for RCU readers (tracepoint executions) to finish */
> +		call_rcu(&wprobe_data->rcu, wprobe_trigger_data_rcu_free);

[Severity: High]
Since triggers can be attached to faultable syscall tracepoints (which exec=
ute
in a sleepable RCU Tasks Trace context), is call_rcu() sufficient here?

If a sleeping tracepoint reader is iterating triggers when this unregistrat=
ion
occurs, the normal RCU grace period will expire and wprobe_data will be fre=
ed.
When the tracepoint wakes up and executes wprobe_trigger(), won't it derefe=
rence
the freed wprobe_data?

Should this use tracepoint_synchronize_unregister() to safely wait for all
tracepoint contexts?

> +	}
> +}
> +
> +static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
> +				    struct trace_event_file *file,
> +				    char *glob, char *cmd,
> +				    char *param_and_filter)
> +{
[ ... ]
> +	ret =3D event_trigger_set_filter(cmd_ops, file, filter, trigger_data);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Soft-enable (register) wprobe event on WPROBE_DEFAULT_CLEAR_ADDRESS =
*/
> +	if (!trace_event_try_get_ref(wprobe_file->event_call))
> +		return -ENODEV;

[Severity: Medium]
If trace_event_try_get_ref() fails, this returns -ENODEV directly.

Since event_trigger_reset_filter() is bypassed on this error path, does this
leak the dynamically allocated filter memory?

> +
> +	WRITE_ONCE(tw->addr, WPROBE_DEFAULT_CLEAR_ADDRESS);

[Severity: High]
Registering a clear_wprobe trigger on an already-active wprobe is permitted.

However, this unconditionally overwrites tw->addr with
WPROBE_DEFAULT_CLEAR_ADDRESS. When the clear_wprobe trigger fires, it checks
if tw->addr !=3D WPROBE_DEFAULT_CLEAR_ADDRESS.

Since it has already been set to WPROBE_DEFAULT_CLEAR_ADDRESS here, will th=
is
prevent the clear trigger from actually clearing the hardware breakpoints,
thereby corrupting the wprobe state and permanently leaking hardware breakp=
oints?

> +	ret =3D trace_event_enable_disable(wprobe_file, 1, 1);
> +	if (ret < 0) {
> +		trace_event_put_ref(wprobe_file->event_call);
> +		event_trigger_reset_filter(cmd_ops, trigger_data);
> +		return ret;
> +	}
> +	ret =3D event_trigger_register(cmd_ops, file, glob, trigger_data);
> +	if (ret) {
> +		event_trigger_reset_filter(cmd_ops, trigger_data);
> +		trace_event_enable_disable(wprobe_file, 0, 1);
> +		trace_event_put_ref(wprobe_file->event_call);
> +		synchronize_rcu();

[Severity: High]
Similar to call_rcu() above, is synchronize_rcu() sufficient here for
tracepoints that rely on RCU Tasks Trace?

> +		return ret;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178417033089.209165=
.16717079876036408877.stgit@devnote2?part=3D8
