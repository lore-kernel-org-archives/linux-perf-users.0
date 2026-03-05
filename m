Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EB91684B0
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Mar 2026 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673663; cv=pass; b=hZy7fM1SwBdOQBeOekLQRjTDycU2G+4LFLT6kBWLj33bwTEj0/yWkdbSGuZ98bPsvZoc/RHIvdDQDJF61kI3qaxHdvlwTclDXnHixkj2p+8zGaH/xWcHp3E+7PpsVtbzr/XMaF/47T01cnvKJdmHdzGXJvo5X+9qVlIYB/1hsKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673663; c=relaxed/simple;
	bh=lsLZOv04/ikheu7jm7ogR0aW4VpRaHcBcUL6Ln4SAtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kaZpqV9S7nceN0/Ej1TKZ5N1O66dw0/zcY+qxFP+JmrlvjBQsW3goGKZjT0VOeBkeON9d9o7vIreO6+/SmVsjySlclnf7neP2qph5rBREOoVBYTPOae1LaBBb1FjfOtYu8aOJoI8EkUklsZ3UDSMAxbz420zxazRhKh2ZCMn5wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZKz1I0EU; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZKz1I0EU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae4b40999bso20075ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Mar 2026 17:21:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772673661; cv=none;
        d=google.com; s=arc-20240605;
        b=dFtK8P8EbBwyBic4QE/w72KrKWo9T9T0gaHaXv9uS6Y08vvE3F0+o7RQdb5CiFuInC
         epVwJn7nRlH5AM0dP6gILhSB5pjtRdtHfMfDyb6PGJiLUsjU0xgiv3l93O3MtApQ9Np3
         J9ie7IA8jY4Qn8mzDPUG64/mhuHUBEMnvj5UNGiC2IxCLHOOnI8OztOCz7jUOivwWlCp
         TCTqrMogsHWeQ1ybX6fuwe738yuoFF/kn5HaX+0sGad9cJoF9x+YSd5k3R93Q5WboW/2
         3zoN0KXJ2uGb/MJNUuzP2XO46YC+YQW1OlqK4lBXwvtmetScIsuoV5Ajz6jTxmOL3DxW
         TlnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=95l1xCcmZg03wkt3yCZAv3MU5Iuxy1v+gjaumKQEiaI=;
        fh=fWYZl1eKoL7C0IwcgVmySQc+58zx7XL8P5ECLE1HoVI=;
        b=e1mlQIiq5fAYDWKhp5LA+1mAG9GV1yJRnNAG+5+/nVXC5A3yz1+Oku9xnctPg8n/nb
         PGsFCtX1OP5qgrhkuj5foorvkS2ZjbvP+Ij+61W87v6szW+3s/D0eo5yWVStrdvBEJ2g
         zsiKKdcmOADEdbPLGxFh+hOtyG/t0vznNbiyTpd6gTQQc9Epnk07W/H300nUzC1gtSsc
         rrAr3gn7s7QaadO38z7dYj2LOExyg1crclFF1mL5M/GF5VYsdK1w6mTjD1s3kZXXKkCV
         Ht9uTla096GytQuAwv8zlPfwX5CFi3/+XawUn3EnxWy9mnWdo8hiyx3XsOlQRlpc4R3g
         LFKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772673661; x=1773278461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95l1xCcmZg03wkt3yCZAv3MU5Iuxy1v+gjaumKQEiaI=;
        b=ZKz1I0EUjssA+BNFaZekSTG4YJ9vrh2Qf3myYpaSqWby8oOYy0ExL0e2DwvuNEZ493
         gjmyt6idbrKnJ8M2Iqlg0KmWi/7Zmkc4x2onELrNuH6IbUFfMDJATDwkjxftoM4j2Liv
         xwLdXEJ8Kqzi7zrISEQe1OUDlI5O5CC7OVfmocgN7oHUyKJZfoFKOPZuFrddH06hhq7Y
         Ezih3FZGFL0LHyKwz4M7lafHp2ZkI2B08BH5DQ4PUDMM0o69Xchrnz0lrTWlhRs/Lp3T
         /XSL9JZFwleboV8QW4GiavJTlzxlLiw0u3BJBaIdeCLU32/aDU1Zpmiey3WRfOa8vKKb
         IOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772673661; x=1773278461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=95l1xCcmZg03wkt3yCZAv3MU5Iuxy1v+gjaumKQEiaI=;
        b=MbqgAwUTQLE5KY9em4734Ktk9lMKwhLMIJAmc3rgmSoKbWuyZMHmYt3csK90YmqkBC
         XqgJo7usQhwjsm/KFNoAvjH/0ehXG3CQxaSPMZclLjWB+9zmM5mWF+R/D51DjmiN+Acs
         1E7J2bd0PWxB999ZuM8iPwwaIP5qDRhK+vR+EvW7tMF0YFKh7sSfNkG8l4muc3jIuW6y
         Uht9m0HvI4ia03oqXyS+YHGTOS2NtQhURQmDJ+fnVsJzbsp+hiv24zuxkO2XOtvtuTnQ
         1IF0njLUGd+lJtv2bfetw75t5a/4UcTOPoXu/WKhYBZbXqPkOKKm6cgEpypxejFOb7sq
         MuRg==
X-Forwarded-Encrypted: i=1; AJvYcCWo9/t088+Uo0QrTh8s6O2LTsUHahc1d6gxHDzEBkMqXkCOcUn21KWSEw3T+6NpLfPfjgENGuJtdyKMjNTU2mz1@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSeAClNXWMShgwdB7Iu1/AX/ysiwt7na8mkqlyN19ygzZU4ic
	7H/PbHtArHNbd8KHXxyNn/NWjlDaKvq+ZJggOVu/sZgM26vmBfiLg+OivXSgx1ed9Uv/rbf1pKu
	a4xGlMFU50zlnJm7eNqDyexJM2825rNSKNDRNtTYn
X-Gm-Gg: ATEYQzxctyrzUPyFCp7vCIFcG/vJsv+lv2GuBPt6q5EEZDjnJPz8Pe5J/JZxUz+tclO
	Qmh0don4+uijPvm18Ty97VVc1y30tghMrjCZeotVs9HQob0A2d39TEvKVa+zN2I6QjrVCihBXec
	6bL32uMcBwvQiKZE0XZ9Eo0yVn+rVGjMIyAnLx0eMN1Mje8eaN0av74/CxXssIaGzrI3+uRSxlp
	1IizhYgtsXpYQyVB7PwGyFSaTM7dq6BNI6CWEb4DWhqUjNrvEptyXV8qvHK/acmlt7za1OCyKIl
	gTACFAwLpT2Hju2iN8QGSfK9nchKwG05NGkuwQ==
X-Received: by 2002:a17:903:46c6:b0:2ae:45bb:bc4e with SMTP id
 d9443c01a7336-2ae7513597bmr870095ad.24.1772673660722; Wed, 04 Mar 2026
 17:21:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com> <20251029102136.61364-12-dapeng1.mi@linux.intel.com>
In-Reply-To: <20251029102136.61364-12-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Mar 2026 17:20:49 -0800
X-Gm-Features: AaiRm51a408dWrmD3aQ1EBAPDlT8OHaQmrX0eqvJj5m4LQ1uYGXnHjX7LPEqi24
Message-ID: <CAP-5=fUPw6qs9i9NoxHgnc1wW3MhQqO5KxRnn2S8sDuX5ynUSQ@mail.gmail.com>
Subject: Re: [Patch v9 11/12] perf/x86/intel: Setup PEBS data configuration
 and enable legacy groups
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>, 
	Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 3:25=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> Different with legacy PEBS, arch-PEBS provides per-counter PEBS data
> configuration by programing MSR IA32_PMC_GPx/FXx_CFG_C MSRs.
>
> This patch obtains PEBS data configuration from event attribute and then
> writes the PEBS data configuration to MSR IA32_PMC_GPx/FXx_CFG_C and
> enable corresponding PEBS groups.
>
> Please notice this patch only enables XMM SIMD regs sampling for
> arch-PEBS, the other SIMD regs (OPMASK/YMM/ZMM) sampling on arch-PEBS
> would be supported after PMI based SIMD regs (OPMASK/YMM/ZMM) sampling
> is supported.
>
> Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c     | 136 ++++++++++++++++++++++++++++++-
>  arch/x86/events/intel/ds.c       |  17 ++++
>  arch/x86/events/perf_event.h     |   4 +
>  arch/x86/include/asm/intel_ds.h  |   7 ++
>  arch/x86/include/asm/msr-index.h |   8 ++
>  5 files changed, 171 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 40ccfd80d554..75cba28b86d5 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2563,6 +2563,45 @@ static void intel_pmu_disable_fixed(struct perf_ev=
ent *event)
>         cpuc->fixed_ctrl_val &=3D ~mask;
>  }
>
> +static inline void __intel_pmu_update_event_ext(int idx, u64 ext)
> +{
> +       struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> +       u32 msr;
> +
> +       if (idx < INTEL_PMC_IDX_FIXED) {
> +               msr =3D MSR_IA32_PMC_V6_GP0_CFG_C +
> +                     x86_pmu.addr_offset(idx, false);
> +       } else {
> +               msr =3D MSR_IA32_PMC_V6_FX0_CFG_C +
> +                     x86_pmu.addr_offset(idx - INTEL_PMC_IDX_FIXED, fals=
e);
> +       }
> +
> +       cpuc->cfg_c_val[idx] =3D ext;
> +       wrmsrq(msr, ext);
> +}
> +
> +static void intel_pmu_disable_event_ext(struct perf_event *event)
> +{
> +       if (!x86_pmu.arch_pebs)
> +               return;
> +
> +       /*
> +        * Only clear CFG_C MSR for PEBS counter group events,
> +        * it avoids the HW counter's value to be added into
> +        * other PEBS records incorrectly after PEBS counter
> +        * group events are disabled.
> +        *
> +        * For other events, it's unnecessary to clear CFG_C MSRs
> +        * since CFG_C doesn't take effect if counter is in
> +        * disabled state. That helps to reduce the WRMSR overhead
> +        * in context switches.
> +        */
> +       if (!is_pebs_counter_event_group(event))
> +               return;
> +
> +       __intel_pmu_update_event_ext(event->hw.idx, 0);
> +}
> +
>  static void intel_pmu_disable_event(struct perf_event *event)
>  {
>         struct hw_perf_event *hwc =3D &event->hw;
> @@ -2571,9 +2610,12 @@ static void intel_pmu_disable_event(struct perf_ev=
ent *event)
>         switch (idx) {
>         case 0 ... INTEL_PMC_IDX_FIXED - 1:
>                 intel_clear_masks(event, idx);
> +               intel_pmu_disable_event_ext(event);
>                 x86_pmu_disable_event(event);
>                 break;
>         case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
> +               intel_pmu_disable_event_ext(event);
> +               fallthrough;
>         case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
>                 intel_pmu_disable_fixed(event);
>                 break;
> @@ -2940,6 +2982,66 @@ static void intel_pmu_enable_acr(struct perf_event=
 *event)
>
>  DEFINE_STATIC_CALL_NULL(intel_pmu_enable_acr_event, intel_pmu_enable_acr=
);
>
> +static void intel_pmu_enable_event_ext(struct perf_event *event)
> +{
> +       struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> +       struct hw_perf_event *hwc =3D &event->hw;
> +       union arch_pebs_index old, new;
> +       struct arch_pebs_cap cap;
> +       u64 ext =3D 0;
> +
> +       if (!x86_pmu.arch_pebs)
> +               return;
> +
> +       cap =3D hybrid(cpuc->pmu, arch_pebs_cap);
> +
> +       if (event->attr.precise_ip) {
> +               u64 pebs_data_cfg =3D intel_get_arch_pebs_data_config(eve=
nt);
> +
> +               ext |=3D ARCH_PEBS_EN;
> +               if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD)
> +                       ext |=3D (-hwc->sample_period) & ARCH_PEBS_RELOAD=
;

Nit: Perhaps there should be a warning if "hwc->sample_period >
ARCH_PEBS_RELOAD"?

Thanks,
Ian

> +
> +               if (pebs_data_cfg && cap.caps) {
> +                       if (pebs_data_cfg & PEBS_DATACFG_MEMINFO)
> +                               ext |=3D ARCH_PEBS_AUX & cap.caps;
> +
> +                       if (pebs_data_cfg & PEBS_DATACFG_GP)
> +                               ext |=3D ARCH_PEBS_GPR & cap.caps;
> +
> +                       if (pebs_data_cfg & PEBS_DATACFG_XMMS)
> +                               ext |=3D ARCH_PEBS_VECR_XMM & cap.caps;
> +
> +                       if (pebs_data_cfg & PEBS_DATACFG_LBRS)
> +                               ext |=3D ARCH_PEBS_LBR & cap.caps;
> +               }
> +
> +               if (cpuc->n_pebs =3D=3D cpuc->n_large_pebs)
> +                       new.thresh =3D ARCH_PEBS_THRESH_MULTI;
> +               else
> +                       new.thresh =3D ARCH_PEBS_THRESH_SINGLE;
> +
> +               rdmsrq(MSR_IA32_PEBS_INDEX, old.whole);
> +               if (new.thresh !=3D old.thresh || !old.en) {
> +                       if (old.thresh =3D=3D ARCH_PEBS_THRESH_MULTI && o=
ld.wr > 0) {
> +                               /*
> +                                * Large PEBS was enabled.
> +                                * Drain PEBS buffer before applying the =
single PEBS.
> +                                */
> +                               intel_pmu_drain_pebs_buffer();
> +                       } else {
> +                               new.wr =3D 0;
> +                               new.full =3D 0;
> +                               new.en =3D 1;
> +                               wrmsrq(MSR_IA32_PEBS_INDEX, new.whole);
> +                       }
> +               }
> +       }
> +
> +       if (cpuc->cfg_c_val[hwc->idx] !=3D ext)
> +               __intel_pmu_update_event_ext(hwc->idx, ext);
> +}
> +
>  static void intel_pmu_enable_event(struct perf_event *event)
>  {
>         u64 enable_mask =3D ARCH_PERFMON_EVENTSEL_ENABLE;
> @@ -2955,10 +3057,12 @@ static void intel_pmu_enable_event(struct perf_ev=
ent *event)
>                         enable_mask |=3D ARCH_PERFMON_EVENTSEL_BR_CNTR;
>                 intel_set_masks(event, idx);
>                 static_call_cond(intel_pmu_enable_acr_event)(event);
> +               intel_pmu_enable_event_ext(event);
>                 __x86_pmu_enable_event(hwc, enable_mask);
>                 break;
>         case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
>                 static_call_cond(intel_pmu_enable_acr_event)(event);
> +               intel_pmu_enable_event_ext(event);
>                 fallthrough;
>         case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
>                 intel_pmu_enable_fixed(event);
> @@ -5301,6 +5405,30 @@ static inline bool intel_pmu_broken_perf_cap(void)
>         return false;
>  }
>
> +static inline void __intel_update_pmu_caps(struct pmu *pmu)
> +{
> +       struct pmu *dest_pmu =3D pmu ? pmu : x86_get_pmu(smp_processor_id=
());
> +
> +       if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_VECR_XMM)
> +               dest_pmu->capabilities |=3D PERF_PMU_CAP_EXTENDED_REGS;
> +}
> +
> +static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
> +{
> +       u64 caps =3D hybrid(pmu, arch_pebs_cap).caps;
> +
> +       x86_pmu.large_pebs_flags |=3D PERF_SAMPLE_TIME;
> +       if (caps & ARCH_PEBS_LBR)
> +               x86_pmu.large_pebs_flags |=3D PERF_SAMPLE_BRANCH_STACK;
> +
> +       if (!(caps & ARCH_PEBS_AUX))
> +               x86_pmu.large_pebs_flags &=3D ~PERF_SAMPLE_DATA_SRC;
> +       if (!(caps & ARCH_PEBS_GPR)) {
> +               x86_pmu.large_pebs_flags &=3D
> +                       ~(PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER);
> +       }
> +}
> +
>  #define counter_mask(_gp, _fixed) ((_gp) | ((u64)(_fixed) << INTEL_PMC_I=
DX_FIXED))
>
>  static void update_pmu_cap(struct pmu *pmu)
> @@ -5349,8 +5477,12 @@ static void update_pmu_cap(struct pmu *pmu)
>                 hybrid(pmu, arch_pebs_cap).counters =3D pebs_mask;
>                 hybrid(pmu, arch_pebs_cap).pdists =3D pdists_mask;
>
> -               if (WARN_ON((pebs_mask | pdists_mask) & ~cntrs_mask))
> +               if (WARN_ON((pebs_mask | pdists_mask) & ~cntrs_mask)) {
>                         x86_pmu.arch_pebs =3D 0;
> +               } else {
> +                       __intel_update_pmu_caps(pmu);
> +                       __intel_update_large_pebs_flags(pmu);
> +               }
>         } else {
>                 WARN_ON(x86_pmu.arch_pebs =3D=3D 1);
>                 x86_pmu.arch_pebs =3D 0;
> @@ -5514,6 +5646,8 @@ static void intel_pmu_cpu_starting(int cpu)
>                 }
>         }
>
> +       __intel_update_pmu_caps(cpuc->pmu);
> +
>         if (!cpuc->shared_regs)
>                 return;
>
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 1179980f795b..c66e9b562de3 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1528,6 +1528,18 @@ pebs_update_state(bool needed_cb, struct cpu_hw_ev=
ents *cpuc,
>         }
>  }
>
> +u64 intel_get_arch_pebs_data_config(struct perf_event *event)
> +{
> +       u64 pebs_data_cfg =3D 0;
> +
> +       if (WARN_ON(event->hw.idx < 0 || event->hw.idx >=3D X86_PMC_IDX_M=
AX))
> +               return 0;
> +
> +       pebs_data_cfg |=3D pebs_update_adaptive_cfg(event);
> +
> +       return pebs_data_cfg;
> +}
> +
>  void intel_pmu_pebs_add(struct perf_event *event)
>  {
>         struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> @@ -2947,6 +2959,11 @@ static void intel_pmu_drain_arch_pebs(struct pt_re=
gs *iregs,
>
>         index.wr =3D 0;
>         index.full =3D 0;
> +       index.en =3D 1;
> +       if (cpuc->n_pebs =3D=3D cpuc->n_large_pebs)
> +               index.thresh =3D ARCH_PEBS_THRESH_MULTI;
> +       else
> +               index.thresh =3D ARCH_PEBS_THRESH_SINGLE;
>         wrmsrq(MSR_IA32_PEBS_INDEX, index.whole);
>
>         mask =3D hybrid(cpuc->pmu, arch_pebs_cap).counters & cpuc->pebs_e=
nabled;
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 13f411bca6bc..3161ec0a3416 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -304,6 +304,8 @@ struct cpu_hw_events {
>         /* Intel ACR configuration */
>         u64                     acr_cfg_b[X86_PMC_IDX_MAX];
>         u64                     acr_cfg_c[X86_PMC_IDX_MAX];
> +       /* Cached CFG_C values */
> +       u64                     cfg_c_val[X86_PMC_IDX_MAX];
>
>         /*
>          * Intel LBR bits
> @@ -1782,6 +1784,8 @@ void intel_pmu_pebs_data_source_cmt(void);
>
>  void intel_pmu_pebs_data_source_lnl(void);
>
> +u64 intel_get_arch_pebs_data_config(struct perf_event *event);
> +
>  int intel_pmu_setup_lbr_filter(struct perf_event *event);
>
>  void intel_pt_interrupt(void);
> diff --git a/arch/x86/include/asm/intel_ds.h b/arch/x86/include/asm/intel=
_ds.h
> index 023c2883f9f3..695f87efbeb8 100644
> --- a/arch/x86/include/asm/intel_ds.h
> +++ b/arch/x86/include/asm/intel_ds.h
> @@ -7,6 +7,13 @@
>  #define PEBS_BUFFER_SHIFT      4
>  #define PEBS_BUFFER_SIZE       (PAGE_SIZE << PEBS_BUFFER_SHIFT)
>
> +/*
> + * The largest PEBS record could consume a page, ensure
> + * a record at least can be written after triggering PMI.
> + */
> +#define ARCH_PEBS_THRESH_MULTI ((PEBS_BUFFER_SIZE - PAGE_SIZE) >> PEBS_B=
UFFER_SHIFT)
> +#define ARCH_PEBS_THRESH_SINGLE        1
> +
>  /* The maximal number of PEBS events: */
>  #define MAX_PEBS_EVENTS_FMT4   8
>  #define MAX_PEBS_EVENTS                32
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-=
index.h
> index fc7a4e7c718d..f1ef9ac38bfb 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -333,6 +333,14 @@
>  #define ARCH_PEBS_OFFSET_MASK          0x7fffff
>  #define ARCH_PEBS_INDEX_WR_SHIFT       4
>
> +#define ARCH_PEBS_RELOAD               0xffffffff
> +#define ARCH_PEBS_LBR_SHIFT            40
> +#define ARCH_PEBS_LBR                  (0x3ull << ARCH_PEBS_LBR_SHIFT)
> +#define ARCH_PEBS_VECR_XMM             BIT_ULL(49)
> +#define ARCH_PEBS_GPR                  BIT_ULL(61)
> +#define ARCH_PEBS_AUX                  BIT_ULL(62)
> +#define ARCH_PEBS_EN                   BIT_ULL(63)
> +
>  #define MSR_IA32_RTIT_CTL              0x00000570
>  #define RTIT_CTL_TRACEEN               BIT(0)
>  #define RTIT_CTL_CYCLEACC              BIT(1)
> --
> 2.34.1
>
