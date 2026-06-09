Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9222C17A30A;
	Tue,  9 Jun 2026 06:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986143; cv=none; b=gnWlWUUylIIyCAlT9wGd/KFFr2TEvs4axvBM9gE1feZNQ7KiEAdGtd4Udvo6prGmep575rX8Zj3trBbbGoypISiI4vl6wYE8GBRsuiBs8BeAJclbUSJKiW0N4/gh6YGpb8mtjyNJBoRoYDKu37TtcJ3r6Tohh3NR0VaokY22yLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986143; c=relaxed/simple;
	bh=tytI5l/0zQrdvgZJoG5J/gKZud0TNFlxZMVylN1OMPo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OFb8AngaTOleCE5ja8hij+kUv0jvIbA0quD+DSAGIc9kAgpEwnrG9iGR16A8HwqHyOqYQCKHSZ11ow/+56oti5Kk6yXvyxxegRCY3Z8CMGg1Wr7Ik2aGcBRu/0dF1Vicu7/ylpHPdmuvXtppZ25G613YEyO57+kOIwtZTMt/VTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6HXht5T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6HXht5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90C81F00893;
	Tue,  9 Jun 2026 06:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780986142;
	bh=WDa98brwrNPSjvoXajWInmf3xbWFYF28BBA1BE+tiAs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n6HXht5Ts+Yl0gYuXhvXDOLnnPCVzp28l3pTBBQDUlrrRx3Bd3IqGw4y1uzgREVix
	 vvQsrGrA/oytiAdsRgP603u5P0FPo8A0bW3OfwYY4WA2Q9tbt0WcaP9DOodwi5G084
	 JDN+oFkICVd4prTXB8zxgLqxspNuzauII9MKHeCT6GWwfhwdWjLkcm0m5FOKLqQif+
	 nCssS/elsDneKDuwUEVnvw4HzhpiCwYvQnSqrWImAxeIUs5G6ybCMPRbgUz4sYJyEP
	 5D+5OCt1wlJPQhiacwozerIH79BbSEMSYkhq0pBnkxcjrvzoZMORvF+Ynff1nSdhQC
	 aBv43zf5KZi0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 17/21] RISC-V: perf: Add Qemu virt machine events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: linux-perf-users@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260608-counter_delegation-v6-17-285b72ed65a9@meta.com>
References: <20260608-counter_delegation-v6-17-285b72ed65a9@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:22:21 +0000
Message-Id: <20260609062221.D90C81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch incorrectly overloads the generic 'unimplemented' or '=
non-commercial' CPU IDs (`mvendorid=3D0`, `marchid=3D0`, `mimpid=3D0`) to u=
niquely identify the QEMU virt machine, applying QEMU-specific PMU events g=
lobally to any minimal or academic RISC-V core.
--

commit 61b476b524390d76a4db3dcbab4b57114ff0ebc8
Author: Atish Patra <atishp@rivosinc.com>

RISC-V: perf: Add Qemu virt machine events

This patch adds a minimal set of legacy perf events for the QEMU virt
machine to the vendor table, allowing users to use them when counter
delegation is enabled.

> diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/=
asm/vendorid_list.h
> index 7f5030ee1fcf8..603aa2b21c0ba 100644
> --- a/arch/riscv/include/asm/vendorid_list.h
> +++ b/arch/riscv/include/asm/vendorid_list.h
> @@ -11,4 +11,8 @@
>  #define SIFIVE_VENDOR_ID	0x489
>  #define THEAD_VENDOR_ID		0x5b7
> =20
> +#define QEMU_VIRT_VENDOR_ID		0x000
> +#define QEMU_VIRT_IMPL_ID		0x000
> +#define QEMU_VIRT_ARCH_ID		0x000
> +

[Severity: Medium]
Do these definitions overload the generic "unimplemented" or "non-commercia=
l"
CPU IDs to uniquely identify the QEMU virt machine?

According to the RISC-V Privileged Architecture specification, a value of 0
in the mvendorid, marchid, and mimpid CSRs indicates that the ID is either
unimplemented or represents a non-commercial implementation.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 00b84b28117a8..74acac54328e0 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c

[ ... ]

> @@ -453,7 +454,42 @@ struct riscv_vendor_pmu_events {
>  	  .hw_event_map =3D _hw_event_map, .cache_event_map =3D _cache_event_ma=
p, \
>  	  .attrs_events =3D _attrs },
> =20

[ ... ]

>  static struct riscv_vendor_pmu_events pmu_vendor_events_table[] =3D {
> +	RISCV_VENDOR_PMU_EVENTS(QEMU_VIRT_VENDOR_ID, QEMU_VIRT_ARCH_ID, QEMU_VI=
RT_IMPL_ID,
> +				qemu_virt_hw_event_map, qemu_virt_cache_event_map,
> +				qemu_virt_event_group)
>  };

[Severity: Medium]
By binding the 0x000 ID tuple to QEMU's specific PMU event maps here, will
the kernel mistakenly assume any generic core returning 0 is a QEMU virt
machine?

If that non-QEMU core implements PMU counter delegation (Ssccfg/Smcdeleg) b=
ut
uses standard or different raw event encodings, this could unconditionally
program QEMU's arbitrary raw event values into the core's PMU configuration
registers, silently corrupting performance monitoring statistics.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-counter_de=
legation-v6-0-285b72ed65a9@meta.com?part=3D17
