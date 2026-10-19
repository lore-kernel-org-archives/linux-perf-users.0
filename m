Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7448875D;
	Mon, 19 Oct 2026 07:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394913; cv=none; b=XQbklZVUERvpf7rGDoeXbUlfOhupzZyJbo3Dvy9h9RufDgut0Pj7YyD0yGtoGZgfgi1kWXnBATJhAIOI63DDyUjbK1meYirTMxCwji8SGRulmMonNtyLc4VC7D8CGhEr4DokADpHeLrYlksg0VhJQ9/Br6LGQ+mBarEFReltqzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394913; c=relaxed/simple;
	bh=wzSPSQP14nOUWnUkCLcnw6P8OJhJPhsNsdJfZpDwOQw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pI0X6dkHStbV+3VZOnw3zod0xrFt9e5Kj/pXmC8XsGixAQGNXDv+wOkvv2/Z4ME99V8/GMM7wmfDsCH7JDY204g4O25ZzIONFJt9J4rLzCb0wq/Os/jzlPD7U7UmzMEnnuCv78+HyTxKdR1SyxWdD/6yBZ6S5mkKAwa2rUXyf+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHqgcASq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHqgcASq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FAF1F000C4;
	Mon, 19 Oct 2026 07:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792394910;
	bh=KubjCLATY2mohcWYNWDi8lK41JHzEvaGAtUBAOuiA2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BHqgcASq72+5P9T0H2vFTAI+WGh6U0q/aJbm7BVC7Dja1FhcQMc0Tnw63oXT3c0CA
	 +RXnK9EGpo9NfTyCoYEfdwVLxpVlY7uFQcnv6NncllgqGDzL/jksnTDWzTaVtNizs9
	 MC+yapaRpJn9kSb0YgBSsfP/3NPnBlZcCKAEnMPn8zpi6XdT89vSw8I9dTjf6N9H2B
	 ooiBdR90r1erTlKC4E8LSG/qeioV+LdRAKoX9yBJE9IQaUddP6ZWOoKJeqlGFqDiFT
	 CPGV5Fsh2Os34neb5mxYgBSG40O/gwRKixT0MfAXjWJjwbMywJFRCbPHMazp9VWUjc
	 2TQJzIOeicRSg==
Message-ID: <sashiko-outbox-176745@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v3 1/4] perf/x86: Clamp x86_pmu.lbr_nr to
 MAX_LBR_ENTRIES
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261019070836.2972403-2-dapeng1.mi@linux.intel.com>
References: <20261019070836.2972403-1-dapeng1.mi@linux.intel.com>
 <20261019070836.2972403-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 07:28:30 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf/x86: late x86_pmu.lbr_nr clamp in init_hw_perf_events() risks=
 #GP
--

commit 7f534b76717bd0a7a33fa3404815780334bcf485
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Clamp x86_pmu.lbr_nr to MAX_LBR_ENTRIES

This commit clamps x86_pmu.lbr_nr to MAX_LBR_ENTRIES in
init_hw_perf_events() to prevent out-of-bounds accesses to the cached
LBR stack.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 4df792b139e05..82f6b66db7e2f 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2645,6 +2645,8 @@ static int __init init_hw_perf_events(void)
>  	if (!x86_pmu.config_mask)
>  		x86_pmu.config_mask =3D X86_RAW_EVENT_MASK;
> =20
> +	x86_pmu.lbr_nr =3D min(x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
> +
>  	perf_events_lapic_init();
>  	register_nmi_handler(NMI_LOCAL, perf_event_nmi_handler, 0, "PMI");

[Severity: High]
Does clamping x86_pmu.lbr_nr after intel_pmu_init() and amd_pmu_init()
return risk an unhandled #GP in intel_pmu_arch_lbr_reset() and leave
the vendor PMU initialization inconsistent with the clamped depth?

For Intel Architectural LBR, supported depths are enumerated as a bitmask
in eax.split.lbr_depth_mask (where each bit indicates support for a
multiple of 8 up to 64). During init_hw_perf_events() -> intel_pmu_init()
-> intel_pmu_arch_lbr_init(), the code selects the highest supported bit
and validates that unclamped depth against MSR_ARCH_LBR_DEPTH:

arch/x86/events/intel/lbr.c:intel_pmu_arch_lbr_init() {
	...
	lbr_nr =3D fls(eax.split.lbr_depth_mask) * 8;
	if (!lbr_nr)
		goto clear_arch_lbr;

	/* Apply the max depth of Arch LBR */
	if (wrmsrq_safe(MSR_ARCH_LBR_DEPTH, lbr_nr))
		goto clear_arch_lbr;
	...
}

If a CPU or hypervisor advertises a depth greater than 32 in
lbr_depth_mask without also setting the bit for depth 32, clamping
x86_pmu.lbr_nr to MAX_LBR_ENTRIES (32) here leaves x86_pmu.lbr_nr set to
an unsupported depth that was never tested with wrmsrq_safe(). When
cpuhp_setup_state() subsequently runs x86_pmu_starting_cpu() ->
intel_pmu_cpu_starting() -> intel_pmu_lbr_reset() ->
intel_pmu_arch_lbr_reset():

arch/x86/events/intel/lbr.c:intel_pmu_arch_lbr_reset() {
	/* Write to ARCH_LBR_DEPTH MSR, all LBR entries are reset to 0 */
	wrmsrq(MSR_ARCH_LBR_DEPTH, x86_pmu.lbr_nr);
}

won't this unchecked wrmsrq() of 32 to MSR_ARCH_LBR_DEPTH raise a fatal
#GP at boot?

Additionally, because this clamp runs after vendor initialization has
completed:

1. intel_pmu_arch_lbr_init() has already validated the XSAVE size via
   is_arch_lbr_xsave_available() and allocated pmu->task_ctx_cache using
   the unclamped lbr_nr.

2. intel_pmu_init() has already probed MSRs up to the unclamped
   x86_pmu.lbr_nr and logged the unclamped depth:

arch/x86/events/intel/core.c:intel_pmu_init() {
	...
	for (i =3D 0; i < x86_pmu.lbr_nr; i++) {
		if (!(check_msr(x86_pmu.lbr_from + i, 0xffffUL) &&
		      check_msr(x86_pmu.lbr_to + i, 0xffffUL)))
			x86_pmu.lbr_nr =3D 0;
	}

	if (x86_pmu.lbr_nr) {
		intel_pmu_lbr_init();

		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
	...
}

3. amd_pmu_lbr_init() has likewise already logged the unclamped depth:

arch/x86/events/amd/lbr.c:amd_pmu_lbr_init() {
	...
	x86_pmu.lbr_nr =3D ebx.split.lbr_v2_stack_sz;

	pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
	...
}

Should the MAX_LBR_ENTRIES limit be enforced at the point where
x86_pmu.lbr_nr (and lbr_depth_mask in intel_pmu_arch_lbr_init()) is
determined inside the vendor initialization paths instead?

> =20
 =EC=99=84=EB=B2=BD

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019070836.2972=
403-1-dapeng1.mi@linux.intel.com?part=3D1
