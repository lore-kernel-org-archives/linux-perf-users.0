Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBD536655A
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 23:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773099468; cv=pass; b=r/xW7ydt/TrNXFqo7PWNZyHyVjDQAFcPpRU51wgoccj7C6xR2TIZIabBAGgVF6s8E4vNrSOpf1djMrhCPZFtJM0p3ewp/WF/gx9RpjoBr2Pfs875auY6T6WC/Q+r4DdINKa/NOp4ugD4AzHWOk+x5SiMEt9RCHyi66r7/YIf3wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773099468; c=relaxed/simple;
	bh=SXrW8pzMM80n3NBlZnw3c8N70cM3xASBRUQOi8HUUc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQi5VK1gt9JgFrC3ytGOz34pmwbecnaYi5ImBTWDtXFs0XkG+Qk2T0IujD+gkuhY+iFgh95OKghyD5G/tbNh3ZbCcnomaL1o1Gu6xVP+xi6CY/+N0lPpl2Yftwm0grsKrOkwyNtcwvhVXerroKncMPf1M1G1voVoxPMv11cKxpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m6crVE1+; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6crVE1+"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae3f822163so37175ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 16:37:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773099466; cv=none;
        d=google.com; s=arc-20240605;
        b=F6R9q/6p5/zZAj1Wf40DRAD4OALxeHzRDk0oBqFMqY41P2avqzOBaQmQBdeYCaQwZa
         MoBwgaVUql6Au4GXgSXaXTyp2rAkauzcKrd4xWM7saPXlcrZ/I0QLuuHPYJhs717x9ra
         a1fm2EcGU16z3hyZjg2X9R0emt07pchhGD92YJ89BJuMH4q+woRShoU9xmX9+w2d4WuL
         D7Px+l0Ptl2X8Ut2DMBHZBpZzWy13tgsksq//FueyX4wKKVUM+2RvbALXoEA8vTaHZHk
         wYHbmz8GPPHQkBCtIjbOfYgrOGiYLVoMWZo66skofU+AbZenBXbIQGeA0LAWaXkF42Hy
         IP2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X9FuYZtseXZj9s2BtuBpTmFTulfhnD70/PZNneQF7vA=;
        fh=PHQ2SJU6ZcRYYc4PxYhjieUx0pSNPmjhyyX5AyOLM8Q=;
        b=NsR9LBYYSGHyGI+f0gp2VrpdSybmltnremEUUm4nxqWGoGwQl60ulp2NdXyRQYIFgO
         6yY2WZqOlR3ARFGsk81/Rx/1kx7jPD083ggkBI7PX6WALAJXcnFyRX05HSIu9RENuuyt
         Jk60tU2krF+6jdv5DdpKUia1/q/IKzCodsQ0C6sNK/izzd7ZCiyJaCH2S4IN/DcDJqw5
         sbdlwC9KpK1d3jpjnV6JStosm52I4+lmMi+8442/MOrK+9hv6knxo+m3HZCet5uqjcc+
         SFGCNafWL7trxPjEyZg2xD03hI2YnYrXHBacSDXH44dDnoeqy2+cqNC59q3dBPbv9/zV
         NQgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773099466; x=1773704266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9FuYZtseXZj9s2BtuBpTmFTulfhnD70/PZNneQF7vA=;
        b=m6crVE1+KxqQDRf7TTXEpoYlK7xThyWFU2HEnvDz/8z0SeZTWezwwtMaWcpQgDMJ9V
         buk8AXSyQIPx/qLm44yUebXJT6/kdJFSrFnNiMC8YAYFK9+JnqCRPjakqS/GUzE/bToL
         Ll++dfIv44yeqwWPu5qjPmmpFNFi2Gz163Md55piV9L4pKO0sA7gqXyWQ55yyj3+dRNi
         +NP9EfMXwf17Q9pL3YyqT58qIvSv5678JgTLF3xz+viLP0Fm5kkXvx9LV90dUOpSXixr
         i7YpAf2dcM0VmE3IV2n/F3dOeFYhtGZwa9HC7BcvDhBcc4LBwzwhaBy8UBrixGgh4Rse
         dP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773099466; x=1773704266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X9FuYZtseXZj9s2BtuBpTmFTulfhnD70/PZNneQF7vA=;
        b=eqRGLEp6l+kbHgLtU4qI6BPInBctd6gB0IduTEUg8+D3MCmA+mpXr/VKnkzihRC6Vs
         4/WX8tBNLjRc9rjUrWQxPpr2Qi/aU++kmUwrlr8A+24EJCXo/3cJu5AvnLiYsIX2S7GR
         chGWfQJfOdOBReTO3ZjK+XX7gNcMx5J34HG7/Q5ImNbGxNw9an47hqnF1mT+tn3j1XJQ
         Qz2bdXVxJ43I9I7gq5CarXgzk6HxRpn3Vps9lAUmzurEKs7mNl4tjhCsJMwPyfdjl+Fl
         3PNUakv3wuN5rpM5rnIpIxXnzE9ktvw/LZ6h7ntI0I2QPr19ilTIhCz51UctWSUWAcNW
         YHPg==
X-Forwarded-Encrypted: i=1; AJvYcCX+1eiTUvIt7Sxs2Jr+qIQ7/eorLVlzAiAEusZMpyGJlZjrfyqoNFcTdyK5g73WV7c3xGxvvE/dxfTwh3PjGzyK@vger.kernel.org
X-Gm-Message-State: AOJu0YwLY2zTri11iDbAz3dR2rq27X2+7/+WdbZyCjJDbMRzRAaDMs8K
	Dn4M9HGE4b85td8YQ6Pov3yZ7ZfTtwtxlkH020bCyRX7+CMEmHykAzFA689I/ybl6Y0TT166X/r
	vwFue9zdIG142Q926ae18SwU9gJedKt+x/lmOkqLF
X-Gm-Gg: ATEYQzwgVXXWLjotFoljVhqkNM+coAZoNxNba2SgpYPpY24TaFXb5cV2OZQEX5bX/ms
	Mvvs+7PrlLic3fozVrLq0UuA+OalLf1IZtTuLhbh9BdM4dFc2NtnIue8I5bgQMXnd0Indt0IyKJ
	Or/OBTRCKu71qqvcLtBJidhO6UODd1lRh3yfT+anPFYWJxBtvTrP/woBDRrIJjQP1o5d1O7poam
	QB75x6dWXvQl6Hqp1QvuyC3aX7wWrYVhjZ3y0ubv8DzDVR9zLmQleLxlfyHQF3tEH2wkOVy5E+u
	qI9WovIKj6nDi1dlifgI2OX5JJE1iYku8W4=
X-Received: by 2002:a17:903:19ce:b0:2aa:d604:62f3 with SMTP id
 d9443c01a7336-2aea3025c94mr1289245ad.10.1773099465895; Mon, 09 Mar 2026
 16:37:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aS1x278mfIu6gIcd@gmail.com>
In-Reply-To: <aS1x278mfIu6gIcd@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 16:37:34 -0700
X-Gm-Features: AaiRm5122r5-kl17iH-uIBLqDg-DH93eia8zrLvRx1j5vDwOf4im6YFA5vdeR_Y
Message-ID: <CAP-5=fUtWC6bP6Jc1ZciAJ_+xarxzet55vpgCEVgrGs6CGfEww@mail.gmail.com>
Subject: Re: [GIT PULL] Performance events changes for v6.19
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 2:47=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
>
> Linus,
>
> Please pull the latest perf/core Git tree from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-20=
25-12-01
>
>    # HEAD: 9929dffce5ed7e2988e0274f4db98035508b16d9 perf/x86/intel: Fix a=
nd clean up intel_pmu_drain_arch_pebs() type use
>
> Performance events changes for v6.19:
>
> Callchain support:
>
>  - Add support for deferred user-space stack unwinding for
>    perf, enabled on x86. (Peter Zijlstra, Steven Rostedt)
>
>  - unwind_user/x86: Enable frame pointer unwinding on x86
>    (Josh Poimboeuf)
>
> x86 PMU support and infrastructure:
>
>  - x86/insn: Simplify for_each_insn_prefix() (Peter Zijlstra)
>
>  - x86/insn,uprobes,alternative: Unify insn_is_nop()
>    (Peter Zijlstra)
>
> Intel PMU driver:
>
>  - Large series to prepare for and implement architectural PEBS
>    support for Intel platforms such as Clearwater Forest (CWF)
>    and Panther Lake (PTL). (Dapeng Mi, Kan Liang)
>
>  - Check dynamic constraints (Kan Liang)
>
>  - Optimize PEBS extended config (Peter Zijlstra)

I'm not seeing this patch on the mailing list, so I'm asking here. An
AI review flagged this change and the condition it describes sounds
unlikely but possible:

> @@ -8171,8 +8169,13 @@
>  if (!is_hybrid() && boot_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
>  update_pmu_cap(NULL);
>
> - if (x86_pmu.arch_pebs)
> + if (x86_pmu.arch_pebs) {
> + static_call_update(intel_pmu_disable_event_ext,
> +    intel_pmu_disable_event_ext);
> + static_call_update(intel_pmu_enable_event_ext,
> +    intel_pmu_enable_event_ext);
>  pr_cont("Architectural PEBS, ");
> + }
>
>  intel_pmu_check_counters_mask(&x86_pmu.cntr_mask64,
>        &x86_pmu.fixed_cntr_mask64,

Does this code expose us to a #GP on hybrid platforms if the CPUID check
fails? For hybrid processors, update_pmu_cap() is deferred to
init_hybrid_pmu(), which runs after intel_pmu_init() sets up the static
calls. If update_pmu_cap() encounters an inconsistent CPUID and clears
x86_pmu.arch_pebs, the static calls remain patched. This will cause
intel_pmu_enable_event_ext() to execute on precise events and access
MSR_IA32_PEBS_INDEX, potentially crashing the kernel.

Thanks,
Ian

>  - cstates: Remove PC3 support from LunarLake (Zhang Rui)
>
>  - cstates: Add Pantherlake support (Zhang Rui)
>
>  - cstates: Clearwater Forest support (Zide Chen)
>
> AMD PMU driver:
>
>  - x86/amd: Check event before enable to avoid GPF (George Kennedy)
>
> Fixes and cleanups:
>
>  - task_work: Fix NMI race condition (Peter Zijlstra)
>
>  - perf/x86: Fix NULL event access and potential PEBS record loss
>    (Dapeng Mi)
>
>  - Misc other fixes and cleanups.
>    (Dapeng Mi, Ingo Molnar, Peter Zijlstra)
>
>  Thanks,
>
>         Ingo
>
> ------------------>
> Dapeng Mi (12):
>       perf/x86: Remove redundant is_x86_event() prototype
>       perf/x86: Fix NULL event access and potential PEBS record loss
>       perf/x86/intel: Replace x86_pmu.drain_pebs calling with static call
>       perf/x86/intel: Correct large PEBS flag check
>       perf/x86/intel: Initialize architectural PEBS
>       perf/x86/intel/ds: Factor out PEBS record processing code to functi=
ons
>       perf/x86/intel/ds: Factor out PEBS group processing code to functio=
ns
>       perf/x86/intel: Process arch-PEBS records or record fragments
>       perf/x86/intel: Allocate arch-PEBS buffer and initialize PEBS_BASE =
MSR
>       perf/x86/intel: Update dyn_constraint base on PEBS event precise le=
vel
>       perf/x86/intel: Setup PEBS data configuration and enable legacy gro=
ups
>       perf/x86/intel: Add counter group support for arch-PEBS
>
> George Kennedy (1):
>       perf/x86/amd: Check event before enable to avoid GPF
>
> Ingo Molnar (1):
>       perf/x86/intel: Fix and clean up intel_pmu_drain_arch_pebs() type u=
se
>
> Josh Poimboeuf (1):
>       unwind_user/x86: Enable frame pointer unwinding on x86
>
> Kan Liang (1):
>       perf/x86/intel: Add a check for dynamic constraints
>
> Peter Zijlstra (19):
>       x86/insn,uprobes,alternative: Unify insn_is_nop()
>       x86/insn: Simplify for_each_insn_prefix()
>       task_work: Fix NMI race condition
>       unwind: Shorten lines
>       unwind: Add required include files
>       unwind: Simplify unwind_reset_info()
>       unwind: Add comment to unwind_deferred_task_exit()
>       unwind: Fix unwind_deferred_request() vs NMI
>       unwind: Clarify calling context
>       unwind: Simplify unwind_user_faultable()
>       unwind: Make unwind_task_info::unwind_mask consistent
>       unwind: Simplify unwind_user_next_fp() alignment check
>       unwind: Implement compat fp unwind
>       unwind_user/x86: Teach FP unwind about start of function
>       perf: Support deferred user unwind
>       unwind_user/x86: Fix arch=3Dum build
>       entry,unwind/deferred: Fix unwind_reset_info() placement
>       perf/x86/intel: Check PEBS dyn_constraints
>       perf/x86/intel: Optimize PEBS extended config
>
> Zhang Rui (2):
>       perf/x86/intel/cstate: Remove PC3 support from LunarLake
>       perf/x86/intel/cstate: Add Pantherlake support
>
> Zide Chen (1):
>       perf/x86/intel/cstate: Add Clearwater Forest support
>
>
>  arch/x86/Kconfig                         |   1 +
>  arch/x86/boot/compressed/sev-handle-vc.c |   3 +-
>  arch/x86/events/amd/core.c               |   7 +-
>  arch/x86/events/core.c                   |  66 +---
>  arch/x86/events/intel/core.c             | 444 +++++++++++++++++++++--
>  arch/x86/events/intel/cstate.c           |  18 +-
>  arch/x86/events/intel/ds.c               | 601 +++++++++++++++++++++++++=
------
>  arch/x86/events/perf_event.h             |  41 ++-
>  arch/x86/include/asm/insn-eval.h         |   2 +
>  arch/x86/include/asm/insn.h              |   5 +-
>  arch/x86/include/asm/intel_ds.h          |  10 +-
>  arch/x86/include/asm/msr-index.h         |  20 +
>  arch/x86/include/asm/perf_event.h        | 116 +++++-
>  arch/x86/include/asm/unwind_user.h       |  41 +++
>  arch/x86/include/asm/uprobes.h           |   9 +
>  arch/x86/kernel/alternative.c            |  20 +-
>  arch/x86/kernel/kprobes/core.c           |   3 +-
>  arch/x86/kernel/uprobes.c                |  70 ++--
>  arch/x86/lib/insn-eval.c                 | 151 +++++++-
>  include/linux/irq-entry-common.h         |   2 +-
>  include/linux/perf_event.h               |   2 +-
>  include/linux/unwind_deferred.h          |  52 ++-
>  include/linux/unwind_deferred_types.h    |  18 +-
>  include/linux/unwind_user_types.h        |   2 +
>  include/uapi/linux/perf_event.h          |  21 +-
>  kernel/bpf/stackmap.c                    |   4 +-
>  kernel/events/callchain.c                |  14 +-
>  kernel/events/core.c                     |  78 +++-
>  kernel/exit.c                            |   7 +-
>  kernel/task_work.c                       |   8 +-
>  kernel/unwind/deferred.c                 |  44 ++-
>  kernel/unwind/user.c                     |  59 ++-
>  tools/arch/x86/include/asm/insn.h        |   5 +-
>  tools/include/uapi/linux/perf_event.h    |  21 +-
>  34 files changed, 1627 insertions(+), 338 deletions(-)
>  create mode 100644 arch/x86/include/asm/unwind_user.h
>
