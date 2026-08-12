Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EE7314B8C
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 05:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513011; cv=none; b=aGaQMw9/lFYywA6Y1aZ9ridbfMhryB5TwQz9tRLljCskHnwxhWzTMlJapako5cf1xva3h/GjB+wkkLByTR0QIumLpemIX+NCaF3WUFZv11phZpPviNpxf/ZM25ayosAhSKJsIeLMVvfsPtgWIZ2F9+MZup83Y7AEKxBc//6E0KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513011; c=relaxed/simple;
	bh=OLwaHcMkzQELuvTxAb8XnQ9zRQ9hqBDARiQ9/bgjStI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OpDX0wQHhWo1ulviBxMZJmrYOuv9EKFSNBEJRio6DAPAMLyA/vIVGiAfu8Uk18y3T3reYti2n8ZNbtZpZCsUUol43OD3pJZeWwZEd1zJ/JXF2Dixw6yWkJQmT/m7wfOavYT+5MKNtVDaB/4WcZiEKF/TEYxyg11a2QH6kJ2Jw5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWND/T9u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWND/T9u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DC01F000E9;
	Wed, 12 Aug 2026 05:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786513009;
	bh=7HBwqv36bKj0YEifTjQXgOiqoTAyESVsnZaHQG1Mtfw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SWND/T9uXmQdvUQbH7DUEq0xvWpsYLZjiwox0ko9Oldmge2PwZGEjiqpRchY+XbBW
	 /dti3UvEYDbM24NqVUe4LkAfeC7lvNsw99tjZTj7lEdIabvdAwRkhjHlW4M06fLG/O
	 18i7VfG0tYwz+IrSSnXuxN3NNeNU4YcJa9tfVN3fszvfPomhZWFpsqHPaVgJkr3zXR
	 TKJPnPzUQ6+dOpCNdju51K3rfNgZuathTh5zH+emyjiT7c2zedQuuNveKk65QJh+5a
	 1JXDfjmUG4ZbufEaRo5ToG0edAR/q1NV5lIc1qJgfTSmL1AEVmzafnejBuiyTaeDAZ
	 JJhiryPCOXylg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] perf: Add Raspberry Pi BCM2835 AXI PMU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260812052417.2361040-2-irogers@google.com>
References: <20260812002728.2283079-1-irogers@google.com>
 <20260812052417.2361040-1-irogers@google.com>
 <20260812052417.2361040-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 05:36:49 +0000
Message-Id: <20260812053649.69DC01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Transient IPC mailbox errors corrupt PMU counter values with massi=
ve positive spikes.
- [High] Module unload triggers a Use-After-Free in CPU hotplug callback.
- [High] Global hardware monitor is never enabled for batched or grouped ev=
ent additions.
- [High] Concurrent timer manipulation triggers WARN_ON_ONCE and timer fail=
ure.
- [Medium] Lockless modification of event->hw.state overwrites PERF_HES_STO=
PPED flag.
- [Medium] VPU hardware monitor events fail to collect data for up to 2 sec=
onds due to missing explicit scheduling.
- [Medium] Unconditional lock drop in worker thread causes lockdep splat an=
d unlocked MMIO access on fallback paths.
--

--- Patch [1]: [PATCH v4 1/2] perf: Add Raspberry Pi BCM2835 AXI PMU driver=
 ---
commit 8696502c11139b0621905345c84a98e3653345a3
Author: Ian Rogers <irogers@google.com>

perf: Add Raspberry Pi BCM2835 AXI PMU driver

This commit adds an uncore performance monitoring unit (PMU) driver
for Broadcom BCM2835-BCM2711 AXI system monitors and VideoCore VPU firmware
mailbox monitors found on Raspberry Pi 1 through 4.

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/perf/rpi_axi_pmu.c

[ ... ]

> +static void rpi_axi_pmu__exit(struct rpi_axi_pmu *pmu)
> +{
> +	perf_pmu_unregister(&pmu->pmu);
> +	cpuhp_state_remove_instance(rpi_axi_pmu_cpuhp_state, &pmu->cpuhp_node);

[Severity: High]
The perf_pmu_unregister() call frees the PMU structures, but
cpuhp_state_remove_instance() will subsequently invoke
rpi_axi_pmu_offline_cpu() on active CPUs.

In rpi_axi_pmu_offline_cpu(), we see:

perf_pmu_migrate_context(&pmu->pmu, cpu, target);

Could this cause a use-after-free by dereferencing pmu->pmu after it has
been unregistered? Should the cpuhp instance be removed before unregistering
the PMU?

[ ... ]

> +static void rpi_axi_pmu_enable_bus_watcher(struct rpi_axi_pmu *pmu, enum=
 monitor mon,
> +					    int idx, int bus, int filter)
> +{
> +	int bus_control;
> +
> +	if (pmu->monitor[mon].hw_events.enabled[idx])
> +		return;
> +
> +	bus_control =3D BW_CTRL_ENABLE_BIT | (bus & 0x3F);
> +	if (filter) {
> +		bus_control |=3D BW_CTRL_ENABLE_ID_FILTER_BIT;
> +		bus_control |=3D (filter & 0x1F) << BW_CTRL_BUS_FILTER_SHIFT;
> +	}
> +	set_bus_watcher_control(pmu, mon, idx, BW_CTRL_RESET_BIT);
> +	set_bus_watcher_control(pmu, mon, idx, bus_control);
> +
> +	if (pmu->monitor[mon].hw_events.num_monitored =3D=3D 1) {
> +		set_monitor_control(pmu, mon, GEN_CTL_RESET_BIT);
> +		set_monitor_control(pmu, mon, GEN_CTL_ENABLE_BIT | GEN_CTL_WATCH_BIT);
> +	}
> +}

[Severity: High]
If grouped events are added, rpi_axi_pmu_add() will increment
num_monitored multiple times before rpi_axi_pmu_start() is called for
the group.=20

When start() invokes this function, num_monitored could already be greater
than 1. Does this mean the global monitor control will never be enabled for
grouped event additions, leaving the hardware disabled?

[ ... ]

> +static u32 rpi_axi_pmu_read_counter(struct rpi_axi_pmu *pmu, enum monito=
r mon, int idx,
> +				    enum counter counter)
> +{

[ ... ]

> +		err =3D rpi_firmware_property(pmu->firmware,
> +					    RPI_FIRMWARE_GET_PERIPH_REG,
> +					    tmp, sizeof(tmp));
> +
> +		if (err < 0 || tmp[1] !=3D 1) {
> +			dev_err(&pmu->pdev->dev, "Failed to read bus watcher\n");
> +			return 0;
> +		}
> +		ret =3D tmp[2] & 0x7FFFFFFF;

[Severity: High]
If the mailbox communication fails, this function returns 0. Over in
rpi_axi_pmu_vpu_work_handler(), this 0 is blindly used to calculate the new
count:

new_count =3D rpi_axi_pmu_read_counter(pmu, MON__VPU, idx, counter);
...
prev_count =3D local64_read(&event->hw.prev_count);
delta =3D (new_count - prev_count) & 0x7FFFFFFF;
local64_add(delta, &event->count);

Can this lead to a massive positive spike in the counter value when
transient IPC errors occur, since 0 minus prev_count evaluates to a huge
positive delta?

[ ... ]

> +static void rpi_axi_pmu_vpu_work_handler(struct work_struct *work)
> +{

[ ... ]

> +		/* If VPU bus watcher is not enabled on hardware, enable it in process=
 context */
> +		if (!pmu->monitor[MON__VPU].hw_events.enabled[idx]) {
> +			int bus =3D pmu->monitor[MON__VPU].hw_events.monitored_bus[idx];
> +			int filter =3D pmu->monitor[MON__VPU].hw_events.filter[idx];
> +
> +			spin_unlock_irq(&pmu->lock);
> +			rpi_axi_pmu_enable_bus_watcher(pmu, MON__VPU, idx, bus, filter);
> +			spin_lock_irq(&pmu->lock);
> +		}

[Severity: Medium]
This drops the spinlock unconditionally. However, if the VPU monitor is
falling back to direct MMIO where use_mailbox_interface is false,
rpi_axi_pmu_enable_bus_watcher() calls set_bus_watcher_control() which
asserts that pmu->lock is held.

Does this lock drop violate the lockdep assertion and risk data races on
non-firmware platforms?

[ ... ]

> +static enum hrtimer_restart rpi_axi_pmu_timer_handler(struct hrtimer *ti=
mer)
> +{

[ ... ]

> +	if (pmu->active_vpu_events > 0)
> +		schedule_work(&pmu->vpu_work);
> +	spin_unlock_irqrestore(&pmu->lock, flags);
> +
> +	hrtimer_forward_now(timer, RPI_AXI_PMU_TIMER_INTERVAL);
> +	return HRTIMER_RESTART;
> +}

[Severity: High]
The spinlock is dropped before calling hrtimer_forward_now(). If a
concurrent delete and add operation occurs on another CPU during this
window, could hrtimer_start() be called while the timer is still processing?

If hrtimer_start() enqueues the timer concurrently, won't
hrtimer_forward_now() run on an already queued timer and trigger a warning
in the hrtimer core?

[ ... ]

> +static void rpi_axi_pmu_start(struct perf_event *event, int flags)
> +{
> +	struct rpi_axi_pmu *pmu =3D pmu_to_rpi_axi_pmu(event->pmu);
> +	enum monitor mon =3D config_to_monitor(event->attr.config);
> +	enum counter counter =3D config_to_counter(event->attr.config);
> +	unsigned long spinflags;
> +
> +	spin_lock_irqsave(&pmu->lock, spinflags);
> +	event->hw.state =3D 0;
> +	pmu->monitor[mon].hw_events.num_started++;
> +	if (mon =3D=3D MON__SYSTEM) {
> +		int bus =3D pmu->monitor[mon].hw_events.monitored_bus[event->hw.idx];

[Severity: Medium]
When mon is MON__VPU, the hardware enablement is delegated entirely to
pmu->vpu_work. However, schedule_work() is not explicitly called here.

Does this mean VPU monitoring relies entirely on the periodic 2-second
hrtimer to start collecting data?

If so, won't short-lived perf workloads report 0 counts for VPU events
because the hardware takes up to 2 seconds to be enabled?

[ ... ]

> +static void rpi_axi_pmu_stop(struct perf_event *event, int flags)
> +{

[ ... ]

> +	if (event->hw.state & PERF_HES_STOPPED)
> +		return;
> +
> +	if (flags & PERF_EF_UPDATE) {
> +		rpi_axi_pmu_read(event);
> +		event->hw.state |=3D PERF_HES_UPTODATE;
> +	}
> +
> +	spin_lock_irqsave(&pmu->lock, spinflags);
> +	event->hw.state |=3D PERF_HES_STOPPED;

[Severity: Medium]
rpi_axi_pmu_stop() modifies event->hw.state to add PERF_HES_UPTODATE
without holding the spinlock.

Meanwhile, rpi_axi_pmu_vpu_work_handler() performs read-modify-write
operations on event->hw.state under the lock, such as:

event->hw.state |=3D PERF_HES_UPTODATE;

If stop() sets PERF_HES_STOPPED under the lock shortly after the worker
reads the old state, will the worker thread overwrite the state and
accidentally clear the PERF_HES_STOPPED flag when it writes back?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812052417.2361=
040-1-irogers@google.com?part=3D1
