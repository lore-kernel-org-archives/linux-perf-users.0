Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B491358375;
	Fri,  7 Aug 2026 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092226; cv=none; b=ts9xKwboSFuzPVx76ytSJSZZIOc95/jBYeburDS/TapuZtn1gE/W/oBhjiXBnoEjfwyglGix89mGtJrHhbhATBSNzlwKaI71Y+bMrwSDiu1rMvLaB9MoS8n7qFok6V68J+FCdGohRgw6Vr1QrZMqQnxRjOY8/frjbJQ7lZMuev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092226; c=relaxed/simple;
	bh=kFxQkI9bZxLouE0rKXsIOzrk/K4/smlbbnuGCaG8oxE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n0Px0IB8Y5i1/lPP+bNJyicSv331jOIUHEJojiqJ12JMCtvQU8ZqMNQM2hf285u6z7Ooh9/g8a6ykQxazF+61lIqgSWYsR2h5U1NDzgVgYfFD3tDtxu3edEgfUDcXbVhpwF5w1C+0GlSC3Ckv/v/kbDwSNVrkbYmO7DeIbC5ap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITzzrHoV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITzzrHoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DABF1F000E9;
	Fri,  7 Aug 2026 08:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786092222;
	bh=aA1Y4phFzgytFdsuCQvZJANmIyaprXjtxdVBWa8Z02c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ITzzrHoVy3PXZdTjUkGVCgZiTfIsl8cKhdkLs/cupRhckBsnWMPYpcwiU2KN2PaWR
	 aYIXAAt+ZFR2lB1M9FRsM1G88L/ZTKhqhJ4ND/ms2amcY/4Kn3rK+7Wjl4wPWziRPc
	 AvK9xQCoOjOPKWq0HW23+oIRiRG1aYGTwTHQrtxtokIBMUrhlWHCPkqp2425QYNblY
	 50JZNI9zV/UMeezqavNwxQSbto58NHWbNCd+RBR5dgJvIoXGMVgV3Jz08urVfkorRW
	 1pc/jUh5Zhe7hw7JeW4znJBBBs9G3Jti58sd3NCuiVIlmF8pOlaYwSmCYOon/lc0ln
	 qUW/PgHMR1qmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 16/20] RISC-V: perf: Use config2/vendor table for
 event to counter mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: conor+dt@kernel.org, linux-perf-users@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260807-counter_delegation-v9-16-58658104e487@meta.com>
References: <20260807-counter_delegation-v9-0-58658104e487@meta.com>
 <20260807-counter_delegation-v9-16-58658104e487@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:43:41 +0000
Message-Id: <20260807084342.4DABF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Standard host legacy hardware events (e.g., 'perf stat -e cycles')=
 fail to open and cannot map to fixed counters via the vendor driver table.
- [High] Raw events with broad counter masks are unconditionally forced to =
count cycles or instructions on fixed counters, returning incorrect metrics.
--

--- Patch [16]: [PATCH v9 16/20] RISC-V: perf: Use config2/vendor table for=
 event to counter mapping ---
commit 450780026222524d85a7b60f40dbdc3d52fed837
Author: Atish Patra <atishp@rivosinc.com>
Subject: RISC-V: perf: Use config2/vendor table for event to counter mapping

This patch allows platform vendors to specify custom mapping between
events and hpmcounters using the config2 parameter in perf attributes.
Legacy events are mapped via the vendor event table in the driver, while
the fixed cycle and instruction counters map to legacy events.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index f0b8b6eff2ea7..ee0c077859273 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
[ ... ]
> @@ -1522,24 +1524,85 @@ static int rvpmu_deleg_find_ctrs(void)
>  static int get_deleg_fixed_hw_idx(struct cpu_hw_events *cpuc, struct per=
f_event *event)
>  {
> -	return -EINVAL;
> +	bool guest_events =3D event->attr.config1 & RISCV_PMU_CONFIG1_GUEST_EVE=
NTS;
> +	int idx;
> +
> +	/* event_base is 0 on the delegation path; match via the original perf =
attrs. */
> +	if (guest_events) {
> +		if (event->attr.type !=3D PERF_TYPE_HARDWARE)
> +			return -EINVAL;
> +		if (event->attr.config =3D=3D PERF_COUNT_HW_CPU_CYCLES)
> +			idx =3D 0; /* CY counter */
> +		else if (event->attr.config =3D=3D PERF_COUNT_HW_INSTRUCTIONS)
> +			idx =3D 2; /* IR counter */
> +		else
> +			return -EINVAL;
> +	} else if (event->attr.config2 & RISCV_PMU_CYCLE_FIXED_CTR_MASK) {
> +		idx =3D 0; /* CY counter */

[Severity: High]
Does this unconditionally force raw events with broad counter masks to count
cycles instead of the requested metric?

If a raw event is provided with a broad counterid_mask (e.g., 0xFFFFFFFF)
that allows any counter, config2 will have bit 0 set. This causes
get_deleg_fixed_hw_idx() to immediately assign it to fixed counter 0.

Since fixed counter 0 is architecturally hardwired to count cycles, the
actual raw event ID is ignored and the PMU returns cycle counts, leading to
incorrect metrics.

> +	} else if (event->attr.config2 & RISCV_PMU_INSTRUCTION_FIXED_CTR_MASK) {
> +		idx =3D 2; /* IR counter */
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	/* Take the fixed counter only if delegated and free, else fall back. */
> +	if (!(cmask & BIT(idx)) || test_bit(idx, cpuc->used_hw_ctrs))
> +		return -EINVAL;
> +
> +	return idx;
>  }
> =20
>  static int get_deleg_next_hpm_hw_idx(struct cpu_hw_events *cpuc, struct =
perf_event *event)
>  {
> -	unsigned long hw_ctr_mask =3D 0;
> +	u32 hw_ctr_mask =3D 0, temp_mask =3D 0;
> +	u32 type =3D event->attr.type;
> +	u64 config =3D event->attr.config;
> +	int ret;
> =20
> -	/*
> -	 * TODO: Treat every hpmcounter can monitor every event for now.
> -	 * The event to counter mapping should come from the json file.
> -	 * The mapping should also tell if sampling is supported or not.
> -	 */
> +	/* Select only available hpmcounters */
> +	hw_ctr_mask =3D cmask & (~0x7) & ~(cpuc->used_hw_ctrs[0]);

[Severity: High]
Will standard host legacy hardware events fail to map to fixed counters if
the vendor map mandates them?

When a user runs a command like "perf stat -e cycles", config2 is 0.
As a result, get_deleg_fixed_hw_idx() ignores current_pmu_hw_event_map and
returns -EINVAL without finding a fixed counter mapping.

This fallback function then explicitly strips out fixed counter bits (~0x7),
which prevents assigning fixed counters even if the vendor table specifical=
ly
requests them. If the vendor map requires counter 0 via counterid_mask, the
resulting hw_ctr_mask becomes 0, and the allocation fails entirely with
-ENOENT.

> +
> +	switch (type) {
> +	case PERF_TYPE_HARDWARE:
> +		temp_mask =3D current_pmu_hw_event_map[config].counterid_mask;
> +		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-counter_de=
legation-v9-0-58658104e487@meta.com?part=3D16
