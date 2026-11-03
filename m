Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703297;
	b=G55fCNyYBWE4NSpxBWCIj5Sn0cJXUyuHj6+THF4o0YmDi8R3Y6Ejx3cQ8brBu1CXoqpI
	 3zniRZCoLw0yuXHF1PzjU/Y/sriBL50HJhOE3IaPCqlf4ZIJegZTNYdkHueAa8v1yOWRV
	 Q/wmCPWs9yvOMXkwk7HG2xgjumKd+ImqUo8c+4Bc7PNY4+XqnwGI4ZMTa5crLnwnaacwT
	 dMFbqBat7lEM6epykl6XhPY6fpzUP5YH3HdjzzrrqtMy3qMuVk8JJ70jY9xI/rexvHCox
	 FifTclxbRWDdq/J2/BLhllgPEo2cp/pFAaAfqei6NDguO7uYhCBmdSGSkTf2kRC2MXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703297;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6hMyoFma0f21MEbZrR8QhDlPHUhRUe7/HSlXqi0WQ5g=;
	b=2TaNX8Gg3UqIt55wl98B00D+OzJf4kIpojFUox3CqieW+EAscDXHb1EO8I3ED9lvTA6U
	 n49LU0tFkw7HmiLJ5LI2Ak2ZnpaWiATY4qC4Ma5jbStH0rI2XKXHEbr0rjrAcf0mHFynW
	 XnTkqQ/R7DWOl3K2WhNKvVgbEwUT/qjiR5FcpOxYh1RbqkLOQiJituQcBOVmZJMpPWzoC
	 FnleH9/ykGZT/6JptyVww+RB1ZVNkFaLYi7Jq9h1Boq5S8OmvJyAd6Hq63MuW/3o1qjd2
	 A7Jnss7UY1emPT3R2rg1IN937pwIf1IxdWQ3oe0L+ikEvJHbp2RABK7DiD+ni85DwGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h+VAUXFJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F22606D82C;
	Tue,  3 Nov 2026 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h+VAUXFJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD41E1F0093A;
	Tue,  3 Nov 2026 10:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793703297;
	bh=6hMyoFma0f21MEbZrR8QhDlPHUhRUe7/HSlXqi0WQ5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h+VAUXFJfhRCW7AeUr3kHXsHJ5fdll/aFxUhFeqFZIMCT3K0FfI1U4Ud29rKXwOtk
	 atH9W1i0kjFruhVXQydScgUJ6rnlJCuPUS1YcaVzvu6AXpV2KPPU2IzKFXqprd6PY0
	 u+bpKaGw9RKq901aG8wJ4CkIAYx9OK+9umGHOCHXz6v5FoPMMtEPks0DzXYQXXw7j6
	 ETML5DBAe+vMENODtYv3g5Hk1EeiMi895HZ2LZysJ2x68mi0wr8muOnmnt/2oxTTN7
	 xpbPSKKXRGGr12Em4qGy1/4JiChoqAdSJW3FJTauH7fgYNet7AW24/g98j0nmEnUEj
	 SygQt33EIkmiw==
Message-ID: <sashiko-outbox-195083@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/13] arm64: dts: apple: t603x: Add PMU Device Nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261103-m3-plus-pmu-events-v1-9-a8eb6c1139fe@gmail.com>
References: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
 <20261103-m3-plus-pmu-events-v1-9-a8eb6c1139fe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:54:56 +0000
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
- [High] arm64: dts: apple: missing AIC PMU affinities in t6030 and t6031-b=
ase
--

commit b22393aa51d5b877175fc97e743f45d90d0a09a1
Author: Myria Sarvay <myrialsarvay@gmail.com>

arm64: dts: apple: t603x: Add PMU Device Nodes

This commit adds the pmu-e (apple,sawtooth-pmu) and pmu-p (apple,everest-pm=
u)
device tree nodes to t6030.dtsi and t6031-base.dtsi.

> diff --git a/arch/arm64/boot/dts/apple/t6030.dtsi b/arch/arm64/boot/dts/a=
pple/t6030.dtsi
> index 85a16d03e22f3..c3779e1584c2a 100644
> --- a/arch/arm64/boot/dts/apple/t6030.dtsi
> +++ b/arch/arm64/boot/dts/apple/t6030.dtsi
> @@ -239,6 +239,18 @@ l2_cache_1: l2-cache-1 {
>  		};
>  	};
> =20
> +	pmu-e {
> +		compatible =3D "apple,sawtooth-pmu";
> +		interrupt-parent =3D <&aic>;
> +		interrupts =3D <AIC_FIQ AIC_CPU_PMU_E IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	pmu-p {
> +		compatible =3D "apple,everest-pmu";
> +		interrupt-parent =3D <&aic>;
> +		interrupts =3D <AIC_FIQ AIC_CPU_PMU_P IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
>  	reserved-memory {
>  		ranges;
>  		#address-cells =3D <2>;
> diff --git a/arch/arm64/boot/dts/apple/t6031-base.dtsi b/arch/arm64/boot/=
dts/apple/t6031-base.dtsi
> index f62ce0690182b..3b97c12409340 100644
> --- a/arch/arm64/boot/dts/apple/t6031-base.dtsi
> +++ b/arch/arm64/boot/dts/apple/t6031-base.dtsi
> @@ -308,6 +308,18 @@ l2_cache_2: l2-cache-2 {
>  		};
>  	};
> =20
> +	pmu-e {
> +		compatible =3D "apple,sawtooth-pmu";
> +		interrupt-parent =3D <&aic>;
> +		interrupts =3D <AIC_FIQ 0 AIC_CPU_PMU_E IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	pmu-p {
> +		compatible =3D "apple,everest-pmu";
> +		interrupt-parent =3D <&aic>;
> +		interrupts =3D <AIC_FIQ 0 AIC_CPU_PMU_P IRQ_TYPE_LEVEL_HIGH>;
> +	};

[Severity: High]
Do the aic nodes for t6030 and the t6031-based SoCs (t6031, t6032, and t603=
4)
 also need affinities child nodes mapping AIC_CPU_PMU_E and AIC_CPU_PMU_P to
their respective E-core and P-core CPU phandles?

In drivers/irqchip/irq-apple-aic.c, aic_irq_domain_translate() merges
AIC_CPU_PMU_E and AIC_CPU_PMU_P onto a single Linux percpu_devid IRQ
(AIC_CPU_PMU_P), and relies on the affinities subnode under aic (parsed by
aic_of_ic_init() -> build_fiq_affinity() into aic_irqc->fiq_aff[]) to report
the CPU mask for each PMU in aic_irq_get_fwspec_info():

drivers/irqchip/irq-apple-aic.c:aic_irq_get_fwspec_info() {
	...
	if (aic_irqc->fiq_aff[intid])
		mask =3D &aic_irqc->fiq_aff[intid]->aff;
	else
		mask =3D cpu_possible_mask;
	...
}

Because neither arch/arm64/boot/dts/apple/t6030.dtsi nor
arch/arm64/boot/dts/apple/t6031-die0.dtsi (or t6031.dtsi / t6032.dtsi)
defines an affinities subnode under aic, aic_irqc->fiq_aff[AIC_CPU_PMU_E] a=
nd
aic_irqc->fiq_aff[AIC_CPU_PMU_P] remain NULL, causing both PMUs to receive
cpu_possible_mask via:

m1_pmu_device_probe()
  -> arm_pmu_device_probe()
    -> pmu_parse_irqs()
      -> platform_get_irq_affinity()
        -> of_irq_get_affinity()
          -> aic_irq_get_fwspec_info()

When pmu-e probes first, pmu_parse_percpu_irq() sets pmu-e's supported_cpus
to cpu_possible_mask, and armpmu_request_irq() registers pmu-e's per-CPU IRQ
across all CPUs and sets per_cpu(cpu_irq, cpu) =3D irq on every CPU.

When pmu-p probes second with the same merged virq and affinity equal to
cpu_possible_mask, armpmu_count_irq_users(affinity, irq) returns non-zero in
armpmu_request_irq():

drivers/perf/arm_pmu.c:armpmu_request_irq() {
	...
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
	...
}

As a result, pmu-p skips calling request_percpu_irq_affinity() and never
registers its per-CPU irqaction on the shared PMU FIQ line. P-core PMU
counter overflow FIQs will be routed to pmu-e (leaving the P-core overflow
status and PMCR0_IACT uncleared when PMCR0_IMODE_FIQ is re-enabled), and
teardown in armpmu_free_irqs() will trigger a warning in __free_percpu_irq()
because pmu-p's dev_id was never registered.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-m3-plus-pm=
u-events-v1-0-a8eb6c1139fe@gmail.com?part=3D9
