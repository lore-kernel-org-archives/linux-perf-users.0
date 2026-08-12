Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C368531355C
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 05:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786512880; cv=none; b=AkFWwG3OiXJnFuxG8vhd3DngBfFBgqmoa6cGZmetcyvaJzCVp1JHbEP0m3eQDigAWfMegbX4KpBNG33/aLCQNjswZBE10mMgh2fJukN0xBOCFyHJDGRgLFPyWpHEuJ7Zu/8WyUAZq626/CoP8Z24Wh9FSnWmZYfcpP8L45b4Tkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786512880; c=relaxed/simple;
	bh=6xgNwMZXi3ln5EeM+qsuFr46rO2SdkWxfEmq/tGlYtQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rSF2k+LXTYPu+mGg/MuK03CyLY1DbNrQmxen+XCYElVDGEWdmu5D3gQNEYEefcKE7GmRkiZFMbO0cDILsoJpIBvIwk3lgm+QTUODIHlPKFoKFOBcALltjRcMlo5fo4th6PpWi4pZLPmUF9mKKBVvXVZYRVjhWX+Qm+N6ABvh8H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWrywwl/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWrywwl/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4104B1F00A3A;
	Wed, 12 Aug 2026 05:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786512878;
	bh=VqFiNfCO2ngmR9I3cnvNgVfoUwNou9r4PooxsaMB0ic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XWrywwl/0QpguohRobAk1AxMawBvL7gMQguHSrNS++0P9Mb/IQ4PNYMzjbtX4QZ4x
	 7Er2WThhnNytpyfcbVp6Mg+eesb5D2UatZ9GicgTYAFOlhSNIyEHYKk3usDSyNe8VZ
	 uyqXT8sDwJoAkyG6HAzY+rhkkQAqxaNf1G0bF6fImiC1hHLkTHhBvpMKI+RS1EZDEW
	 xWNn9O7J/jHFqvmpVevSNi6xZuWCo+VI9n9GgnM5D1ICKqjr69CBQA4bszM2s8/WCY
	 F+s0vtj22/R02WOMOYpnHEcIk3x7qPgiDcTA08QC67asBq99Dk0J3iVCe6FHP12VDi
	 ldvtxaEgI2ctg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260812052417.2361040-3-irogers@google.com>
References: <20260812002728.2283079-1-irogers@google.com>
 <20260812052417.2361040-1-irogers@google.com>
 <20260812052417.2361040-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 05:34:37 +0000
Message-Id: <20260812053438.4104B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The BCM2712 visibility filter incorrectly hides the JPEG hardwar=
e acceleration bus PMU events.
- [Medium] Missing and mismatched PMU event aliases for BCM2712 PERIPHERAL,=
 CPU_UC, and CPU_L2 buses.

Pre-existing issues:
- [High] PMU is exposed to userspace before driver initialization completes=
, allowing a Use-After-Free if a subsequent step fails.
--

--- Patch [2]: [PATCH v4 2/2] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU su=
pport ---
commit ac1314c26eb484b245288019eb6f6293df532017
Author: Ian Rogers <irogers@google.com>

perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

Expand the Raspberry Pi AXI PMU driver to support Broadcom BCM2712
(Raspberry Pi 5) system monitors, PCIe RP1 Southbridge links, HEVC decoder,
and Cortex-A76 DSU L3 interconnects.

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> index 827656b14d85d..02ab73be70b25 100644
> --- a/drivers/perf/rpi_axi_pmu.c
> +++ b/drivers/perf/rpi_axi_pmu.c
[ ... ]
> @@ -723,6 +861,44 @@ PMU_EVENT_ATTR_STRING(isp_system_l2_wtrans, rpi_axi_=
pmu_event_isp_system_l2_wtra
[ ... ]
> +/*
> + * Quad-Core Arm Cortex-A76 Cores 0-3 I-Cache & D-Cache Filtered Events
> + * (bus=3D14, BCM2712_SB__CPU_L2)
> + */
> +/* BCM2712 Master ID Filtered Events */
> +PMU_EVENT_ATTR_STRING(arm_rtrans,              rpi_axi_pmu_event_arm_rtr=
ans,              "monitor=3D0,bus=3D5,counter=3D4,filter=3D10");
> +PMU_EVENT_ATTR_STRING(arm_wtrans,              rpi_axi_pmu_event_arm_wtr=
ans,              "monitor=3D0,bus=3D5,counter=3D2,filter=3D10");

[Severity: Medium]
Does this mapping correctly reflect the intended hardware bus?

The comment states that the Cortex-A76 Cores L2 cache events correspond to
bus 14 (BCM2712_SB__CPU_L2), but the event strings specify bus=3D5
(BCM2712_SB__SYSTEM_L2). Will this yield incorrect measurements for the CPU
L2 cache when queried via sysfs?

[ ... ]
> @@ -879,12 +1055,107 @@ static struct attribute *rpi_axi_pmu_events_attrs=
[] =3D {
[ ... ]
> +static umode_t rpi_axi_pmu_events_is_visible(struct kobject *kobj,
> +					      struct attribute *attr, int unused)
> +{
[ ... ]
> +	if (rpi_pmu->chip =3D=3D CHIP_BCM2712) {
> +		/*
> +		 * On RPi 5 (BCM2712), hide legacy VPU Mailbox IPC events (monitor=3D1)
> +		 * and legacy RPi 1-4 System Monitor aliases
> +		 */
> +		if (strstr(pmu_attr->event_str, "monitor=3D1") ||
[ ... ]
> +		    strstr(attr->name, "v3d_") ||
> +		    strstr(attr->name, "jpeg_") ||

[Severity: Medium]
Should the jpeg_ aliases be hidden on BCM2712?

The BCM2712 hardware definitions (BCM2712_SB__JPEG =3D 2) indicate that the
JPEG hardware acceleration bus is supported, but this logic explicitly
hides it from userspace on this platform. Does this incorrectly deny access
to valid hardware events?

> +		    strstr(attr->name, "peripheral_") ||
> +		    strstr(attr->name, "cpu_uc_") ||
> +		    strstr(attr->name, "cpu_l2_") ||

[Severity: Medium]
Is it intentional to hide these legacy aliases without providing replacemen=
ts
for BCM2712?

The aliases for peripheral_, cpu_uc_, and cpu_l2_ are hidden here, which
limits functionality on the new platform since equivalents weren't added in
the newly defined BCM2712 expanded event aliases.

[ ... ]
> @@ -1575,7 +1847,7 @@ static int rpi_axi_pmu__init(struct rpi_axi_pmu *pm=
u, struct platform_device *pd
>  	spin_lock_init(&pmu->lock);
>  	mutex_init(&pmu->vpu_mutex);
> =20
> -	pmu->chip =3D CHIP_BCM2835;
> +	pmu->chip =3D (enum rpi_axi_chip)(uintptr_t)of_device_get_match_data(de=
v);
> =20
>  	pmu->pmu =3D (struct pmu) {
>  		.module =3D THIS_MODULE,

[Severity: High]
This is a pre-existing issue, but does this function expose the PMU to
userspace before driver initialization is complete?

Looking at rpi_axi_pmu__init(), the PMU is registered before ensuring all
initializations succeed:

drivers/perf/rpi_axi_pmu.c:rpi_axi_pmu__init() {
    ...
    ret =3D perf_pmu_register(&pmu->pmu, PMU_NAME, /*type=3D*/-1);
    if (ret) {
        ...
    }

    ret =3D cpuhp_state_add_instance(rpi_axi_pmu_cpuhp_state, &pmu->cpuhp_n=
ode);
    if (ret) {
        dev_err(dev, "Failed to add cpuhp instance %d\n", ret);
        goto err_pmu_unregister;
    }
    ...
}

If cpuhp_state_add_instance() fails, the error path calls
perf_pmu_unregister(). However, if userspace opens the event during this
window, it will retain a reference to the struct pmu memory. That memory
gets freed by the devres framework when the probe fails, potentially causing
a use-after-free when userspace interacts with the open event.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812052417.2361=
040-1-irogers@google.com?part=3D2
