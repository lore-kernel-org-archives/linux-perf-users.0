Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704374;
	b=ZnNFSrQq9hGLX1tWK+ql/67FjfByrYpuaF8+CA7MrnLWXd24zXRVByG976duxEQLZXBa
	 b2YuNwp6rvz0pnhfup7rsNaTB3pEz07iy5epGp9BDfED8Hi6jU8zKwesxP3sYFZUSZ4Dv
	 /BRmMQwCJ+6JrXCHSOyAlAC4Z7q6JUVSMRNP2jLumoICb+93WMDqS/DGP29Tpq/Tmd0JK
	 8Ug2ftcr8PlGUEXHpT21BXk3ck1wgd9pTAWrydu4AOFW/OD9Qq9xDTUPBMNDJausyFEug
	 cJLuA50E9scRPIwPVFwl4TZnjXdzwBPabj+gIS8/VMhkC5N72/xEXvOP3GgK98iOwqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704374;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p3iQDriiwxe/5du2e1tCc3FwMservQSWsuM2sFE2jDo=;
	b=3EqLm0tlYDTdrujNBhxq2SvaC01Fdny7XztAafZbspLe4rjO8RFWKuwYCJqI+8keXcFA
	 IR6LROk7xL6JJfeT/ecoy5c2yDzPZ4OPVDzhB6a6j66+zbmomf2f5wrc++zRx5mXjmEqJ
	 g9zzDWpJGClj2hAOrksTTEhOAcWxonlnR51mJQEiSORND4JTCwlpP3MWzGFRQP+qqltGB
	 sZzfRNEe94gTIFFTruCZuHAbrqI/mr/f5GOF4eX0v+SFSwX/1gKPLV50XAtll1HEF9UUr
	 qIl+mlX9i+jOzqjSlOfbsq57wol/O3yTWXmA3YJox/dSks99aUTDbpnKVda8bsu1gwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYuQPLUL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64495606B13B;
	Tue,  3 Nov 2026 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYuQPLUL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0033E1F000C1;
	Tue,  3 Nov 2026 11:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704374;
	bh=p3iQDriiwxe/5du2e1tCc3FwMservQSWsuM2sFE2jDo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dYuQPLUL/S9LSYLUncaaBQ1b4bFhIxlOciSF9QHGZxnewMOaYilkaFTQflBXyc8cC
	 /NHqp3PlHVic9HEAUTiiPknFXtpEiSNCyqxJOIaioTiGTv+jBpZrJSWkbS47WCsN9C
	 j21kc5iszINBmwEU9S4/MtBI1alW+qYh/Qq8/vprXcqBddPv5QbMvgPDJ9aC7pRTTO
	 CEPVMLpR7eyJ4HlEcho3Ad+59OYlhll9jzwUTJCj2uYgdqdvl5VRzeECFLFSpAEE9C
	 U1QZ1q5Bekx69sniqgcsJSqK1wdAi60i/Fxi56QynzN0qRejL5hJ4G+3XAh48P/yhc
	 w6F7Pt070vLww==
Message-ID: <sashiko-outbox-195124@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/13] arm64: dts: apple: t604x: Add PMU Device Nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261103-m3-plus-pmu-events-v1-11-a8eb6c1139fe@gmail.com>
References: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
 <20261103-m3-plus-pmu-events-v1-11-a8eb6c1139fe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:12:53 +0000
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
- [High] arm64: dts: apple: t6041: 4-cell PMU interrupts with 3-cell aic pa=
rent
--

commit d0216cee20998d9364fd46a4827e945211d4e88a
Author: Myria Sarvay <myrialsarvay@gmail.com>

arm64: dts: apple: t604x: Add PMU Device Nodes

This commit adds the pmu-e and pmu-p device tree nodes for the Apple M4
Pro/Max (t6041) SoC.

> diff --git a/arch/arm64/boot/dts/apple/t6041.dtsi b/arch/arm64/boot/dts/a=
pple/t6041.dtsi
> index 9110d05c896da..2c72972d12192 100644
> --- a/arch/arm64/boot/dts/apple/t6041.dtsi
> +++ b/arch/arm64/boot/dts/apple/t6041.dtsi
> @@ -314,6 +314,18 @@ l2_cache_2: l2-cache-2 {
>  		};
>  	};
> =20
> +	pmu-e {
> +		compatible =3D "apple,brava-e-pmu";
> +		interrupt-parent =3D <&aic>;
> +		interrupts =3D <AIC_FIQ 0 AIC_CPU_PMU_E IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	pmu-p {
> +		compatible =3D "apple,brava-p-pmu";
> +		interrupt-parent =3D <&aic>;
> +		interrupts =3D <AIC_FIQ 0 AIC_CPU_PMU_P IRQ_TYPE_LEVEL_HIGH>;
> +	};

[Severity: High]
Should the interrupts properties in pmu-e and pmu-p use 3 cells instead of =
4?

In arch/arm64/boot/dts/apple/t6041.dtsi, the parent aic controller declares
3 interrupt cells:

	aic: interrupt-controller@502400000 {
		compatible =3D "apple,t6041-aic3", "apple,t8122-aic3";
		...
		#interrupt-cells =3D <3>;

When arm_pmu_device_probe() -> pmu_parse_irqs() ->
platform_get_irq_affinity() -> of_irq_parse_one() parses these 4-cell
specifiers against the 3-cell parent, only the first 3 cells are read into
fwspec->param[0..2] with fwspec->param_count =3D 3.

In drivers/irqchip/irq-apple-aic.c, both aic_irq_get_fwspec_info() and
aic_irq_domain_translate() then read param[1] (which is 0, matching
AIC_TMR_HV_PHYS) as the FIQ index and param[2] (AIC_CPU_PMU_E or
AIC_CPU_PMU_P) as the trigger type:

	if (fwspec->param_count =3D=3D 3)
		intid =3D fwspec->param[1];
	else
		intid =3D fwspec->param[2];

and:

	args =3D &fwspec->param[1];

	if (fwspec->param_count =3D=3D 4) {
		die =3D args[0];
		args++;
	}

As a result, the PMU affinity masks at AIC_CPU_PMU_E and AIC_CPU_PMU_P are
missed, and interrupt translation or registration fails for both PMU nodes
(returning -ENOENT in EL1, or colliding with the hyp-phys timer FIQ / faili=
ng
aic_fiq_set_type() with -EINVAL in EL2). When platform_get_irq_affinity()
fails in pmu_parse_irqs(), it triggers WARN_ON(irq <=3D 0) and leaves
pmu->supported_cpus empty, causing armpmu_register() to pass nr_cpu_ids to
topology_core_has_smt() and read past the end of cpu_topology[].

Should these be:

	interrupts =3D <AIC_FIQ AIC_CPU_PMU_E IRQ_TYPE_LEVEL_HIGH>;

and:

	interrupts =3D <AIC_FIQ AIC_CPU_PMU_P IRQ_TYPE_LEVEL_HIGH>;

matching the timer node in t6041.dtsi and the PMU nodes in t8132.dtsi and
t8140.dtsi?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-m3-plus-pm=
u-events-v1-0-a8eb6c1139fe@gmail.com?part=3D11
