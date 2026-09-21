Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7AE48F00D
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990306; cv=none; b=K7qVTvTozuXRnVxtjV3Lr2dOCSevGTVm6lM6qS2LelpEe/Ac6/cgi7agJC1eOpU1lgeZivz+n4pKnDUo1kJbkE/Nw9cu/+lT6JgAVd5hPznlHXbXl1/4YQV36ve+Rh7uLpr2RVcI27p/LXU1neOJZkptMBDioU5BzmAYNiTchpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990306; c=relaxed/simple;
	bh=TH7Z7vBNwQ2jbpODWf+E7p8b+/ah+iXdY07etHC9TQk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f+z6pSDYvsV46t0NRe0drhQftz55FYwxvx9d7+hsJbipfXLNnGtOPWMg9HxPjG4bjOFeOq1l3I65l75DymcEAiA4BTekgPAUH6CY8mwpfO6dUI4tUZYDaJB534tiyNmKO+Pw8bGFq1U+EXNnkuQ9x1pECRQ9kRYHsydxblz0Dko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN9iN+FE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN9iN+FE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0191F000FF;
	Mon, 21 Sep 2026 11:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789990303;
	bh=UtoRvdNkzm8LNYc9+fEfBzrinoDMap47pz49Bb5yxDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eN9iN+FEPWG/EzqLzfy1wHnll6g2D633dd++ieMyJuFtAWxnR2D14uXKud4CZV9Rd
	 qQ62NmxhlY+3HpVQqIv8G+hpOzugFtGGn0FWOw8Cgtknmvj5E/GH6BNff00LClBOLU
	 fbvWVCTRW5oZqdSl53+eaLvRCaWK0MRVJuap2KYDub4c3AENthgy6LFfmLYNl/CCmM
	 FfBz3n6Df38Uz3OCad4qASfp1dgJJpRE+mUbT/yoFa10sgnrzRVdtpgxl8NhxoMTAH
	 K4ww/bvRExEMtpJLZ1ABLnaAmxGR1kH3nzeVuxh6zZyaYdN5y03Dnj2Isv9Yf9WDYX
	 fXzLyxpRH05mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 RESEND 2/9] riscv: add support for SBI Supervisor
 Software Events extension
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <d067d9d2a8f33d480ebdcce276328a336aa26073.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
References: <cover.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
 <d067d9d2a8f33d480ebdcce276328a336aa26073.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 11:31:43 +0000
Message-Id: <20260921113143.6F0191F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] riscv: premature restoration of CSR_SSTATUS re-enables interru=
pts leading to privilege escalation
- [High] riscv: truncation of 64-bit physical addresses on RV32 during SBI =
ecall
--

commit 491bc3336b6e02d6ec5b41c80039d8746df8e36e
Author: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

riscv: add support for SBI Supervisor Software Events extension

This commit introduces support for the SBI Supervisor Software Events
extension, allowing firmware to notify supervisor software of independent
events. It implements event registration, handler contexts with dedicated
stacks, and restoration of the interrupted supervisor state.

diff --git a/arch/riscv/kernel/sbi_sse.c b/arch/riscv/kernel/sbi_sse.c
new file mode 100644
index 0000000000000..7dd496e2bdb0e
--- /dev/null
+++ b/arch/riscv/kernel/sbi_sse.c
@@ -0,0 +1,246 @@
[ ... ]
> +void noinstr do_sse(struct sse_event_arch_data *arch_evt,
> +		    struct pt_regs *regs, unsigned long hstatus)
> +{
[ ... ]
> +	/* Retrieve missing GPRs from SBI */
> +	sret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, arch_evt->evt_=
id,
> +			 SBI_SSE_ATTR_INTERRUPTED_A6,
> +			 (SBI_SSE_ATTR_INTERRUPTED_A7 -
> +			  SBI_SSE_ATTR_INTERRUPTED_A6) + 1,
> +			 (unsigned long)arch_evt->interrupted_phys, 0, 0);

[Severity: High]
Does this cast to unsigned long truncate the upper 32 bits of the physical=
=20
address on RV32 systems?

On RV32 systems with 34-bit physical addressing (Sv32), phys_addr_t is=20
64-bit. If the event data is allocated in memory residing above the 4GB=20
boundary, this truncation could cause the firmware to write the interrupted=
=20
registers to the wrong physical address in the lower 4GB, resulting in=20
memory corruption.

> +	if (sret.error) {
[ ... ]
> +	if (memcmp(&regs->a6, arch_evt->interrupted,
> +		   sizeof(*arch_evt->interrupted))) {
> +		memcpy(arch_evt->interrupted, &regs->a6,
> +		       sizeof(*arch_evt->interrupted));
> +		sret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_WRITE,
> +				 arch_evt->evt_id, SBI_SSE_ATTR_INTERRUPTED_A6,
> +				 (SBI_SSE_ATTR_INTERRUPTED_A7 -
> +				  SBI_SSE_ATTR_INTERRUPTED_A6) + 1,
> +				 (unsigned long)arch_evt->interrupted_phys, 0, 0);

[Severity: High]
Similarly, does this truncation happen identically on the writeback path?

> +		/*
> +		 * If writeback fails, COMPLETE resumes with firmware's original
> +		 * a6/a7 rather than treating the shared buffer as committed.
> +		 */
[ ... ]

diff --git a/arch/riscv/kernel/sbi_sse_entry.S b/arch/riscv/kernel/sbi_sse_=
entry.S
new file mode 100644
index 0000000000000..e0e8efba12ddb
--- /dev/null
+++ b/arch/riscv/kernel/sbi_sse_entry.S
@@ -0,0 +1,226 @@
[ ... ]
> +	csrw CSR_SSCRATCH, s4
> +	ALTERNATIVE("nop", "csrw hstatus, s5", 0, RISCV_ISA_EXT_H, 1)
> +	csrw CSR_STVEC, s3
> +
> +	REG_L a0, PT_STATUS(sp)
> +	REG_L a1, PT_EPC(sp)
> +	REG_L a2, PT_BADADDR(sp)
> +	REG_L a3, PT_CAUSE(sp)
> +	csrw CSR_SSTATUS, a0
> +	csrw CSR_EPC, a1
> +	csrw CSR_STVAL, a2
> +	csrw CSR_SCAUSE, a3

[Severity: Critical]
Does restoring the interrupted context's sstatus here prematurely re-enable=
=20
interrupts before the handler completes natively via the SBI firmware?

If the interrupted context had interrupts enabled (SR_SIE bit set), writing=
=20
it back immediately re-enables interrupts while still executing on the kern=
el's
SSE stack.=20

If a pending interrupt fires during the window before the ecall,=20
handle_exception reads the previously restored sscratch. If sscratch contai=
ns
a user task pointer, handle_exception could incorrectly swap the user's=20
TASK_TI_USER_SP with the kernel SSE stack pointer, leaking the kernel stack
to userspace.

> +
> +	REG_L ra, PT_RA(sp)
> +	REG_L s0, PT_S0(sp)
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789974241.gi=
t.zhangzhanpeng.jasper@bytedance.com?part=3D2
