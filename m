Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B80320A00
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576716; cv=none; b=QSmjeSb+dcE41eYFOoAxn1VSHnYGPLo/09BNq6xMfUiJ8EoEUseggdrHS9wQe9bRa8gZdiiGlm0p5/MeR3GrGc8ak/1QukjvrJBTEv73Zh60o8A5zYGGu1kBKPgH9hahmpgygC0sLg8GEYM0vrS79BQCRb0VKccb/42GCeTW20c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576716; c=relaxed/simple;
	bh=i/XFWMh8akqTsmfvDrPFHxLifr0MWKVoo37tT/kBTwQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jXpwZYwI33HCrBcVOJVQSIOPjLNS/cZbqIcY3JI/m+JQ1pDvkD3mQlEiE+1StSzTCYENAxR1bZra1X5uiQhuH62f0qAmRW72vICkq7fkRlgW+wYeynRRXTy1xcrhQdlc1W3Vqcq33ZN8XlxEyBSgKnHijSqK1gn2lGjC482RzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1BzGgB5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1BzGgB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C321F00A3A;
	Wed, 12 Aug 2026 23:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786576715;
	bh=oJ2kRE6QKDgg+ZiFXe3VLSU4M2sdxp+X2tB9lMb3m6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H1BzGgB5Uuw7Srsf8FYsvTax3Ml1BM0eNlwLwlTAN50fFem/xqWrbM5YhzHVuGh4Z
	 NfViWflQtEqu2tF5Fhgm1qus84PqEqwOCkv2d5H/ZYGa+DkgFU5KXzD3GukppHPq48
	 eK8hfelELshgRgm0kS9snXta0D+RfS2c5yFKe8w427WRT5yvj3ZfaeDjjNic4Di/dB
	 OFGhviXUEtgSgC2IKqC+ihW4nYcoaQl/5WMJkrp7+95CQICwyYTVIW0igBxFMC4ePt
	 q6EdsEd1wXqCOaRfTG2XpYoe0km1sLQQQFvJc6T7ZkLhV2ELLFmkkOC3k2Cq74jHoh
	 gY+f0XlI+QdkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260812230145.2644281-3-irogers@google.com>
References: <20260812052417.2361040-1-irogers@google.com>
 <20260812230145.2644281-1-irogers@google.com>
 <20260812230145.2644281-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 23:18:34 +0000
Message-Id: <20260812231835.14C321F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Removing `enabled[idx] =3D false` from `rpi_axi_pmu_del` causes bu=
s watcher misconfiguration when a watcher index is rapidly reused.
- [Medium] Overly broad substring matching inadvertently hides newly added =
BCM2712 events on RPi 5 while exposing them on RPi 1-4.
- [Medium] The VPU monitor hardware is not reliably disabled during module =
unload because `cancel_work_sync()` is used instead of `flush_work()`.
--

--- Patch [2]: [PATCH v5 2/2] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU su=
pport ---
commit 71567bad9b4b4c6115df3982a734e87c6c908033
Author: Ian Rogers <irogers@google.com>

perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

This patch expands the Raspberry Pi AXI PMU driver to support Broadcom
BCM2712 system monitors. It adds new monitored buses, filter options,
and event aliases for the Raspberry Pi 5 platform.

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> index e5cc86fc78b25..a24b6587f8718 100644
> --- a/drivers/perf/rpi_axi_pmu.c
> +++ b/drivers/perf/rpi_axi_pmu.c
[ ... ]
> @@ -1113,31 +1203,66 @@ static umode_t rpi_axi_pmu_events_is_visible(stru=
ct kobject *kobj,
>  					      struct attribute *attr, int unused)
>  {
[ ... ]
>  	if (rpi_pmu->chip =3D=3D CHIP_BCM2712) {
>  		/*
>  		 * On RPi 5 (BCM2712), hide legacy VPU Mailbox IPC events (monitor=3D1)
>  		 * and legacy RPi 1-4 System Monitor aliases
>  		 */
>  		if (strstr(pmu_attr->event_str, "monitor=3D1") ||
[ ... ]
>  		    strstr(attr->name, "peripheral_") ||
>  		    strstr(attr->name, "cpu_uc_") ||
[ ... ]
>  			return 0;
>  	} else {
>  		/* On RPi 1-4 (BCM2835-BCM2711), hide RPi 5 specific events */
>  		if (strstr(attr->name, "pcie_rp1") ||
[ ... ]
>  			return 0;
>  	}
> =20
>  	return attr->mode;
>  }

[Severity: Medium]
Will these substring matches inadvertently hide the newly added BCM2712 eve=
nts
on RPi 5?

The new BCM2712 events are named "bcm2712_peripheral_rtrans" and
"bcm2712_cpu_uc_rtrans", which will match "peripheral_" and "cpu_uc_"
and be hidden here.=20

Conversely, won't these same new events be mistakenly exposed on older chips
because they don't match any of the substrings in the `else` block?

[ ... ]
> @@ -1810,14 +1831,16 @@ static void rpi_axi_pmu_del(struct perf_event *ev=
ent, int flags)
[ ... ]
>  	if (pmu->monitor[mon].hw_events.monitored_bus[idx] >=3D 0) {
>  		pmu->monitor[mon].hw_events.refcount[idx]--;
>  		if (pmu->monitor[mon].hw_events.refcount[idx] =3D=3D 0) {
> -			if (mon =3D=3D MON__SYSTEM)
> -				rpi_axi_pmu_disable_bus_watcher(pmu, mon, idx);
>  			pmu->monitor[mon].hw_events.monitored_bus[idx] =3D -1;
>  			pmu->monitor[mon].hw_events.filter[idx] =3D BCM2835_FLT__NONE;
> -			pmu->monitor[mon].hw_events.enabled[idx] =3D false;
>  			pmu->monitor[mon].hw_events.num_monitored--;
> -			if (mon =3D=3D MON__SYSTEM && pmu->monitor[mon].hw_events.num_monitor=
ed =3D=3D 0) {
> -				set_monitor_control(pmu, mon, GEN_CTL_RESET_BIT);
> -				pmu->monitor[mon].hw_events.monitor_running =3D false;
> +			if (mon =3D=3D MON__SYSTEM) {
> +				rpi_axi_pmu_disable_bus_watcher(pmu, mon, idx);
> +				if (pmu->monitor[mon].hw_events.num_monitored =3D=3D 0) {
> +					set_monitor_control(pmu, mon, GEN_CTL_RESET_BIT);
> +					pmu->monitor[mon].hw_events.monitor_running =3D false;
> +				}
> +			} else if (mon =3D=3D MON__VPU) {
> +				schedule_work(&pmu->vpu_work);
>  			}
>  		}
>  	}

[Severity: High]
Is it safe to remove `pmu->monitor[mon].hw_events.enabled[idx] =3D false` h=
ere?

If a VPU event is deleted, the watcher slot is marked as free. If a new VPU
event is added immediately before `vpu_work` runs to perform the teardown,
the new event could claim this slot.

When `vpu_work` runs, it checks `if (!enabled[idx])` to program the hardwar=
e.
Since `enabled[idx]` is still true from the deleted event, it skips
initialization, causing the hardware to monitor the old bus while the new
perf event incorrectly reports those counts.

[ ... ]
> @@ -2014,9 +2065,10 @@ static void rpi_axi_pmu__exit(struct rpi_axi_pmu *=
pmu)
>  {
> -	perf_pmu_unregister(&pmu->pmu);
>  	cpuhp_state_remove_instance(rpi_axi_pmu_cpuhp_state, &pmu->cpuhp_node);
> +
> +	perf_pmu_unregister(&pmu->pmu);
>  	hrtimer_cancel(&pmu->hrtimer);
>  	cancel_work_sync(&pmu->vpu_work);
>  	if (pmu->firmware)

[Severity: Medium]
Since `rpi_axi_pmu_del()` was updated to schedule `vpu_work` to disable the
VPU hardware, does this `cancel_work_sync()` prevent the hardware teardown
from completing during module unload?

`perf_pmu_unregister()` will call `rpi_axi_pmu_del()`, which schedules
the asynchronous teardown. Canceling it immediately after means the VPU AXI
bus watchers could be left running. Should this be `flush_work()` instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812230145.2644=
281-1-irogers@google.com?part=3D2
