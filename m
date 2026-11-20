Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189281;
	b=tDlSnki2pWLAe6x7mKfJLkgseXIV7TqmJvJMVQHPQoK3pnZHxiIUDAI8nPwxoCEG4nM2
	 GkDyewZ9I2kkB0uKsP60TuzUjoWpjZGcxsBp0McjuxfwC7w1l7FVGJ1hcDNF7GaMhLJh6
	 ybklFu1cklRM/pN8CNN4895fzHT5xQJrFQazDXO0Fe92to3NU/sTtyg9MPAqjgH/dvaBl
	 8K2+/ZcW6epkrAxiYPQkwKGyvbBTlHoc39pmO8dmWiD9btIJuRDdLiT0qlJJ6l2LJcCWK
	 VHo/7mzJq4uFmLyR3/EkuvI00YEy5SK6cCxJfox2oLJ4CVrT57zrdDDiMGHkPm5/ePQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189281;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jnP4nWESdgFPDNI/fng5Ab9alHxVJjZ+Y/o4fMDRmHQ=;
	b=NdSPHnZBog5JUA5rZcGe/YXtMhVlYikNJQxExKpDE06zrFkSECtmwz6iwUX9vwLZZLd1
	 H8lU/azM43PqE/6iHgMMdP3jPeW2f4yebaCzH473UGxL31R7eZ/TJ7IBtY/T9OAktf8e5
	 QixaokMh7dp4BUt+Vo9tMFMz7JWjy4TSJLpg1P2dlXuIqrSx8lHLnGe2IJgLfTzKTfHck
	 mSUXcPWmxZ5ng+CEqCbK/mGp/DofQJ8Tr+7WPayLcFd01ht3cHZqYxJxeLgeoPP9PMW/w
	 ja1YNHnudoVOr98hDJzhndtwXS5k+7qjt4C+mxYfxFAIDeaB+W3Tr8Nr9Ets0nBExDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZTXNptc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0C9606A320
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZTXNptc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821C41F000EB;
	Fri, 20 Nov 2026 15:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795189280;
	bh=jnP4nWESdgFPDNI/fng5Ab9alHxVJjZ+Y/o4fMDRmHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XZTXNptc42/MRzfOZlsSpx+mMDyiuOBdshxSW1cSumjBucHDQgvgHcf9mHxIVzU/G
	 dqWUr2uOZcC5j2uW8rTSSEHhzFDUymogbGlamYfNmtQ/vqqWTRVGXUytJhSbzNQxOv
	 JYJ9Dtnpj5xxmxXj3B5N8AEQ/laLhy4EyoLMNGxloGaXHXbcVWPJkjvVdWMPM5V4sr
	 f6y1FYI/uUbWh92L4opCxnZ6eeFXfdk8Wr1YVJkHHYhwTGQhtBBOWpCxvehiXSKC8z
	 etxmnSCH0rR0dKknc9+5agEu6iRyyOf6xt8y4M5CLWh1ZnYcOiaEBVMSMui/Ovdwq6
	 86migqkkYBBJQ==
Message-ID: <sashiko-outbox-225475@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/7] coresight: Add pmu_pulse/extout_pulse
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <c43cc5feecb253821499be80d43f1e71ccb32193.1795182850.git.aaupov@fb.com>
References: <cover.1795182850.git.aaupov@fb.com>
 <c43cc5feecb253821499be80d43f1e71ccb32193.1795182850.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 15:41:20 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] coresight: extout_pulse loads on 1-event ETE lacking EVENT1
  and TRCEXTOUT1
- [Low] coresight: missing coresight-cfg-preload.h include in
  coresight-cfg-pmu-pulse.c
--

commit e489c2f2f5183f248bad3a743fec51069d6bccc4
Author: Amir Ayupov <aaupov@fb.com>

coresight: Add pmu_pulse/extout_pulse

This commit adds a built-in pmu_pulse configuration and extout_pulse
feature for ETMv4/ETE to pulse external output 1 on every traced cycle for
counting via the TRCEXTOUT1 PMU event.

> diff --git a/drivers/hwtracing/coresight/coresight-cfg-pmu-pulse.c b/driv=
ers/hwtracing/coresight/coresight-cfg-pmu-pulse.c
> new file mode 100644
> index 0000000000000..76e8e6b5da0e9
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

[Severity: Low]
Should this file also include coresight-cfg-preload.h for the extern
declarations of extout_pulse_etm4x and pmu_pulse_etm4x?  Without it, C=3D1
sparse builds warn that both symbols are undeclared, as fixed for
coresight-cfg-afdo.c in commit a7195f3f9383 ("coresight: Fix undeclared
variable warnings from sparse checker").

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
> +	.match_flags =3D CS_CFG_MATCH_CLASS_SRC_ETM4 | CS_CFG_MATCH_CAP_ETE_TRC=
EXTOUT,
> +	.nr_regs =3D ARRAY_SIZE(extout_pulse_regs),
> +	.regs_desc =3D extout_pulse_regs,
> +};

[Severity: Medium]
Can extout_pulse_etm4x match and load on an ETE that only implements a
single event (caps.nr_event =3D=3D 1), where EVENT1 and TRCEXTOUT1 do not
exist?

CS_CFG_MATCH_CAP_ETE_TRCEXTOUT is set by etm4_pmu_counts_extout(), which
only checks up to drvdata->caps.nr_event:

drivers/hwtracing/coresight/coresight-etm4x-core.c:etm4_pmu_counts_extout()=
 {
	if (!etm4x_is_ete(drvdata) || !drvdata->caps.nr_event)
		return false;

	for (n =3D 0; n < drvdata->caps.nr_event; n++) {
		if (!pmuv3_event_implemented(ARMV8_PMUV3_PERFCTR_TRCEXTOUT0 + n))
			return false;
	}

	return true;
}

When TRCIDR0.NUMEVENT is 0 (so caps.nr_event =3D=3D 1) and TRCEXTOUT0 is
implemented, etm4_pmu_counts_extout() returns true and
etm4_cfg_map_reg_offset() accepts TRCEVENTCTL0R without checking
caps.nr_event >=3D 2.  Enabling pmu_pulse on such a device succeeds instead
of returning -EINVAL, writing 0x0100 to the unimplemented
TRCEVENTCTL0R.EVENT1 (bits [15:8]) field with no external output pulses.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795182850.gi=
t.aaupov@fb.com?part=3D7
