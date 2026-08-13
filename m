Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55663344D9B
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 04:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786596499; cv=none; b=IqKJ4ZhqBts1c9RfXbqtELw6yfxv6+bI0oUwT2hum3RwCNl1G3VXzsTb7XJGcdOppIpzpMU48Iy+4WTMujnDGZH08pK1fuqOP+3+jbT/eCnIdGdwHZzjvCptFNGT2wuieq8fKyXoBuTHVJnMLVplTTMwskDgV85u0t/+oz/xhiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786596499; c=relaxed/simple;
	bh=IV88KldfdoYPspuFO6dRHbgov5BAM8L52hDt2R+GgBI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d5LmYpdFqVTKIX1N7uqMpPp1w2MMaPyd80EMlPkwVM1a7voUEDDnEUmVAdpniuCOzBeShcoAFanH8T/pew3+BQUBUy5V+sbbz+fTR66/+S0MsQmfVwErnkH4Qem6uqc/idiikaFq4R+RkRz4X0kPnfOhZOQBgZJ+VJik8nJCJY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=At/3k6V1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="At/3k6V1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8A21F000E9;
	Thu, 13 Aug 2026 04:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786596497;
	bh=bKVexhaLmbi6d3gMvMCHcGHkaCa17TfUB177r94E7Xw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=At/3k6V1sWiITcUPEVg3GwGiLy4yr+2kyPqOHh9ZHuO7/OvBjZRAYVMb55cf+tTWA
	 dxxYY36YA2jxKqKrLKnGjglxOcOlN/NyHcGOHy1/mJaVnfqU70NI2WT2pQmwPiLA58
	 rkQbJsitfOGhsa4KwclS0rgLaDejf7LHjEi6iHWimpjyrbG8uspJmo/j/fR+L5G5wd
	 SFROCBZqLHLOQUiJ5/mxxwls9zeA1/xNiVWaw0JtxVQiLYyN0Ut5mNnE+GoVW75Y0I
	 GmnGM7iU0X2DgCsRbaUrZZRy8s6jcEmqCSISFLX0zx49q4eo+NqTV56ATLOtQxYOmb
	 z8LyIoUHiI5zQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] perf: Add Raspberry Pi BCM2835 AXI PMU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813043533.2744442-2-irogers@google.com>
References: <20260812230145.2644281-1-irogers@google.com>
 <20260813043533.2744442-1-irogers@google.com>
 <20260813043533.2744442-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 04:48:17 +0000
Message-Id: <20260813044817.BD8A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Concurrent execution of `rpi_axi_pmu_del()`, `rpi_axi_pmu_add()`=
, and the background workqueue can leave a VPU hardware bus watcher permane=
ntly disabled due to unprotected mutation of the `vpu_disable_pending` flag.
- [Low] The BCM2712 (Raspberry Pi 5) specific event aliases referenced in t=
he `rpi_axi_pmu_events_attrs` array are missing their macro definitions, ca=
using compilation to fail.
- [Low] Usage of LINUX_VERSION_CODE check for out-of-tree backward compatib=
ility in a mainline patch.
--

--- Patch [1]: [PATCH v6 1/2] perf: Add Raspberry Pi BCM2835 AXI PMU driver=
 ---
commit cb96f82b55ab634031075f8a381cb2d336d091c7
Author: Ian Rogers <irogers@google.com>

perf: Add Raspberry Pi BCM2835 AXI PMU driver

This commit adds an uncore performance monitoring unit (PMU) driver
for Broadcom BCM2835-BCM2711 AXI system monitors and VideoCore VPU firmware
mailbox monitors found on Raspberry Pi 1 through 4.

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> new file mode 100644
> index 0000000000000..f7e5520d02eb9
> --- /dev/null
> +++ b/drivers/perf/rpi_axi_pmu.c
> @@ -0,0 +1,2009 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/**
> + * DOC: Raspberry Pi AXI Bus Performance Monitoring Unit (PMU) Driver
> + *
> + * This driver exposes the performance monitoring hardware on Raspberry =
Pi

[ ... ]

> +#include <linux/version.h>
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 13, 0)
> +static inline void rpi_hrtimer_setup(struct hrtimer *timer,
> +				     enum hrtimer_restart (*function)(struct hrtimer *),
> +				     clockid_t clock_id, enum hrtimer_mode mode)
> +{

[Severity: Low]
Should this out-of-tree backward compatibility check using LINUX_VERSION_CO=
DE
be included in a mainline patch? Typically, mainline submissions only target
the current kernel version and avoid legacy version checks.

> +	hrtimer_init(timer, clock_id, mode);
> +	timer->function =3D function;
> +}
> +#define hrtimer_setup rpi_hrtimer_setup
> +#endif

[ ... ]

> +static int rpi_axi_hw_events__get_alloc_event_idx(struct rpi_axi_hw_even=
ts *hw_events,
> +						  const struct perf_event *event)
> +{
> +	int bus =3D config_to_bus(event->attr.config);
> +	int filter =3D config_to_filter(event->attr.config);
> +
> +	for (int i =3D 0; i < NUM_BUS_WATCHERS_PER_MONITOR; i++) {
> +		if (hw_events->monitored_bus[i] =3D=3D bus && hw_events->filter[i] =3D=
=3D filter) {
> +			hw_events->refcount[i]++;
> +			return i;
> +		}
> +	}
> +	if (hw_events->num_monitored =3D=3D NUM_BUS_WATCHERS_PER_MONITOR)
> +		return -1;
> +
> +	for (int i =3D 0; i < NUM_BUS_WATCHERS_PER_MONITOR; i++) {
> +		if (hw_events->monitored_bus[i] =3D=3D -1) {
> +			hw_events->monitored_bus[i] =3D bus;
> +			hw_events->filter[i] =3D filter;
> +			hw_events->refcount[i] =3D 1;

[Severity: Medium]
Can a newly allocated VPU watcher be immediately and permanently disabled d=
ue
to a stale vpu_disable_pending flag?

If a concurrent rpi_axi_pmu_del() frees a watcher and sets:
   vpu_disable_pending[idx] =3D true;
   enabled[idx] =3D false;
   schedule_work(&pmu->vpu_work);

And then rpi_axi_hw_events__get_alloc_event_idx() reuses this idx for a new
event before the workqueue runs, it does not clear vpu_disable_pending here.

When rpi_axi_pmu_vpu_work_handler() later processes the new event, it will
enable it in hardware and set enabled[idx] =3D true. However, on the next r=
un,
the handler will see the stale vpu_disable_pending =3D=3D true, disable the
hardware, but skip re-enabling it because enabled[idx] is already true,
leaving the hardware counter silently stopped.

> +			hw_events->num_monitored++;
> +			return i;
> +		}
> +	}
> +	return -1;
> +}

[ ... ]

> +	/* Filtered Event Aliases (RPi 1-4) */
> +	&rpi_axi_pmu_event_cpu0_icache_rtrans.attr.attr,
> +	&rpi_axi_pmu_event_cpu0_dcache_rtrans.attr.attr,
> +	&rpi_axi_pmu_event_cpu0_dcache_wtrans.attr.attr,
> +	&rpi_axi_pmu_event_cpu1_icache_rtrans.attr.attr,
> +	&rpi_axi_pmu_event_cpu1_dcache_rtrans.attr.attr,
> +	&rpi_axi_pmu_event_cpu1_dcache_wtrans.attr.attr,
> +	&rpi_axi_pmu_event_dma0_l2_rtrans.attr.attr,
> +	&rpi_axi_pmu_event_dma0_l2_wtrans.attr.attr,
> +	&rpi_axi_pmu_event_dma1_l2_rtrans.attr.attr,
> +	&rpi_axi_pmu_event_dma1_l2_wtrans.attr.attr,
> +	&rpi_axi_pmu_event_v3d0_system_l2_rtrans.attr.attr,
> +	&rpi_axi_pmu_event_v3d0_system_l2_wtrans.attr.attr,
> +	&rpi_axi_pmu_event_v3d1_system_l2_rtrans.attr.attr,
> +	&rpi_axi_pmu_event_v3d1_system_l2_wtrans.attr.attr,
> +	&rpi_axi_pmu_event_hvs_system_l2_rtrans.attr.attr,
> +	&rpi_axi_pmu_event_hvs_system_l2_wtrans.attr.attr,
> +	&rpi_axi_pmu_event_isp_system_l2_rtrans.attr.attr,
> +	&rpi_axi_pmu_event_isp_system_l2_wtrans.attr.attr,
> +	&rpi_axi_pmu_event_usb_system_l2_rtrans.attr.attr,
> +	&rpi_axi_pmu_event_usb_system_l2_wtrans.attr.attr,
> +
> +	/* RPi 5 (BCM2712) Expanded Event Aliases */
> +	&rpi_axi_pmu_event_pcie_rp1_atrans.attr.attr,
> +	&rpi_axi_pmu_event_pcie_rp1_atwait.attr.attr,

[Severity: Low]
Are these BCM2712 event aliases missing their corresponding macro definitio=
ns?
It looks like the array references variables like
rpi_axi_pmu_event_pcie_rp1_atrans that were never declared with
PMU_EVENT_ATTR_STRING, which would cause a compiler error for undefined
identifiers when building the driver.

> +	&rpi_axi_pmu_event_pcie_rp1_wtrans.attr.attr,
> +	&rpi_axi_pmu_event_pcie_rp1_wtwait.attr.attr,
> +	&rpi_axi_pmu_event_pcie_rp1_rtrans.attr.attr,
> +	&rpi_axi_pmu_event_pcie_rp1_rtwait.attr.attr,
> +
> +	&rpi_axi_pmu_event_hevc_dec_atrans.attr.attr,

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813043533.2744=
442-1-irogers@google.com?part=3D1
