Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792911021;
	b=Qy+hv8mA0voqNzpx7iKPVfogE2BXRhWs729lkBx0YiKttnyMJffbBMNDbVSnlkWxcsRA
	 L34XvGjwZh67owfQEawThoM4+gAFfsn/QphH16GRSMqkmQSYwDqJ8xS4dtwTRcOFRYpUS
	 6zkQbpVBVLBS3WA+5oSnQP5k19B4jgkRdvvTSrBfSiTHS7KoNyEvucuargv3xKeJrz7Ba
	 HKBPrzwFEzlOiHaQ14sKwVSD7tH3lEkZWYX8z9YV3gegYkhXKZd2YCib3F5OnssesV9O6
	 jh3HvFKerMz59XTcsqBf47b2A3191lxs15c2W5sQK1PVEGLWjJTauRpeWowqSTp5KvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792911021;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fVHpdAvspCYMrkDcByy6lDPwg4zMKjKzaAgmFlr2Azg=;
	b=yA5ZHQIpjDvZE6h68bWnQUBgzQ03whkTFI1bA17MHWRZ6e78VtXZEUuHQKU5eQXJBM2N
	 BbqBhKrr5gp6qaxeC5Ac0w294327Z+mr12deVBzpO65U5YAHTQFUJSWxuUUcAdWjM36ND
	 h9VQcVD9Yx7xQqY51u+bIx1jtUDKu46/+YI40+CyyFXO4xwq9sRKFJC0MNWX6XCNolFk0
	 lbiUI0dZDaBUmTOGK0pxNnLMRjR2wbegZ5d6FIfA4obNPYKQrN6QeQfOBrle4DZiretMD
	 ocunxOmTcUIc1UC+J2ENQprd1NfxlWhRvUw+vVkLktv+IG6f+h8aCbg54/XsJh+Hjew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BnibZCMU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB09606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BnibZCMU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E021F01825;
	Sun, 25 Oct 2026 06:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792911021;
	bh=fVHpdAvspCYMrkDcByy6lDPwg4zMKjKzaAgmFlr2Azg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BnibZCMUGIbI6C5UlKZiijfl2LWuu4k6fqIVUaVTwG78Dd/7UOIQQm/NG1Hr74JGg
	 /5n72h/0WNGhbw/C/RDnKymv1vpw/qrEZ5RJgoBq4HNJ1e92r1l2Hq6G/J19Q5nuvz
	 3Oh1z47MwsNO9QsDAGnI/pj+DwZi5rNOocGogvV5tXmvox+vPaQ91294OikigvfYWt
	 3HIncVKW65MunMUmvbBR29uO4N2TbcvB/jkRxspp6tsdfn8TU1qXwhk/JJPPvOou++
	 Wn0tVVwUDIBPMAuWX5nWnYJkkBCzn9TL85eUnXgGnncmF0EjCbqcJ+DMyEzwcYFmiK
	 JZglCPyZd+ZWw==
Message-ID: <sashiko-outbox-184103@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/7] coresight: Add pmu_pulse/extout_pulse
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <de0b4afa0952e145eae78eae2c81aa66d1247692.1792907333.git.aaupov@fb.com>
References: <20261012230527.750567-1-aaupov@fb.com>
 <cover.1792907332.git.aaupov@fb.com>
 <de0b4afa0952e145eae78eae2c81aa66d1247692.1792907333.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 06:50:20 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] coresight: pmu_pulse loads on 1-event ETE lacking event 1 and TR=
CEXTOUT1
--

commit 75adf8bc69eef9902a1a675969ecaf268f815f11
Author: Amir Ayupov <aaupov@fb.com>

coresight: Add pmu_pulse/extout_pulse

This commit adds a built-in pmu_pulse configuration and extout_pulse feature
for ETMv4/ETE trace units that program event 1 in TRCEVENTCTL0R to select t=
he
always-true resource and pulse external output 1 (TRCEXTOUT1) on every trac=
ed
cycle.

> diff --git a/drivers/hwtracing/coresight/coresight-cfg-pmu-pulse.c b/driv=
ers/hwtracing/coresight/coresight-cfg-pmu-pulse.c
> new file mode 100644
> index 0000000000000..61472154dd02a
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-cfg-pmu-pulse.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Pulse ETM external output 1 on every traced cycle for a PMU event to =
count.
> + * Based on coresight-cfg-afdo.c
> + */
> +
> +#include "coresight-config.h"
> +
> +/* ETMv4 includes and features */
> +#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
> +#include "coresight-etm4x-cfg.h"
> +
> +/*
> + * extout_pulse feature: event 1 selects the always-true resource, so ETM
> + * external output 1 pulses on every cycle while the trace unit is enabl=
ed. A
> + * PMU event counting that output (TRCEXTOUT1), for example with
> + * aux-action=3Dpause, then fires after as many traced cycles as its sam=
ple
> + * period. Event 0 is avoided because it is the trace unit trigger, and =
the
> + * TRBE driver treats a detected trigger as fatal.
> + */
> +static struct cscfg_regval_desc extout_pulse_regs[] =3D {
> +	/* event 1: resource selector 1 (always true), drives external output 1=
 */
> +	{
> +		.type =3D CS_CFG_REG_TYPE_STD | CS_CFG_REG_TYPE_VAL_MASK,
> +		.offset =3D TRCEVENTCTL0R,
> +		.val32 =3D 0x0100,
> +		.mask32 =3D 0xff00,
> +	},
> +	/* end of regs */
> +};
> +
> +struct cscfg_feature_desc extout_pulse_etm4x =3D {
> +	.name =3D "extout_pulse",
> +	.description =3D "Pulse external output 1 on every traced cycle.\n",
> +	.match_flags =3D CS_CFG_MATCH_CLASS_SRC_ETM4 | CS_CFG_MATCH_CAP_TRCEXTO=
UT,
> +	.nr_regs =3D ARRAY_SIZE(extout_pulse_regs),
> +	.regs_desc =3D extout_pulse_regs,
> +};

[Severity: Medium]
Can extout_pulse_etm4x load on a 1-event ETE that only implements event 0 a=
nd
TRCEXTOUT0, where event 1 (TRCEVENTCTL0R[15:8]) and TRCEXTOUT1 do not exist?

In drivers/hwtracing/coresight/coresight-etm4x-core.c, on an ETE where
TRCIDR4.NUMRSPAIR > 0 and TRCIDR0.NUMEVENT =3D=3D 0, etm4_init_arch_data() =
sets
drvdata->caps.nr_event =3D 1. When etm4_cscfg_register() checks
etm4_pmu_counts_extout(), it only verifies the events up to caps.nr_event:

static bool etm4_pmu_counts_extout(struct etmv4_drvdata *drvdata)
{
	int n;

	if (!etm4x_is_ete(drvdata) || !drvdata->caps.nr_event)
		return false;

	for (n =3D 0; n < drvdata->caps.nr_event; n++) {
		if (!pmuv3_event_implemented(ARMV8_PMUV3_PERFCTR_TRCEXTOUT0 + n))
			return false;
	}

	return true;
}

When drvdata->caps.nr_event =3D=3D 1 and ARMV8_PMUV3_PERFCTR_TRCEXTOUT0 is
implemented, etm4_pmu_counts_extout() returns true and sets
CS_CFG_MATCH_CAP_TRCEXTOUT without checking TRCEXTOUT1.

During feature loading in drivers/hwtracing/coresight/coresight-etm4x-cfg.c,
etm4_cfg_load_feature() -> etm4_cfg_map_reg_offset() maps TRCEVENTCTL0R
unconditionally via CHECKREG(TRCEVENTCTL0R, eventctrl0) without checking
whether drvdata->caps.nr_event covers the event fields masked by the featur=
e.

Should etm4_cfg_load_feature() or the capability check verify that
drvdata->caps.nr_event >=3D 2 before allowing extout_pulse_etm4x to load and
program TRCEVENTCTL0R[15:8]?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792907332.gi=
t.aaupov@fb.com?part=3D7
