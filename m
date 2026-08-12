Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6E830BF4F
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 00:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786495235; cv=none; b=XfxwLuE9KdH8fOypIV2PKCI+vRnvWWgukEh6vn2t/7gtPls3uBcGK3IdK0utfpMBHoouS7ORNup7mZVpxKXQexqZsr49fROWRojYms9M0NiVKfR8v9eiqN/0yD5KwuQi5uOtDqT6fceyv5imp/v5L42n7wiT6CIp6o6gkv3Zx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786495235; c=relaxed/simple;
	bh=3z/bzLMnkCavpi5AbjUQVN69Oq0DT0cpvpOpCoTpjmo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jk1tN9JSexZ80KUMcseW+EZdeuVXJ4FI8oAdQcN4lA4Z2z1MBd6sz7tutmahUPTQ6G8BejX1nnd7cGzq0sz/1mUuhJ1IQkb73jcCVPiBh284HIdDIDOxyzgEilcqjvGcpeHWnqldMYo9JzIJDaQXFUvk5OFO4/ooHHRiFtYQoYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/2qsbVI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/2qsbVI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F88D1F00A3A;
	Wed, 12 Aug 2026 00:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786495234;
	bh=kslvo3fV3EOAWgGuc+IIdEvmyyi0Udt+/sItDuKRdZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c/2qsbVI/Ix7/Y0skZAuTVlkQBePsJAmvPOwVkKUpCg+IMO4qGVIq3NyS6NkFTy59
	 jqfbehoCcXtB8v0au+/BCdAdIikD2amxGEa89BkLcaoGwKDdTlz+3nS0P/ASQFBMH3
	 hTWL26ZUSSMjln16+60leJmNM0JVKJ5gza/wSt8ZtVaN9zXK5HiOaAR1DDe3EGYdVK
	 BxwCexvKGuG07atAWTdZOVf5jpCBwZwlnCw++KgU+cNd4Etflbp9/fvMQrWWynVgY3
	 h8+3d27W4QDlSwBi1u8rxNga/7atW3f2ODNmqP5tWSZldA+EgEKqM7cNxfNTPx7HJn
	 XxAxzFmQE1WVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] perf: Add Raspberry Pi BCM2835 AXI PMU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260812002728.2283079-2-irogers@google.com>
References: <20260811235112.2267241-1-irogers@google.com>
 <20260812002728.2283079-1-irogers@google.com>
 <20260812002728.2283079-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 00:40:33 +0000
Message-Id: <20260812004034.2F88D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Calling hrtimer_cancel() inside rpi_axi_pmu_del() causes an unreco=
verable deadlock if the PMU event is deleted via a cross-CPU IPI while the =
timer callback is running.
- [High] Global monitor reset is asserted every time a single bus watcher i=
s enabled, corrupting other active events.
- [High] When MON__VPU falls back to MMIO, the vpu_work_handler drops the s=
pinlock before accessing hardware, triggering lockdep assertions and unprot=
ected MMIO writes.
- [Medium] rpi_axi_pmu_read_counter() returns -1 (0xFFFFFFFF) when a mailbo=
x IPC failure occurs, causing massive artificial spikes in the reported eve=
nt counts.
- [Medium] Race condition during probe allows the PMU to be permanently bou=
nd to an offline CPU.
--

--- Patch [1]: [PATCH v3 1/2] perf: Add Raspberry Pi BCM2835 AXI PMU driver=
 ---
commit b18036baa6b636e4ea8f9af5eee5462724c801ef
Author: Ian Rogers <irogers@google.com>

perf: Add Raspberry Pi BCM2835 AXI PMU driver

This commit adds an uncore performance monitoring unit (PMU) driver for=20
Broadcom BCM2835-BCM2711 AXI system monitors and VideoCore VPU firmware=20
mailbox monitors found on Raspberry Pi 1 through 4.

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> new file mode 100644
> index 0000000000000..1923dc34cb3e9
> --- /dev/null
> +++ b/drivers/perf/rpi_axi_pmu.c

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
> +	set_monitor_control(pmu, mon, GEN_CTL_RESET_BIT);

[Severity: High]
Does this global reset corrupt other active events?

It appears that whenever a new event is started, this unconditionally
issues the reset bit to the global monitor control register. This might
destroy the hardware state and clear the counters of all other currently
running bus watchers, resulting in massive phantom spikes on their next
read due to underflow.

> +	set_monitor_control(pmu, mon, GEN_CTL_ENABLE_BIT | GEN_CTL_WATCH_BIT);
> +}

[ ... ]

> +static u32 rpi_axi_pmu_read_counter(struct rpi_axi_pmu *pmu, enum monito=
r mon, int idx,
> +				    enum counter counter)
> +{
> +	int watcher =3D watcher_offset(pmu, mon, idx);
> +	int offset =3D counter_offset(counter);
> +	u32 ret;
> +
> +	if (!pmu->monitor[mon].hw_events.enabled[idx])
> +		return 0;
> +
> +	if (pmu->monitor[mon].use_mailbox_interface) {
> +		u32 tmp[3] =3D {
> +			pmu->monitor[mon].mailbox + watcher + offset,
> +			1, -1
> +		};
> +		int err;
> +
> +		might_sleep();
> +		lockdep_assert_held(&pmu->vpu_mutex);
> +		if (WARN_ON_ONCE(in_interrupt() || irqs_disabled()))
> +			return -1;
> +
> +		err =3D rpi_firmware_property(pmu->firmware,
> +					    RPI_FIRMWARE_GET_PERIPH_REG,
> +					    tmp, sizeof(tmp));
> +
> +		if (err < 0 || tmp[1] !=3D 1)
> +			dev_err(&pmu->pdev->dev, "Failed to read bus watcher\n");
> +		ret =3D tmp[2];

[Severity: Medium]
Is it safe to return the uninitialized buffer on an IPC failure?

If the firmware mailbox call fails or times out, it looks like the response
buffer tmp[2] remains -1, and that is returned directly. This could be
treated as a huge jump (0xFFFFFFFF) in the delta calculation and result in
massive artificial spikes in the reported event counts.

> +	} else {
> +		void __iomem *addr =3D pmu->monitor[mon].base_address + watcher + offs=
et;
> +
> +		lockdep_assert_held(&pmu->lock);
> +		ret =3D readl(addr) & 0x7FFFFFFF;
> +	}
> +	return ret;
> +}

[ ... ]

> +static void rpi_axi_pmu_vpu_work_handler(struct work_struct *work)
> +{
> +	struct rpi_axi_pmu *pmu =3D container_of(work, struct rpi_axi_pmu, vpu_=
work);
> +
> +	might_sleep();
> +	mutex_lock(&pmu->vpu_mutex);
> +	spin_lock_irq(&pmu->lock);
> +
> +	for (int i =3D 0; i < RPI_AXI_MAX_EVENTS; i++) {

[ ... ]

> +		/* Drop spinlock during Mailbox IPC read (which can sleep) */
> +		spin_unlock_irq(&pmu->lock);
> +
> +		new_count =3D rpi_axi_pmu_read_counter(pmu, MON__VPU, idx, counter);
> +
> +		spin_lock_irq(&pmu->lock);

[Severity: High]
Could this drop of the spinlock trigger a lockdep warning and data race
if the monitor falls back to MMIO?

If the firmware is unavailable, the VPU monitor might fall back to direct
MMIO (use_mailbox_interface =3D false). The work handler assumes it uses
IPC and drops the lock. But the MMIO path in rpi_axi_pmu_read_counter()
asserts lockdep_assert_held(&pmu->lock), and performs raw readl operations,
potentially racing with synchronous MMIO reads in rpi_axi_pmu_read().

[ ... ]

> +static void rpi_axi_pmu_del(struct perf_event *event, int flags)
> +{
> +	struct rpi_axi_pmu *pmu =3D pmu_to_rpi_axi_pmu(event->pmu);
> +	enum monitor mon =3D config_to_monitor(event->attr.config);
> +	unsigned long spinflags;
> +	int idx =3D event->hw.idx;
> +
> +	if (idx < 0)
> +		return;
> +
> +	rpi_axi_pmu_stop(event, PERF_EF_UPDATE);
> +
> +	spin_lock_irqsave(&pmu->lock, spinflags);

[ ... ]

> +	event->hw.idx =3D -1;
> +	pmu->active_events--;
> +	if (mon =3D=3D MON__VPU)
> +		pmu->active_vpu_events--;
> +
> +	if (pmu->active_events =3D=3D 0) {
> +		spin_unlock_irqrestore(&pmu->lock, spinflags);
> +		hrtimer_cancel(&pmu->hrtimer);
> +		spin_lock_irqsave(&pmu->lock, spinflags);

[Severity: High]
Can this sequence cause a deadlock?

The rpi_axi_pmu_del() function can be invoked in hardirq context
via an SMP cross-CPU IPI. Since the hrtimer is configured with
HRTIMER_MODE_REL_SOFT, its callback runs in softirq context on the
same CPU. If the IPI interrupts the executing softirq timer handler,
synchronously calling hrtimer_cancel() will spin indefinitely
waiting for the preempted callback to finish.

> +		if (pmu->active_events > 0)
> +			hrtimer_start(&pmu->hrtimer, RPI_AXI_PMU_TIMER_INTERVAL,
> +				      HRTIMER_MODE_REL_SOFT);
> +		spin_unlock_irqrestore(&pmu->lock, spinflags);
> +		return;
> +	}
> +	spin_unlock_irqrestore(&pmu->lock, spinflags);
> +}

[ ... ]

> +static int rpi_axi_pmu__init(struct rpi_axi_pmu *pmu, struct platform_de=
vice *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *fw_node;
> +	int ret;
> +
> +	spin_lock_init(&pmu->lock);
> +	mutex_init(&pmu->vpu_mutex);
> +
> +	pmu->chip =3D CHIP_BCM2835;
> +
> +	pmu->pmu =3D (struct pmu) {

[ ... ]

> +	};
> +	pmu->pdev =3D pdev;
> +	pmu->cpu =3D raw_smp_processor_id();
> +	hrtimer_setup(&pmu->hrtimer, rpi_axi_pmu_timer_handler, CLOCK_MONOTONIC,
> +		      HRTIMER_MODE_REL_SOFT);
> +	INIT_WORK(&pmu->vpu_work, rpi_axi_pmu_vpu_work_handler);

[ ... ]

> +	ret =3D perf_pmu_register(&pmu->pmu, PMU_NAME, /*type=3D*/-1);
> +	if (ret) {
> +		dev_err(dev, "PMU register failed %d\n", ret);
> +		goto err_teardown;
> +	}
> +
> +	ret =3D cpuhp_state_add_instance(rpi_axi_pmu_cpuhp_state, &pmu->cpuhp_n=
ode);

[Severity: Medium]
Is there a race condition here with CPU hotplug?

The CPU is assigned using raw_smp_processor_id() in a preemptible context
before cpuhp_state_add_instance() is called. If this CPU is taken offline
before the hotplug instance is registered, the subsystem misses the
transition. The teardown callback won't run, leaving the PMU permanently
bound to an offline CPU.

> +	if (ret) {
> +		dev_err(dev, "Failed to add cpuhp instance %d\n", ret);
> +		goto err_pmu_unregister;
> +	}
> +	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812002728.2283=
079-1-irogers@google.com?part=3D1
