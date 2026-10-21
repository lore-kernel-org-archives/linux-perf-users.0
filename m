Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561367;
	b=T8aE3c9t+szfkYVyKdGyoLteYapXHy2T6lxLwpohQRYlFi8TLhgopu4jNZV21/NkXI8V
	 fH4Ud1n2ymz/qp/ZDVRFv6OvOTvIafCC+gvDKY4qClGyIrh/kGGuMpFlFSlaG2Kd71cdd
	 nrQKvP1JNZQsG9ybB3QhmSBMeAP9q7GL/FwPu+/C0z1Rq37PiOf+kOy5uZDnZ9jCsSRo5
	 vnds3gAlexAigPcc55O4UDXr4edvBfEJmaL/tXkEdC0gNXIztJkc03FOistpqdc6UVsAn
	 /JHolyEgun1Sj2kUbMhITr8iOLTUb7EXN4uzt2+oLkkQszc7WLFeuqoKktHCHdxSwvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561367;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZHxZCtkGBIHHZ3WxoYYt7JtY8VjyuJK1miMgGbSw6mQ=;
	b=LxJkU3/JiXzySpODhu2+chcq/RbuwsF2COAfNN7/V+P13fYb/bjPquObash/j42EQLNq
	 WrDSUcDaEgXAuzxcXYyA1OXIz5bDQrRhJoFudLDWCjEkBPjhBqTz5qgAVYQJvnAJGVTgM
	 WrfZSY6Naf5eeDtp35qIl3G2uJwU0g9o9wv+TREbQ0pGlMC/61b/m6d4AC0DyqxM9y///
	 YwNi4WPahmuC5idV04QkQVJgdLz6IrFIHB3DLP+sy3PsdyRXhIOSxJwjgOY2OovO1W+tf
	 KyOtn2MzrfS4b5quQgz86+JDN3QUmW7n0AvVOIPc5TeuKhJEjftmyW3IbJlJvI7bBUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kViUn5FW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0AD606A319;
	Wed, 21 Oct 2026 05:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kViUn5FW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BA51F000C9;
	Wed, 21 Oct 2026 05:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792561366;
	bh=ZHxZCtkGBIHHZ3WxoYYt7JtY8VjyuJK1miMgGbSw6mQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kViUn5FWPfLv8eVi1je6k+h0kmNq1ISUyD3sVwX6t2tuM20CL32sGuWAFif+nR5Hw
	 ck7nNoyRiJJM5Q86jP++o25xUzI8L7gIfLoZkCWIpIWMiopysOu9dQyHmqcq0+WE0n
	 h3Yr3Ao4l61GqpUDBXDFcQRx1yXYPSNDPDAEJ5Q3bvxdupqxs33PbO8ktDG7L+oMM+
	 KgKukxg3BLqvrmYW04Hd+t7lBR+X9NmcDGGnjLsbFZ1T6q4Rh6zQrdhtMrN1Wg+Hqi
	 BkIzndZqLQgMS2o8h8Hx81Hq7DxM+dZkqDBEaLshl9bl9ZDgug4trdrFbcoZPjCXEB
	 lud7Z/3GfbG6w==
Message-ID: <sashiko-outbox-179814@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v4 1/5] perf/x86: Disable LBR if x86_pmu.lbr_nr exceeds
 MAX_LBR_ENTRIES
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261021050711.4043703-2-dapeng1.mi@linux.intel.com>
References: <20261021050711.4043703-1-dapeng1.mi@linux.intel.com>
 <20261021050711.4043703-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 05:42:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf/x86: init_hw_perf_events() disables LBR too late after vend=
or PMU init
--

commit c6c1bbb1f4feb929dd247ddd507177ce58d871e1
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Disable LBR if x86_pmu.lbr_nr exceeds MAX_LBR_ENTRIES

This commit disables last branch record support in init_hw_perf_events()
if x86_pmu.lbr_nr exceeds MAX_LBR_ENTRIES to prevent out-of-bounds
accesses in the cached branch stack handling path.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 4df792b139e05..002a04c149c29 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2645,6 +2645,12 @@ static int __init init_hw_perf_events(void)
>  	if (!x86_pmu.config_mask)
>  		x86_pmu.config_mask =3D X86_RAW_EVENT_MASK;
> =20
> +	if (x86_pmu.lbr_nr > MAX_LBR_ENTRIES) {
> +		pr_warn("LBR entries %d exceeds max %d, disable LBR.\n",
> +			x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
> +		x86_pmu.lbr_nr =3D 0;
> +	}
> +
>  	perf_events_lapic_init();
>  	register_nmi_handler(NMI_LOCAL, perf_event_nmi_handler, 0, "PMI");

[Severity: Medium]
Does zeroing x86_pmu.lbr_nr here in init_hw_perf_events() happen too late,
after intel_pmu_init() and amd_pmu_init() have already configured hardware
and driver state using the unvalidated x86_pmu.lbr_nr value?

In arch/x86/events/intel/lbr.c:intel_pmu_arch_lbr_init(), if lbr_nr exceeds
MAX_LBR_ENTRIES, initialization proceeds instead of taking the clear_arch_l=
br
path:

	lbr_nr =3D fls(eax.split.lbr_depth_mask) * 8;
	if (!lbr_nr)
		goto clear_arch_lbr;

	/* Apply the max depth of Arch LBR */
	if (wrmsrq_safe(MSR_ARCH_LBR_DEPTH, lbr_nr))
		goto clear_arch_lbr;
	...
	x86_pmu.lbr_counters =3D ecx.split.lbr_counters;
	x86_pmu.lbr_nr =3D lbr_nr;

	if (!!x86_pmu.lbr_counters)
		x86_pmu.flags |=3D PMU_FL_BR_CNTR | PMU_FL_DYN_CONSTRAINT;

Because clear_arch_lbr is skipped, X86_FEATURE_ARCH_LBR remains enabled,
MSR_ARCH_LBR_DEPTH is written, pmu->task_ctx_cache is allocated via
create_lbr_kmem_cache(), and x86_pmu.lbr_ctl_map and static branches are
configured.

Subsequently, arch/x86/events/intel/lbr.c:reserve_lbr_buffers() checks the
feature bit and task_ctx_cache rather than x86_pmu.lbr_nr:

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

Wouldn't this still allocate per-cpu cpuc->lbr_xsave buffers on hardware
reservation even after x86_pmu.lbr_nr is set to 0?

Similarly, in arch/x86/events/intel/core.c:lbr_is_visible(), leaving
PMU_FL_BR_CNTR set in x86_pmu.flags keeps branch_counter_nr and
branch_counter_width visible in sysfs when x86_pmu.lbr_nr is 0:

	/* branches */
	if (i =3D=3D 0)
		return x86_pmu.lbr_nr ? attr->mode : 0;

	return (x86_pmu.flags & PMU_FL_BR_CNTR) ? attr->mode : 0;

In addition, both arch/x86/events/intel/core.c:intel_pmu_init() and
arch/x86/events/amd/core.c:amd_core_pmu_init() check x86_pmu.lbr_nr before
init_hw_perf_events() clears it:

	if (x86_pmu.lbr_nr) {
		intel_pmu_lbr_init();

		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);

		/* only support branch_stack snapshot for perfmon >=3D v2 */
		if (x86_pmu.disable_all =3D=3D intel_pmu_disable_all) {
			if (boot_cpu_has(X86_FEATURE_ARCH_LBR)) {
				static_call_update(perf_snapshot_branch_stack,
						   intel_pmu_snapshot_arch_branch_stack);
			} else {
				static_call_update(perf_snapshot_branch_stack,
						   intel_pmu_snapshot_branch_stack);
			}
		}
	}

And in amd_core_pmu_init():

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
	} else if (!amd_brs_init()) {

If bpf_get_branch_snapshot() is later called when x86_pmu.lbr_nr is 0, won't
the registered perf_snapshot_branch_stack callback still run, manipulate
branch and global control registers, and unconditionally call
intel_pmu_enable_all(0) or amd_pmu_v2_enable_all(0)?

Should the MAX_LBR_ENTRIES check be performed before or during the
vendor-specific initialization routines (such as intel_pmu_lbr_init(),
intel_pmu_arch_lbr_init(), and amd_pmu_lbr_init()) so that None of the
hardware state, slab caches, flags, or static calls are enabled when
lbr_nr is out of range?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021050711.4043=
703-1-dapeng1.mi@linux.intel.com?part=3D1
