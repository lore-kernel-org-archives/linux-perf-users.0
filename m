Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049062;
	b=YPrR19oFmKTrdkiTa9OmZDYUxdcuKzVsAXDo7x1Up7kSR6aPT6RUgzncb1pZVeKM69xk
	 tC458sRSWJgUhqrhwArcuAnaften9/JFwvp6p9/38Sm9ddDkFrPB4wczR8AA9zDfL9lgl
	 IiQejYDCBjsrxV2n92zSCHPbr0mVX6mI0404O4WOQLfwAGS4v+2M/t63NiFhdQAECAzK/
	 cKv4vDGwBXMSjDqK0r7+c9tLuzXUlEVPm/Zrby8c15amSXUk3BKdC3dKX4IrKos8W6rHT
	 tHaRoQOAfGK9s0e7ilH/8Mev1bBjOIOzLXXDDBHUemRsTW3xnE98HdYs+USbI5Njvow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049062;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d+NgMx40JnIwsr5HMCsxgsiIdBJO3W4zu6/UauQ0yMI=;
	b=NUbw54q0632/lAXhfsPQV1uaEBJr67kVW1Re3fIcVExRhqOA6k3kMq5/t3EZYiYvIVSC
	 bw8L5Ki3EQHFJWD9QoJhORP8HuVUbpTpXyWAHc3nkAa9Bsj25R2RLl7xkTgdGMzRet+uS
	 n1y85H3GaLWMM1ZEHIcslQVrXGr33lRWf66g/R0vomb1CZy/SpHkgnJEFFJ6bNzn6fS4C
	 ZH3GHJt0XkH+3BrQeIVLUWHK8cMrLQ1T4OVrIMJinisywiZJJsrrM+subWmIa/moK4t5m
	 LoASSaACE74rKy6UOWCROjYGtAojNvgIJnCY92zKlgGNm8t4sTmqz5ANP/dA2hbI1vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DM2nQ/dw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0740606A326;
	Sat,  7 Nov 2026 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DM2nQ/dw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A581F0089F;
	Sat,  7 Nov 2026 10:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049061;
	bh=d+NgMx40JnIwsr5HMCsxgsiIdBJO3W4zu6/UauQ0yMI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DM2nQ/dwwINFCe+vYEqYf8wFLA006p+GDVENWAX/ZLD8peTX0DE5HMFnT5qp1n0q7
	 vG/a78zK2LqMriP3SiOgdmFvHBi8qDuabCQoZenvk1VBUb2HRBSBeUX6/jy8KfAWOe
	 6VxbdzxZm2grh73+S6SYsdwYIedhKmEHouOlccazq16+NE/5k/jvk0qqCtSzd+A03F
	 tXzEegIo0OmhtYEvn60sMgPinzZvtt3gvJ3d3lQ8jjoNmolQANtIrmlABt7rTmN0BB
	 a2dYfgD/bVKvw/QfcKmMNcA/x3L/eoWpg/tFskVwX+OdDinW79/Mb9JDeuSbqkuiAq
	 yGx3n8xIYJvSw==
Message-ID: <sashiko-outbox-202838@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/15] arm64: dts: apple: t8140: Add core interrupt
 affinities
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261107-m3-plus-pmu-events-v2-10-acf1e78da039@gmail.com>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
 <20261107-m3-plus-pmu-events-v2-10-acf1e78da039@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 10:57:40 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] arm64: dts: apple: t8140: apple,fiq-index ordered before cpus in
  affinities
--

commit f8b309addc78ccc75edc4dfad6c0a8f6e8b87b71
Author: Myria Sarvay <myrialsarvay@gmail.com>

arm64: dts: apple: t8140: Add core interrupt affinities

This commit adds the CPU PMU interrupt affinity nodes under the AIC
interrupt controller for the Apple T8140 (A18 Pro) SoC.

> diff --git a/arch/arm64/boot/dts/apple/t8140.dtsi b/arch/arm64/boot/dts/a=
pple/t8140.dtsi
> index 3b4f7695552b5..89a26a1b23649 100644
> --- a/arch/arm64/boot/dts/apple/t8140.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8140.dtsi
> @@ -167,6 +167,19 @@ aic: interrupt-controller@301000000 {
>  			#interrupt-cells =3D <3>;
>  			interrupt-controller;
>  			power-domains =3D <&ps_aic>;
> +
> +			affinities {
> +				e-core-pmu-affinity {
> +					apple,fiq-index =3D <AIC_CPU_PMU_E>;
> +					cpus =3D <&cpu_e0 &cpu_e1
> +						&cpu_e2 &cpu_e3>;
> +				};
> +
> +				p-core-pmu-affinity {
> +					apple,fiq-index =3D <AIC_CPU_PMU_P>;
> +					cpus =3D <&cpu_p0 &cpu_p1>;
> +				};
> +			};
>  		};

[Severity: Low]
Should cpus be ordered before apple,fiq-index in e-core-pmu-affinity and
p-core-pmu-affinity?  Per the Devicetree coding style, common properties
without a vendor prefix come before vendor-specific properties, and
placing apple,fiq-index first triggers warnings from
scripts/dtc/dt-check-style --mode=3Dstrict (unlike 84a1163b0a3e ("arm64:
dts: apple: t8132: Fix ordering-related dt-check-style issues") and
commit "arm64: dts: apple: t603*: Add core interrupt affinities" earlier
in this series).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-m3-plus-pm=
u-events-v2-0-acf1e78da039@gmail.com?part=3D10
