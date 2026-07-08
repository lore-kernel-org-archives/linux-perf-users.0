Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A35342E8E6
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507554; cv=none; b=Tr8jI2wCDbgfZwlQQhpmuZ03QcaXoNZtX9hEOsDR/eov3td8Wat1N+1PM4SpOag4/SqMOd7GltMaxGEFm1q5JTiHWZQMK0dCY/fZL4GTnIkD2eG0bfXF0LFNVZC6KFKKtvpR3CeF/LhZFxfYoJoZ+wcS8DnB6RdQTxkmyn/rMfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507554; c=relaxed/simple;
	bh=ym3bOenHEXPv6FMBWCpZ2VV6vTt0AU148RCY6Fw/FtQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CquZF8QWMwQRN5h7MNshFrZQIzIYuHw8LenGOgfr6JbhfcrIH3oVp2/tUqP2yY5FJcmuXuE51s9+GHVzkZIlKrbMIrggDL2DNAcFRkyhsnDPTP1UDnn+jLxN6NcM+N/TYD6Z3eOhPT/qd7LGIjPL+eDcADy0KgnFKSJ8QaViQSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbU8eqvC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbU8eqvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BAC1F000E9;
	Wed,  8 Jul 2026 10:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783507543;
	bh=sfN4CcU8h/eoF/SyqV24545njCPMEgzuAna4RFbBZ4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KbU8eqvCL9NIVl5NvMJ4QI4HLhmzJVkIDD6Bvmv/gb47Kldp96FdTdAJ1zHyuSnGQ
	 R6NCCYhaYfUt8x0tj68PDTe8WT1CLvPiKpXrwjINatfNpvWT2jGiDINa+Wa64PyKcc
	 02pXupPAnW+X5IgPUuqMCNexUS5oG90xWRpxXJdple1M0YWdxhRCq12rceMwDWSJzF
	 90QUTJ58PRCFZveGKqbSnTFTBnrH8KQs/xddO0VkUpCS8o6BhGfOVv5EJoWoR7vWUg
	 M+wvgWdNgQb/YYrYEFnIIlx5luJiDxFAvhwVDmBKcwqVNhMi8zVTw9RNANDVcLifjQ
	 gWLmiBf+7prUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/amd/core: Avoid enabling BRS from the SVM
 reload path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <702fa204d574b03d14e3664c7d4b201db048bbfd.1783506528.git.sandipan.das@amd.com>
References: <702fa204d574b03d14e3664c7d4b201db048bbfd.1783506528.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 10:45:42 +0000
Message-Id: <20260708104543.18BAC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] An NMI race condition during PMU reprogramming can lead to an NMI =
storm (Denial of Service) by erroneously re-enabling a throttled PMU event.
--

--- Patch [1]: [PATCH] perf/x86/amd/core: Avoid enabling BRS from the SVM r=
eload path ---
commit d7d24046acc25b0323b31722e9413ffccd9d4f43
Author: Sandipan Das <sandipan.das@amd.com>

perf/x86/amd/core: Avoid enabling BRS from the SVM reload path

This commit fixes a general protection fault (#GP) during an SVM toggle on
processors that support LBR but not BRS. It separates the reprogramming of
event selectors from the BRS enablement to avoid writing to the deprecated
DebugExtnCfg MSR.

> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
[ ... ]
> @@ -752,13 +752,11 @@ static void amd_pmu_enable_event(struct perf_event =
*event)
>  	x86_pmu_enable_event(event);
>  }
> =20
> -static void amd_pmu_enable_all(int added)
> +static void __amd_pmu_enable_all(void)
>  {
>  	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
>  	int idx;
> =20
> -	amd_brs_enable_all();
> -
>  	for_each_set_bit(idx, x86_pmu.cntr_mask, X86_PMC_IDX_MAX) {
>  		/* only activate events which are marked as active */
>  		if (!test_bit(idx, cpuc->active_mask))
> @@ -773,6 +771,12 @@ static void amd_pmu_enable_all(int added)
>  	}
>  }

[Severity: High]
This isn't a bug introduced by this patch, but I have a question about a
pre-existing issue in the __amd_pmu_enable_all() event iteration loop in
arch/x86/events/amd/core.c.

The loop checks test_bit(idx, cpuc->active_mask), and then subsequently cal=
ls
amd_pmu_enable_event(cpuc->events[idx]).

Could an NMI strike between evaluating the active_mask and actually enabling
the event?

CPU0 in __amd_pmu_enable_all():
   if (!test_bit(idx, cpuc->active_mask))=20
       // evaluates to false, event is active, execution is interrupted

NMI fires:
x86_pmu_handle_irq()
   // event overflows and is throttled
   x86_pmu_stop()
       clear_bit(idx, cpuc->active_mask)
       hwc->state |=3D PERF_HES_STOPPED
   // cpuc->events[idx] is NOT set to NULL here

CPU0 resumes:
   if (cpuc->events[idx])
       amd_pmu_enable_event(cpuc->events[idx]);

Would this result in the hardware re-arming a throttled event? On the next
overflow, an NMI would be generated. However, because the event is no longer
in active_mask, would the NMI handler ignore it, failing to clear the
overflow status?

Could this uncleared overflow trigger an unrecoverable NMI storm and lock up
the CPU, especially since an unprivileged user might be able to reach this
path by profiling a KVM guest during an SVM reload?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/702fa204d574b03d14e=
3664c7d4b201db048bbfd.1783506528.git.sandipan.das@amd.com?part=3D1
