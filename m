Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990C22D5A19;
	Mon, 22 Jun 2026 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117227; cv=none; b=ZiiwGX0SQb6CmCZk9be3Y088raOE4l6fBoBXbhb7KCEhvery3R6Gdn5sHm6LVctlJCa8pLQqWvK2t0xWHbubo4ESbcztaJwS0KoFFLYg1RlZcNyEXC/beZAY6lLzqJkBHZSjE43wcoJe5sdUfdAVYnjd15rqX0FRJLDxdcihmPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117227; c=relaxed/simple;
	bh=OowKGiE7NP7e98spuHMDNvBaz0e25tLIp4od0WeW2as=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TfbnkeFVid/SYH6tRjGhRFOZsnfPigeFtK9Jg7FgKLwd9MnbRB2M958wRSu6SkqqqICI5JVZRYn6gOjiPM6B0tOMMe9qz2aAX9X1h88P3jS+1dXCSvvJpE+FF58wNFEPqzq14oiVgI/+/cYo8/mQrrCRgXDG+YCsdRVUrbyFTrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpB8ufC3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpB8ufC3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F234B1F000E9;
	Mon, 22 Jun 2026 08:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782117226;
	bh=U3FyEpRs+jXE/erDxHzeCHaB4RoLF9Lms4M9uDAE6Ms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VpB8ufC3wLJ7Oy1kZCBaHaOLBqvNhz19NbFaf2cjaPMR4OGjWCJQmRQojyz5b8n0b
	 5TfZVy46cxC5mkEa2x5EkCx5Xl2p4cvjYruHaFO9amrCH9IOhsEoi4tq7jWWZ9Zxp0
	 l6IG43AkZHBuNIwBlbDGBnV8SMThZ1dW/t4qquQlcE8mxLpl18nv+My+VZ77f5rCZU
	 czllIxU9MSOTqcUYO94x5Q9SC/HKLs6GqTvS/skqtuTKDLsfez601QXHSvS4vj0BEK
	 2Cmeoi0yEv8wD5KVuieKkFNb/DqkXrE0suzfeGwfR1whOa6k/rUzxgYoSstbpQ+mH3
	 nb4GwEHBv1Lxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/22] RISC-V: perf: Implement supervisor counter
 delegation support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260622-counter_delegation-v7-14-0ba2fd34614e@meta.com>
References: <20260622-counter_delegation-v7-0-0ba2fd34614e@meta.com>
 <20260622-counter_delegation-v7-14-0ba2fd34614e@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 08:33:45 +0000
Message-Id: <20260622083345.F234B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Unconditionally setting the HPMEVENT_OF bit and failing to cle=
ar it due to early returns in `rvpmu_deleg_ctr_enable_irq` guarantees an in=
escapable infinite interrupt storm.
- [High] The driver incorrectly falls back to SBI snapshot logic for delega=
ted counters when both counter delegation and SBI PMU snapshots are availab=
le.
- [High] On 32-bit RISC-V, `firmware_cmask` causes undefined behavior when =
populated, and incorrectly stops hardware counters instead of firmware coun=
ters during CPU hotplug.
- [High] In `rvpmu_sbi_start_ovf_ctrs_snapshot()`, an invalid `counter_idx_=
base` is passed to the SBI call and incorrect indices are used to write sna=
pshot data.
- [Medium] On 32-bit RISC-V, `update_deleg_hpmevent` drops privilege mode f=
iltering bits for fixed counters if `Smcntrpmf` is present but `Sscofpmf` i=
s not.
--

commit 65245d6fdd7f56371717df02024d346e436c2c26
Author: Atish Patra <atishp@rivosinc.com>

RISC-V: perf: Implement supervisor counter delegation support

This commit introduces support for RISC-V supervisor counter delegation.
It detects relevant ISA extensions at runtime to program counters directly
from S-mode, falling back to the SBI PMU extension for firmware counters
or when user-requested.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 1c0961e09b15f..6407e229c2c3c 100644
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

[Severity: High]
Does this code inadvertently read stale or zero values for delegated
counters?

If both counter delegation and SBI PMU snapshots are available,
sbi_pmu_snapshot_available() will be true. The early return in
rvpmu_ctr_read() will read from the snapshot shared memory, bypassing
hardware CSRs. However, stopped delegated counters are stopped locally
and won't update the SBI shared memory, resulting in an incorrect read.

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
Does this early return guarantee an inescapable infinite interrupt storm
for non-sampling events?

When rvpmu_deleg_ctr_start() is called for a non-sampling event, this
returns early without clearing the HPMEVENT_OF bit. When scountinhibit
is subsequently cleared, the active OF bit will immediately trigger a
local counter overflow interrupt. Since rvpmu_ovf_handler() skips
non-sampling events, the OF bit is never cleared, trapping the system
in an interrupt loop.

[ ... ]
> -static inline void rvpmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_event=
s *cpu_hw_evt,
> -						     u64 ctr_ovf_mask)
> +static void rvpmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_events *cpu_=
hw_evt,
> +					      u64 ctr_ovf_mask)
>  {
>  	int i, idx =3D 0;
>  	struct perf_event *event;

[Severity: High]
Does this function use an invalid base index and incorrect array indices?

The inner loop for_each_set_bit(idx, &cpu_hw_evt->used_hw_ctrs[i],
BITS_PER_LONG) completes with idx equal to BITS_PER_LONG. The subsequent
call to sbi_ecall() then uses idx * BITS_PER_LONG as the base index,
passing 1024 or 4096 instead of i * BITS_PER_LONG, which causes the SBI
call to fail.

Additionally, the assignment to sdata->ctr_values[idx] uses the relative
word index instead of adding the word offset. On 32-bit architectures,
this overwrites elements 0-31 instead of updating elements 32-63,
corrupting the snapshot memory.

[ ... ]
> @@ -1116,15 +1269,53 @@ static inline void rvpmu_sbi_start_ovf_ctrs_snaps=
hot(struct cpu_hw_events *cpu_h
>  	}
>  }
> =20
> -/*
> - * This function starts all the used counters in two step approach.
> - * Any counter that did not overflow can be start in a single step
> - * while the overflowed counters need to be started with updated initial=
ization
> - * value.
> - */
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
Does this code incorrectly fall back to SBI PMU snapshot restart logic
for delegated counters?

Since sbi_pmu_snapshot_available() and riscv_pmu_cdeleg_available() can
both be true simultaneously, checking sbi_pmu_snapshot_available() first
without verifying if the counter is actually delegated causes the driver
to attempt restarting delegated hardware counters via SBI PMU ECALLs
instead of direct CSR writes.

[ ... ]
> +static void update_deleg_hpmevent(int counter_idx, uint64_t event_value,=
 uint64_t filter_bits)
> +{
> +	u64 hpmevent_value =3D 0;
> +
> +	/* OF bit should be enable during the start if sampling is requested */
> +	hpmevent_value =3D (event_value & ~HPMEVENT_MASK) | filter_bits | HPMEV=
ENT_OF;

[Severity: Critical]
Does unconditionally setting HPMEVENT_OF cause an inescapable interrupt
loop when combined with the early return in rvpmu_deleg_ctr_enable_irq()?

Setting the HPMEVENT_OF bit here guarantees a pending overflow interrupt
will be asserted once scountinhibit is cleared. If the event is
non-sampling, the early return in rvpmu_deleg_ctr_enable_irq() skips
clearing this bit, resulting in an infinite interrupt storm.

> +#if defined(CONFIG_32BIT)
> +	csr_ind_write(CSR_SIREG2, SISELECT_SSCCFG_BASE, counter_idx, hpmevent_v=
alue & 0xFFFFFFFF);
> +	if (riscv_isa_extension_available(NULL, SSCOFPMF))
> +		csr_ind_write(CSR_SIREG5, SISELECT_SSCCFG_BASE, counter_idx,
> +			      hpmevent_value >> BITS_PER_LONG);

[Severity: Medium]
On 32-bit RISC-V, does this check inadvertently drop privilege mode
filtering bits for fixed counters?

Fixed counters rely on the Smcntrpmf extension for filtering bits. If a
system implements Smcntrpmf and counter delegation but lacks Sscofpmf,
the upper 32 bits (which contain the privilege mode filtering bits) are
skipped, and the privilege filter configuration is silently dropped.

[ ... ]
> @@ -1323,7 +1681,16 @@ static int rvpmu_starting_cpu(unsigned int cpu, st=
ruct hlist_node *node)
>  		csr_write(CSR_SCOUNTEREN, 0x2);
> =20
>  	/* Stop all the counters so that they can be enabled from perf */
> -	rvpmu_sbi_stop_all(pmu);
> +	if (riscv_pmu_cdeleg_available()) {
> +		rvpmu_deleg_ctr_stop_mask(cmask);
> +		if (riscv_pmu_sbi_available()) {
> +			/* Stop the firmware counters as well */
> +			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0, firmware_cmask,
> +				  0, 0, 0, 0);
> +		}

[Severity: High]
Does this code inadvertently invoke undefined behavior and stop the wrong
counters on 32-bit architectures?

firmware_cmask is defined as an unsigned long. Since firmware counters
occupy indices 32-63, populating firmware_cmask via BIT(i) where i >=3D 32
invokes undefined behavior on 32-bit architectures by wrapping the
shift, which corrupts the mask.

When sbi_ecall() is invoked here with base index 0 and the corrupted
firmware_cmask, it instructs the SBI firmware to stop hardware counters
(0-31) that map to the wrapped bits, while failing to stop the actual
firmware counters.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-counter_de=
legation-v7-0-0ba2fd34614e@meta.com?part=3D14
