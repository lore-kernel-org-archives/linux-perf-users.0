Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C0044AB9A
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Aug 2026 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927822; cv=none; b=Ams88XRvbdBbUDl4nD5X9nzKLV+WNfz/LuPfNa+JNNQFgsCSQNr7UkomXzcn5/fbtnriyy1xih7K2VlISENkE7UGb8h1Oda8Vu/dFh7Dsg24atod0I4hWyH5UiTlPaHTkdDC+BgsfAJ6UQ7643cSfWPlvKmara2bfhu9mZOK/dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927822; c=relaxed/simple;
	bh=W9dtgscnoMN4qIPOJrta4zespZWi/y7v/n1jY2ETWdA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SjJFoBj04g/IK3ZfRq5ksuvq+J2G8LjGjWV/a8VGQHY3BFAxy6yF8rYRDbamsN4kEup8nEU+JqQOEhIQXIO4hLM+UMsENj2tK8wS92yI2c2YFyHTrqHD6EXvcFQwx0QK4bgYOXLDM4IS1Bkh7DiPykAxGbmgMJhtXs/pzE1dqLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSNR559L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSNR559L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9F21F000E9;
	Fri, 28 Aug 2026 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787927820;
	bh=vjVvhbKVV9jy/ZkMFghaRg1iI3Cdx9xVZi7ITQLE15g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZSNR559LO/OJfzg127HAVQsY5JkzTBBe5F5AKPLYY8ViTCRvPCPEShy9g5ZlSZmZt
	 OF5GTSOpXveFweqpUA3if7evG4wJP6H19atGyCstPFs5+siz99kid89eiaFLkz/mpd
	 Z02G5DYJHQHAjE4gBY6s59JAuPzP3ibNvt2hjA93S7Kl0iP94JxAbwXW71YYKi3GWW
	 gL4pMCsg3Im3iKT06iXa30h03ya0w5i4Wc8oLWInJumoUkIT6bry/t5UJBpestaX4y
	 ZFYTeyklIkj0LBA27ifcNCWPzUqHkXCZAzDApFP9UdX4Yhojv/Rpriy9/aqatrQ7t0
	 1Jo6C1640k/4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: riscv: fix PMU overflow counter restart state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260828142120.12616-1-pengpeng@iscas.ac.cn>
References: <20260828142120.12616-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 14:36:59 +0000
Message-Id: <20260828143700.6D9F21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Accumulation of bits in `ctr_overflow_mask` causes phantom PMU ove=
rflows and infinite loops.
- [High] Batch PMU operations clobber stopped counter snapshot values on RV=
32.
- [High] Using BIT() for a potentially large IRQ number causes undefined be=
havior and fails to clear the interrupt.
- [High] The 'cmask' variable is undersized on RV32, causing out-of-bounds =
reads and undefined behavior.
- [Medium] Mapping firmware counters unintentionally enables/disables users=
pace access to the hardware cycle counter.
--

commit 5c2027925f34b7a9d276d3526dd841300147c576
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

perf: riscv: fix PMU overflow counter restart state

This commit fixes PMU overflow counter restart states on RISC-V by applying
the correct overflow-mask word to each used-counter word. It updates the
snapshot path and overflow handler to use 64-bit bit operations for global
counter indices. Additionally, it ensures the snapshot start base is correc=
tly
derived from the outer word index.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 50220f7b46d9b..6cfb1fc0ec6e1 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -962,7 +962,9 @@ static inline void pmu_sbi_start_ovf_ctrs_sbi(struct =
cpu_hw_events *cpu_hw_evt,
>  	u64 init_val =3D 0;
> =20
>  	for (i =3D 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
> -		ctr_start_mask =3D cpu_hw_evt->used_hw_ctrs[i] & ~ctr_ovf_mask;
> +		unsigned long word_ovf_mask =3D
> +			ctr_ovf_mask >> (i * BITS_PER_LONG);
> +		ctr_start_mask =3D cpu_hw_evt->used_hw_ctrs[i] & ~word_ovf_mask;
>  		/* Start all the counters that did not overflow in a single shot */
>  		if (ctr_start_mask) {
>  			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BITS_PER_LONG,

[ ... ]

[Severity: High]
This is a pre-existing issue, but can the 64-bit mask corruption cause phan=
tom
PMU overflows and infinite loops?

On RV32, when stopping counters across multiple words:

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_stop_hw_ctrs() {
...
    temp_ctr_overflow_mask |=3D sdata->ctr_overflow_mask << (i * BITS_PER_L=
ONG);
...
    sdata->ctr_overflow_mask =3D temp_ctr_overflow_mask;
...
}

The OS fails to clear the 64-bit mask sdata->ctr_overflow_mask before calli=
ng
SBI_EXT_PMU_COUNTER_STOP for i=3D1. Firmware ORs relative overflow bits into
this uncleared mask, mixing base 0 and base 32 overflows.

Does the kernel then shift and OR this corrupted mask into
temp_ctr_overflow_mask, accumulating stale bits indefinitely and causing
phantom interrupts?

[Severity: High]
This is a pre-existing issue, but does this batch PMU operation clobber
stopped counter snapshot values on RV32?

If all counters in used_hw_ctrs[0] are already stopped,
SBI_EXT_PMU_COUNTER_STOP returns an error, skipping the save of their
snapshot values to snapshot_cval_shcopy:

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_stop_hw_ctrs() {
...
    ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, i * BITS_PER_L=
ONG,
                    cpu_hw_evt->used_hw_ctrs[i], flag, 0, 0, 0);
...
    sdata->ctr_values[idx] =3D cpu_hw_evt->snapshot_cval_shcopy[idx];
...
}

When i=3D1 runs for counters 32..63, does the firmware write their snapshot=
 into
sdata->ctr_values[0..31], clobbering the values for counters 0..31?

Does the kernel then restore snapshot_cval_shcopy[0..31] (which remains 0)
into sdata->ctr_values, destroying the saved snapshot of the already stopped
counters?

[Severity: Medium]
This is a pre-existing issue, but does mapping firmware counters
unintentionally toggle userspace access to the hardware cycle counter?

When userspace maps a firmware counter, pmu_sbi_event_mapped() unconditiona=
lly
calls pmu_sbi_set_scounteren():

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_set_scounteren() {
...
    csr_write(CSR_SCOUNTEREN,
              csr_read(CSR_SCOUNTEREN) | BIT(pmu_sbi_csr_index(event)));
...
}

This calls pmu_sbi_csr_index(), which subtracts CSR_CYCLE from the
uninitialized csr field of the firmware counter:

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_csr_index() {
...
    return pmu_ctr_list[event->hw.idx].csr - CSR_CYCLE;
...
}

Since the csr field is 0, the result -3072 truncates to 0 in uint8_t.

Does this erroneously toggle SCOUNTEREN[0], inadvertently enabling or
disabling hardware access to the cycle counter?

[Severity: High]
This is a pre-existing issue, but does using BIT() for a potentially large =
IRQ
number cause undefined behavior here?

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_ovf_handler() {
...
    if (fidx =3D=3D RISCV_MAX_COUNTERS) {
        csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
        return IRQ_NONE;
    }
...
}

For the ANDES custom PMU, riscv_pmu_irq_num is 274. If this path executes,
does shifting by 274 trigger undefined behavior?

Does this also fail to clear the pending IRQ since it targets CSR_SIP inste=
ad
of the custom ANDES_CSR_SLIP register correctly handled by
ALT_SBI_PMU_OVF_CLEAR_PENDING?

[Severity: High]
This is a pre-existing issue, but is the 'cmask' variable undersized on RV3=
2,
causing out-of-bounds reads and undefined behavior?

drivers/perf/riscv_pmu_sbi.c:
...
static unsigned long cmask;
...

In pmu_sbi_get_ctrinfo(), BIT(i) is used for i up to 63:

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_get_ctrinfo() {
...
    *mask |=3D BIT(i);
...
}

And in riscv_pmu_get_hpm_info():

drivers/perf/riscv_pmu_sbi.c:riscv_pmu_get_hpm_info() {
...
    for_each_set_bit(i, &cmask, RISCV_MAX_COUNTERS) {
...
}

Since cmask is an unsigned long, it is 32 bits on RV32.

Does for_each_set_bit() read 64 bits, overrunning the 32-bit cmask variable
into adjacent memory and causing undefined behavior when i >=3D 32?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828142120.1261=
6-1-pengpeng@iscas.ac.cn?part=3D1
