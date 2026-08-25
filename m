Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB913D6CA7
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787644861; cv=none; b=jJhCTDUzxEo/c1N2dn4gkNfSTr2OnLQ5iN32hd/dVMdF2m4QtgOnuiKJKeHtXgCwb0ZgiU3P9/dClUyTQiHSLDFxJn9PQZaIxgOHyuknRZvI5dWowGeHPoS5WBxQQS4Y7kBroYqjR7dJS3jCzHvqnTsECN5Xfmx54GQieBwuggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787644861; c=relaxed/simple;
	bh=Aq9IvkhOWE7EE9Hfa5soirbHNBPhBbUZt/s0TVsyJ8Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mFqkocpOZgyBJq2Wo0DiVLiD7m17aU0bCsv2LlfENsCDfYBb1u23sVlwgqH2j2pOz4qENRfwW4mfmHr+8nGqzmAK81z2f4noBPGFe39MIr7KvFvQ6A0rEe4VW7QeD6x8+izjhWZ56WSJ9LDTBDmbOk1Bj1u2yEd4Pcv9psI256w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj77MFCI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj77MFCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1431F00A3A;
	Tue, 25 Aug 2026 08:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787644859;
	bh=mc3TcDAKgAhNc6f0OCUB/zhdSxyI0VIFlOe+MniYuiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yj77MFCIRiAxMKuYJuHkP3bRiikk4Uv+DJRSkQ0onfeTC2qLhWtD4kwWXAp/RCUq3
	 RK2iAAdjmU+JaICTfUUOyXPGWq1i/WeYVEzMy5UtjL1SQ5EeiGfbjxvXdD+cZfkVxA
	 ihuqj0J2clxRRT+MJuzGlFxGh3cHcy8fFT6g0fkiWpP9QepZ0jTg2m7PIA61oOZtc+
	 Fxm8H+pg0oiSrm5jb9w4ZcV4ZHLKXeboSxd4qF/9Ga66vxF5q0GK5BTTzk7jNSJbmw
	 ijnVJ/f15/UcCXw/L12YdaLQqEURSpjYzNo82QtZu2KKjA20hvrKAGrP6y/ePzgrbh
	 xGRJgOcbeoD6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: riscv: Clear PMU pending interrupt through vendor
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260825151001.2-andes-pmu-clear-caplitmus-rv@iscas.ac.cn>
References: <20260825151001.2-andes-pmu-clear-caplitmus-rv@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 08:00:58 +0000
Message-Id: <20260825080059.5F1431F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The global `riscv_pmu_irq_mask` is declared as a 32-bit `unsigned =
int` but initialized with a 64-bit mask, causing dangerous truncation and s=
ign-extension on RV64 systems.
- [High] A spurious PMU interrupt triggers an early return that leaves the =
hardware performance counters permanently stopped.
--

--- Patch [1]: [PATCH] perf: riscv: Clear PMU pending interrupt through ven=
dor helper ---
commit 58e4c92109db4c76ba1174701bb0aa79f0e00c65
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

perf: riscv: Clear PMU pending interrupt through vendor helper

When no hardware counters are in use, the PMU overflow handler clears the
pending interrupt directly in CSR_SIP. This patch modifies the early return
to use ALT_SBI_PMU_OVF_CLEAR_PENDING instead to avoid an out-of-width
shift and the wrong CSR on Andes PMU.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 50220f7b46d9b..ff95f5f136030 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -1058,7 +1058,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, voi=
d *dev)
>  	/* Firmware counter don't support overflow yet */
>  	fidx =3D find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS);
>  	if (fidx =3D=3D RISCV_MAX_COUNTERS) {
> -		csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
> +		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);

[Severity: High]
This is a pre-existing issue, but does using riscv_pmu_irq_mask here risk
truncation or sign-extension on RV64 systems?

The global riscv_pmu_irq_mask is declared as a 32-bit unsigned int:

drivers/perf/riscv_pmu_sbi.c:
    static unsigned int riscv_pmu_irq_mask;

But it is initialized with a 64-bit mask in pmu_sbi_setup_irqs():

    riscv_pmu_irq_mask =3D BIT(riscv_pmu_irq_num % BITS_PER_LONG);

On RV64, if the PMU IRQ number results in (num % 64) >=3D 32, the assigned
value is truncated to 0, which would cause ALT_SBI_PMU_OVF_CLEAR_PENDING to
clear nothing and potentially lead to an unrecoverable interrupt storm.

Additionally, if (num % 64) =3D=3D 31, the 32-bit value 0x80000000 could be
sign-extended to 64-bits by the compiler when placed in a general-purpose
register for the csrc inline assembly, unintentionally clearing bits 31-63
of the interrupt pending CSR.

Would it be better to change the type of riscv_pmu_irq_mask to unsigned
long?

[Severity: High]
This isn't a bug introduced by this patch, but does the early return for
spurious interrupts leave the hardware performance counters permanently
stopped?

Later in pmu_sbi_ovf_handler(), all active PMU hardware counters are
stopped before reading the overflow status:

drivers/perf/riscv_pmu_sbi.c:pmu_sbi_ovf_handler() {
    ...
    pmu =3D to_riscv_pmu(event->pmu);
    pmu_sbi_stop_hw_ctrs(pmu);

    if (sbi_pmu_snapshot_available())
        overflow =3D sdata->ctr_overflow_mask;
    else
        ALT_SBI_PMU_OVERFLOW(overflow);
    ...
    /* No overflow bit is set */
    if (!overflow)
        return IRQ_NONE;
    ...
}

If a spurious interrupt occurs or overflow evaluates to 0, this early exit
returns IRQ_NONE and bypasses the call to pmu_sbi_start_overflow_mask()
at the end of the function.

Could this silently and permanently break performance sampling on that CPU
until manually restarted by userspace?

>  		return IRQ_NONE;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825151001.2-an=
des-pmu-clear-caplitmus-rv@iscas.ac.cn?part=3D1
