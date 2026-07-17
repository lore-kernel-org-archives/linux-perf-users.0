Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89AF3ECBE2
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301540; cv=none; b=oa56C3QUM5rYkOghtzt8BT4QgjJdOrtCS41x7gHpOiXExwh1b/TZr/1pd4FWKK4vQKUxxq4cxp+w2MtjimWVeMySaSCcWe2vlTlo+YkPQaz8soEme1nnM0uYnqlzUsR5oD4xe55XqH5zBRI2TIHd6xpXT6evn4pz9MzpHuQaYo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301540; c=relaxed/simple;
	bh=6D+DvPrJZQk+LFgbu1nBPKz7xXETdfDwJWdhKHi5vhA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ctJoBY4V4eaYdTQZ7cvt6nqQLYn6L2sXsUB5FLoESh9aGn2s5Cd8DSIlQaOOsx0+hcNoR314V546XbJCHm9DSdfl8f8zEa53sH9mgyk7fqN7m8z10IH22gsqbo81CrUGSU7gms10yEY0qEMSTO7sdR5wIz72kAPDIc35e5IzZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXM86xJk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXM86xJk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED701F000E9;
	Fri, 17 Jul 2026 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784301538;
	bh=TNRp9SfePjZC0Q3ZSXdRyRVnadc/jOgf3xS2HfaUvPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AXM86xJktVhuxKPq6bBtN0sfsZz39zHAE2yNW3JbPFNKPE4xAajyM1eHmgTA2Nl2i
	 AaytPjHgPiZcZ+Uim/BSg5ZLjyH2BJENCXQovBxc+NlK4ACi1bIkQitki/VmryfzSr
	 RNwCT0CNeS5TIHjKqZibn9NvNT6BAr7hQ5/XajjcHnQkG/DhWZhAB+ut4sk1FzbQfd
	 DRXowIiuS9+zv4h9xR6FYHkedfnoZJ/Dh+NVz9XlHaCchX2Go/kyuXYtZJBpzV+ZpF
	 gw+9Br6ciXO+ZFO6W3HGRixWAQgVqSigv4z6Oz9E7VFEBNrS9/RMrQyOp8aWiNUGmt
	 c2GruYJ6GgRnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] perf/x86: Do not read fixed counter control
 register if there is none
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Tesarik" <ptesarik@suse.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717150315.2868314-1-ptesarik@suse.com>
References: <20260717150315.2868314-1-ptesarik@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 15:18:58 +0000
Message-Id: <20260717151858.8ED701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Using `x86_pmu.fixedctr` as a capability flag is conceptually fl=
awed and suppresses valid debug output on Zhaoxin.

Pre-existing issues:
- [High] Zhaoxin PMU fails to initialize `x86_pmu.fixedctr`, leading to bro=
ken fixed counters and unsafe RDMSR accesses.
- [High] Undefined behavior in `GENMASK_ULL` during Zhaoxin PMU initializat=
ion if fixed counters are missing.
--

--- Patch [1]: [PATCH 1/1] perf/x86: Do not read fixed counter control regi=
ster if there is none ---
commit d0dd53a6709a65141e2d105b19abad4d851825d4
Author: Petr Tesarik <ptesarik@suse.com>

perf/x86: Do not read fixed counter control register if there is none

This patch skips reading the MSR_ARCH_PERFMON_FIXED_CTR_CTRL register
during perf debug output if fixed counters are not implemented. This avoids
a #GP on AMD CPUs with PerfMonV2 that do not implement this register.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 576baa9a52c5b..3055d59e0e82f 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1572,13 +1572,16 @@ void perf_event_print_debug(void)
>  		rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
>  		rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
>  		rdmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, overflow);
> -		rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
> =20
>  		pr_info("\n");
>  		pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
>  		pr_info("CPU#%d: status:     %016llx\n", cpu, status);
>  		pr_info("CPU#%d: overflow:   %016llx\n", cpu, overflow);
> -		pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
> +
> +		if (x86_pmu.fixedctr) {

[Severity: Medium]
Is it safe to use x86_pmu.fixedctr as a capability flag here?

The x86_pmu.fixedctr field is an MSR address, not a boolean capability
flag. While this check works for most architectures, the Zhaoxin PMU driver
fails to initialize this field, leaving it as 0. Because of this, the check
evaluates to false and inadvertently suppresses the debug output of
MSR_ARCH_PERFMON_FIXED_CTR_CTRL on Zhaoxin systems.

> +			rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
> +			pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
> +		}
>  		if (pebs_constraints) {
>  			rdmsrq(MSR_IA32_PEBS_ENABLE, pebs);
>  			pr_info("CPU#%d: pebs:       %016llx\n", cpu, pebs);
[ ... ]


[Severity: High]
This is a pre-existing issue and was not introduced by the patch under
review, but the lack of initialization for x86_pmu.fixedctr causes other
issues.

In the Zhaoxin PMU driver setup:

arch/x86/events/zhaoxin/core.c:zhaoxin_pmu
static const struct x86_pmu zhaoxin_pmu __initconst =3D {
    ...
    /* missing .fixedctr =3D MSR_ARCH_PERFMON_FIXED_CTR0 */
};

Because this remains 0, x86_pmu_fixed_ctr_addr() returns 0 + idx instead of
the correct MSR. This causes fixed counter 0 to silently return without
updating in x86_perf_event_update():

arch/x86/events/core.c:x86_perf_event_update() {
    ...
    if (unlikely(!hwc->event_base))
        return 0;
    ...
}

It also leads to unsafe MSR reads when iterating over the fixed counter
mask in perf_event_print_debug():

arch/x86/events/core.c:perf_event_print_debug() {
    ...
    for_each_set_bit(idx, fixed_cntr_mask, X86_PMC_IDX_MAX) {
        ...
        rdmsrq(x86_pmu_fixed_ctr_addr(idx), pmc_count);
        ...
    }
}

Could this lead to reads from arbitrary low MSRs like MSR 0, 1, or 2,
potentially triggering a system crash if a user programs fixed counter
events or triggers SysRq-P?


[Severity: High]
This is a pre-existing issue and was not introduced by the patch under
review, but does this bitmask generation in the Zhaoxin PMU initialization
risk undefined behavior?

arch/x86/events/zhaoxin/core.c:zhaoxin_pmu_init() {
    ...
    x86_pmu.fixed_cntr_mask64 =3D GENMASK_ULL(edx.split.num_counters_fixed =
- 1, 0);
    ...
}

If a hypervisor configures the CPU to report 0 fixed counters,
edx.split.num_counters_fixed - 1 wraps to -1. Expanding GENMASK_ULL(-1, 0)
results in a right-shift by 64, which is undefined behavior in C. On x86,
this yields ~0ULL, making the kernel assume 64 fixed counters exist.

Could this cause the kernel to attempt reading 64 undefined MSRs during
debug output or event initialization, leading to #GP exceptions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717150315.2868=
314-1-ptesarik@suse.com?part=3D1
