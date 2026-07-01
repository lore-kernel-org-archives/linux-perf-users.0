Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A8619067C;
	Wed,  1 Jul 2026 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898080; cv=none; b=C9bOirRDTymsc3T4Wi5VJTbivlbr/JWl6d6h97H+JRgA7e33wfdcZbiGoaSC39KmOrD1eLCyxb5RGd2f1E2W5QOR+7VZtudWpvkL5eiDCYv2oam1OF0yBqbkZMuqqjFrQ5RGkJRZ8U6/uT14YxmbyJedWpa4wKl66KpBE5Kw9xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898080; c=relaxed/simple;
	bh=CqxWk3qP5jw7CVZLW3Os1HDMxjvufVlJkagunj87HBI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GM8kq4WIM8diSM3BC8mIx66HnZgLPRuFg6KksDImczDgfOTlX2lLH97tXhjq2pmzN1GDLlsPIjJKQonXMQvr47/Jm/nEAdTRMgTpyLKoVa1bNiIXzf4g5hn6zjk74FZNYyrfWpcXuzSxdym0Va2DOecy4TS8GGFr28u5G13XBTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Og7BVcrE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Og7BVcrE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5FD1F000E9;
	Wed,  1 Jul 2026 09:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782898078;
	bh=yZM2Q7kjoc+jW89NRSLf5yR1ZvLzabNfnO4tNrczkh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Og7BVcrErYAVKSoktCjXzCc0y0PXwgT6MVktsCDD2iS9wP8vMdejBntR5Vq7YDBXs
	 xm3ab+XmoyCn+WBplK5HrQBlhonzFv42/R/IWNTbJRDBJN2atSzsGbGji9De7Csk/N
	 qdaCIneCeEKqZ+3E8l83Qf9Vg0jlUPWnYyOIySh7agFLFp9qlstXCKXoRDIx+aIX4t
	 oozZDW6TeybDY9nXHciftf4NlcEQvNSvEUkKIoL3IrP0IIH9AECuPHTzM0bq4VtLAQ
	 n3MGidLYmK2fepsv3IPX2+cLigzmvmejZUu1zIhlI1Dz5YOtOy5ZugshFLRnv4eyne
	 O9yfHc6q89ybg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/22] RISC-V: perf: Implement supervisor counter
 delegation support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260701-counter_delegation-v8-14-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-14-7909f863a645@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:27:57 +0000
Message-Id: <20260701092758.5F5FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Improper handling of the HPMEVENT_OF bit causes non-sampling e=
vents to never count and leads to permanent PMU interrupt deadlocks for sam=
pling events.
- [High] Counter delegation and SBI PMU snapshot features conflict, causing=
 stale counter reads and broken overflow handling when both are present.

Pre-existing issues:
- [High] The PMU overflow handler unconditionally restarts counters, ignori=
ng the throttling decision from perf_event_overflow().
--

commit 11b768ace0260db50741675707cb662cdb941c07
Author: Atish Patra <atishp@rivosinc.com>

RISC-V: perf: Implement supervisor counter delegation support

This commit adds support for the ssccfg, sscsrind, and smcntrpmf RISC-V ISA=
=20
extensions to program hpmcounters directly from supervisor mode. It falls
back to the SBI PMU extension for firmware counters or if the ISA extensions
are unavailable.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 2568c6808f5d2..7995da4a98a1c 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c

[ ... ]

> @@ -821,7 +968,7 @@ static int pmu_sbi_snapshot_setup(struct riscv_pmu *p=
mu, int cpu)
>  	return 0;
>  }
> =20
> -static u64 rvpmu_sbi_ctr_read(struct perf_event *event)
> +static u64 rvpmu_ctr_read(struct perf_event *event)
>  {
>  	struct hw_perf_event *hwc =3D &event->hw;
>  	int idx =3D hwc->idx;

[Severity: High]
If both counter delegation and SBI snapshot features are available, could
this return stale data?

When the counter is stopped via rvpmu_deleg_ctr_stop_mask(), the SBI snapsh=
ot
shared memory is not updated. Since sbi_pmu_snapshot_available() is still
true, it seems we might read a stale or zero value from sdata->ctr_values
instead of reading the hardware counter.

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

[Severity: Critical]
Will non-sampling events remain permanently halted here?

In update_deleg_hpmevent(), the HPMEVENT_OF bit is unconditionally set, whi=
ch
architecturally inhibits the counter. This function is responsible for clea=
ring
it. However, if this returns early for non-sampling events, the OF bit is
never cleared. Could this cause events like standard perf stat to perpetual=
ly
read zero?

Additionally, if sip_val & SIP_LCOFIP is true (e.g. if another counter
overflows while processing), does returning early permanently deadlock this
newly restarted sampling counter?

[ ... ]

> -static inline void rvpmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_event=
s *cpu_hw_evt,
> -						     u64 ctr_ovf_mask)
> +static void rvpmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_=
hw_evt,
> +					      u64 ctr_ovf_mask)

[ ... ]

> -static void rvpmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
> -					  u64 ctr_ovf_mask)
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
Does this bypass counter delegation entirely when SBI snapshots are present?

If sbi_pmu_snapshot_available() is true, this unconditionally delegates to
rvpmu_sbi_start_ovf_ctrs_snapshot(). This appears to use the SBI interface
to restart the counters and initializes them from the potentially stale
snapshot memory, which might clobber the hardware state managed by counter
delegation.

[ ... ]

> @@ -1228,22 +1427,183 @@ static irqreturn_t rvpmu_ovf_handler(int irq, vo=
id *dev)
>  		hw_evt->state =3D 0;
>  	}
> =20
> -	rvpmu_sbi_start_overflow_mask(pmu, overflowed_ctrs);
> +	rvpmu_start_overflow_mask(pmu, overflowed_ctrs);

[Severity: High]
This is a pre-existing issue, but does this unconditionally restart counters
even if perf_event_overflow() requests throttling?

The core perf_event_overflow() returns non-zero to signal that an event has
exceeded the maximum sample rate and should be throttled. Since the return
value is ignored here, the counter is blindly restarted via
rvpmu_start_overflow_mask(). Could this allow a maliciously low sample peri=
od
to cause an unmitigated PMU interrupt storm?

>  	perf_sample_event_took(sched_clock() - start_clock);
> =20
>  	return IRQ_HANDLED;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-counter_de=
legation-v8-0-7909f863a645@meta.com?part=3D14
