Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386E827BF7D
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 04:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773117416; cv=pass; b=uTbs3TuupNJxW8jveTd3tf+H2KNHTPAFY4NmKdYqmX8ZdFCDvb+0TVrPbHqJec4pV/QIh7OYzoQ+Zy+pI1UYnfjAkfQxlJ1XQnsejcnuu902KgTPUnsewWUw54kQzpxtTPnui76flABGWTEEArPGTGs8Z3alkaxR7RCemApUdRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773117416; c=relaxed/simple;
	bh=N8L3CMph+fFoXS9fWAlVAhuxjxaA3dTe8587pz1hJuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3sDooRQLkNmayYtzXB1zd/XzGvemQJmXJSIq80IcLJ6lclUL6XSq9LAhJpAWo/sW8UbZgcxl5d50oKnZesHeC1KBtCoVbjKGbm79IcxuQe7BLcoon0KupONtuaolEaCmD0chDX4IVd/ZkEfbdEgiY3fI8DE4I9ZA5NR8XtxtbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4y3aUvNE; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4y3aUvNE"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae49120e97so57185ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 21:36:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773117415; cv=none;
        d=google.com; s=arc-20240605;
        b=dl814+YWen/N3DiXW6tosw+w1vS/aCEcBd6suaATybwiwsEZXwnAsFbXr8JsU4vmfa
         HS4syer4BG9xVaW9JC8ZakyDD/IR21VXIY1fZkili6Q9pU6P8wjaRNTLZgLdqnIEYPof
         TOSbS1IhyPrqYQ3QjaoFwxZyrh2CugjLgi6rHU0a0RODdhbuaPrupRaLVMvG/RQx+sjo
         U97+JsdiD/RdDKLPpUFOfyYDpf9ITsKGgPKm07JPAk55sVUAw/wf91EgrRiC9BwZYOEP
         9JIaWd8/6OiKUWeCSscBEuMjJm009bRR9L1MTO1IPv6ko5m5MFrq0WYvp3lY1E5rqyXz
         AWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bWWhtzrdouIalXN1CWDFZwiJVS/W9+/FwC/d8SmBfDw=;
        fh=jnY/0JhXGBKQfDzIrBV7zy5OeLSPoXTHGZt3edsvwno=;
        b=YaU9OSSxjyHC/ZH2s3diy4dllQEc2vp+3vlkE2N+r0/RS2PC2/ALlEqN+AgbCtGSmC
         TwT0muV6AkSwK07zF4mUWQIYbekIcEnHr24+B6UMZuj8wrpFPM0OuDnGhlaHcdiWWvFD
         HTifDmpJRcXGkT67GwWGPkfjzaDSQvQ+nH89KYehDa2Qjy2iNZA7W5mUqwZuLhc5diyh
         8BaJHDvck6pTZtIz8auHRJighEhFWSm8YxZE/xFUbgdqzt4twHdUDQpMuTkfLFEo/T/m
         l95uUW3bRNVqmOlqALDOv16nOp+4sTco05f9BIh8BUvUdOWKJvg1RhpKFeotAHH4cFO8
         azxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773117415; x=1773722215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWWhtzrdouIalXN1CWDFZwiJVS/W9+/FwC/d8SmBfDw=;
        b=4y3aUvNElOawDhrwr4+cMEV0w9guh1ozzYQQYcX2w9uGQ5Z811Fvgzmfp3kYMpCuZg
         jS67C/y68IoAi3LEQmrqTkm5lYIA06LBefwQntiOmZOT6hVIniQzxKWX9ac/V/+bzm8s
         62GS25hhz3ukOFpqB+JOvO6nK7KAOyR/XOLwmQt9R2O/aUS/KJiyWPui60hSINn4lbOc
         CJFXbj8rXFQ1ZnGekWd75PNhLG3Yg20du+QqdmpTxqXHYGtC4lU8zrGYjzjGlByOIR4W
         WWzhUxPMAI6XghC5b4j6yi2I+wsEh2c7L+/WMXQFdBfoQgPL9YZVlW+v7Jrss54YT637
         /Z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773117415; x=1773722215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bWWhtzrdouIalXN1CWDFZwiJVS/W9+/FwC/d8SmBfDw=;
        b=Qn6frbHbPzh7hhzF9iMOS4ZhgA3pfySknQY6hFlqMLIw4C6DgsCTjJN7MKJNlXeqLK
         AEFaqv4a4xTN6IG6EgIkBXOU+NkoHXmBHkWNZesPG0WPeQfDbmRfTVi00eQiHVGDkWNN
         zWgsNzkLiGvaAB4LeiRqy/ZQnBAnVXlXsmC2XSisOnC5h/7PNVvwk9xVKj4NRStu7Pe7
         QJXoc0CPbrpNo8nW6qArD0+PDrP4NxPgVsk8KNrUIos9JTJHI/qeu98DKwNNa3PDfGpM
         qMTWr1LFqWhOGbXMhKfj6aPSfWpi+ZXuOylAgw8SN601iMGS/HJ7UCOX+lmdv7tXtVYT
         IAfw==
X-Forwarded-Encrypted: i=1; AJvYcCX/EdIeykcE8cFFQzU2j1k25tAY2jErc93Vd8kZQOYQuLNHgWaS3ouAu2hUI4cjvU23DNBiH1/qcX+hTbCwA92e@vger.kernel.org
X-Gm-Message-State: AOJu0YxGldIT60znXfLEXa8Rjvy2Opttk05N11TLTVTkfSja2rWup6V8
	6xPhzBoOekOKfP9nOKtbyz2HZvq6COs3NxwKw+pjHV2yW+M8OATGBUeQCiBh2lKch+mgX6uf/by
	vgOPGazSdoT6I7D958+V9klNHboxxFUp3819cq7Ag
X-Gm-Gg: ATEYQzw9JUa1fsKVzWV8nb6Y8KGm/p8GhYABN1fHffc1NYX/lfcvDS8bJvn9L7I3RII
	on7b1LFfQOTiYy/U9N7/MLLA06RsaurcbVTrUKeoI4n2Cc1HhfQ3Vs3cHanbCIs9IgV+TIPhbAc
	CrLAnb3UF4ijQdy/Wjx3Y0b0QvgQkNbijTx0uTi1ZZ9dJuGiKtMplL7GArfSvAlTKKjMO77K4RI
	k3yO+mRo23EvOrFwLo/awpzbDqJeIEEzo7RFwH3BLq+40if0eujrEy5/FO0owqnBGtx9KEDpI58
	cr0zQlOF
X-Received: by 2002:a17:903:4b27:b0:2ad:ab68:f2c3 with SMTP id
 d9443c01a7336-2aea4561625mr1023755ad.13.1773117413838; Mon, 09 Mar 2026
 21:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
 <20251029102136.61364-13-dapeng1.mi@linux.intel.com> <CAP-5=fUDfgSC9CcJWg9CpKQo4aTdFbD89_XcmVX8OivRLoEAcA@mail.gmail.com>
 <0e6df3b8-d9c7-4b0e-99d4-eb5dd73a5a5e@linux.intel.com>
In-Reply-To: <0e6df3b8-d9c7-4b0e-99d4-eb5dd73a5a5e@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 21:36:41 -0700
X-Gm-Features: AaiRm52OaTZ-fQW3_bKO6LT9t4UveeG_grxGqYqrq-4oLkZzp8ZbU3gjcWhMpwM
Message-ID: <CAP-5=fUAky0k3NUdWejkiKvjE-6PH=3V2Giaz=+DcQ6=FhkH6g@mail.gmail.com>
Subject: Re: [Patch v9 12/12] perf/x86/intel: Add counter group support for arch-PEBS
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
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

On Mon, Mar 9, 2026 at 7:06=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.c=
om> wrote:
>
>
> On 3/10/2026 6:59 AM, Ian Rogers wrote:
> > On Wed, Oct 29, 2025 at 3:25=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.int=
el.com> wrote:
> >> Base on previous adaptive PEBS counter snapshot support, add counter
> >> group support for architectural PEBS. Since arch-PEBS shares same
> >> counter group layout with adaptive PEBS, directly reuse
> >> __setup_pebs_counter_group() helper to process arch-PEBS counter group=
.
> >>
> >> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >> ---
> >>  arch/x86/events/intel/core.c      | 38 ++++++++++++++++++++++++++++--=
-
> >>  arch/x86/events/intel/ds.c        | 29 ++++++++++++++++++++---
> >>  arch/x86/include/asm/msr-index.h  |  6 +++++
> >>  arch/x86/include/asm/perf_event.h | 13 ++++++++---
> >>  4 files changed, 77 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core=
.c
> >> index 75cba28b86d5..cb64018321dd 100644
> >> --- a/arch/x86/events/intel/core.c
> >> +++ b/arch/x86/events/intel/core.c
> >> @@ -3014,6 +3014,17 @@ static void intel_pmu_enable_event_ext(struct p=
erf_event *event)
> >>
> >>                         if (pebs_data_cfg & PEBS_DATACFG_LBRS)
> >>                                 ext |=3D ARCH_PEBS_LBR & cap.caps;
> >> +
> >> +                       if (pebs_data_cfg &
> >> +                           (PEBS_DATACFG_CNTR_MASK << PEBS_DATACFG_CN=
TR_SHIFT))
> >> +                               ext |=3D ARCH_PEBS_CNTR_GP & cap.caps;
> >> +
> >> +                       if (pebs_data_cfg &
> >> +                           (PEBS_DATACFG_FIX_MASK << PEBS_DATACFG_FIX=
_SHIFT))
> >> +                               ext |=3D ARCH_PEBS_CNTR_FIXED & cap.ca=
ps;
> >> +
> >> +                       if (pebs_data_cfg & PEBS_DATACFG_METRICS)
> >> +                               ext |=3D ARCH_PEBS_CNTR_METRICS & cap.=
caps;
> >>                 }
> >>
> >>                 if (cpuc->n_pebs =3D=3D cpuc->n_large_pebs)
> >> @@ -3038,6 +3049,9 @@ static void intel_pmu_enable_event_ext(struct pe=
rf_event *event)
> >>                 }
> >>         }
> >>
> >> +       if (is_pebs_counter_event_group(event))
> >> +               ext |=3D ARCH_PEBS_CNTR_ALLOW;
> >> +
> >>         if (cpuc->cfg_c_val[hwc->idx] !=3D ext)
> >>                 __intel_pmu_update_event_ext(hwc->idx, ext);
> >>  }
> >> @@ -4323,6 +4337,20 @@ static bool intel_pmu_is_acr_group(struct perf_=
event *event)
> >>         return false;
> >>  }
> >>
> >> +static inline bool intel_pmu_has_pebs_counter_group(struct pmu *pmu)
> >> +{
> >> +       u64 caps;
> >> +
> >> +       if (x86_pmu.intel_cap.pebs_format >=3D 6 && x86_pmu.intel_cap.=
pebs_baseline)
> >> +               return true;
> >> +
> >> +       caps =3D hybrid(pmu, arch_pebs_cap).caps;
> >> +       if (x86_pmu.arch_pebs && (caps & ARCH_PEBS_CNTR_MASK))
> >> +               return true;
> >> +
> >> +       return false;
> >> +}
> >> +
> >>  static inline void intel_pmu_set_acr_cntr_constr(struct perf_event *e=
vent,
> >>                                                  u64 *cause_mask, int =
*num)
> >>  {
> >> @@ -4471,8 +4499,7 @@ static int intel_pmu_hw_config(struct perf_event=
 *event)
> >>         }
> >>
> >>         if ((event->attr.sample_type & PERF_SAMPLE_READ) &&
> >> -           (x86_pmu.intel_cap.pebs_format >=3D 6) &&
> >> -           x86_pmu.intel_cap.pebs_baseline &&
> >> +           intel_pmu_has_pebs_counter_group(event->pmu) &&
> >>             is_sampling_event(event) &&
> >>             event->attr.precise_ip)
> >>                 event->group_leader->hw.flags |=3D PERF_X86_EVENT_PEBS=
_CNTR;
> >> @@ -5420,6 +5447,8 @@ static inline void __intel_update_large_pebs_fla=
gs(struct pmu *pmu)
> >>         x86_pmu.large_pebs_flags |=3D PERF_SAMPLE_TIME;
> >>         if (caps & ARCH_PEBS_LBR)
> >>                 x86_pmu.large_pebs_flags |=3D PERF_SAMPLE_BRANCH_STACK=
;
> >> +       if (caps & ARCH_PEBS_CNTR_MASK)
> >> +               x86_pmu.large_pebs_flags |=3D PERF_SAMPLE_READ;
> >>
> >>         if (!(caps & ARCH_PEBS_AUX))
> >>                 x86_pmu.large_pebs_flags &=3D ~PERF_SAMPLE_DATA_SRC;
> >> @@ -7134,8 +7163,11 @@ __init int intel_pmu_init(void)
> >>          * Many features on and after V6 require dynamic constraint,
> >>          * e.g., Arch PEBS, ACR.
> >>          */
> >> -       if (version >=3D 6)
> >> +       if (version >=3D 6) {
> >>                 x86_pmu.flags |=3D PMU_FL_DYN_CONSTRAINT;
> >> +               x86_pmu.late_setup =3D intel_pmu_late_setup;
> >> +       }
> >> +
> >>         /*
> >>          * Install the hw-cache-events table:
> >>          */
> >> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> >> index c66e9b562de3..c93bf971d97b 100644
> >> --- a/arch/x86/events/intel/ds.c
> >> +++ b/arch/x86/events/intel/ds.c
> >> @@ -1530,13 +1530,20 @@ pebs_update_state(bool needed_cb, struct cpu_h=
w_events *cpuc,
> >>
> >>  u64 intel_get_arch_pebs_data_config(struct perf_event *event)
> >>  {
> >> +       struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> >>         u64 pebs_data_cfg =3D 0;
> >> +       u64 cntr_mask;
> >>
> >>         if (WARN_ON(event->hw.idx < 0 || event->hw.idx >=3D X86_PMC_ID=
X_MAX))
> >>                 return 0;
> >>
> >>         pebs_data_cfg |=3D pebs_update_adaptive_cfg(event);
> >>
> >> +       cntr_mask =3D (PEBS_DATACFG_CNTR_MASK << PEBS_DATACFG_CNTR_SHI=
FT) |
> >> +                   (PEBS_DATACFG_FIX_MASK << PEBS_DATACFG_FIX_SHIFT) =
|
> >> +                   PEBS_DATACFG_CNTR | PEBS_DATACFG_METRICS;
> >> +       pebs_data_cfg |=3D cpuc->pebs_data_cfg & cntr_mask;
> >> +
> >>         return pebs_data_cfg;
> >>  }
> >>
> >> @@ -2444,6 +2451,24 @@ static void setup_arch_pebs_sample_data(struct =
perf_event *event,
> >>                 }
> >>         }
> >>
> >> +       if (header->cntr) {
> >> +               struct arch_pebs_cntr_header *cntr =3D next_record;
> >> +               unsigned int nr;
> >> +
> >> +               next_record +=3D sizeof(struct arch_pebs_cntr_header);
> >> +
> >> +               if (is_pebs_counter_event_group(event)) {
> >> +                       __setup_pebs_counter_group(cpuc, event,
> >> +                               (struct pebs_cntr_header *)cntr, next_=
record);
> >> +                       data->sample_flags |=3D PERF_SAMPLE_READ;
> >> +               }
> >> +
> >> +               nr =3D hweight32(cntr->cntr) + hweight32(cntr->fixed);
> >> +               if (cntr->metrics =3D=3D INTEL_CNTR_METRICS)
> >> +                       nr +=3D 2;
> >> +               next_record +=3D nr * sizeof(u64);
> >> +       }
> >> +
> >>         /* Parse followed fragments if there are. */
> >>         if (arch_pebs_record_continued(header)) {
> >>                 at =3D at + header->size;
> >> @@ -3094,10 +3119,8 @@ static void __init intel_ds_pebs_init(void)
> >>                         break;
> >>
> >>                 case 6:
> >> -                       if (x86_pmu.intel_cap.pebs_baseline) {
> >> +                       if (x86_pmu.intel_cap.pebs_baseline)
> >>                                 x86_pmu.large_pebs_flags |=3D PERF_SAM=
PLE_READ;
> >> -                               x86_pmu.late_setup =3D intel_pmu_late_=
setup;
> >> -                       }
> > Hi Dapeng,
> >
> > I'm trying to understand why the late_setup initialization was changed
> > here and its connection with counter group support. I couldn't find a
> > mention in the commit message.
>
> It's because arch-PEBS also supports counters group sampling, not just th=
e
> legacy PEBS with PEBS format 6. Currently ACR (auto counter reload) and
> PEBS both needs the late_setup, ACR and counters group sampling (regardle=
ss
> of legacy PEBS or arch-PEBS) are introduced since Perfmon v6, so the
> late_setup initialization is moved to the unified place of perfmon v6
> initialization. Thanks.

Ah, okay. I think it would have been clearer if those changes and the
counter group changes were kept in separate patches. Anyway, this code
has landed and nothing broke with this change.

Thanks,
Ian

>
> >
> > Thanks,
> > Ian
> >
> >>                         fallthrough;
> >>                 case 5:
> >>                         x86_pmu.pebs_ept =3D 1;
> >> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/m=
sr-index.h
> >> index f1ef9ac38bfb..65cc528fbad8 100644
> >> --- a/arch/x86/include/asm/msr-index.h
> >> +++ b/arch/x86/include/asm/msr-index.h
> >> @@ -334,12 +334,18 @@
> >>  #define ARCH_PEBS_INDEX_WR_SHIFT       4
> >>
> >>  #define ARCH_PEBS_RELOAD               0xffffffff
> >> +#define ARCH_PEBS_CNTR_ALLOW           BIT_ULL(35)
> >> +#define ARCH_PEBS_CNTR_GP              BIT_ULL(36)
> >> +#define ARCH_PEBS_CNTR_FIXED           BIT_ULL(37)
> >> +#define ARCH_PEBS_CNTR_METRICS         BIT_ULL(38)
> >>  #define ARCH_PEBS_LBR_SHIFT            40
> >>  #define ARCH_PEBS_LBR                  (0x3ull << ARCH_PEBS_LBR_SHIFT=
)
> >>  #define ARCH_PEBS_VECR_XMM             BIT_ULL(49)
> >>  #define ARCH_PEBS_GPR                  BIT_ULL(61)
> >>  #define ARCH_PEBS_AUX                  BIT_ULL(62)
> >>  #define ARCH_PEBS_EN                   BIT_ULL(63)
> >> +#define ARCH_PEBS_CNTR_MASK            (ARCH_PEBS_CNTR_GP | ARCH_PEBS=
_CNTR_FIXED | \
> >> +                                        ARCH_PEBS_CNTR_METRICS)
> >>
> >>  #define MSR_IA32_RTIT_CTL              0x00000570
> >>  #define RTIT_CTL_TRACEEN               BIT(0)
> >> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/=
perf_event.h
> >> index 3b3848f0d339..7276ba70c88a 100644
> >> --- a/arch/x86/include/asm/perf_event.h
> >> +++ b/arch/x86/include/asm/perf_event.h
> >> @@ -141,16 +141,16 @@
> >>  #define ARCH_PERFMON_EVENTS_COUNT                      7
> >>
> >>  #define PEBS_DATACFG_MEMINFO   BIT_ULL(0)
> >> -#define PEBS_DATACFG_GP        BIT_ULL(1)
> >> +#define PEBS_DATACFG_GP                BIT_ULL(1)
> >>  #define PEBS_DATACFG_XMMS      BIT_ULL(2)
> >>  #define PEBS_DATACFG_LBRS      BIT_ULL(3)
> >> -#define PEBS_DATACFG_LBR_SHIFT 24
> >>  #define PEBS_DATACFG_CNTR      BIT_ULL(4)
> >> +#define PEBS_DATACFG_METRICS   BIT_ULL(5)
> >> +#define PEBS_DATACFG_LBR_SHIFT 24
> >>  #define PEBS_DATACFG_CNTR_SHIFT        32
> >>  #define PEBS_DATACFG_CNTR_MASK GENMASK_ULL(15, 0)
> >>  #define PEBS_DATACFG_FIX_SHIFT 48
> >>  #define PEBS_DATACFG_FIX_MASK  GENMASK_ULL(7, 0)
> >> -#define PEBS_DATACFG_METRICS   BIT_ULL(5)
> >>
> >>  /* Steal the highest bit of pebs_data_cfg for SW usage */
> >>  #define PEBS_UPDATE_DS_SW      BIT_ULL(63)
> >> @@ -603,6 +603,13 @@ struct arch_pebs_lbr_header {
> >>         u64 ler_info;
> >>  };
> >>
> >> +struct arch_pebs_cntr_header {
> >> +       u32 cntr;
> >> +       u32 fixed;
> >> +       u32 metrics;
> >> +       u32 reserved;
> >> +};
> >> +
> >>  /*
> >>   * AMD Extended Performance Monitoring and Debug cpuid feature detect=
ion
> >>   */
> >> --
> >> 2.34.1
> >>
>
