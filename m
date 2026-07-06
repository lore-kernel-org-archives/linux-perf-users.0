Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD37035B645
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 02:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783304485; cv=none; b=D3dMJ73ub6+2e9zAaw7BaL5tOQINIBZDSdA5rfQ/UaZ5vaZ7xJAfTV69r0tmoRxEQ1R00jx8BryZkoLrWVVdar/2XSoVHXgcwFtfgxSxbHyBES2nCTbmh3nPhYbLu/KCm/ANNxTaCMoF/Dv/d8j2Wesb73ammdTWYABj1fjdZZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783304485; c=relaxed/simple;
	bh=QFDn7b2YyITa/VUMuzchGQPEi/aPg8Ok6YOMr+ZSqI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cJ4a5/vZRZMaUHrPQ6BLqqze1Hpo3rs0ffZMDXI645ckc4/27J0x8t2BE11yaExcwQJ5Y0+Pkguj3YLPXZHchKcx20a7hH+YS33xXfbOmHKBJ+whp/IXZCTEx1szJM9n45gKGAvDZg/XoIUu967wc8WjfyO1eYjNz7AKAtBKEuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlkJteGw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlkJteGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480411F000E9;
	Mon,  6 Jul 2026 02:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783304483;
	bh=TtmRsTrV1OWGZcOYjWZ1MTrVRUf6f0ymPxNLRyK1wnk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hlkJteGwKX0a2nsLEA3iUFfTAMEVAl1oInicgJEglmpL5xtU3iC8Z0qhyHeH2KFi0
	 HYxyii9K5e2zBC8C7Hma1EMNb0Ypvv4Inq0Ngf2Lwg17aHKdXts0BEdzw/OYZsl4ys
	 bl3rC3SVzLG1Bxu15k1gQQRzDw8jle3XnIGqePOZjkRQGcxAUy2roI6ZJeOrrTue6q
	 OPs+sPnc0dGm4v95AcCf3whMh7/i2IJcguxxmgL3PTjCrHF8QYH+n3hp3RURX+ZiuJ
	 BCjk9XHCG5tbn6Eo7/V6fc9fPxPMQDo9cIWRrp4NliBg+Vy1KRbMwEuP/WxlVNhjFe
	 1LGWcEED6Yzjg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v9 01/24] perf/x86: Fix two error-path and hybrid PMU
 guard issues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260706015439.3040804-2-dapeng1.mi@linux.intel.com>
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:21:22 +0000
Message-Id: <20260706022123.480411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch adds a check for `x86_pmu.num_hybrid_pmus` to prevent me=
mory corruption in `intel_pmu_cpu_dead()` on error paths, but it is incompl=
ete and still allows an out-of-bounds write during CPU hotplug rollback if =
the `CPUHP_AP_PERF_X86_STARTING` state setup fails.
- [High] If `alloc_arch_pebs_buf_on_cpu()` fails in `intel_pmu_cpu_prepare(=
)`, resources allocated by `intel_cpuc_prepare()` are leaked.
- [High] Dangling `cpuc->pmu` pointer leads to Use-After-Free in `perf_even=
t_print_debug()` when hybrid PMU registration fails.
- [High] Out-of-bounds read on the global `.bss` section in `perf_event_pri=
nt_debug()` due to an invalid struct cast when `init_hw_perf_events()` fail=
s early.
- [Medium] The dynamically allocated `x86_pmu.hybrid_pmu` array is permanen=
tly leaked on multiple error paths in `init_hw_perf_events()`.
--

commit e4457672386c09fea418faeba61fc0c2418ad7e5
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Fix two error-path and hybrid PMU guard issues

Fix an NMI handler leak in init_hw_perf_events(). When PMU
initialization fails after register_nmi_handler(), the error path
exits without calling unregister_nmi_handler(), leaving a stale
NMI_LOCAL "PMI" handler registered. Add the missing call before
clearing x86_pmu state.

Also guard the hybrid PMU cpumask update in intel_pmu_cpu_dead()
with a check on x86_pmu.num_hybrid_pmus. Without this, hybrid_pmu()
may be called when the hybrid PMU array has not been allocated,
leading to an out-of-bounds access.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index af0b67ffb43d8..872d07a5fa80d 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c

[ ... ]

> @@ -2273,6 +2273,8 @@ static int __init init_hw_perf_events(void)
>  	cpuhp_remove_state(CPUHP_AP_PERF_X86_STARTING);
>  out:
>  	cpuhp_remove_state(CPUHP_PERF_X86_PREPARE);
> +pmi_unregister:
> +	unregister_nmi_handler(NMI_LOCAL, "PMI");
>  out_bad_pmu:
>  	memset(&x86_pmu, 0, sizeof(x86_pmu));

[Severity: Medium]
This isn't a bug introduced by this patch, but does this memset cause a
memory leak?

If cpuhp_setup_state() or check_hw_exists() fails during initialization,
the code jumps to the out_bad_pmu label and executes the memset without
freeing x86_pmu.hybrid_pmu. Could this permanently leak the dynamically
allocated hybrid PMU array?


[Severity: High]
This is a pre-existing issue, but could this error path lead to an
out-of-bounds read in perf_event_print_debug()?

If check_hw_exists() fails early during initialization, out_bad_pmu is
reached, but the perf_is_hybrid static key is never disabled. cpuc->pmu
defaults to the global &pmu.

If a privileged user triggers sysrq-p, perf_event_print_debug() uses
hybrid(cpuc->pmu, cntr_mask). Because is_hybrid() evaluates to true, it
casts the global &pmu to the larger struct x86_hybrid_pmu and attempts to
read cntr_mask, reading memory well beyond the object bounds in the .bss
section.


[Severity: High]
This is a pre-existing issue, but is there a use-after-free risk here if
hybrid PMU registration fails?

If perf_pmu_register() fails for a hybrid PMU inside init_hw_perf_events(),
the x86_pmu.hybrid_pmu array is freed via kfree. However, cpuc->pmu was
already assigned to elements of this array during intel_pmu_cpu_starting().

Since the teardown callbacks do not clear the cpuc->pmu pointers, they
remain dangling. A privileged user triggering sysrq-p will invoke
perf_event_print_debug(), which dereferences cpuc->pmu, potentially causing
a use-after-free.

>  	return err;
>  }

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index b39c6ce0efb5c..b8a6382dbb825 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c

[ ... ]

> @@ -6479,7 +6479,7 @@ static void intel_pmu_cpu_dead(int cpu)
>  	release_arch_pebs_buf_on_cpu(cpu);
>  	intel_cpuc_finish(cpuc);
> =20
> -	if (is_hybrid() && cpuc->pmu)
> +	if (is_hybrid() && x86_pmu.num_hybrid_pmus && cpuc->pmu)

[Severity: High]
This is a pre-existing issue, but does this incomplete guard still allow an
out-of-bounds write during CPU hotplug rollback?

If CPUHP_AP_PERF_X86_STARTING hotplug setup fails, it rolls back the already
successful CPUHP_PERF_X86_PREPARE state by invoking intel_pmu_cpu_dead().

Because cpuc->pmu defaults to the statically allocated &pmu, the condition
evaluates to true. hybrid_pmu() casts the global pmu to the much larger
struct x86_hybrid_pmu, which could result in an out-of-bounds write when
modifying supported_cpus.

>  		cpumask_clear_cpu(cpu, &hybrid_pmu(cpuc->pmu)->supported_cpus);
>  }


[Severity: High]
This is a pre-existing issue, but can intel_pmu_cpu_prepare() leak memory
allocated by intel_cpuc_prepare() if alloc_arch_pebs_buf_on_cpu() fails?

When the CPU hotplug core attempts to online a CPU, it runs the prepare
callback. If alloc_arch_pebs_buf_on_cpu() fails, the state transitions are
aborted without calling the teardown callback intel_pmu_cpu_dead() for this
specific CPU.

Under memory pressure, could repeated CPU hotplug operations leak the
cpuc->shared_regs, cpuc->constraint_list, and cpuc->excl_cntrs structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706015439.3040=
804-1-dapeng1.mi@linux.intel.com?part=3D1
