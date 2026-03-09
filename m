Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435BF363C51
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097180; cv=pass; b=nPERGDPf/fipvJ0q+oae85w0kBdTojUHmvWcH83Z9OJJNkM+BbzAf3coPXC9rsZl7cuEgS8s0npxPE+80A2bTGxtyHf4aErOgglv5HEArueeDjhaW5J71IvPeHeW/LvWoEWFGQK9u1H1SwFVtZywjq5zQ7DxzXIvJ8rOHQgaj+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097180; c=relaxed/simple;
	bh=Z/jmCblZoylhSnwV7Jngt89T8/eqyEsDj0J6gbxxLYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPzZaMjP9LX0j8kcpiwKTn0CHakznRBxiABk5JTnbQuzXhIqwn/oVHPp+Q/d+BeNTtiiV58W2z/ci+TUf4BFKUIib2kda7lwg6bTfhNuVbVnWX01p8K1zfiNEIopm41zqJHn/Cn80A78r9owXEAPPC6G8uYHekExQq4l/+0Q48I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VNmV/DNR; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNmV/DNR"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ae49120e97so40615ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 15:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773097178; cv=none;
        d=google.com; s=arc-20240605;
        b=fb0xlLelHMb7qgWefMO8aYsqobANhltgrWY1IVQW3IN+DdIcWCeszXmd6PuIqFDRuq
         Yy3XiWodVsg9sN2PmYCEQ182pFE6jixXL2dMA8P2WWZSnXhz2inhZhDKzjBe7++i9HXI
         EaBz2Tw2ypIdmtdfoozqxNn/Z1BzdmkX1hDeF35hnB0DAljuY4S4s7nE7G/rkADSg65d
         Otob5phgIzUA2u/z3yCVV9+Gs4aSAHBSPjNXHnGfHQ3iAQbERrMFa0Z1obBA4YSwW0Xg
         ZZg0+e4/FSS4Y6pqMVOmhex4Z2C0nMhAEj3zjw5i/WUwXqeUJ+1VPsOE/R3EbeFeJg12
         qixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=os7AY2tjf4fGYQ+cvcDeQaQoIcPlZCxBA4vFIaLXnq0=;
        fh=uTsqb7wtEh9G853AbEK+15zfW+CGqwjgUvHZYHZ9mjc=;
        b=gmNFso39hcxq2V4t1tJmf34dJiGbHRCj8xVlBvKu1HZw3b71zWxNHk929hPgqXuYc5
         uKKkD2PcyHFSy9z6N3vc1teq8Gi1hq9+I2/RNSMV2lHBCwiy73sObTauW4RLwDCJ3YqL
         m29cIXPPLZAMMSN6vbf91O883w1BNxtZP2s6mv5jysj9HfCI75byLgLF5a04OkstZccB
         Ci6i9yu9bpF4+c805cKw9xxmhc5W81IVyNfqFOvQ2hWK1bxUtdxfsaWItwrgI/zYq65e
         5btxZYL6OF1ypld3F1D7wWvcgYcx/NWc176sSUo1SVPgdKxPnMAPNG3FlvJrw3Mjyo/W
         1dRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773097178; x=1773701978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os7AY2tjf4fGYQ+cvcDeQaQoIcPlZCxBA4vFIaLXnq0=;
        b=VNmV/DNRPLpKVhSAfC2sqFNsRXSTMQ0s3IdkJ9p7bF8TqXEnGhn14eq4lVTYtYHZhz
         Yun9ag5AhtyyGv7spSUJ6rUJnkQloc+qHH0dIlbmAN6PkSOWG5hWjlB0piamGQZdNSSi
         jCBK3/as9vR/qTdvdFYoDAtrkLdMlAS9553oop8svUdTSdSe4S/t5xbvXcyvZ/GUwD0z
         PtdVWdNbZbUr7wefum8JbZMv0gCvUlAzMEOYcN3YsWJtKqIzCLcyXfoEHBD/KtkTvs4o
         EiBtDiur79VDlC5/de/96GhD1IsJaQcN4PX6HtavPow8yNXMzb+h0wmMkr8O8PwX3Icf
         Lyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773097178; x=1773701978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=os7AY2tjf4fGYQ+cvcDeQaQoIcPlZCxBA4vFIaLXnq0=;
        b=n7Vgn7pogIZnET21rs/qPonhVi331/hZffJzzc7iWoWUrGp58J/HIHakLORJBD+ZgU
         Xnnl5g1i8govuv37kp5c8CHxbWJ2dsv+Q5e1HgkO6UqvKlOq94NpFrqpkBTxbU/fFd3c
         RBBOgG17nFag7r7arml8sWhjKIgT57y2Y353uQB1goM73Y76It2Pcq53G9uIvBxl3ifc
         ULApbcC38TSxoHio82+6K2ShfWKLcBTf5lcEDcCnXotuyYlY33Qwp4O4SwL5JRb9lrBB
         qSGTMKv6tMBeWdMhH5oEWmbYGjuqTPup3jQarZlTuDKcuaaGYBpUYDEOH2id5UjUWsCa
         cIEA==
X-Forwarded-Encrypted: i=1; AJvYcCWb9c1qwN3IVPQdN+E0DnPXOcmQF2yMeY0SrEWqJQLpbslbEo5Pmxl/AqrmStz5MhRNoXCnz2pnTEfBMpuwggkF@vger.kernel.org
X-Gm-Message-State: AOJu0YwdaTsWmjvSyGHV6ax3RUBM11k1eeh95VsYZPmiGCaSVld7px34
	ZNTIWIL7qYD72xaX0r1b9XJhb9BGqz7VmN8aw42Fs/XYSVMtelYQB71PMZ031qpP1jcehgyOh4L
	XikZvUp6CTgRrcgBP0KjdgIwBy/+/JFo99q0ic+mz
X-Gm-Gg: ATEYQzwD1hx0SbIdPNLIDY+1lb2tE07W03Bl79yTaiFT2nU/AIz1lsUIo+Q1LzXQjyk
	6BmsPC/5H3mqQMTUKJYq2hCFU9Ozo6/pOfyRyBo2YDGkZHqgyvWPsnASNA+H7901jtis9E872iz
	gA+HhExvbkDFyC4v9iPDHJeB0VPuPI7WgvkBmlJLfKKIuBDvimsSJcjeMA5vRvSesl6ddXeuAGn
	wiXnTe2e4alNCuy2ZgFVgelhJKAGwI29NTS5LMhWAIgCvHoL98Wwl/SZ27ICbwkMBM4Rg8kQ3/F
	HKf5GnS83UXAtm75e9YAu/XgwtKZ/Pshumo=
X-Received: by 2002:a17:902:f546:b0:2ae:575f:3755 with SMTP id
 d9443c01a7336-2aea30d24bamr1083385ad.20.1773097177859; Mon, 09 Mar 2026
 15:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com> <20251029102136.61364-13-dapeng1.mi@linux.intel.com>
In-Reply-To: <20251029102136.61364-13-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 15:59:26 -0700
X-Gm-Features: AaiRm503uT3jaZ0zar52MVLyw4lEbHqhjS0ERr5x5F_56bGcXIDZvNBGVeVLer0
Message-ID: <CAP-5=fUDfgSC9CcJWg9CpKQo4aTdFbD89_XcmVX8OivRLoEAcA@mail.gmail.com>
Subject: Re: [Patch v9 12/12] perf/x86/intel: Add counter group support for arch-PEBS
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>, 
	Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 3:25=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> Base on previous adaptive PEBS counter snapshot support, add counter
> group support for architectural PEBS. Since arch-PEBS shares same
> counter group layout with adaptive PEBS, directly reuse
> __setup_pebs_counter_group() helper to process arch-PEBS counter group.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c      | 38 ++++++++++++++++++++++++++++---
>  arch/x86/events/intel/ds.c        | 29 ++++++++++++++++++++---
>  arch/x86/include/asm/msr-index.h  |  6 +++++
>  arch/x86/include/asm/perf_event.h | 13 ++++++++---
>  4 files changed, 77 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 75cba28b86d5..cb64018321dd 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3014,6 +3014,17 @@ static void intel_pmu_enable_event_ext(struct perf=
_event *event)
>
>                         if (pebs_data_cfg & PEBS_DATACFG_LBRS)
>                                 ext |=3D ARCH_PEBS_LBR & cap.caps;
> +
> +                       if (pebs_data_cfg &
> +                           (PEBS_DATACFG_CNTR_MASK << PEBS_DATACFG_CNTR_=
SHIFT))
> +                               ext |=3D ARCH_PEBS_CNTR_GP & cap.caps;
> +
> +                       if (pebs_data_cfg &
> +                           (PEBS_DATACFG_FIX_MASK << PEBS_DATACFG_FIX_SH=
IFT))
> +                               ext |=3D ARCH_PEBS_CNTR_FIXED & cap.caps;
> +
> +                       if (pebs_data_cfg & PEBS_DATACFG_METRICS)
> +                               ext |=3D ARCH_PEBS_CNTR_METRICS & cap.cap=
s;
>                 }
>
>                 if (cpuc->n_pebs =3D=3D cpuc->n_large_pebs)
> @@ -3038,6 +3049,9 @@ static void intel_pmu_enable_event_ext(struct perf_=
event *event)
>                 }
>         }
>
> +       if (is_pebs_counter_event_group(event))
> +               ext |=3D ARCH_PEBS_CNTR_ALLOW;
> +
>         if (cpuc->cfg_c_val[hwc->idx] !=3D ext)
>                 __intel_pmu_update_event_ext(hwc->idx, ext);
>  }
> @@ -4323,6 +4337,20 @@ static bool intel_pmu_is_acr_group(struct perf_eve=
nt *event)
>         return false;
>  }
>
> +static inline bool intel_pmu_has_pebs_counter_group(struct pmu *pmu)
> +{
> +       u64 caps;
> +
> +       if (x86_pmu.intel_cap.pebs_format >=3D 6 && x86_pmu.intel_cap.peb=
s_baseline)
> +               return true;
> +
> +       caps =3D hybrid(pmu, arch_pebs_cap).caps;
> +       if (x86_pmu.arch_pebs && (caps & ARCH_PEBS_CNTR_MASK))
> +               return true;
> +
> +       return false;
> +}
> +
>  static inline void intel_pmu_set_acr_cntr_constr(struct perf_event *even=
t,
>                                                  u64 *cause_mask, int *nu=
m)
>  {
> @@ -4471,8 +4499,7 @@ static int intel_pmu_hw_config(struct perf_event *e=
vent)
>         }
>
>         if ((event->attr.sample_type & PERF_SAMPLE_READ) &&
> -           (x86_pmu.intel_cap.pebs_format >=3D 6) &&
> -           x86_pmu.intel_cap.pebs_baseline &&
> +           intel_pmu_has_pebs_counter_group(event->pmu) &&
>             is_sampling_event(event) &&
>             event->attr.precise_ip)
>                 event->group_leader->hw.flags |=3D PERF_X86_EVENT_PEBS_CN=
TR;
> @@ -5420,6 +5447,8 @@ static inline void __intel_update_large_pebs_flags(=
struct pmu *pmu)
>         x86_pmu.large_pebs_flags |=3D PERF_SAMPLE_TIME;
>         if (caps & ARCH_PEBS_LBR)
>                 x86_pmu.large_pebs_flags |=3D PERF_SAMPLE_BRANCH_STACK;
> +       if (caps & ARCH_PEBS_CNTR_MASK)
> +               x86_pmu.large_pebs_flags |=3D PERF_SAMPLE_READ;
>
>         if (!(caps & ARCH_PEBS_AUX))
>                 x86_pmu.large_pebs_flags &=3D ~PERF_SAMPLE_DATA_SRC;
> @@ -7134,8 +7163,11 @@ __init int intel_pmu_init(void)
>          * Many features on and after V6 require dynamic constraint,
>          * e.g., Arch PEBS, ACR.
>          */
> -       if (version >=3D 6)
> +       if (version >=3D 6) {
>                 x86_pmu.flags |=3D PMU_FL_DYN_CONSTRAINT;
> +               x86_pmu.late_setup =3D intel_pmu_late_setup;
> +       }
> +
>         /*
>          * Install the hw-cache-events table:
>          */
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index c66e9b562de3..c93bf971d97b 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1530,13 +1530,20 @@ pebs_update_state(bool needed_cb, struct cpu_hw_e=
vents *cpuc,
>
>  u64 intel_get_arch_pebs_data_config(struct perf_event *event)
>  {
> +       struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
>         u64 pebs_data_cfg =3D 0;
> +       u64 cntr_mask;
>
>         if (WARN_ON(event->hw.idx < 0 || event->hw.idx >=3D X86_PMC_IDX_M=
AX))
>                 return 0;
>
>         pebs_data_cfg |=3D pebs_update_adaptive_cfg(event);
>
> +       cntr_mask =3D (PEBS_DATACFG_CNTR_MASK << PEBS_DATACFG_CNTR_SHIFT)=
 |
> +                   (PEBS_DATACFG_FIX_MASK << PEBS_DATACFG_FIX_SHIFT) |
> +                   PEBS_DATACFG_CNTR | PEBS_DATACFG_METRICS;
> +       pebs_data_cfg |=3D cpuc->pebs_data_cfg & cntr_mask;
> +
>         return pebs_data_cfg;
>  }
>
> @@ -2444,6 +2451,24 @@ static void setup_arch_pebs_sample_data(struct per=
f_event *event,
>                 }
>         }
>
> +       if (header->cntr) {
> +               struct arch_pebs_cntr_header *cntr =3D next_record;
> +               unsigned int nr;
> +
> +               next_record +=3D sizeof(struct arch_pebs_cntr_header);
> +
> +               if (is_pebs_counter_event_group(event)) {
> +                       __setup_pebs_counter_group(cpuc, event,
> +                               (struct pebs_cntr_header *)cntr, next_rec=
ord);
> +                       data->sample_flags |=3D PERF_SAMPLE_READ;
> +               }
> +
> +               nr =3D hweight32(cntr->cntr) + hweight32(cntr->fixed);
> +               if (cntr->metrics =3D=3D INTEL_CNTR_METRICS)
> +                       nr +=3D 2;
> +               next_record +=3D nr * sizeof(u64);
> +       }
> +
>         /* Parse followed fragments if there are. */
>         if (arch_pebs_record_continued(header)) {
>                 at =3D at + header->size;
> @@ -3094,10 +3119,8 @@ static void __init intel_ds_pebs_init(void)
>                         break;
>
>                 case 6:
> -                       if (x86_pmu.intel_cap.pebs_baseline) {
> +                       if (x86_pmu.intel_cap.pebs_baseline)
>                                 x86_pmu.large_pebs_flags |=3D PERF_SAMPLE=
_READ;
> -                               x86_pmu.late_setup =3D intel_pmu_late_set=
up;
> -                       }

Hi Dapeng,

I'm trying to understand why the late_setup initialization was changed
here and its connection with counter group support. I couldn't find a
mention in the commit message.

Thanks,
Ian

>                         fallthrough;
>                 case 5:
>                         x86_pmu.pebs_ept =3D 1;
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-=
index.h
> index f1ef9ac38bfb..65cc528fbad8 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -334,12 +334,18 @@
>  #define ARCH_PEBS_INDEX_WR_SHIFT       4
>
>  #define ARCH_PEBS_RELOAD               0xffffffff
> +#define ARCH_PEBS_CNTR_ALLOW           BIT_ULL(35)
> +#define ARCH_PEBS_CNTR_GP              BIT_ULL(36)
> +#define ARCH_PEBS_CNTR_FIXED           BIT_ULL(37)
> +#define ARCH_PEBS_CNTR_METRICS         BIT_ULL(38)
>  #define ARCH_PEBS_LBR_SHIFT            40
>  #define ARCH_PEBS_LBR                  (0x3ull << ARCH_PEBS_LBR_SHIFT)
>  #define ARCH_PEBS_VECR_XMM             BIT_ULL(49)
>  #define ARCH_PEBS_GPR                  BIT_ULL(61)
>  #define ARCH_PEBS_AUX                  BIT_ULL(62)
>  #define ARCH_PEBS_EN                   BIT_ULL(63)
> +#define ARCH_PEBS_CNTR_MASK            (ARCH_PEBS_CNTR_GP | ARCH_PEBS_CN=
TR_FIXED | \
> +                                        ARCH_PEBS_CNTR_METRICS)
>
>  #define MSR_IA32_RTIT_CTL              0x00000570
>  #define RTIT_CTL_TRACEEN               BIT(0)
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/per=
f_event.h
> index 3b3848f0d339..7276ba70c88a 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -141,16 +141,16 @@
>  #define ARCH_PERFMON_EVENTS_COUNT                      7
>
>  #define PEBS_DATACFG_MEMINFO   BIT_ULL(0)
> -#define PEBS_DATACFG_GP        BIT_ULL(1)
> +#define PEBS_DATACFG_GP                BIT_ULL(1)
>  #define PEBS_DATACFG_XMMS      BIT_ULL(2)
>  #define PEBS_DATACFG_LBRS      BIT_ULL(3)
> -#define PEBS_DATACFG_LBR_SHIFT 24
>  #define PEBS_DATACFG_CNTR      BIT_ULL(4)
> +#define PEBS_DATACFG_METRICS   BIT_ULL(5)
> +#define PEBS_DATACFG_LBR_SHIFT 24
>  #define PEBS_DATACFG_CNTR_SHIFT        32
>  #define PEBS_DATACFG_CNTR_MASK GENMASK_ULL(15, 0)
>  #define PEBS_DATACFG_FIX_SHIFT 48
>  #define PEBS_DATACFG_FIX_MASK  GENMASK_ULL(7, 0)
> -#define PEBS_DATACFG_METRICS   BIT_ULL(5)
>
>  /* Steal the highest bit of pebs_data_cfg for SW usage */
>  #define PEBS_UPDATE_DS_SW      BIT_ULL(63)
> @@ -603,6 +603,13 @@ struct arch_pebs_lbr_header {
>         u64 ler_info;
>  };
>
> +struct arch_pebs_cntr_header {
> +       u32 cntr;
> +       u32 fixed;
> +       u32 metrics;
> +       u32 reserved;
> +};
> +
>  /*
>   * AMD Extended Performance Monitoring and Debug cpuid feature detection
>   */
> --
> 2.34.1
>
