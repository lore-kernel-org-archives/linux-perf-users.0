Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991779;
	b=eKMaKODA3yhY4nKxqCsuf+nda0Xd5WlaanhzE260W3rDuUh07nqwWpFoMeevYxBKgFqc
	 9qSjSEZSyDNZm7LFdHBdkhYNj7DqpG54jW53Zfaonjo0OYDjUmCZ7XzyZiJcWsZC6pdvu
	 s1CQpr47lXb2brU6AGIsd2ApIhBJozzUY9lkfT7nw9J8R7EIHQrGRL9YtIwiDC4vyMYkS
	 GGGDgn6Xy+uv1ArfdeiJ7KpINj9oMxBUIs7En36PXrG6BKVufmT++l1o+8LQuUoLm6PG+
	 VvRreg3vWxq8y6xfoP7NzOJsJqgtrYwfi8zBe3UYhscI+tNNEU1W6rzKMBGSHyhpqQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991779;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Pt/5fpmP0+J+ocGo6pBCbou02A0K/XqveWyQAw/dN5s=;
	b=zjFrqJZ8ckxufTClwjAPMr4gk89kN4Qtkct/cZwiYaUt6Tqxsk5SfObGlnf0cqSVt8ej
	 /HgNkF8pF+azwMhW8thxLmiNJCu3998Pr/2nlWkHGzEXqCVNkhqbLkQ3nuOvdsypz7/Tu
	 a08QSYwDvuhqpCaQ12I/ADqCuhojawSPAJBgUedzwUUUpWrPKmJ9SBEGuIUcrYjwk+ZA6
	 bHU/XjuONmcRAm2XQKOuz4+AinSPq2Av/VWrWjOJlnR/cbz8Owqqy+aCz6yC6DqyQHzd1
	 lg6wNs1ztGt1F/xVHy96rcpAy5gY6jRMql5MqwCxDCn+X+Y+g2J+yCQCh/L+QQo00ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oyyfVCkR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C013606A31C;
	Wed, 18 Nov 2026 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oyyfVCkR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811BD1F000C4;
	Wed, 18 Nov 2026 08:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991778;
	bh=Pt/5fpmP0+J+ocGo6pBCbou02A0K/XqveWyQAw/dN5s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oyyfVCkRxEv2kmVKzRvGpZNsmcaswlqyfyhPMimSP1iWqJOhroJ/ys0R7OynQzq1t
	 oXWpmOZRFQrsFsc6iP/kJo6QBE7tjnlQVtl8gS4cfNorapekSB3Asw9wUqgVK0fvH/
	 cp16wJFqycrrvXuavwtOh0yw7nbjhHCNVbfxyjUb9Vl5kWHc9UyW8xj7Ac4ojGCLjo
	 cVjJZd4OQW+mwRx4XI8S7SV0pX37vOcWoDdYfbJDozHVVaAbjI+l0ZVe+46YLRrkUy
	 WIkLjPgqA+RIAVd0NgZbIWXPUO/F99YFsHtcLcuTRlxc6+KwlIFa2+qX+KSli2PvRm
	 BIBde8/GaPo9Q==
Message-ID: <sashiko-outbox-220512@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 4/5] perf: riscv: Add PDIS event and counter
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>, linux-perf-users@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261118081327.10684-11-zhangzhanpeng.jasper@bytedance.com>
References: <20261118081327.10684-7-zhangzhanpeng.jasper@bytedance.com>
 <20261118081327.10684-11-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:49:38 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] perf: riscv: stale pcpu->switching in pdis_del() inhibits
  subsequent events
- [Medium] perf: riscv: pdis_event_update() drops period and corrupts
  state on wrap
- [Medium] perf: riscv: unguarded for_each_sibling_event() in
  pdis_event_init()
--

commit ae54dcd2ba8108979f94818a492fed1b6ab87dcc
Author: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

perf: riscv: Add PDIS event and counter callbacks

This commit implements perf event initialization, counter programming,
read/start/stop callbacks, and task context-switch handling for the
experimental RISC-V PDIS PMU.

> diff --git a/drivers/perf/riscv_pdis.c b/drivers/perf/riscv_pdis.c
> index b7671e5ad63eb..9a8fe5e4ab828 100644
> --- a/drivers/perf/riscv_pdis.c
> +++ b/drivers/perf/riscv_pdis.c

[ ... ]

> @@ -119,19 +148,299 @@ void riscv_pdis_cpu_starting(void)
>  	cpumask_set_cpu(cpu, &pdis_cpus);
>  }

[ ... ]

> +static int pdis_event_init(struct perf_event *event)
> +{
> +	struct perf_event *sibling;
> +	u64 mode;
> +	int ret;
> +
> +	if (event->attr.type !=3D pdis_pmu.type)
> +		return -ENOENT;
> +	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK ||
> +	    event->attr.inherit || event->attr.freq || event->attr.exclusive ||
> +	    event->attr.aux_output ||
> +	    !is_sampling_event(event))
> +		return -EOPNOTSUPP;
> +	if (!cpumask_test_cpu(event->cpu, &pdis_cpus))
> +		return -ENODEV;
> +	if (event->attr.config > RISCV_PDIS_SELECT_CONTROL ||
> +	    event->attr.config1 || event->attr.config2)
> +		return -EINVAL;
> +	/* Discovery requires host-only execution; an explicit H is optional. */
> +	if (event->attr.sample_type & ~RISCV_PDIS_SAMPLE_TYPES ||
> +	    event->attr.exclude_host ||
> +	    event->attr.exclude_idle || event->attr.precise_ip ||
> +	    event->attr.exclude_user =3D=3D event->attr.exclude_kernel)
> +		return -EOPNOTSUPP;
> +	if (event->group_leader !=3D event && event->group_leader->pmu =3D=3D e=
vent->pmu)
> +		return -EINVAL;
> +	for_each_sibling_event(sibling, event->group_leader) {
> +		if (sibling !=3D event && sibling->pmu =3D=3D event->pmu)
> +			return -EINVAL;
> +	}

[Severity: Medium]
Does calling for_each_sibling_event() when event->group_leader =3D=3D event
trigger a lockdep splat under CONFIG_PROVE_LOCKING=3Dy?

For a newly allocated standalone event or group leader, event->ctx is still
NULL during pmu->event_init(), and perf_try_init_event() only locks
group_leader->ctx->mutex when event->group_leader !=3D event.
for_each_sibling_event() unconditionally runs lockdep_assert_event_ctx(),
which checks lockdep_is_held(&event->ctx->mutex) with event->ctx =3D=3D NULL
and fires WARN_ON_ONCE.  Guarding the loop with
if (event->group_leader !=3D event) avoids this.

[ ... ]

> +/* COUNT is frozen by the caller; OF is sticky until acknowledged. */
> +static void pdis_event_update(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	u64 period =3D hwc->last_period;
> +	s64 prev =3D local64_read(&hwc->prev_count);
> +	s64 delta, next, step;
> +	u32 progress;
> +
> +	do {
> +		u32 count =3D csr_read(RISCV_PDIS_CSR_COUNTER);
> +		bool pending =3D csr_read(CSR_SCOUNTOVF) & RISCV_PDIS_COUNTER_BIT;
> +		bool accounted =3D prev & PDIS_OF_ACCOUNTED;
> +
> +		progress =3D count + (u32)period;
> +		/* COUNT may have overflowed without reloading yet. */
> +		if (progress >=3D period)
> +			return;
> +
> +		/* OF can reveal one wrap; multiple unseen wraps cannot be recovered. =
*/
> +		step =3D (s64)progress - (u32)prev;
> +		delta =3D step;
> +		if (step < 0 || (pending && !accounted))
> +			delta +=3D period;
> +		next =3D progress;
> +		if (accounted || pending || step < 0)
> +			next |=3D PDIS_OF_ACCOUNTED;
> +	} while (!local64_try_cmpxchg(&hwc->prev_count, &prev, next));
> +
> +	local64_add(delta, &event->count);
> +	/* Apply the position change without overwriting a nested update. */
> +	local64_sub(step, &hwc->period_left);
> +}
> +
> +static void pdis_update_and_quiesce(struct perf_event *event)
> +{
> +	csr_set(CSR_SCOUNTINHIBIT, RISCV_PDIS_COUNTER_BIT);
> +	pdis_event_update(event);
> +	pdis_quiesce();
> +}

[Severity: Medium]
Can returning early on progress >=3D period in pdis_event_update() lose the
elapsed period and leave the counter state out of sync when called from
pdis_update_and_quiesce()?

If COUNT has wrapped past 0xffffffff and is waiting for an in-flight
selection to retire and reload INITVAL when pdis_stop() or
pdis_sched_task() calls pdis_update_and_quiesce(), pdis_event_update()
returns without updating event->count, hwc->prev_count, or
hwc->period_left, and pcpu->counter_valid remains true.  pdis_quiesce()
then writes 0 to RISCV_PDIS_CSR_CTL (cancelling the in-flight selection)
and clears PDIS_OF_ACCOUNTED.

Because pcpu->counter_valid is still true, a subsequent sched-in or
non-reloading pdis_start() calls pdis_program(event, false) without
reloading RISCV_PDIS_CSR_COUNTER.  The counts up to the wrap are lost from
event->count, hwc->period_left keeps its stale value across a stop, and if
cancelling the selection leaves COUNT at 0, every subsequent
pdis_event_update() continues to see progress >=3D period until COUNT
increments through 2^32 - period events.

[ ... ]

> +static void pdis_del(struct perf_event *event, int flags)
> +{
> +	struct pdis_cpu *pcpu =3D this_cpu_ptr(&pdis_cpu);
> +
> +	pdis_stop(event, PERF_EF_UPDATE);
> +	pcpu->event =3D NULL;
> +	pcpu->counter_valid =3D false;
> +	perf_sched_cb_dec(event->pmu);
> +}

[ ... ]

> +/* Drop pending selections before changing the task used for sample meta=
data. */
> +static void pdis_sched_task(struct perf_event_pmu_context *ctx,
> +			   struct task_struct *task, bool sched_in)
> +{
> +	struct pdis_cpu *pcpu =3D this_cpu_ptr(&pdis_cpu);
> +	struct perf_event *event =3D pcpu->event;
> +
> +	pcpu->switching =3D !sched_in;
> +	if (!pcpu->ready || !event || (event->hw.state & PERF_HES_STOPPED))
> +		return;

[Severity: Medium]
Can pdis_del() leave pcpu->switching stuck at true if the event is removed
during a context switch?

On task switch-out, __perf_event_task_sched_out() calls
perf_pmu_sched_task(task, next, false), which runs pdis_sched_task() and
sets pcpu->switching =3D true.  Before perf_pmu_sched_task(prev, task, true)
runs on switch-in, perf_event_context_sched_in() can schedule out a
flexible CPU-wide PDIS event when the incoming task has a pinned task
event:

__perf_event_task_sched_out()
  perf_pmu_sched_task(..., false)
    pdis_sched_task(..., false)
      pcpu->switching =3D true
__perf_event_task_sched_in()
  perf_event_context_sched_in()
    ctx_sched_out(&cpuctx->ctx, NULL, EVENT_FLEXIBLE)
      event_sched_out()
        pdis_del()
          perf_sched_cb_dec(event->pmu)

If the PDIS event is not re-added in cpu_ctx_sched_in() (for example,
because event->pending_disable transitioned it to PERF_EVENT_STATE_OFF in
event_sched_out()), perf_sched_cb_dec() has already removed pdis_pmu from
sched_cb_list, so perf_pmu_sched_task(prev, task, true) never calls
pdis_sched_task() to clear pcpu->switching.  Any subsequent PDIS event
added or started on that CPU outside a context switch will have
pdis_enable() skip clearing CSR_SCOUNTINHIBIT, leaving the counter
inhibited.

In addition, pdis_event_init() does not reject
is_cgroup_event(event->group_leader), so a PDIS event grouped under a
cgroup software leader can be scheduled out by perf_cgroup_switch() at the
end of __perf_event_task_sched_out() after pdis_sched_task(..., false) has
already set pcpu->switching =3D true.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118081327.1068=
4-7-zhangzhanpeng.jasper@bytedance.com?part=3D4
