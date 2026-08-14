Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64D936B905
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730501; cv=none; b=KR9ppoAIyAg9WttH3rg8GPvLVne0xb3rOmb3+uU47GPvY3fPwQrC5rwIa+Qlw0LXKU3mXvK52nOwSNpp62LIEvrwRLh31KNbxJ5dQWCgseMgAruRLup98wvenUpTvc3Z1Ym7iOppsVB6b0QJecMo3DQgWo5Kp21fnpX7/UIQvcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730501; c=relaxed/simple;
	bh=UOFJ/A5Flm/jQC7vaU8JtOhlywgxLvW2jaeq7jkz9CQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fBbs9+iovGgpHKd/KXaS5IPuKYDZD3PJMUxVRHZP2E5ILxNBRki2SC2WiNfBEu2gp5zo9tvNq/R91jtC8iE6brJ++AZXOGqodnmFrg5bnhEUh4IbuX0zsufd62ab+r9UM0T6VM40x9spoy46A8vg77uKI/rmnvPY/tGWP/g6ZtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YogkKrr8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YogkKrr8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9BB1F00A3A;
	Fri, 14 Aug 2026 18:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786730500;
	bh=4Dcnapuy7A1dLQG9Alhhc+1gr5sIamoIfSXY/S6uawA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YogkKrr8nY4rCMJbbEuHWbyz+z+gauJ8vn0a76L1d8RkfkihsyiU5+U4isBxsT9UA
	 GZkRFDCBG5xk+5GQCcR6lTofNMt2N1ZEUshxhGFWQwuIcM+RBQK3j273akuHYbVRFh
	 1ewIp3Bt2WvdJHrq5k2EmbcOCDlNjsRFD0kBWpfhzOZU4CLzPRpK2Nd2XupQtdTJGQ
	 7Fls5aQ7OxHqhQM0ONxF2q/TJRI8XqAxpW1kmAcSg+Y/ZL83AqDk6XGoxHg9d4g66X
	 etCqpM4rITn0uFsgLvrIK30Qo/PyTYC3i3V/SAn6QPnaXbmB9/3b6+l2gQ4GNXbNer
	 t8DXr7zPoo2lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] perf/x86: Move MSR_CORE_PERF_GLOBAL_* dump to
 vendor code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <d83896ecfd6e98424c2053298fbb10a3d91592f9.1786728929.git.sandipan.das@amd.com>
References: <cover.1786728929.git.sandipan.das@amd.com>
 <d83896ecfd6e98424c2053298fbb10a3d91592f9.1786728929.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 18:01:39 +0000
Message-Id: <20260814180140.5F9BB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unintended removal of MSR_IA32_DEBUGCTLMSR from AMD PMU debug du=
mp.
--

--- Patch [2]: [PATCH v2 2/3] perf/x86: Move MSR_CORE_PERF_GLOBAL_* dump to=
 vendor code ---
commit 9c3227849508af744eb4359d394119d9f9ee749a
Author: Sandipan Das <sandipan.das@amd.com>

perf/x86: Move MSR_CORE_PERF_GLOBAL_* dump to vendor code

This commit moves the dumping of MSR_CORE_PERF_GLOBAL_* and
MSR_ARCH_PERFMON_FIXED_CTR_CTRL registers from common code to vendor-specif=
ic
code. This prevents unchecked MSR access errors on AMD processors that repo=
rt
PerfMonV2 support but lack these Intel Architectural PerfMon registers.

Closes: https://lore.kernel.org/all/20260717150315.2868314-1-ptesarik@suse.=
com/

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index ae773f8d55c39..4c70cb0148716 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c

[ ... ]

> @@ -1561,38 +1561,15 @@ static void x86_pmu_start(struct perf_event *even=
t, int flags)
> =20
>  void x86_pmu_print_debug(int cpu)
>  {
> -	u64 ctrl, status, overflow, pmc_ctrl, pmc_count, prev_left, fixed;
>  	unsigned long *cntr_mask, *fixed_cntr_mask;
> -	struct event_constraint *pebs_constraints;
> +	u64 pmc_ctrl, pmc_count, prev_left;
>  	struct cpu_hw_events *cpuc;
> -	u64 pebs, debugctl;
>  	int idx;
> =20
>  	cpuc =3D &per_cpu(cpu_hw_events, cpu);
>  	cntr_mask =3D hybrid(cpuc->pmu, cntr_mask);
>  	fixed_cntr_mask =3D hybrid(cpuc->pmu, fixed_cntr_mask);
> -	pebs_constraints =3D hybrid(cpuc->pmu, pebs_constraints);
> -
> -	if (x86_pmu.version >=3D 2) {
> -		rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
> -		rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
> -		rdmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, overflow);
> -		rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
> -
> -		pr_info("\n");
> -		pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
> -		pr_info("CPU#%d: status:     %016llx\n", cpu, status);
> -		pr_info("CPU#%d: overflow:   %016llx\n", cpu, overflow);
> -		pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
> -		if (pebs_constraints) {
> -			rdmsrq(MSR_IA32_PEBS_ENABLE, pebs);
> -			pr_info("CPU#%d: pebs:       %016llx\n", cpu, pebs);
> -		}
> -		if (x86_pmu.lbr_nr) {
> -			rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
> -			pr_info("CPU#%d: debugctl:   %016llx\n", cpu, debugctl);
> -		}

[Severity: Medium]
Will this unintentionally drop the MSR_IA32_DEBUGCTLMSR dump for AMD CPUs?

AMD processors with LBR support use MSR_IA32_DEBUGCTLMSR for LBR freezing, =
but
since this read was moved entirely to the Intel-specific intel_pmu_print_de=
bug(),
SysRq-P will no longer dump this register for AMD processors relying on the
common x86_pmu_print_debug() function.

Should the debugctl dump be preserved in common code, or added to an AMD-sp=
ecific
print_debug function?

> -	}
> +
>  	pr_info("CPU#%d: active:     %016llx\n", cpu, *(u64 *)cpuc->active_mask=
);
> =20
>  	for_each_set_bit(idx, cntr_mask, X86_PMC_IDX_MAX) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786728929.gi=
t.sandipan.das@amd.com?part=3D2
