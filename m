Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250198;
	b=HYI37Rse8k+xARjKwPLMVagghGw+kPvtisU5A/EIFfLQ7naXCiXbiopJ0QydRw5zAkc8
	 fn7VALb9hwYPdAeghEB16uQbIVR5AYUSM43YfufMLqs/FErTwQl4uOWYNPPhFF07HgrTG
	 FRIbb1wGWkKSm9vexX9Y7H2skW2ZICfhfOogMhoahsLUFzlXWKGqY4cgQlZRqaRy7cBXM
	 cheEj/BMbq5hsmAds0NjaESmG5Hc3p1nDubrFx3zU0TJnDsQTo/urrgt/JD63moARXCp2
	 gNqEbdcbJ5El5tp4Q8rLGOkFjoc1zCjypwm7aWRfFEW4ppEwy3bYwXqPCJ4OLRZiBtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250198;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZgkpuPqjAZW/pcOMxCz0A45RFH9JdYkezI6qYl5POvE=;
	b=OJ+XdQAjagOH6iwpuXM5qyAijab38HdbfhJijV5v3kxySwrZhS7H4ko+OaLJ2+RKmWMs
	 jR0k8psvEKfdtL+KFU4TdTNcd6Z0iK3UUntJ87QU8VtOxVeqVWjlTwqTpDjHkej56KQ1x
	 3b9MyEcBRJmvnhiR1nznuryaG8OBKnQMIJcsN7Fuc6C9y4evXtvFrVifuw19BjmkU8b/i
	 RVHK+tsIi1UUfonkOg5mwt6cq1MGEEBfmm8YpyA4m61SjC/KelusZdbmTydI6m6uBss2i
	 vG0MRSkHHHl7PwS0kgiCII+Dx6rDbSqacNA5Q0E28aFuAHhOqImEpKZBspTGU/SLO3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oevPdWJj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50140606A31C;
	Thu, 29 Oct 2026 05:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oevPdWJj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF0C1F01825;
	Thu, 29 Oct 2026 05:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793250197;
	bh=ZgkpuPqjAZW/pcOMxCz0A45RFH9JdYkezI6qYl5POvE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oevPdWJjZhMEfMRfsPUdLzaOJvmuDhhIAFq2SWrgSU9baww19nkankuMJaQvrOJND
	 K7JqMKJoHoAeZbfEPL/etACQubg0WoTtHnYF/vGw3iznRflthZOdBXQF4JUOA5541Q
	 ckLfnLzBBdH8dIl3+yrocLcg3vYrR94sGMGQRja8n694FJ8oNp61zR2XHqKwN2+rIW
	 2AUq3syvmZca8g2tp3Bs/edG1bEIEwJ0pnqZ/Xije9aRyo+mZRVrrSvFOo91NmOxXv
	 IF056LYdbuBUwuu9ukxdxF0Jbm7Xu6gHSbexgijnKinFSsLJljqIMCNng6frbU7cXl
	 gvY4zgPqP6GFw==
Message-ID: <sashiko-outbox-188726@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v5 01/18] perf/x86: Disable LBR if x86_pmu.lbr_nr
 exceeds MAX_LBR_ENTRIES
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261029043914.1395147-2-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:03:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf/x86/intel: incomplete Arch LBR disablement in intel_pmu_ini=
t()
- [Medium] perf/x86/amd: amd_pmu_lbr_init() returns 0 when LBR is disabled
--

commit 03c28823478ca7f089145cd93c93be2824eab310
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Disable LBR if x86_pmu.lbr_nr exceeds MAX_LBR_ENTRIES

This commit adds a sanity check on x86_pmu.lbr_nr during AMD and Intel PMU
initialization to disable LBR if the hardware reports more entries than
MAX_LBR_ENTRIES.

> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index a55646fcb8465..96c5b5e56053b 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -433,7 +433,13 @@ __init int amd_pmu_lbr_init(void)
>  	ebx.full =3D cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
>  	x86_pmu.lbr_nr =3D ebx.split.lbr_v2_stack_sz;
> =20
> -	pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
> +	if (x86_pmu.lbr_nr > MAX_LBR_ENTRIES) {
> +		pr_warn("LBR entries %d exceeds max %d, disable LBR.\n",
> +			x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
> +		x86_pmu.lbr_nr =3D 0;
> +	} else {
> +		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
> +	}
> =20
>  	return 0;
>  }

[Severity: Medium]
Should amd_pmu_lbr_init() return an error code such as -EOPNOTSUPP when
x86_pmu.lbr_nr exceeds MAX_LBR_ENTRIES?

Because amd_pmu_lbr_init() still returns 0 after setting x86_pmu.lbr_nr =3D=
 0,
its caller in arch/x86/events/amd/core.c treats LBR initialization as
successful and installs the LBR callbacks:

arch/x86/events/amd/core.c:amd_core_pmu_init() {
	...
	/* LBR and BRS are mutually exclusive features */
	if (!amd_pmu_lbr_init()) {
		/* LBR requires flushing on context switch */
		x86_pmu.sched_task =3D amd_pmu_lbr_sched_task;
		static_call_update(amd_pmu_branch_hw_config, amd_pmu_lbr_hw_config);
		static_call_update(amd_pmu_branch_reset, amd_pmu_lbr_reset);
		static_call_update(amd_pmu_branch_add, amd_pmu_lbr_add);
		static_call_update(amd_pmu_branch_del, amd_pmu_lbr_del);

		/* Only support branch_stack snapshot on perfmon v2 */
		if (x86_pmu.handle_irq =3D=3D amd_pmu_v2_handle_irq)
			static_call_update(perf_snapshot_branch_stack, amd_pmu_v2_snapshot_branc=
h_stack);
	}
	...
}

If perf_snapshot_branch_stack is later invoked (for example via
bpf_get_branch_snapshot()), amd_pmu_v2_snapshot_branch_stack() runs without
checking x86_pmu.lbr_nr and touches MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
MSR_AMD_DBG_EXTN_CFG, and MSR_IA32_DEBUGCTLMSR:

arch/x86/events/amd/core.c:amd_pmu_v2_snapshot_branch_stack() {
	...
	local_irq_save(flags);
	amd_pmu_core_disable_all();
	__amd_pmu_lbr_disable();

	cpuc =3D this_cpu_ptr(&cpu_hw_events);

	amd_pmu_lbr_read();
	cnt =3D min(cnt, x86_pmu.lbr_nr);
	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);

	amd_pmu_v2_enable_all(0);
	local_irq_restore(flags);
	...
}

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 0a34d674df590..10c694db85ea3 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -9023,6 +9023,13 @@ __init int intel_pmu_init(void)
>  	 */
>  	if (x86_pmu.lbr_tos && !check_msr(x86_pmu.lbr_tos, 0x3UL))
>  		x86_pmu.lbr_nr =3D 0;
> +
> +	if (x86_pmu.lbr_nr > MAX_LBR_ENTRIES) {
> +		pr_warn("LBR entries %d exceeds max %d, disable LBR.\n",
> +			x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
> +		x86_pmu.lbr_nr =3D 0;
> +	}

[Severity: Medium]
When X86_FEATURE_ARCH_LBR is enabled and CPUID leaf 28 enumerates a depth
greater than MAX_LBR_ENTRIES, does zeroing x86_pmu.lbr_nr here leave
Architectural LBR partially initialized and leak x86_pmu.task_ctx_cache and
per-CPU cpuc->lbr_xsave buffers?

In intel_pmu_init(), intel_pmu_arch_lbr_init() and
intel_pmu_check_event_constraints_all() are called before this check:

arch/x86/events/intel/core.c:intel_pmu_init() {
	...
	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
		intel_pmu_arch_lbr_init();

	intel_pmu_check_event_constraints_all(NULL);
	...
}

Inside arch/x86/events/intel/lbr.c:intel_pmu_arch_lbr_init(), lbr_nr is
computed as fls(eax.split.lbr_depth_mask) * 8. Because it does not bail out=
 to
clear_arch_lbr when lbr_nr > MAX_LBR_ENTRIES, it already:

- writes lbr_nr to MSR_ARCH_LBR_DEPTH
- allocates x86_pmu.task_ctx_cache
- enables the x86_lbr_mispred, x86_lbr_cycles, and x86_lbr_type static
  branches
- sets x86_pmu.lbr_ctl_map (which keeps x86_pmu_has_lbr_callstack() true)
- sets PMU_FL_BR_CNTR and PMU_FL_DYN_CONSTRAINT in x86_pmu.flags
- leaves X86_FEATURE_ARCH_LBR set

As a result, when any hardware perf event is later opened,
reserve_lbr_buffers() still allocates cpuc->lbr_xsave across all possible C=
PUs
from task_ctx_cache:

arch/x86/events/intel/lbr.c:reserve_lbr_buffers() {
	...
	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR))
		return;

	for_each_possible_cpu(cpu) {
		cpuc =3D per_cpu_ptr(&cpu_hw_events, cpu);
		kmem_cache =3D x86_get_pmu(cpu)->task_ctx_cache;
		if (!kmem_cache || cpuc->lbr_xsave)
			continue;

		cpuc->lbr_xsave =3D kmem_cache_alloc_node(kmem_cache,
							GFP_KERNEL | __GFP_ZERO,
							cpu_to_node(cpu));
	}
}

In addition, lbr_is_visible() in arch/x86/events/intel/core.c still exposes
branch_counter_nr and branch_counter_width in sysfs because PMU_FL_BR_CNTR
remains set, and attach_perf_ctx_data() can still allocate task->perf_ctx_d=
ata
for events with PERF_SAMPLE_READ and PERF_SAMPLE_BRANCH_CALL_STACK.

Should intel_pmu_arch_lbr_init() check lbr_nr > MAX_LBR_ENTRIES before writ=
ing
MSR_ARCH_LBR_DEPTH and jump to clear_arch_lbr so X86_FEATURE_ARCH_LBR is
cleared cleanly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029043914.1395=
147-1-dapeng1.mi@linux.intel.com?part=3D1
