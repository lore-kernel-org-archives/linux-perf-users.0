Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2CA348C5D;
	Fri,  7 Aug 2026 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091645; cv=none; b=bPMh6FysMNr+7q8/lCXpNfPWzCb7grYCXbsaZYSvRERE+14sqiqhajfI6s7HU+G3HQns3UK+Tgg/uWwDWJf0131Tthx77F6p6iy06fQAU5xudPIxtv2k+hUfTjbSqzCD04zt1Ul3Pvc6bHlSb1lw7HsXPLUv39JWj1bVjcMZCAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091645; c=relaxed/simple;
	bh=RuoitR6H60DSllYMhIs4DXZPn70NU4WQWcqp1ckTj1c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y+HklWVcsu5rRj3uasafXmLui1scb9Agti4F97k0CSEphXXgUmKYIPOfxmPS5oLTDfwYgHxA1UbGUyr1AdNwznZ/do6EDkSg6Xy++9y74Npa+FHlYJJT+TF4H9R0O9OpqiyW+OSu5nRrHDML7hdwckrVHlRjZhjUlUA+MHnVE/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egpE/sHd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egpE/sHd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5833F1F000E9;
	Fri,  7 Aug 2026 08:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786091643;
	bh=iXwDOCVwuABsSnsc7nuG5npLY75DePuZTBjYJTNdzSs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=egpE/sHdEx6c0T8pL5cFZNzJEdSjq+6qepeSas+5guwlK+Y8b9DD6aLPXUxAYE1vv
	 oUq7JwSLoe4I4Sv1aqCN0lg56roU945SFs1Mv784GJQ7gtpk8/EaktIILv+XbwdOfj
	 E6BdYqJrhSaxkbmjgOUeuUiiJvsjnSumgibCLwexyoDXE45W2LJdZpiwfG6Y9gRbBs
	 qbYuGmiPv50VVVcUFiPoO/quT8tQzhAnzUcSn+HtpxfKNpkR31J8ZJzV5fjdidZcJu
	 wtqxZqdqcfDAQiU6enAc82M9/eoSB1Xht7bnI23Wto7LxvkG5tGYKsbOO4KOWHSA3P
	 /W8KOYT6NyZnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 14/20] RISC-V: perf: Implement supervisor counter
 delegation support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: linux-perf-users@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260807-counter_delegation-v9-14-58658104e487@meta.com>
References: <20260807-counter_delegation-v9-0-58658104e487@meta.com>
 <20260807-counter_delegation-v9-14-58658104e487@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:34:02 +0000
Message-Id: <20260807083403.5833F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Unconditionally setting the HPMEVENT_OF bit causes an unrecove=
rable interrupt storm for non-sampling events.
- [High] Bailing out of `rvpmu_deleg_ctr_enable_irq()` when `SIP_LCOFIP` is=
 set causes newly started counters to falsely trigger spurious overflows.
- [High] Calling `__ffs()` on a zero mask when all hardware PMU counters ar=
e in use invokes undefined behavior and silently corrupts active perf event=
s.
--

--- Patch [14]: [PATCH v9 14/20] RISC-V: perf: Implement supervisor counter=
 delegation support ---
commit c2b448f2df09243c89d8cc4f0c47edd59230b3d1
Author: Atish Patra <atishp@rivosinc.com>

RISC-V: perf: Implement supervisor counter delegation support

This commit adds runtime detection and support for RISC-V ISA extensions
(ssccfg, sscsrind, smcntrpmf) to program hpmcounter/hpmevents directly from
S-mode. It falls back to the SBI PMU extension if the new extensions are
unavailable or for firmware counters.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 7afd79b0a29b8..fd4bf8804c9a6 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
[ ... ]
> @@ -1038,55 +1187,75 @@ static inline void rvpmu_sbi_stop_hw_ctrs(struct =
riscv_pmu *pmu)
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
write_deleg_hpmevent() unconditionally sets the HPMEVENT_OF flag on the
counter. If this returns early for non-sampling events, the OF flag remains
set. When the counter is uninhibited, won't the set OF flag immediately ass=
ert
an interrupt?

And since rvpmu_ovf_handler() skips non-sampling events:

	/* Skip if invalid event or user did not request a sampling */
	if (!event || !is_sampling_event(event))
		continue;

Will this result in an unrecoverable interrupt storm that hangs the CPU?

[Severity: High]
If SIP_LCOFIP is set from another counter's pending overflow, returning ear=
ly
here means this new counter starts with its OF bit still set. When local
interrupts are re-enabled, won't the overflow handler falsely detect this n=
ew
counter as having instantly overflowed, corrupting the event state?

[ ... ]
> @@ -1232,22 +1448,194 @@ static irqreturn_t rvpmu_ovf_handler(int irq, vo=
id *dev)
[ ... ]
> +static int get_deleg_next_hpm_hw_idx(struct cpu_hw_events *cpuc, struct =
perf_event *event)
> +{
> +	unsigned long hw_ctr_mask =3D 0;
> +
> +	/*
> +	 * TODO: Treat every hpmcounter can monitor every event for now.
> +	 * The event to counter mapping should come from the json file.
> +	 * The mapping should also tell if sampling is supported or not.
> +	 */
> +
> +	/* Select only hpmcounters */
> +	hw_ctr_mask =3D cmask & (~0x7);
> +	hw_ctr_mask &=3D ~(cpuc->used_hw_ctrs[0]);
> +	return __ffs(hw_ctr_mask);
> +}

[Severity: High]
If all eligible PMU counters are currently active, hw_ctr_mask will be 0.
Calling __ffs(0) invokes undefined behavior, which on RV32 without the Zbb
extension evaluates to 31.

Then in rvpmu_deleg_ctr_get_idx():

	idx =3D get_deleg_next_hpm_hw_idx(cpuc, event);
	if (idx < 3 || idx > hw_ctr_max_id)
		goto out_err;
found_idx:
	priv_filter =3D get_deleg_priv_filter_bits(event);
	write_deleg_hpmevent(idx, hwc->config, priv_filter);
skip_update:
	if (!test_and_set_bit(idx, cpuc->used_hw_ctrs))
		return idx;

Won't this overwrite the configuration of the active counter (e.g. index 31)
in write_deleg_hpmevent() before verifying its availability with
test_and_set_bit(), silently corrupting the active counter's
configuration?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-counter_de=
legation-v9-0-58658104e487@meta.com?part=3D14
