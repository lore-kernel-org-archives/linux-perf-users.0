Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004603;
	b=sAqOUoRDZdtZ4a0uQU9fs1uSfRgJc//bNjRwHX5u1Nd9IyjpOidy9bFzq9JquEOnbPUl
	 qJLSgKwAxpgzHBJqslSRkqnx2oyB5KswUTkcwoia7Nq21evQ/iyy3lUxd8v4ai4zNM9PV
	 WbL1MJBveeMqBWHNUNrKtom83EUMs/oztF/13wO4ihXSO9qheP9arc1i4/5cBlxHaiXh8
	 4ov+JIuTgSw5nxBvZDlOb2BrlKC6QtH0BJtC9OGusI7KQMj1K+pMPPQxOcmmS6j3Iiz6Q
	 xwCUtdyG5kwEbhGIKykn5J8QXigfS6VHBXRxvnui+R43qPqOQoMludcZUidtU6eN9zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004603;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wzSKxc+ZPuU18dYT/cMcB4hbyiVD8dhB+pduVO/cbzQ=;
	b=HwgyW+a+eYsh7U/4dM5sbX0iQDy7r9zyqnfzJyAnfNfLx3KtHSNFqQHfwgtzhegimRPv
	 03aAAzcq+2ZDps7BM+sgoNKBh/i2BuOCRKVmkZ4U0HgN/y0yQgWjZQgo++TQ5d1irR3++
	 zsQV4lioeu3wm+rh6n1pW7y45myZW+bzOJ0Gql2cN1XsqfhhSLIXsEhijtJtEVl+ZRtez
	 ZdzoR/G2jrj3G48pSBHLCzhB0h/ZrfvwRUqmzu77ftVJla6h9RtBKy1Nm5OJMCHwJ+Uf7
	 GTCd9Zr52gx/OFLWvYydSBAhG24dk0hiNY3K6YftSqih2rm9pNkUx9ooIgggQWngy7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bpi/l4g6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BDF606A31B
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpi/l4g6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93011F031E0;
	Mon, 26 Oct 2026 08:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004602;
	bh=wzSKxc+ZPuU18dYT/cMcB4hbyiVD8dhB+pduVO/cbzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bpi/l4g6v+JAVrLkAlCaPNEnhPZldlTkKHUPnq2qJ0eH/F8qohQhnSc0sr+E7G4+r
	 Z45facGgzboXVEZ76YRsDekf8EyuoEf/wXyIzeMcAL35Zt48rLrohMIxAt8FfSq35O
	 I+T/9N3/xy3SiIq2PzB3wGPZLGsJQ+fNuFIr7IaW/OrmCNAiWrjJXCOvnR8FMCXfpJ
	 xalriUZ+QsRKfmmqpOqCtpDqxqI2DLyRnKr3S0T+ST/gRPjUVvycaAEeYOA3CyN9Au
	 zMPTZhUJ7FdYw0+0/H58CGl1V2LI5eEtBrZDtkFYP6WSTtUMgR/6sK76Xm83PaOtRO
	 WwoAVzGS3gnig==
Message-ID: <sashiko-outbox-184696@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/7] coresight: Add pmu_pulse/extout_pulse
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <02268c4958153f6d2e549e4bd7b93f11ed79fa90.1792989860.git.aaupov@fb.com>
References: <cover.1792907332.git.aaupov@fb.com>
 <cover.1792989860.git.aaupov@fb.com>
 <02268c4958153f6d2e549e4bd7b93f11ed79fa90.1792989860.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 08:50:02 +0000
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
- [Medium] coresight: extout_pulse loads on ETE with single event lacking T=
RCEXTOUT1
--

commit 5f7a0d60c7147cc2e10191888168dd0008749154
Author: Amir Ayupov <aaupov@fb.com>

coresight: Add pmu_pulse/extout_pulse

This commit adds the built-in pmu_pulse configuration and extout_pulse
feature for ETMv4/ETE to pulse external output 1 on every traced cycle
for the PMU to count as TRCEXTOUT1.

> diff --git a/drivers/hwtracing/coresight/coresight-cfg-pmu-pulse.c b/driv=
ers/hwtracing/coresight/coresight-cfg-pmu-pulse.c
> new file mode 100644
> index 0000000000000..61472154dd02a
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-cfg-pmu-pulse.c
> @@ -0,0 +1,55 @@
[ ... ]
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
Can extout_pulse_etm4x load and enable on an ETE implementation that only
supports a single event (event 0 / TRCEXTOUT0), where event 1 and
TRCEXTOUT1 do not exist?

In drivers/hwtracing/coresight/coresight-etm4x-core.c, when TRCIDR0.NUMEVENT
is 0 and resources are present, etm4_init_arch_data() sets caps->nr_event to
1. Then etm4_pmu_counts_extout() checks whether the implemented events have
matching PMU counters:

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

When drvdata->caps.nr_event =3D=3D 1 and ARMV8_PMUV3_PERFCTR_TRCEXTOUT0 is
implemented, etm4_pmu_counts_extout() returns true and etm4_cscfg_register()
advertises CS_CFG_MATCH_CAP_TRCEXTOUT.

When loading the feature, etm4_cfg_load_feature() -> etm4_cfg_map_reg_offse=
t()
maps TRCEVENTCTL0R without checking whether drvdata->caps.nr_event >=3D 2. =
By
contrast, event_store() in drivers/hwtracing/coresight/coresight-etm4x-sysf=
s.c
shows that EVENT1 (bits [15:8] of TRCEVENTCTL0R) is only implemented when
caps->nr_event >=3D 2:

	case 1:
		/* EVENT0, bits[7:0] */
		sysfs_config->eventctrl0 =3D val & 0xFF;
		break;
	case 2:
		/* EVENT1, bits[15:8] */
		sysfs_config->eventctrl0 =3D val & 0xFFFF;
		break;

On an ETE with caps.nr_event =3D=3D 1, enabling pmu_pulse will succeed and
write 0x0100 to the unimplemented EVENT1 field in TRCEVENTCTL0R while
TRCEXTOUT1 does not exist. Should CS_CFG_MATCH_CAP_TRCEXTOUT or the feature
loading path verify that event 1 (caps.nr_event >=3D 2 and TRCEXTOUT1) is
available?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792989860.gi=
t.aaupov@fb.com?part=3D7
