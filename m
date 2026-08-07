Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121043DAACF;
	Fri,  7 Aug 2026 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092116; cv=none; b=EcAqzUfF8oYVC7FklQx1YtK07ocA80kNsilV7Jl0VXcRyVq4mezaKfHU2SAmeBz1K3Qq+36S2hn3VWTHGzpZzbWp7J6GOglcsZm5yI0NqzpTdPBnfx1uj+S4BKQfwbvETrcWInfO/A2Xr1kcYbflw5yeZGaTOqkqgKr/nfm6iaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092116; c=relaxed/simple;
	bh=yPuG8hb5Xf0buZ8efVD2j3dcMx++hGuVCdBXPkG9B70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QO1c7PEfiqh141W76Vc3JDNNwovwr7Css+POG9T7/oh6l5hH9kOYzty+pWMPYmASeu/AyO5Ilg5G00NFkSsbeNQ4MUUhkgtdoCpoRMDS4ApVgpSUnnIfbLgwctlWNN1mZs6Sx1kC0ZkfOoTF/3TjPXvuUI1dFISbK2xNBb1KY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btAu8Nbg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btAu8Nbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F171F000E9;
	Fri,  7 Aug 2026 08:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786092114;
	bh=04FBecOjZYsrwkEvpI7rkPOAh2q9kTHhuekUpy/SjXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=btAu8NbgP4SdsiVMIxe6gKeXvQMVcIqjr7DxfPi/Xpm+XILOYCclAUwJQHXfB3ngl
	 IvFFRTToCskKfnMSf/zXeU4V3oh2RIxsS9eW9VXuqBHhhp/OZLQ96BcUbCyJmELwBv
	 LtsFw+XvRCs/hyqxshZUnRWaXto4mnJ6Dy6bHpSS1moDM7FeaR46eQPNvroXd2o/kB
	 C90V9m6hM34EVMIadNIZ5D8aKysD0+GAXLorroPJdZMBtBpfd/KYDVjP+D5kEg69xa
	 SNPwRFNIqx8XSf4mcDGYAOHmb4fLRbe1NLkN9xU+5ELVe0Q0oNAhqqtYZ0CRc+o5An
	 8IkLT2+BX5JEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 18/20] RISC-V: perf: Add Qemu virt machine events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: robh@kernel.org, linux-perf-users@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260807-counter_delegation-v9-18-58658104e487@meta.com>
References: <20260807-counter_delegation-v9-0-58658104e487@meta.com>
 <20260807-counter_delegation-v9-18-58658104e487@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:41:53 +0000
Message-Id: <20260807084153.E6F171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `counterid_mask` for `cycles` and `instructions` events in t=
he QEMU PMU vendor events table incorrectly excludes fixed counters, unnece=
ssarily consuming limited programmable counters.
--

--- Patch [18]: [PATCH v9 18/20] RISC-V: perf: Add Qemu virt machine events=
 ---
commit c3b03b30f6d05637f0ec5ea8c549bff42e2bbc49
Author: Atish Patra <atishp@rivosinc.com>

RISC-V: perf: Add Qemu virt machine events

Qemu virt machine supports a very minimal set of legacy perf events.
Add them to the vendor table so that users can use them when
counter delegation is enabled.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 5eb49db8bc7c1..9220c75651a5c 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c

[ ... ]

> @@ -468,7 +469,45 @@ struct riscv_vendor_pmu_events {
>  	  .hw_event_map =3D _hw_event_map, .cache_event_map =3D _cache_event_ma=
p, \
>  	  .attrs_events =3D _attrs },
> =20
> +/* QEMU virt PMU events */
> +static const struct riscv_pmu_event qemu_virt_hw_event_map[PERF_COUNT_HW=
_MAX] =3D {
> +	PERF_MAP_ALL_UNSUPPORTED,
> +	[PERF_COUNT_HW_CPU_CYCLES]		=3D {0x01, 0xFFFFFFF8},
> +	[PERF_COUNT_HW_INSTRUCTIONS]		=3D {0x02, 0xFFFFFFF8}
> +};

[Severity: Medium]
Does the counterid_mask of 0xFFFFFFF8 inadvertently exclude the fixed hardw=
are
counters for these events?

By clearing bits 0, 1, and 2, this mask prevents the driver from using the
dedicated fixed counters (counter 0 for cycles, counter 2 for instructions).

When checking if a fixed counter is permitted, get_deleg_fixed_hw_idx()=20
verifies event->attr.config2 against RISCV_PMU_CYCLE_FIXED_CTR_MASK (0x01)
or RISCV_PMU_INSTRUCTION_FIXED_CTR_MASK (0x04). Because 0xFFFFFFF8 & 0x01 =
=3D=3D 0
and 0xFFFFFFF8 & 0x04 =3D=3D 0, the driver will bypass the fixed counters a=
nd=20
unnecessarily consume scarce programmable HPM counters instead.

Would it be better to include the respective fixed counter bits in the mask
(e.g., 0xFFFFFFF9 for cycles and 0xFFFFFFFD for instructions), or perhaps
use 0xFFFFFFFF?

> +
> +static const struct riscv_pmu_event qemu_virt_cache_event_map[PERF_COUNT=
_HW_CACHE_MAX]
> +						[PERF_COUNT_HW_CACHE_OP_MAX]
> +						[PERF_COUNT_HW_CACHE_RESULT_MAX] =3D {

[ ... ]

> +	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)]	=3D {0x10021, 0xFFFFFFF8},
> +};
> +
> +RVPMU_EVENT_CMASK_ATTR(cycles, cycles, 0x01, 0xFFFFFFF8);
> +RVPMU_EVENT_CMASK_ATTR(instructions, instructions, 0x02, 0xFFFFFFF8);

[Severity: Medium]
Since this macro exposes the counterid_mask to userspace via sysfs aliases,=
=20
does providing 0xFFFFFFF8 here cause the perf tool to populate config2 with=
=20
0xFFFFFFF8?

If so, this will enforce the same fixed-counter bypass on the counter=20
delegation path. Updating these masks to include the fixed counter bits
would ensure they can be fully utilized.

> +RVPMU_EVENT_CMASK_ATTR(dTLB-load-misses, dTLB_load_miss, 0x10019, 0xFFFF=
FFF8);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-counter_de=
legation-v9-0-58658104e487@meta.com?part=3D18
