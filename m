Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1766230F958
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786782811; cv=none; b=IcdQu/B4wfV9R8mbcoWXcXbXtQX/Zc1CY2dnWYsoGgXpMuGB2GcDU7sGcvhe2TfN6Gwko1Q53peuqQpwcccGG1ZbmPrZI1z0agJoGOseNTFKIvO15Lyidx7YyzVtEzlaXxgtBz3OLC0C4yBsZ9aZmb+SjpUto+B0seuSdFk792w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786782811; c=relaxed/simple;
	bh=V/eXk4IUtNq90e7QRL148PQkzy4hlY1ZyzdmZYRu53Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P+U3Pj4t1jH9uOwPOayb8F1pleWhazRpwNt+7LFg4YhhSgODJxr8dhmq4jqbvKczZYMht9eP2MgpStDDWYCmWPB9U29s5/qz59l0Jq1Oy7P9lXkeRYdjJuUBT3Gc4Qh2B69AWPgu+Dj67LZXCuxkd0/seniiulbiGMdD7ca16vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQw/tcSA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQw/tcSA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986B51F000E9;
	Sat, 15 Aug 2026 08:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786782809;
	bh=RI6fDVeTuBWJ6i/Xhnb6sXfMlPbXatVoqf7+SPgjeKA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iQw/tcSACjonTtl+kbGQPxBv0sTf7vZQwlqM9NoYccnFjQVoa6fytNW86thFlyQ6n
	 srgPezkpn4ge6vhRXwd8BFjgMUO5b/3YNW15j/iqGWen9XcRaeUhIl3C9ybHaRAyxw
	 jLagxUq8p4/LHs2XYOtWTxjqx1vfytWN8Sj1TWdA0ZjDASHueUmRkvB0ZpW1V2Czmf
	 EAfgZen1b4xKmfFu9PhcqSBHKByfFTSvaeh7bXxH3Ev8lNciDnYa2tyeL8IchLgplF
	 yIiZfhhVMCWl/jRuQWqYE4E+lZCe3u1JbnlyS4JzF3a8kkUEtOTAUGoDQwvSXFLMPH
	 JLU8dog4GWdQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 3/3] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260815082048.4043217-4-irogers@google.com>
References: <cover.1691900000.git.irogers@google.com>
 <20260815082048.4043217-1-irogers@google.com>
 <20260815082048.4043217-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 08:33:29 +0000
Message-Id: <20260815083329.986B51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch omits the actual sysfs string definitions and array en=
tries for BCM2712 CPU L2 events (bus 14) and all BCM2712 Master ID Filtered=
 events, despite adding block comments explicitly advertising them.
--

--- Patch [3]: [PATCH v12 3/3] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU s=
upport ---
commit 98bc0717543a8bd621987519c302f6eacbe4544d
Author: Ian Rogers <irogers@google.com>
perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

This commit introduces native MMIO-based AXI Performance Counters support
for the BCM2712 architecture (Raspberry Pi 5). It bypasses the legacy VPU
Mailbox IPC layer and defines the mapping arrays for the new endpoints.

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> index eda831d66056f..a7e832df49d39 100644
> --- a/drivers/perf/rpi_axi_pmu.c
> +++ b/drivers/perf/rpi_axi_pmu.c

[ ... ]

> +PMU_EVENT_ATTR_STRING(cpu_uc_wtrans.scale, rpi_axi_pmu_event_bcm2712_cpu=
_uc_wtrans_scale,
> +		      "32");
> +PMU_EVENT_ATTR_STRING(cpu_uc_wtrans.unit, rpi_axi_pmu_event_bcm2712_cpu_=
uc_wtrans_unit,
> +		      "Bytes");
> +
> +/* BCM2712 Master ID Filtered Events */
> +
> -static struct attribute *rpi_axi_pmu_events_attrs[] =3D {
> -	/* System Monitor events */
> +static struct attribute *rpi_axi_pmu_bcm2835_events[] =3D {

[Severity: Medium]
Are the actual sysfs string definitions for the BCM2712 Master ID filtered
events and CPU L2 events (bus 14) missing here? The block comment advertises
the Master ID filtered events, but the code immediately transitions into the
rpi_axi_pmu_bcm2835_events array. Without these definitions, they will not
be exported for use by the perf tool.

[ ... ]

> +	&rpi_axi_pmu_event_bcm2712_cpu_uc_rtrans.attr.attr,
> +	&rpi_axi_pmu_event_bcm2712_cpu_uc_rtrans_scale.attr.attr,
> +	&rpi_axi_pmu_event_bcm2712_cpu_uc_rtrans_unit.attr.attr,
> +	&rpi_axi_pmu_event_bcm2712_cpu_uc_wtrans.attr.attr,
> +	&rpi_axi_pmu_event_bcm2712_cpu_uc_wtrans_scale.attr.attr,
> +	&rpi_axi_pmu_event_bcm2712_cpu_uc_wtrans_unit.attr.attr,
> +	NULL,
> +};

[Severity: Medium]
Does the rpi_axi_pmu_bcm2712_events pointer array end prematurely? It appea=
rs
to stop after configuring the cpu_uc events (bus 13) and entirely lacks
pointers for the CPU L2 (bus 14) and Master ID filtered features, meaning t=
hey
won't be exposed via sysfs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815082048.4043=
217-1-irogers@google.com?part=3D3
