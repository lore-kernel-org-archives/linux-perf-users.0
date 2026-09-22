Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21C63EF643;
	Tue, 22 Sep 2026 04:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790052207; cv=none; b=cr0sC62yYmtpRqGYLBDc7wtLD3cLdyblcY/MwLEY6waIjHo+PfjLxFkVO+m5Oei3HzodkTk4v5hQxP/n5Nf8JjFLXmOaVV9VN9w1wLZcBg2+L2K9zkGBQtJu0WerWnKnpt3WbJl5xNAJ8JXdeApvGpA3DcsvDN7TL57CRLHLjhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790052207; c=relaxed/simple;
	bh=HNh6LFFz+e0NH7/c5b+cI/N6SJ6nn07BY6vxmJZE2zE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nPbI9AFO2iEOjt/bNICCL9brj1drgI9z/PiOWHVOhGmEK1gXD1euqShaDp4Suf0xm5cjI+nt/ZPl4Dbw7w+pEFZUQi3XqvkNyX9XzSkPFxpD7fw1CgkoxCzF14JhG3ebXG9j8GKqrv4Ft3SDpI+jt5XkFe2IgP72b80uV5gDxew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kg1ksjNw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kg1ksjNw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587F31F00898;
	Tue, 22 Sep 2026 04:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790052205;
	bh=Odv7FKtwUjwFOr+6EH3TTpEfPpThxAHyHGSWPGckV3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kg1ksjNwaRHyWBX6k5BKlRoOXIfSX/gAxA1mktIOm1LQ8heFueAMY3j64qVCdqIPm
	 tLJhyf1oTRDq26Nj5rZpN4kjzOX0Xi1YL+IV4PgmWFg4VqCetsePtz02mfxmJIjisb
	 tpuGJdGhKvOirpA/gyLucb7vJW6Elo06CzLdRp0rjVYkb9ybVkduxmu4HWYen7kZO2
	 GUzR/m5SUM+apA1cbkUTBy4o1Ol2DLmhpE6MZZFcxIl8Fq1svZtSoZweR6cclXieaB
	 n1MBKH6LLXj78pSXyx+nFill2liC51KopRtg53vcY2KsfWUkcWXetcWZq32OpQrQCl
	 uRxjzri5j8wGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 10/13] tracing/wprobe: Add set_wprobe and
 clear_wprobe event triggers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <179005120276.388919.1645992887114424511.stgit@devnote2>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005120276.388919.1645992887114424511.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 04:43:24 +0000
Message-Id: <20260922044325.587F31F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] tracing/wprobe: NMI deadlock in wprobe_trigger() when count is not=
 specified
- [High] tracing/wprobe: CPU hotplug race in __register_trace_wprobe() miss=
es new CPUs
- [Medium] tracing/wprobe: TOCTOU race in wprobe_trigger() corrupts watchpo=
int address
--

commit b9f67542e6bf772512bb8cbf3c3011379c301eb4
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/wprobe: Add set_wprobe and clear_wprobe event triggers

Add set_wprobe and clear_wprobe event triggers to dynamically attach
and detach hardware breakpoint address monitoring based on event field
contents.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> index 9c6100b63e8d9..f1d6aa320f213 100644
> --- a/kernel/trace/trace_wprobe.c
> +++ b/kernel/trace/trace_wprobe.c
> @@ -193,20 +217,130 @@ static int __register_trace_wprobe(struct trace_wp=
robe *tw)

[ ... ]

>  	tw->bp_event =3D register_wide_hw_breakpoint(&attr, wprobe_perf_handler=
, tw);
>  	if (IS_ERR_PCPU(tw->bp_event)) {
>  		int ret =3D PTR_ERR_PCPU(tw->bp_event);
> =20
>  		tw->bp_event =3D NULL;
>  		return ret;
>  	}
> =20
> +	mutex_lock(&wprobe_mutex);
> +	list_add(&tw->active_list, &active_wprobes);
> +	mutex_unlock(&wprobe_mutex);
> +

[Severity: High]
Does this code have a race condition with CPU hotplug?

Looking at __register_trace_wprobe(), it calls register_wide_hw_breakpoint()
which installs breakpoints and releases the hotplug lock internally.

If a new CPU comes online immediately after that lock is released, but befo=
re
this wprobe is added to active_wprobes under wprobe_mutex, could the
wprobe_cpu_online() callback miss the wprobe? This would leave the new CPU
without hardware breakpoints installed for this probe.

>  	return 0;
>  }

[ ... ]

> @@ -767,9 +923,608 @@ static int trace_wprobe_show(struct seq_file *m, st=
ruct dyn_event *ev)

[ ... ]

> +static void wprobe_trigger(struct event_trigger_data *data,
> +			   struct trace_buffer *buffer,  void *rec,
> +			   struct ring_buffer_event *event)
> +{
> +	struct wprobe_trigger_data *wprobe_data =3D data->private_data;
> +	struct trace_wprobe *tw =3D wprobe_data->tw;
> +	unsigned long target_addr, addr =3D 0, flags;
> +
> +	if (wprobe_data->field) {
> +		if (!rec)
> +			return;
> +		addr =3D *(unsigned long *)((char *)rec + wprobe_data->offset);
> +		addr +=3D wprobe_data->adjust;
> +	}
> +
> +	raw_spin_lock_irqsave(&tw->lock, flags);
> +

[Severity: High]
Could this raw_spin_lock_irqsave() cause a deadlock if interrupted by an NM=
I?

When no count limit is specified (EVENT_TRIGGER_FL_COUNT is not set),
wprobe_trigger() takes tw->lock before calling __wprobe_count_func().

If an NMI interrupts a CPU already holding tw->lock and hits a trace event
that fires the same uncounted trigger, it will attempt to acquire tw->lock
again here. Since the in_nmi() check is located inside __wprobe_count_func(=
),
the NMI would spin forever before realizing it shouldn't proceed.

> +	if (!(data->flags & EVENT_TRIGGER_FL_COUNT)) {
> +		if (!__wprobe_count_func(data, addr)) {
> +			atomic_inc(&tw->missed);
> +			goto out;
> +		}
> +	}

[Severity: Medium]
Is there a time-of-check to time-of-use (TOCTOU) race here for counted
triggers?

For counted triggers, wprobe_count_func() is called locklessly by the trace
core, which evaluates __wprobe_count_func(). Then, wprobe_trigger() is call=
ed
and takes tw->lock. Because EVENT_TRIGGER_FL_COUNT is set, the state
validation check (__wprobe_count_func()) is explicitly skipped under the lo=
ck.

If a counted trigger fires concurrently on multiple CPUs, both might
observe the unset address locklessly. Could the second CPU unconditionally
overwrite tw->addr, breaking the exclusive trigger constraint?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179005108298.388919=
.4535333252892590932.stgit@devnote2?part=3D10
