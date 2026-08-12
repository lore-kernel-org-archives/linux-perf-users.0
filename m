Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C08740B0F9
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577058; cv=none; b=FNc/XIHcIb1352Wwc+NNAaz8pqV4QE/pyUzRYuayXfaPr5b5Z4pOhA918LTvQjoGgBaNX8ERXHA8raIqxOlmPCMOCdrn1prAbBplOovZeiiaWCpYK3xkv/XoH4xea4UOk5iOGPzRm5KhaWD3qAcANR6OXV3in46wmI5Lx8PBcxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577058; c=relaxed/simple;
	bh=2Qm487nXs1i5NEwiLw36DAq2Q5gBgC+XJgYZHn4+5CA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UXmr4N+37KKiXJ6hfb6fECAZDtOVc91SKe2xTmEZAPW11c0gk98+ePkIkWm2CT755+2fPsVY7ILSXkuY9hb5fLIGFYXFAZW3onYPuNloN4gN3/3/CotzQxvqTNykj+iBJJbbRMkKSPpG7BcLcy47Ih0BAVPNo/LxSYaA50Eiia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbD8zmoO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbD8zmoO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A458A1F000E9;
	Wed, 12 Aug 2026 23:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786577056;
	bh=vK+Kf3hoALWpMKI9M+Bl0VjSas6pdtfI59eWedFCgrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JbD8zmoOZwt38Z76FoAJFM1YT38UJZPVavGqHWEoPgn21WpGGNvPHl4t9kcwZBkF3
	 ZEJna20RkKeEL33LNIsBuUXZiavorzYIkKN+CzYt5k05S3StZZIMavKZqWN5bKq3Ox
	 BFOSVxzaZFzNT1H28qSW+5w4ce7HSolA3rBeiy+w1ryhYyDpU/nqTEPWKnwcipWjZn
	 JT/eUx6KS7lkAkPclwqqxAa89fd/ZE2eIHCFUjarwYTHeKSxV03BnvSPC5PnbpmqzE
	 q3WCSWNGFsIrW16ml/46V+wOh0J0em/2KPsNlUMTsMELgkTXyIBWVfDhw3ouHuHP4K
	 SDg7wsPtQGVVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260812230800.2646749-3-irogers@google.com>
References: <20260812230145.2644281-1-irogers@google.com>
 <20260812230800.2646749-1-irogers@google.com>
 <20260812230800.2646749-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 23:24:16 +0000
Message-Id: <20260812232416.A458A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] VPU bus watcher reconfiguration is skipped if a watcher slot is re=
allocated before asynchronous vpu_work executes, causing silent data corrup=
tion.
- [Medium] Broad substring matching in `rpi_axi_pmu_events_is_visible()` un=
intentionally hides newly added BCM2712-specific event aliases on the BCM27=
12 platform.
--

--- Patch [2]: [PATCH v5 2/2] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU su=
pport ---
commit f428ceab1c23265b486b6b953b78aae6ae47a096
Author: Ian Rogers <irogers@google.com>

perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

Expand the Raspberry Pi AXI PMU driver to support Broadcom BCM2712
(Raspberry Pi 5) system monitors, PCIe RP1 Southbridge links, HEVC decoder,
and Cortex-A76 DSU L3 interconnects.

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> --- a/drivers/perf/rpi_axi_pmu.c
> +++ b/drivers/perf/rpi_axi_pmu.c

[ ... ]

> @@ -880,12 +1062,111 @@ static struct attribute *rpi_axi_pmu_events_attrs=
[] =3D {

[ ... ]

> +static umode_t rpi_axi_pmu_events_is_visible(struct kobject *kobj,
> +					      struct attribute *attr, int unused)
> +{
> +	struct device *dev =3D kobj_to_dev(kobj);
> +	struct pmu *pmu =3D dev_get_drvdata(dev);
> +	struct rpi_axi_pmu *rpi_pmu =3D pmu_to_rpi_axi_pmu(pmu);
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr =3D container_of(attr, struct perf_pmu_events_attr, attr.attr);
> +
> +	if (rpi_pmu->chip =3D=3D CHIP_BCM2712) {
> +		/*
> +		 * On RPi 5 (BCM2712), hide legacy VPU Mailbox IPC events (monitor=3D1)
> +		 * and legacy RPi 1-4 System Monitor aliases
> +		 */
> +		if (strstr(pmu_attr->event_str, "monitor=3D1") ||
> +		    strstr(attr->name, "cpu0_") ||
> +		    strstr(attr->name, "cpu1_") ||
> +		    strstr(attr->name, "dma0_") ||
> +		    strstr(attr->name, "dma1_") ||
> +		    strstr(attr->name, "v3d0_") ||
> +		    strstr(attr->name, "v3d1_") ||
> +		    strstr(attr->name, "hvs_system") ||
> +		    strstr(attr->name, "isp_system") ||
> +		    strstr(attr->name, "usb_system") ||
> +		    strstr(attr->name, "ccp2tx_") ||
> +		    strstr(attr->name, "mphi_") ||
> +		    strstr(attr->name, "h264_") ||
> +		    strstr(attr->name, "v3d_") ||
> +		    strstr(attr->name, "peripheral_") ||
> +		    strstr(attr->name, "cpu_uc_") ||

[Severity: Medium]
Does this broad substring matching unintentionally hide the newly added
bcm2712_peripheral_* and bcm2712_cpu_uc_* event aliases on the BCM2712
platform?

Since the new aliases are named bcm2712_peripheral_rtrans and
bcm2712_cpu_uc_rtrans, they contain the exact substrings "peripheral_" and
"cpu_uc_". It looks like they might be incorrectly filtered out here, making
them unavailable in sysfs.

> +		    strstr(attr->name, "cpu_l2_") ||
> +		    strstr(attr->name, "l2_control_") ||
> +		    strstr(attr->name, "system_control_") ||
> +		    strstr(attr->name, "direct_control_") ||
> +		    strstr(attr->name, "direct_data_"))
> +			return 0;
> +	} else {

[ ... ]

> @@ -1507,15 +1831,17 @@ static void rpi_axi_pmu_del(struct perf_event *ev=
ent, int flags)
>  	if (pmu->monitor[mon].hw_events.monitored_bus[idx] >=3D 0) {
>  		pmu->monitor[mon].hw_events.refcount[idx]--;
>  		if (pmu->monitor[mon].hw_events.refcount[idx] =3D=3D 0) {
> -			if (mon =3D=3D MON__SYSTEM)
> -				rpi_axi_pmu_disable_bus_watcher(pmu, mon, idx);
>  			pmu->monitor[mon].hw_events.monitored_bus[idx] =3D -1;
>  			pmu->monitor[mon].hw_events.filter[idx] =3D BCM2835_FLT__NONE;
> -			pmu->monitor[mon].hw_events.enabled[idx] =3D false;
>  			pmu->monitor[mon].hw_events.num_monitored--;

[Severity: High]
Could removing this synchronous clear of enabled[idx] cause a race condition
leading to silent data corruption?

If a VPU monitor event is deleted here, refcount[idx] drops to 0,
monitored_bus[idx] becomes -1 (freeing the slot), and we schedule
pmu->vpu_work.

If a new VPU event is added before rpi_axi_pmu_vpu_work_handler() runs,
it will reuse this empty slot and increment refcount[idx] to 1.

Then when rpi_axi_pmu_vpu_work_handler() finally runs:

drivers/perf/rpi_axi_pmu.c:rpi_axi_pmu_vpu_work_handler() {
    ...
    /* If VPU bus watcher is not enabled on hardware, enable it... */
    if (!pmu->monitor[MON__VPU].hw_events.enabled[idx]) {
        ...
    }
    ...
}

It appears the worker will skip configuring the new hardware because
enabled[idx] remained true from the old event.

Furthermore, the teardown of the old hardware is also skipped later in the
handler:

drivers/perf/rpi_axi_pmu.c:rpi_axi_pmu_vpu_work_handler() {
    ...
    for (int idx =3D 0; idx < NUM_BUS_WATCHERS_PER_MONITOR; idx++) {
        if (pmu->monitor[MON__VPU].hw_events.refcount[idx] =3D=3D 0 &&
            pmu->monitor[MON__VPU].hw_events.enabled[idx]) {
            ...
        }
    }
}

Since the new event already incremented refcount[idx], this block won't
execute, potentially leaving the hardware misconfigured and causing userspa=
ce
to receive PMU counts for a completely different AXI bus.

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812230800.2646=
749-1-irogers@google.com?part=3D2
