Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD5D239E9A
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762948; cv=none; b=gI346ruQfY+2EWBd4oIbj4w/SbRMCrydKeVbMcMg7aO5UpqDEx5KOmA0FC9qqTdeMYPZ8lmclEp+PF45oyPBcUc9otlXHc81nTtucAylmtPRj+kNDTmS3UlEK2vSs/14FkyTlWFW3oM0dRe5UKJOutlOh7bFT7XJupsaSjlO22I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762948; c=relaxed/simple;
	bh=JSAtc/8tKE5c4ZN4b8fjG6mzAo+am7z5rWdD58KnnX4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S2ocwo9lLgq4DPcehtxMOZpw1i741fFLvAx7TjyBnciVcVfIjOEZt75K2tnzBWnodfvdgrCpmwnusJNrGDj8rWXGaDuQVbSysxHq41SYoMutAaVDxaJXcsCGAxfQ95YuFY4WeOANZiwP45ZgCPjK44I3HGdwFkJoe0ku9gBTlc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSpPKt32; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSpPKt32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C52CC2BCB3;
	Thu, 14 May 2026 12:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778762947;
	bh=JSAtc/8tKE5c4ZN4b8fjG6mzAo+am7z5rWdD58KnnX4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hSpPKt32huli7sWzI92aHn2DyzbbLVoqOLP9CpcOmN8v5zwtz2EUOLm/hmcxfx1RH
	 Eo8n7BbHvPiul3VRi3nWjvokZ2RgAjLRDgOzxEzCLRy9pw3EDWCW3GT3fauT1NRkw8
	 0jxqR94DEKdkTMu1pEEsMJX8A3ulIyTIwMleHxfVe+tpqSOck5Uloj4C+wdFrfzsND
	 1rZD81ZTIs75CHRA8txuqudpha7k6OQDFOl0abfCV7iJ18ZBSQMlHqhbZxeuYzz5m7
	 /NboEA1obmFnwRL9lXa0PsbbCWe/bO1DbOlXCJFUGgzZH/kaCRPk4KF3rvl8ooAcuX
	 do2u60/hhJqcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] perf: nvidia_t410_cmem_latency: handle
 PERF_EF_UPDATE in stop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Saurav Sachidanand" <sauravsc@amazon.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260514010629.76558-2-sauravsc@amazon.com>
References: <20260514010629.76558-2-sauravsc@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 12:49:06 +0000
Message-Id: <20260514124907.0C52CC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Performing MMIO reads on clock-gated hardware in pmu->stop() w=
ill trigger a system crash (SError).
- [High] API Contract Violation and conditional update logic error for free=
-running PMU counters.
- [High] Use-After-Free of PMU context during CPU hotplug teardown.
--

commit 1c17f7a02936b83432204f0c38f9d1d22f6f4acd
Author: Saurav Sachidanand <sauravsc@amazon.com>

perf: nvidia_t410_cmem_latency: handle PERF_EF_UPDATE in stop

This commit updates cmem_lat_pmu_stop to return early if the event is
already stopped, and conditionally updates the event if the update flag is
requested.

> cmem_lat_pmu_stop() does not read the final counter value when called
> with PERF_EF_UPDATE. When perf core calls pmu->del() -> pmu->stop()
> with PERF_EF_UPDATE, the last counter delta is lost because the event
> is marked stopped without reading hardware.

Is this description accurate?

Looking at cmem_lat_pmu_disable(), it explicitly stops the hardware, reads
and updates all active events, and clears the counters. Since pmu->stop()
is called within the perf_pmu_disable() block, the final count should alrea=
dy
be unconditionally read before shutting down the hardware, meaning the last
counter delta might not be lost.

> diff --git a/drivers/perf/nvidia_t410_cmem_latency_pmu.c b/drivers/perf/n=
vidia_t410_cmem_latency_pmu.c
> --- a/drivers/perf/nvidia_t410_cmem_latency_pmu.c
> +++ b/drivers/perf/nvidia_t410_cmem_latency_pmu.c
> @@ -303,6 +303,12 @@ static void cmem_lat_pmu_start(struct perf_event *ev=
ent, int pmu_flags)
> =20
>  static void cmem_lat_pmu_stop(struct perf_event *event, int pmu_flags)
>  {
> +	if (event->hw.state & PERF_HES_STOPPED)
> +		return;

Does this early return violate the perf core API contract by ignoring
subsequent PERF_EF_UPDATE requests for already-stopped events?

> +
> +	if (pmu_flags & PERF_EF_UPDATE)
> +		cmem_lat_pmu_event_update(event);

Will this trigger an asynchronous external abort (SError) and crash
the system?

The perf core calls pmu->stop() within a perf_pmu_disable() block.
In this driver, cmem_lat_pmu_disable() gates the module clock. Calling
cmem_lat_pmu_event_update() performs MMIO reads on the PMU registers.
Since this happens while the PMU clock is gated, these MMIO accesses will
target unclocked registers.

Additionally, does this conditional update cause regressions for free-runni=
ng
PMU counters?

Since this PMU uses free-running global counters without per-event hardware
stops, conditionally updating the event only when PERF_EF_UPDATE is set mea=
ns
calls like pmu->stop(event, 0) will fail to capture the counter delta. This
allows the hardware counter to continue incrementing while the event is
logically stopped, which could corrupt subsequent readings.

> +
>  	event->hw.state |=3D PERF_HES_STOPPED;
>  }

While reviewing this driver, I noticed an existing regression in the hotplug
teardown path.

Can a use-after-free occur during CPU hotplug teardown?

In cmem_lat_pmu_device_remove(), perf_pmu_unregister() is called before
cpuhp_state_remove_instance(). perf_pmu_unregister() detaches all events and
frees internal core PMU resources.

When cpuhp_state_remove_instance() runs sequentially after it, it executes
the hotplug teardown callback cmem_lat_pmu_cpu_teardown(), which invokes
perf_pmu_migrate_context() with the already unregistered PMU pointer. This
accesses partially freed perf core state, which might cause a kernel panic
upon unbind or failed initialization.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514010629.7655=
8-1-sauravsc@amazon.com?part=3D2
