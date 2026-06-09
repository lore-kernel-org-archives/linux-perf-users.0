Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A916E1990A7;
	Tue,  9 Jun 2026 06:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986221; cv=none; b=SIViz/Bs3FQhsYcTR0EOkAVNGq7w+ZdPejVubxX2LGQgr8rYJmNOto6OGOcI2R+3YrYubWCko9iQUfAmD9mUcmobZQGc71JyvNt7sbfk/qpWv98XeqY/RYH8zGTtOeQhz/9xJ+RA7cjNxaZaO2Qy17sjN5weU5GvRjd2pNA8lIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986221; c=relaxed/simple;
	bh=/z31ilgIy0k/2elY1si/zcMAqLUldPq851NYvGjUUg4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QhlhIivHrsn1EmhK/o9shFyqL6yxJwn1951ViASM9xxA2W/5sRBT7qH4JMZUUMp0d9xd1/9mP2lJ6ZDPY761MKAwGsE5U+8gIICUKmEbEpTWvIdHn818JCKxM2MPNALVbOCtJyh0mtCT8edEPLnVUR8+mRiXYvnfUg59uaxi5os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqecfnnq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqecfnnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F223A1F00893;
	Tue,  9 Jun 2026 06:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780986220;
	bh=/3z/m3l7/Uko4BznX+C3Y9X9nPlsdVhwUqPkRFZUrVo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kqecfnnqjm6CMNcD+bN3PbjSOpoQ2kEBV8QtQY3M+8+llnFK673l+sEy7iZr12Wse
	 d48LVYivyeqKjSVnxCjhs6QzcRY9nYpfTJgsmUkEolHLcfJwXa4O1ZAORc6WNKSTvX
	 zvP1sdd6xV5xOfXnwu9HG0tr+nsYqYjHUefKqnKBDHveitY4443U6OF84DvqYPfW6i
	 ob79HLomKO8195qE1FmTBgMq2m0tTFc2S3lt1WA/fkg8UVJE2vZmdHi9htNl2Bket7
	 FNmPydeleoPZIiDvi3nu/dPxvhSGrl+11Mt3DBZ8GUlzzhHh2tqZ1REMPjTfwK/eoc
	 rdOHzAn6f87Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/21] RISC-V: perf: Implement supervisor counter
 delegation support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260608-counter_delegation-v6-13-285b72ed65a9@meta.com>
References: <20260608-counter_delegation-v6-13-285b72ed65a9@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:23:39 +0000
Message-Id: <20260609062339.F223A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Bitwise shift of signed 32-bit integer causes overflow and corrupt=
s SCOUNTINHIBIT on 64-bit systems.
- [High] Non-sampling events are permanently inhibited from counting becaus=
e HPMEVENT_OF is unconditionally set but never cleared.
- [High] On 32-bit architectures, `rvpmu_deleg_ctr_enable_irq` writes modif=
ied event configuration to the wrong CSR (`CSR_SIREG4` instead of `CSR_SIRE=
G5`).
- [High] SBI PMU snapshot logic breaks supervisor counter delegation by unc=
onditionally bypassing S-mode CSR writes and reading stale shared memory.
--

commit ff1e171673cfe94a12c443765bd5b68dacf3b687
Author: Atish Patra <atishp@rivosinc.com>

RISC-V: perf: Implement supervisor counter delegation support

This patch adds support for RISC-V ISA extensions (ssccfg, sscsrind,
smcntrpmf) that allow programming hpmcounters directly from S-mode.
It falls back to the SBI PMU extension if the hardware extensions are
unavailable or for firmware counters.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 46a25979e95e9..1f16df9d0dd00 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c

[ ... ]

> -static u64 rvpmu_sbi_ctr_read(struct perf_event *event)
> +static u64 rvpmu_ctr_read(struct perf_event *event)
>  {
>  	struct hw_perf_event *hwc =3D &event->hw;
>  	int idx =3D hwc->idx;

[Severity: High]
Does this function still read stale data from the SBI shared memory when
using supervisor counter delegation?

If a platform supports both SBI PMU snapshots and S-mode counter delegation,
the code unconditionally reads from the SBI shared memory for stopped
hardware counters. Since S-mode counters are stopped via direct CSR writes,
the SBI firmware is bypassed and the shared memory is never updated.

[ ... ]

> +static void rvpmu_deleg_ctr_enable_irq(struct perf_event *event)
> +{
> +	unsigned long hpmevent_curr;
> +	unsigned long of_mask;
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	int counter_idx =3D hwc->idx;
> +	unsigned long sip_val =3D csr_read(CSR_SIP);
> +
> +	if (!is_sampling_event(event) || (sip_val & SIP_LCOFIP))
> +		return;

[Severity: High]
Will this early return cause non-sampling events to never be counted?

In update_deleg_hpmevent(), the HPMEVENT_OF bit is unconditionally set for
all events. The Sscofpmf specification states a counter does not increment
while its OF bit is 1. If we return early here for non-sampling events
(like perf stat), the OF bit is never cleared, which would leave these
counters permanently inhibited.

> =20
> -	/* Reinitialize and start all the counter that overflowed */
> -	while (ctr_ovf_mask) {
> -		if (ctr_ovf_mask & 0x01) {
> -			event =3D cpu_hw_evt->events[idx];
> -			hwc =3D &event->hw;
> -			max_period =3D riscv_pmu_ctr_get_width_mask(event);
> -			init_val =3D local64_read(&hwc->prev_count) & max_period;
>  #if defined(CONFIG_32BIT)
> -			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx, 1,
> -				  flag, init_val, init_val >> 32, 0);
> +	hpmevent_curr =3D csr_ind_read(CSR_SIREG5, SISELECT_SSCCFG_BASE, counte=
r_idx);
> +	of_mask =3D (u32)~HPMEVENTH_OF;
>  #else
> -			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx, 1,
> -				  flag, init_val, 0, 0);
> +	hpmevent_curr =3D csr_ind_read(CSR_SIREG2, SISELECT_SSCCFG_BASE, counte=
r_idx);
> +	of_mask =3D ~HPMEVENT_OF;
>  #endif
> -			perf_event_update_userpage(event);
> -		}
> -		ctr_ovf_mask =3D ctr_ovf_mask >> 1;
> -		idx++;
> -	}
> +
> +	hpmevent_curr &=3D of_mask;
> +#if defined(CONFIG_32BIT)
> +	csr_ind_write(CSR_SIREG4, SISELECT_SSCCFG_BASE, counter_idx, hpmevent_c=
urr);

[Severity: High]
Is this writing the event configuration to the wrong CSR?

The code reads the high 32 bits of the event configuration from CSR_SIREG5
and clears the HPMEVENTH_OF bit, but it writes the modified value back to
CSR_SIREG4. Since CSR_SIREG4 maps to hpmcounterh, this might overwrite the
running counter's upper 32 bits with the event configuration value instead
of clearing the OF bit in the hpmevent register.

> +#else
> +	csr_ind_write(CSR_SIREG2, SISELECT_SSCCFG_BASE, counter_idx, hpmevent_c=
urr);
> +#endif
> +}
> +
> +static void rvpmu_deleg_ctr_start(struct perf_event *event, u64 ival)
> +{
> +	unsigned long scountinhibit_val =3D 0;
> +	struct hw_perf_event *hwc =3D &event->hw;
> +
> +#if defined(CONFIG_32BIT)
> +	csr_ind_write(CSR_SIREG, SISELECT_SSCCFG_BASE, hwc->idx, ival & 0xFFFFF=
FFF);
> +	csr_ind_write(CSR_SIREG4, SISELECT_SSCCFG_BASE, hwc->idx, ival >> BITS_=
PER_LONG);
> +#else
> +	csr_ind_write(CSR_SIREG, SISELECT_SSCCFG_BASE, hwc->idx, ival);
> +#endif
> +
> +	rvpmu_deleg_ctr_enable_irq(event);
> +
> +	scountinhibit_val =3D csr_read(CSR_SCOUNTINHIBIT);
> +	scountinhibit_val &=3D ~(1 << hwc->idx);

[Severity: High]
Could this bitwise shift result in sign-extension and corrupt SCOUNTINHIBIT
on 64-bit systems?

Because 1 is a signed 32-bit integer, (1 << 31) results in -2147483648.
When this is negated by a bitwise NOT or cast to an unsigned long on a
64-bit architecture, it gets sign-extended (e.g., 0x000000007FFFFFFF).
This could erroneously clear bits 32-63 of the SCOUNTINHIBIT CSR.

Should this use 1UL << hwc->idx or the BIT() macro instead?

[ ... ]

> -static void rvpmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
> -					  u64 ctr_ovf_mask)
> +/*
> + * This function starts all the used counters in two step approach.
> + * Any counter that did not overflow can be start in a single step
> + * while the overflowed counters need to be started with updated initial=
ization
> + * value.
> + */
> +static void rvpmu_start_overflow_mask(struct riscv_pmu *pmu, u64 ctr_ovf=
_mask)
>  {
> +	int idx =3D 0, i;
> +	struct perf_event *event;
> +	unsigned long ctr_start_mask =3D 0;
> +	u64 max_period, init_val =3D 0;
> +	struct hw_perf_event *hwc;
>  	struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events);
> =20
>  	if (sbi_pmu_snapshot_available())
> -		rvpmu_sbi_start_ovf_ctrs_snapshot(cpu_hw_evt, ctr_ovf_mask);
> -	else
> -		rvpmu_sbi_start_ovf_ctrs_sbi(cpu_hw_evt, ctr_ovf_mask);
> +		return rvpmu_sbi_start_ovf_ctrs_snapshot(cpu_hw_evt, ctr_ovf_mask);

[Severity: High]
Does this check bypass S-mode delegation when both snapshot and delegation
are available?

If a platform supports both, this unconditionally calls
rvpmu_sbi_start_ovf_ctrs_snapshot(), which starts S-mode delegated hardware
counters using SBI ECALLs rather than direct S-mode CSR writes.

[ ... ]

> +static void update_deleg_hpmevent(int counter_idx, uint64_t event_value,=
 uint64_t filter_bits)
> +{
> +	u64 hpmevent_value =3D 0;
> +
> +	/* OF bit should be enable during the start if sampling is requested */
> +	hpmevent_value =3D (event_value & ~HPMEVENT_MASK) | filter_bits | HPMEV=
ENT_OF;

[Severity: High]
Are we unconditionally setting the HPMEVENT_OF bit here?

Although the comment states it should be enabled if sampling is requested,
the bit is added for all events. Combined with the early return in
rvpmu_deleg_ctr_enable_irq(), this causes non-sampling events to remain
inhibited permanently.

[ ... ]

>  static void rvpmu_ctr_stop(struct perf_event *event, unsigned long flag)
>  {
> -	rvpmu_sbi_ctr_stop(event, flag);
> -	/* TODO: Counter delegation implementation */
> +	struct hw_perf_event *hwc =3D &event->hw;
> +
> +	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
> +	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
> +		rvpmu_reset_scounteren((void *)event);
> +
> +	if (riscv_pmu_cdeleg_available() && !pmu_sbi_is_fw_event(event)) {
> +		/*
> +		 * The counter is already stopped. No need to stop again. Counter
> +		 * mapping will be reset in clear_idx function.
> +		 */
> +		if (flag !=3D RISCV_PMU_STOP_FLAG_RESET)
> +			rvpmu_deleg_ctr_stop_mask((1 << hwc->idx));

[Severity: High]
Can this 32-bit shift overflow and corrupt the upper 32 bits of SCOUNTINHIB=
IT?

Passing (1 << 31) will sign-extend to 0xFFFFFFFF80000000 on 64-bit systems.
When passed to rvpmu_deleg_ctr_stop_mask, it ORs this mask into SCOUNTINHIB=
IT,
which erroneously sets bits 32-63 to 1.

Consider using 1UL << hwc->idx or the BIT() macro to prevent overflow.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-counter_de=
legation-v6-0-285b72ed65a9@meta.com?part=3D13
