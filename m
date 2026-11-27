Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795757250;
	b=3dXgLLya5HrhRTdCdZ0IJQ4lrvC9n1BU8seVc2I8P2H0rPHt4FhCy/3zrT0EZfmXCJLq
	 6jUWlDLHbu5pVRSFGU0X309vG4pTabB5bxVb63rozG1oOQVrRlirgNMMdsNSWmnCvV3nW
	 h2Pg45BS5JPrPKXsJRRwNyW2ks4qWkQtV89O4WJZkq6vt2u3YHQOYIDD3stpBrL2zfhUR
	 KPYeDD5J+kLmMJUyqty2PZtlXeSh2Rkv8u8WfyxjZjg7VzW62q0ubiIGQOASg2YKQ8C4J
	 FgmxjwnM8JuzTN7EqB84h6SVkOf66fhyHJVxafvKFWCDJnEuxDLQAn3/WA54ZDXzjbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795757250;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XycquKWts5nXmtBbYAEA4yyPDh0P442LQAAEeCZ4nlw=;
	b=e3DmrwXqtU5GJJvCL4jwPgBBnnm8qsLP/z2cgS3l53yY5IhcokJPF5Ou5EPivaw4k7ee
	 RnToXcJxZ86IXam+o2ittJsLKR/u/1Zx5vD92nMbzqvwncwSuAGK72qun8KgQWRuoKjkM
	 Gxp0JMzuuNFsP8eQAzo3nZKP3VPR41DKI6X9NEOmlre17b+are5kptW16nuRAO++VICzX
	 kCkhziVeApXtC7N7w71S5luLrl1jlcgcuDZ5bqWMzCtlukw7BTlQN64DPU/humUvHA8Mx
	 hDGOQCpyFLmpoOL254s5CfS84prY++D3loXVJJPvnmD/weZIfZUpYKoFRUYRbRE7i6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flK2RuF0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48D0606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 05:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flK2RuF0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39BB1F00893;
	Fri, 27 Nov 2026 05:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795757249;
	bh=XycquKWts5nXmtBbYAEA4yyPDh0P442LQAAEeCZ4nlw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=flK2RuF0XhLmqaYHKnYhsAFBf9XY2DydB+NSMHkSXtN0vzyu7f+eCCxAZBq5ffo7E
	 FMd6fDc23ayiFNIxcv+EBvD7hNl9uwjlPsmtTnikA5YqLS6zSJGbcpTg/XvmYqd+LE
	 xGMiU1xaRW1wiK1wI2Uvtml6WNM4A4xsDAAn0ShikghT80iloxY7xGxrMrnLEwiG5u
	 34RB3JF9Q65hwiBSucocL/C8Vp4SZIAbYC8rYyP4De5rVj3hXvg1H2w1noxRloExiX
	 0fcProVpVOxpMRHR1r8BUtaTVYP+vdGQt+10hXLprDhvHm41G8/aBI6KV+WOueAJwK
	 uQxgLML1Yk1pw==
Message-ID: <sashiko-outbox-236642@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] parisc: perf: add a perf events PMU for
 PA-8800/PA-8900
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261127-parisc-perf-pa8800-v1-5-4f3f077010ce@gmail.com>
References: <20261127-parisc-perf-pa8800-v1-0-4f3f077010ce@gmail.com>
 <20261127-parisc-perf-pa8800-v1-5-4f3f077010ce@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 05:27:29 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] parisc: perf: NULL ctx access in mako_pmu_event_init() on
  standalone event
- [Medium] parisc: perf: unconditional counter disable and re-enable in
  mako_pmu_disable()
- [Medium] parisc: perf: missing perf_event_update_userpage() in
  mako_pmu_add()
- [Medium] parisc: perf: redundant RDR chain-1 counter reads in
  mako_read_all() callers
--

commit b4421aebf6e5977bf8d6dd6b5012fa15f8624837
Author: Matt Turner <mattst88@gmail.com>

parisc: perf: add a perf events PMU for PA-8800/PA-8900

This commit exposes the PA-8800/PA-8900 performance counters to perf events
as the "cpu" PMU, using a per-CPU hrtimer to poll the 31-bit hardware
counters and coordinating ownership with /dev/perf.

> diff --git a/arch/parisc/kernel/perf_event_mako.c b/arch/parisc/kernel/pe=
rf_event_mako.c
> new file mode 100644
> index 0000000000000..f43c8a6cf13d2
> --- /dev/null
> +++ b/arch/parisc/kernel/perf_event_mako.c
[ ... ]
> +/*
> + * Read the counters, and if they are running for perf, update every
> + * started event. The counters have to be stopped to be read. They may
> + * have been left running by /dev/perf, so this always reads them. Called
> + * with interrupts off.
> + */
> +static void mako_read_all(struct mako_pmu_cpu *pc)
> +{
> +	int i;
> +
> +	perf_mako_disable();
> +	if (perf_mako_read(pc->ctrs) =3D=3D 0 && pc->running) {
> +		for (i =3D 0; i < MAKO_NUM_CTRS; i++) {
> +			struct perf_event *event =3D pc->events[i];
> +
> +			if (event && !(event->hw.state & PERF_HES_STOPPED))
> +				mako_event_update(event, pc->ctrs[i]);
> +		}
> +	}
> +	if (pc->running)
> +		perf_mako_enable();
> +}

[Severity: Medium]
Does mako_read_all() need to call perf_mako_read(pc->ctrs) when pc->running
is false?

The perf core calls mako_pmu_disable() before scheduling events out via
mako_pmu_del() -> mako_pmu_stop() and before scheduling events in via
mako_pmu_add() -> mako_pmu_start().  Because mako_pmu_stop() and
mako_pmu_start() each call mako_read_all(pc) per event while pc->running is
already false, every context switch or reschedule with N active events
performs up to 2N + 1 redundant perf_mako_read() calls on already-stopped
counters, each acquiring the cross-core RDR chain 1 lock and shifting all
256 bits of shared RDR15_1 out and back in with interrupts disabled.

> +
> +static enum hrtimer_restart mako_poll(struct hrtimer *timer)
> +{
> +	struct mako_pmu_cpu *pc =3D container_of(timer, struct mako_pmu_cpu, ti=
mer);
> +
> +	mako_read_all(pc);
> +	hrtimer_forward_now(timer, ns_to_ktime(MAKO_POLL_NS));
> +
> +	return HRTIMER_RESTART;
> +}
> +
> +static void mako_pmu_disable(struct pmu *pmu)
> +{
> +	struct mako_pmu_cpu *pc =3D this_cpu_ptr(&mako_pmu_cpu);
> +
> +	mako_read_all(pc);
> +	perf_mako_disable();
> +	pc->running =3D false;
> +}

[Severity: Medium]
Should mako_pmu_disable() return early when !pc->running, and clear
pc->running before calling mako_read_all(pc) (or after updating the counts
without re-enabling the counters)?

When pc->running is true, calling mako_read_all(pc) first causes
mako_read_all() to transiently re-enable the hardware counters right before
mako_pmu_disable() disables them again.

When pc->running is false, mako_pmu_disable() still stops the hardware
counters.  Once a per-CPU event has been created on mako_pmu and closed,
mako_pmu's perf_event_pmu_context remains linked on
cpuctx->ctx.pmu_ctx_list; if /dev/perf is then opened and starts the
counters, any perf_ctx_disable(&cpuctx->ctx, 0) on that CPU (such as a task
with a pinned software event scheduling in) calls mako_pmu_disable() and
stops /dev/perf's active counters, while the paired mako_pmu_enable() sees
no mako_pmu events and leaves them stopped.

[ ... ]
> +static int mako_pmu_add(struct perf_event *event, int flags)
> +{
> +	struct mako_pmu_cpu *pc =3D this_cpu_ptr(&mako_pmu_cpu);
> +	struct perf_event *events[MAKO_NUM_CTRS + 1];
> +	unsigned int code =3D mako_event_code(event);
> +	struct perf_mako_config cfg;
> +	int idx[MAKO_NUM_CTRS + 1];
> +	unsigned long free =3D 0;
> +	int i, n;
> +
> +	n =3D mako_collect(pc, event, events);
> +	if (n > MAKO_NUM_CTRS || !mako_schedule(events, n, idx, &cfg))
> +		return -EAGAIN;
> +
> +	/*
> +	 * Keep the events already here on their counters. Each event can
> +	 * use either only one counter or only ctr1 and ctr3, so if the
> +	 * events fit together, one of this event's counters is free.
> +	 */
> +	for (i =3D 0; i < MAKO_NUM_CTRS; i++)
> +		if (!pc->events[i] && (mako_ctrs[code] & BIT(i)))
> +			free |=3D BIT(i);
> +
> +	event->hw.idx =3D __ffs(free);
> +	pc->events[event->hw.idx] =3D event;
> +
> +	event->hw.state =3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +	if (flags & PERF_EF_START)
> +		mako_pmu_start(event, PERF_EF_RELOAD);
> +
> +	return 0;
> +}

[Severity: Medium]
Is perf_event_update_userpage(event) missing in mako_pmu_add()?

mako_pmu_del() calls perf_event_update_userpage(event) on schedule-out, but
neither mako_pmu_add() nor mako_pmu_start() calls it on schedule-in.  Since
merge_sched_in() only updates the userpage when scheduling in fails,
userspace mappings of perf_event_mmap_page see stale index, offset,
time_enabled, and time_running fields while the event is active.

[ ... ]
> +static int mako_pmu_event_init(struct perf_event *event)
> +{
> +	struct perf_event *leader =3D event->group_leader, *sibling;
> +	struct perf_event *events[MAKO_NUM_CTRS + 1];
> +	struct perf_mako_config cfg;
> +	int idx[MAKO_NUM_CTRS + 1];
> +	int code, n =3D 0;
> +
> +	switch (event->attr.type) {
> +	case PERF_TYPE_HARDWARE:
> +		code =3D mako_map_hw(event->attr.config);
> +		break;
> +	case PERF_TYPE_RAW:
> +		if (event->attr.config & ~MAKO_CONFIG_EVENT)
> +			return -EINVAL;
> +		code =3D event->attr.config;
> +		break;
> +	default:
> +		return -ENOENT;
> +	}
> +	if (code < 0)
> +		return code;
> +	if (code >=3D MAKO_EV_MAX || !mako_ctrs[code])
> +		return -EINVAL;
> +
> +	event->hw.config =3D code;
> +
> +	/* The whole group has to fit on one core. */
> +	if (leader !=3D event && leader->pmu =3D=3D event->pmu)
> +		events[n++] =3D leader;
> +	for_each_sibling_event(sibling, leader) {

[Severity: Medium]
Can for_each_sibling_event(sibling, leader) dereference a NULL leader->ctx
when event is a standalone event or a new group leader (leader =3D=3D event=
)?

During perf_event_alloc() -> perf_init_event() -> perf_try_init_event(),
event->ctx is still NULL and perf_try_init_event() only locks
group_leader->ctx->mutex when event->group_leader !=3D event.  Calling
for_each_sibling_event(sibling, leader) when leader =3D=3D event evaluates
lockdep_assert_event_ctx(leader):

include/linux/perf_event.h:for_each_sibling_event() {
	lockdep_assert_event_ctx(event);			\
	if ((event)->group_leader =3D=3D (event))			\
		list_for_each_entry((sibling), &(event)->sibling_list, sibling_list)
}

Under CONFIG_PROVE_LOCKING=3Dy, lockdep_is_held(&(leader)->ctx->mutex)
triggers a WARN_ON_ONCE() splat on every standalone perf_event_open() and
dereferences a near-NULL pointer in match_held_lock() when an event is
inherited across fork().  Guarding the sibling loop with if (leader !=3D
event) avoids touching leader->ctx before the event is installed in a
context.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-parisc-per=
f-pa8800-v1-0-4f3f077010ce@gmail.com?part=3D5
