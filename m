Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD6413D62
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603944; cv=none; b=jNz3WM5XfA4DHFHbcd9Y5JfenVxq+3DGozIJzwX2kQv2C7NWxfd9auvXyTvwQh1C4BW/YYVIrFsCPO23dn8yP9pKof6ACjXvY2cM4trWbrXN1mTRCk24LPefHlwBhnbhOA18DZr0qUXYLc3QGUA4OF7rVZr0xPdRYDJq2pGDwSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603944; c=relaxed/simple;
	bh=Dhbdo0kXJ/JKZuQRJSzjHaiRoEtK+pC6UV1dgXqHshI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mKsYxb5epxsHe2x6BEwy479VAKb7wOR7h3fvqGgdW3mHWHgS032AkDUBdoi7tZaxVoraRyoHvjXwTuBSHrWX99IiZUC/t6+3yCUnO9BFIGZEHrEEFBMw59b/OnGoxsRZIRxUeVF2GeWjL+cE/wHnd9P72W5OELdMFSSnw4PSgvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6xxaMEb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6xxaMEb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FFB1F000E9;
	Thu, 13 Aug 2026 06:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786603943;
	bh=1w+CqLKiXVCxK0l4t6pLysMKlFysWHwHpy2o/OdQrG4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R6xxaMEbuNE0my3JAVimD1wIKbho6hV2kJSZb86Roa/+wEuINEtoJ12mZ4MwKuJBq
	 LfplYIhaCohEaPCulQABgseF41Wrhotgw0v2/avpXT4fPhSH48GZcB7LD9iwOcV+8S
	 688KDthfi12K0YZWahoOQ/o/cqzT62J56AxqWppjVls84eDiUWOCrGRJxaOENcXkA5
	 P5JCYn4A3DXk4yFg1cywXr7aB3pqOb2rkEOVWahXq/iqbhtgV+Zt8OTi5j66u2ShW3
	 pRoPX1Qq5Klv2yDc6qiLMT5nfbYBtmXltlEM0hdLsfwTAG8KMdPMRwhAVhFY6R4GfQ
	 yRtPHXWJ2b8gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/2] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813064228.2799872-3-irogers@google.com>
References: <20260813052419.2770841-1-irogers@google.com>
 <20260813064228.2799872-1-irogers@google.com>
 <20260813064228.2799872-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 06:52:22 +0000
Message-Id: <20260813065222.F3FFB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `.scale` and `.unit` sysfs attributes for legacy VPU events =
are incorrectly left visible on BCM2712, creating orphaned attributes.
--

--- Patch [2]: [PATCH v8 2/2] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU su=
pport ---
commit 9b809ab6d889410949331370e01a80aece4e483f
Author: Ian Rogers <irogers@google.com>

perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

This patch introduces AXI PMU support for the Broadcom BCM2712 SoC used in =
the
Raspberry Pi 5. It expands the driver with BCM2712-specific buses, hardware
filters, and sysfs events, while ensuring compatibility with prior generati=
ons.

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> index 676c2a3d5962e..25563fa789ca4 100644
> --- a/drivers/perf/rpi_axi_pmu.c
> +++ b/drivers/perf/rpi_axi_pmu.c

[ ... ]

> @@ -1491,12 +1871,62 @@ static struct attribute *rpi_axi_pmu_events_attrs=
[] =3D {
>   * @unused: Index (unused)
>   *
>   * Dynamically filters sysfs event aliases based on the detected Broadco=
m SoC generation:
> + * - On BCM2712 (RPi 5): Hides VideoCore VPU Mailbox IPC events (monitor=
=3D1).
> + * - On BCM2835-BCM2711 (RPi 1-4): Hides Cortex-A76 and RP1 PCIe specifi=
c events.
>   *
>   * Return: attr->mode (0444) if visible on current SoC, 0 to hide.
>   */
>  static umode_t rpi_axi_pmu_events_is_visible(struct kobject *kobj,
>  					      struct attribute *attr, int unused)
>  {
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

[Severity: Medium]
Will this correctly hide the .scale and .unit sysfs attributes for legacy V=
PU
events on BCM2712?

Since the event_str for those attributes is strictly "32" or "Bytes", the
check for "monitor=3D1" will fail. This could leave orphaned .scale and .un=
it
attributes visible in sysfs for events that are otherwise correctly hidden.

Could this be addressed by adding a fallback check on attr->name (for examp=
le,
checking for "vpu") to ensure the scale and unit attributes are also caught?

> +		    strstr(attr->name, "cpu0_") ||
> +		    strstr(attr->name, "cpu1_") ||
> +		    strstr(attr->name, "dma0_") ||

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813064228.2799=
872-1-irogers@google.com?part=3D2
