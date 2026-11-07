Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794026680;
	b=0aq6liZcrKV6/kLSMEsIWe383dtfcFLX7g8cr6/TlXi0eIPAPqgxfEx4TeA3sgtwc9XP
	 AviupaOPEj2Ot7qL8ayzf7Nipap/LFSLWCVTTW+vsNJmj9KrDpq0oOPvgUdtlysZ3mHKx
	 ONyKYPLYwTPMYEsBrTgP3UjYnt6pqjSB30GEJo3uFtyOEpFPHGe+YLDEh4sb8irmiWLKA
	 Q2l/IIxiSeXVXB/ybmSNHw4cVv/BiafwZPPOTV3YUrLzxd5VGXLn08Dr7h2KOdsMMhiH3
	 GtlzE/dhdBH3UMIFkqlXlbJBgtjlvZ+mfUSR9zhWfPx8rorx7pvEwuM0uxuklDtk6kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026680;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yfvnxWu5AHjW62R+/dGRj91kyeH6mBdcMvXmFCDm6EQ=;
	b=XKwa5WeEEPk4GQpQhUpRY0dkqKbyjxj3WQXSeQnpBnVheHjGQcUcN6c2bFTZ1tmn9DFf
	 vvFan3diLZWK3RYzqbAs8npePqq6u1HxnZpiRZWhNsUCSvVJh9sOsnMdUtHFRpnzlUKfs
	 e/5pjyUZaeDI/7nFvi0+Wvj+5fF8jWe5fy9AVBKXj7kfYJl+LUikd1gVq9joTFg5Hcat/
	 2x4oOIMBgqZRIJd81x2Vu1bg4+//idz2z+ZByttng1/kx7Yle9QHEfiSfIdIIIJmCNmtK
	 9ICY/ZEQpG5KaActht65y9oBBLKnY/Jv1faAXqp5E3qAKr+9DU7B8FQ/CW8lPcgz9rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0DSvcns;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F7606A32C;
	Sat,  7 Nov 2026 04:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0DSvcns
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFCD1F0089F;
	Sat,  7 Nov 2026 04:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794026679;
	bh=yfvnxWu5AHjW62R+/dGRj91kyeH6mBdcMvXmFCDm6EQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B0DSvcns83Yu6RacsZ+iplmCURWZseVhWTDnXgXupu2+clFYQ6Oc5o0HSLs9gNESx
	 hMnma4kd4uulwUDS0MIqUQUYJdhLuedO8U3spkwO3Lxu0mrfZUBsrwnKg1rELBFtlu
	 amZMaP6dKW0JYlLrFCafZ/ehjrkyXr/uM5ne7Er9nFARUf1l/+7nA9AxF3Y/xjVXa7
	 ohfT+Jn3NZu9z/C18dBi50qbTwzMK7hingILZYmm1WJhdF9hR9QZflVlQO/mypI+IL
	 shDAyxTnVmUoF+ZQc11FiOjIHksSDmEqgbAT3BSF14wrTr7NV2uwpeTct5dxXJORUj
	 lYCtk7ljRDrHw==
Message-ID: <sashiko-outbox-202592@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 2/3] perf: Add Raspberry Pi BCM2835 AXI PMU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261107040913.1384033-3-irogers@google.com>
References: <20261107040913.1384033-1-irogers@google.com>
 <20261107040913.1384033-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 04:44:38 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf: rpi_axi_pmu: hrtimer_start() in rpi_axi_pmu_add() races
  and resets timer
--

commit 175632998831f232c8904487c2fedb162699a7b8
Author: Ian Rogers <irogers@google.com>

perf: Add Raspberry Pi BCM2835 AXI PMU driver

This commit adds a perf PMU driver for the Raspberry Pi System and VideoCore
AXI performance monitors on Broadcom BCM2835 and BCM2711 platforms.

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> new file mode 100644
> index 0000000000000..c75118c7c902b
> --- /dev/null
> +++ b/drivers/perf/rpi_axi_pmu.c

[ ... ]

> +static enum hrtimer_restart rpi_axi_pmu_timer_handler(struct hrtimer *ti=
mer)
> +{
> +	struct rpi_axi_pmu *pmu =3D container_of(timer, struct rpi_axi_pmu, hrt=
imer);
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&pmu->lock, flags);
> +	if (pmu->active_events =3D=3D 0) {
> +		raw_spin_unlock_irqrestore(&pmu->lock, flags);
> +		return HRTIMER_NORESTART;
> +	}
> +	for (int i =3D 0; i < RPI_AXI_MAX_EVENTS; i++) {
> +		struct perf_event *event =3D pmu->events[i];
> +		enum counter counter;
> +		enum monitor mon;
> +		u32 new_count;
> +
> +		if (!event || (event->hw.state & PERF_HES_STOPPED))
> +			continue;
> +		mon =3D config_to_monitor(event->attr.config);
> +		if (pmu->monitor[mon].use_mailbox_interface)
> +			continue;
> +		counter =3D config_to_counter(event->attr.config);
> +		new_count =3D rpi_axi_pmu_read_counter(pmu, mon,
> +						    event->hw.idx, counter);
> +		rpi_axi_pmu_event_update(event, new_count);
> +	}
> +
> +	if (pmu->active_vpu_events > 0 && pmu->monitor[MON_VPU].use_mailbox_int=
erface)
> +		schedule_work(&pmu->vpu_work);
> +	hrtimer_forward_now(timer, RPI_AXI_PMU_TIMER_INTERVAL);
> +	raw_spin_unlock_irqrestore(&pmu->lock, flags);
> +	return HRTIMER_RESTART;
> +}

[ ... ]

> +static int rpi_axi_pmu_add(struct perf_event *event, int flags)
> +{

[ ... ]

> +	pmu->active_events++;
> +	if (mon =3D=3D MON_VPU)
> +		pmu->active_vpu_events++;
> +	if (pmu->active_events =3D=3D 1)
> +		hrtimer_start(&pmu->hrtimer, RPI_AXI_PMU_TIMER_INTERVAL,
> +			      HRTIMER_MODE_REL_SOFT);

[Severity: Medium]
Can calling hrtimer_start() on every 0-to-1 transition of pmu->active_events
race with rpi_axi_pmu_timer_handler() and starve polling during event
multiplexing?

rpi_axi_pmu_del() decrements pmu->active_events to 0 without canceling
pmu->hrtimer.  If pmu->active_events drops to 0 and rises back to 1 (for
example during perf_rotate_context()) after __run_hrtimer() has dequeued
pmu->hrtimer and before rpi_axi_pmu_timer_handler() acquires pmu->lock,
hrtimer_start() re-enqueues the timer while the callback is about to run
hrtimer_forward_now():

<softirq>                             <hardirq> / CPU1
__run_hrtimer()
  timer->is_queued =3D 0
  rpi_axi_pmu_timer_handler()
                                      perf_mux_hrtimer_handler()
                                        ...
                                        rpi_axi_pmu_del()
                                          pmu->active_events-- (0)
                                        rpi_axi_pmu_add()
                                          pmu->active_events++ (1)
                                          hrtimer_start(&pmu->hrtimer, ...)
                                            timer->is_queued =3D 1
    raw_spin_lock_irqsave(&pmu->lock)
    hrtimer_forward_now(timer, ...)
      WARN_ON(timer->is_queued)       <-- triggers warning

In addition, because perf_rotate_context() deletes all active events
(pmu->active_events -> 0) and immediately adds the next events
(pmu->active_events -> 1), hrtimer_start() pushes the relative 100ms expiry
forward on every rotation.  Whenever the multiplexing interval is shorter
than 100ms, rpi_axi_pmu_timer_handler() never fires, starving 32-bit MMIO
overflow polling and vpu_work.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107040913.1384=
033-1-irogers@google.com?part=3D2
