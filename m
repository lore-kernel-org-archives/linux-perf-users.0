Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705007;
	b=SVfjZSKNwDaurUHnb7JrNUjeSAupmPXRu1Hvo0Daj1NXJI4Isnad5DToM1jO7BNRkEvR
	 qnb03GtQaNIpBMTj36Q3AHaw249ypEccgQftzwTN4pJCJy6Qvyq6Li9xIwy/Oy6S+HiTj
	 W1FJ0kSu5xRu2HOOzwMg65oU/4cFiL6iFXEoVBy0n8jt5IOGM9uNW83WhK7tZkg6eLyHh
	 ETpH9Bj/4T/RHNMsNSfj83PpcnaQnHL9c7+R4PVChW8r28y13VDEY1xXKt/fYiWBof6Lx
	 iFmNAT5JvgK+ePFVH9msC/WJRFlmvssrKubL4Xu1+RTv2Os+fE1eEpwfpoM+pDrS9FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705007;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xKwDj5M5W7QzpCWTO/r/aZMtQDvaYfo41JPGr6JG6EI=;
	b=0I/GG+NsIaXh+BFjmICQ46SMMYziFNarVVqHq5aA1AgQlIc1lj9DN1mypRurex4trPo4
	 6YVBtVBT76KbLUptN746cjt7fagcdxgvTj9ydEYXL8SP2PqBpSgWx5XUmMNAj0mtQr5P5
	 md3NcziOosVOla3Mi30PZYlGMvrkS1FOkDai5zEJGQUOmSrybY9gZkrao5/WDFw1ulA/l
	 LL+5i4o/LteTAkanJZpvp9TMuA9HZB01NI9294YNpR9NLsIsxdYUTMjwgukpvr8cDdzn1
	 OEGcqJog5HiFHrq1qr13TTIuct1ZY4oojtLG5+zo0fYThzXCschQ+qLUBi/wHVrc7PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y96p++EP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A79A606C59A;
	Tue,  3 Nov 2026 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y96p++EP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C307E1F000C1;
	Tue,  3 Nov 2026 11:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793705007;
	bh=xKwDj5M5W7QzpCWTO/r/aZMtQDvaYfo41JPGr6JG6EI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y96p++EP3dBo3Zov0PNAWU4n+p5KNxosUAfJ8ShITHOB2OBuKZKNnOV2V/uYFmkcJ
	 oUo4cfWrG8pbJauigDKv0L6V2fburdjqu2P51yGUoUkPUzW+EwZ/f5kXGUYyGbXCp6
	 7fF83RkMi/sjkXtWckvEa/dmyIYqPwdOQKuNbtvqkiy8bWXjgY+rHKNcoMZ7BttWG5
	 CWwY++wV7wIuWlLdpyTrQaM8EPlGHMHNQONzMqbDjwA5RqpE8tKMF78ohxxU5oaSRQ
	 s626lgVpcd1hrvgknP89wzxyLnctyqsw8/16+SN25ON/SVM/n3BcRSp59YAcklBPfg
	 /4zrtXzG8gHbw==
Message-ID: <sashiko-outbox-195140@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/13] arm64: dts: apple: t8140: Add PMU Device Nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261103-m3-plus-pmu-events-v1-13-a8eb6c1139fe@gmail.com>
References: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
 <20261103-m3-plus-pmu-events-v1-13-a8eb6c1139fe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:23:26 +0000
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
- [High] arm64: dts: apple: t8140: missing aic affinities node for pmu-e an=
d pmu-p
--

commit 4dff2446440e6919eaaded721e0e1ce1b3461270
Author: Myria Sarvay <myrialsarvay@gmail.com>

arm64: dts: apple: t8140: Add PMU Device Nodes

This commit adds the pmu-e and pmu-p device nodes for the efficiency and
performance core PMUs to the Apple t8140 device tree.

> diff --git a/arch/arm64/boot/dts/apple/t8140.dtsi b/arch/arm64/boot/dts/a=
pple/t8140.dtsi
> index 150d91bdf6fcc..6e6fd5754406b 100644
> --- a/arch/arm64/boot/dts/apple/t8140.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8140.dtsi
> @@ -136,6 +136,18 @@ l2_cache_1: l2-cache-1 {
>  		};
>  	};
> =20
> +	pmu-e {
> +		compatible =3D "apple,tahiti-e-pmu";
> +		interrupt-parent =3D <&aic>;
> +		interrupts =3D <AIC_FIQ AIC_CPU_PMU_E IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	pmu-p {
> +		compatible =3D "apple,tahiti-p-pmu";
> +		interrupt-parent =3D <&aic>;
> +		interrupts =3D <AIC_FIQ AIC_CPU_PMU_P IRQ_TYPE_LEVEL_HIGH>;
> +	};

[Severity: High]
Does adding pmu-e and pmu-p also require an affinities child node under the
aic interrupt controller in arch/arm64/boot/dts/apple/t8140.dtsi (matching
t8122.dtsi and t8132.dtsi)?

Currently, the aic node in t8140.dtsi does not define an affinities subnode:

	aic: interrupt-controller@301000000 {
		compatible =3D "apple,t8140-aic3", "apple,t8122-aic3";
		reg =3D <0x3 0x01000000 0x0 0x1cc000>,
		      <0x3 0x01040000 0x0 0x4000>;
		reg-names =3D "core", "event";
		#interrupt-cells =3D <3>;
		interrupt-controller;
		power-domains =3D <&ps_aic>;
	};

Without the affinities node, aic_of_ic_init() in
drivers/irqchip/irq-apple-aic.c leaves aic_irqc->fiq_aff[AIC_CPU_PMU_E] and
aic_irqc->fiq_aff[AIC_CPU_PMU_P] as NULL. When arm_pmu_device_probe() ->
pmu_parse_irqs() -> platform_get_irq_affinity() queries the interrupt
affinity, aic_irq_get_fwspec_info() falls back to cpu_possible_mask for both
PMUs:

	if (aic_irqc->fiq_aff[intid])
		mask =3D &aic_irqc->fiq_aff[intid]->aff;
	else
		mask =3D cpu_possible_mask;

This causes pmu_parse_percpu_irq() to populate pmu->supported_cpus with all
CPUs (both E-cores and P-cores) on both PMU instances, breaking heterogeneo=
us
CPU filtering in armpmu_filter() and armpmu_event_init().

In addition, because aic_irq_domain_translate() merges AIC_CPU_PMU_E onto
AIC_CPU_PMU_P so both PMUs share the same Linux virq, the second PMU to pro=
be
sees armpmu_count_irq_users(affinity, irq) !=3D 0 in armpmu_request_irq()
(drivers/perf/arm_pmu.c) and skips registering its per-CPU interrupt handle=
r:

	} else if (armpmu_count_irq_users(affinity, irq) =3D=3D 0) {
		err =3D request_percpu_nmi(irq, handler, "arm-pmu", affinity, pcpu_armpmu=
);

		/* If cannot get an NMI, get a normal interrupt */
		if (err) {
			err =3D request_percpu_irq_affinity(irq, handler, "arm-pmu",
							  affinity, pcpu_armpmu);
			irq_ops =3D &percpu_pmuirq_ops;
		} else {
			has_nmi =3D true;
			irq_ops =3D &percpu_pmunmi_ops;
		}
	} else {
		/* Per cpudevid irq was already requested by another CPU */
		irq_ops =3D armpmu_find_irq_ops(affinity, irq);

When a P-core PMU counter overflow FIQ fires, handle_percpu_devid_irq()
dispatches it to pmu-e's handler instead of pmu-p's, leaving the P-core
counter unhandled and triggering an FIQ storm.

Should the aic node in t8140.dtsi include an affinities subnode mapping
AIC_CPU_PMU_E to <&cpu_e0>, <&cpu_e1>, <&cpu_e2>, <&cpu_e3> and AIC_CPU_PMU=
_P
to <&cpu_p0>, <&cpu_p1>?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-m3-plus-pm=
u-events-v1-0-a8eb6c1139fe@gmail.com?part=3D13
