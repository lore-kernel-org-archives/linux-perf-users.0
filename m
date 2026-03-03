Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01F9390991
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Mar 2026 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772497232; cv=pass; b=lnED7I5drm9SrB0ge5GbbOJyKECJ6cAZ1Qo3cyz9ieZQiLdvuoe8zSjaqu/3mwbF+kbgWzQzE2gm4TmZZQV0BIPk7E2I96N5xtR5PV0bHK8G9UonBKHJFEBUevhManXO7BR2QghkbfKPIbcqYObSTuezmNG0+owiKCGCoayjVog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772497232; c=relaxed/simple;
	bh=X3i2B1YXg99K4IE5nQTShNxl4Q0Q4i8tgn5tw6OYQl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/xmiCMEPP5h3kltUcReVJIBtERHOcyISqkJji6LuPlnVjMgLGhVLIUr7vuTtOnXts4cpyF014l/5eOU/BuPFro+O43tTyRGmZ8V9UiKMk16F81E3SWGDb8r/7ClH9JgsMxcJJvNUfzTcZo3Gf+TNu6mydzuJVKlsT0rDMOHOsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yq6hP2/o; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yq6hP2/o"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ba895adfeaso4413462eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Mar 2026 16:20:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772497230; cv=none;
        d=google.com; s=arc-20240605;
        b=NkrG8m6bjQhS/w7sOg2JkNPlYrgvvRZ9Q83gCU5NcJNsyCWkO9BCnX37wR/1CZAIwr
         TdyICkETuD0e7zddBZHDeC+ng4C+8Rzg2pQfeK8M7rpiAXbkcZEjGdmEXVBlnuQy82dz
         g7tkN0GLY1P6CXsEBvFqbvbACCrEOPpToUg+59simaua7RxdoOLiV5Z3YpqgeXSciokQ
         eTdvFWusB8ilgbobHOepg9xw5g3+tno1qTKoT1C3s1MYIuNEJd4KsEtO840P1dqOi6CU
         QEb4Xrbr67Qo/+0ew/q54PccuvNLp+PEwJwP2jD2lmuXy8kx5gj2AOzSnIBjCMK+y2kx
         TLAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v4AoBPcIFbDH69i/y7q92CNBH8pnvXhSJ/TRQzp4C+c=;
        fh=/drWCHvwN1fqSPX8kUNaRee0kkpyZUz47bkZORvq7wM=;
        b=RY6ZXDPYC2gdwa7SI4j9+PUeiEjsiHlN7T0QOlK7Pt/q+lDbAz0IMkuTrUCuvjDsiW
         ZhCAXgeTBUN3BNNdvWLfhb4ZqxOp3EPNu3fxYUMA5N3vdz8FoiSiF9Ietyj1uL2mlsHP
         RKqLjxgEMCVESMxexTukjfmnoncbTEOKvTTbUfsa7MFoX7vSnM+z4fT2HB4XbUloPy6b
         1QGgLyh35FyxqIqtTQI94ryiEhxM33VVyujq231GfPeFA5naEPgvCeLMhTuLRC2pMZ1V
         B041oz50iYOBz2qX+DuKGxloD0M64PFruwEvUstIujjMKRKFMrpsfDnlGqHiPNspTW1s
         CmOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772497230; x=1773102030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4AoBPcIFbDH69i/y7q92CNBH8pnvXhSJ/TRQzp4C+c=;
        b=Yq6hP2/oCKxctl758+6fPyO5TtMwP/l0vbfmidsaLCcQRYKGtSOLulzQgLVWv4KwbA
         9ET/qjnl3kj+CtKr8GbLNEV5NYLlVYnFUq7/AtHV+WCB9IcPzIUA4Jx8pBmNrUT49Pq9
         IFSivQxvo53BeRtGIsObxtT8RY6F6egrv21KFe/gq5wT8LaUQxn1ru4iNiJBN9K64Pmo
         FtCXd57uN80Hi51JI0fIQTNsO66Y6tyeyL8yDXw02+WnnNGB/2lUKzRkiTFFuOuy7+DK
         aarDZVP0JgSn6BecR+eDFoRNH8nzBaZ16eSntUP0ek8PY6gdda6Db47+R9Ri9+nra9E4
         iiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772497230; x=1773102030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v4AoBPcIFbDH69i/y7q92CNBH8pnvXhSJ/TRQzp4C+c=;
        b=DTOiojN4Sg1K660YTRcPVpoEhZMFKfwZLd/a8QuOsFlU6j8Zc0DtyIZp8sYfEQ/+I7
         PjA48OzS05qsiEaW73S701OOYLgGkKRIiEruzmbPxJW69HZrfpNM2WlIgNzYR+/1Xl9Y
         LfYTcm3X90SETNIjwUKPXv9b3cGRyTh+zjwoMmvKgoO+ZsidnobjD3/QSYDMc0qB9jRK
         ziBUjSIVThjpjLkryW+QgZDhZPDtG+Uheua00JBuWjrWvqsfX9VYcreEg6Kyx0LbVZBL
         +iDDEZXcYdE9cncmBHCDt4Ba1ZGukWJn5m2UOp1jLmUzuifSd3CbatVIjKKeyh+GKNvR
         G95A==
X-Forwarded-Encrypted: i=1; AJvYcCVZlNYWADM6hTnSL2Pq5ogy9+WFb75Q9MM+7wKOUvykd7xketonngpYa1rijZGQqH1lfQRXJoH+pGP57RL5eMJM@vger.kernel.org
X-Gm-Message-State: AOJu0YxbUXqnyBet0M6zWLJQGGFFCc+hgJWF7A54BYLz5aU616xrEWr1
	+kbbZQQzUiinBTexyqokLNf3Sm65+SB9ZHfwoJclFEYOCpbIz9TmE/qGS+3uXpTuldywIB77pr8
	YvbYZVR3Hf2ATPPiLZhh5y4rwOEmDBaTc8f5RQByes/iWIyFf0hqcepHG
X-Gm-Gg: ATEYQzwjvYrpExBL3WJZejJSScjvPDwEyGrX31XGZy+ZPST22DAo/0TOBeLFydQDJZr
	BbPwg2YVsmJCGFv1cJjtGSndtPiOcCk6JjrMSr5RbQWmO52IY6UwP9SDt0Gc979uHd5g08unGVq
	XFYDhERRuhJn3arz5QilrK887aSbXUO5J7norm7tbMJx5bqsYRO5RPXO3bb4/yi50jJAUri/AIq
	chuS5xlafk0tQgxHciLVGzaZZYW8W691ogy3O8Yg3urPrsV4XsZXlafg1ZXgBJDEa46D+zJHdV2
	Sl/AQtVSOAVARPgxC/9un4K50xGIskJcurcV
X-Received: by 2002:a05:7300:3211:b0:2be:1083:a371 with SMTP id
 5a478bee46e88-2be1083a9dfmr1637671eec.7.1772497229266; Mon, 02 Mar 2026
 16:20:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com> <20251029102136.61364-9-dapeng1.mi@linux.intel.com>
In-Reply-To: <20251029102136.61364-9-dapeng1.mi@linux.intel.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Mon, 2 Mar 2026 16:20:17 -0800
X-Gm-Features: AaiRm536fRzKiMooGnWyJ5JFZ0KkECPtpACPDK2CLqWVFnQBFvUnz7lMM9YO5Gk
Message-ID: <CAJpZYjUwzo7E1QknNkiJy9PDjycVcPLDEnSZL+sGWebv1hYjfQ@mail.gmail.com>
Subject: Re: [Patch v9 08/12] perf/x86/intel: Process arch-PEBS records or
 record fragments
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>, 
	Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 3:39=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> A significant difference with adaptive PEBS is that arch-PEBS record
> supports fragments which means an arch-PEBS record could be split into
> several independent fragments which have its own arch-PEBS header in
> each fragment.
>
> This patch defines architectural PEBS record layout structures and add
> helpers to process arch-PEBS records or fragments. Only legacy PEBS
> groups like basic, GPR, XMM and LBR groups are supported in this patch,
> the new added YMM/ZMM/OPMASK vector registers capturing would be
> supported in the future.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c      |  13 +++
>  arch/x86/events/intel/ds.c        | 184 ++++++++++++++++++++++++++++++
>  arch/x86/include/asm/msr-index.h  |   6 +
>  arch/x86/include/asm/perf_event.h |  96 ++++++++++++++++
>  4 files changed, 299 insertions(+)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 9ce27b326923..de4dbde28adc 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3215,6 +3215,19 @@ static int handle_pmi_common(struct pt_regs *regs,=
 u64 status)
>                         status &=3D ~GLOBAL_STATUS_PERF_METRICS_OVF_BIT;
>         }
>
> +       /*
> +        * Arch PEBS sets bit 54 in the global status register
> +        */
> +       if (__test_and_clear_bit(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT,
> +                                (unsigned long *)&status)) {
> +               handled++;
> +               static_call(x86_pmu_drain_pebs)(regs, &data);
> +
> +               if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
> +                   is_pebs_counter_event_group(cpuc->events[INTEL_PMC_ID=
X_FIXED_SLOTS]))
> +                       status &=3D ~GLOBAL_STATUS_PERF_METRICS_OVF_BIT;
> +       }
> +
>         /*
>          * Intel PT
>          */
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 68664526443f..fe1bf373409e 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2270,6 +2270,117 @@ static void setup_pebs_adaptive_sample_data(struc=
t perf_event *event,
>                         format_group);
>  }
>
> +static inline bool arch_pebs_record_continued(struct arch_pebs_header *h=
eader)
> +{
> +       /* Continue bit or null PEBS record indicates fragment follows. *=
/
> +       return header->cont || !(header->format & GENMASK_ULL(63, 16));
> +}
> +
> +static void setup_arch_pebs_sample_data(struct perf_event *event,
> +                                       struct pt_regs *iregs,
> +                                       void *__pebs,
> +                                       struct perf_sample_data *data,
> +                                       struct pt_regs *regs)
> +{
> +       struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> +       u64 sample_type =3D event->attr.sample_type;
> +       struct arch_pebs_header *header =3D NULL;
> +       struct arch_pebs_aux *meminfo =3D NULL;
> +       struct arch_pebs_gprs *gprs =3D NULL;
> +       struct x86_perf_regs *perf_regs;
> +       void *next_record;
> +       void *at =3D __pebs;
> +
> +       if (at =3D=3D NULL)
> +               return;
> +
> +       perf_regs =3D container_of(regs, struct x86_perf_regs, regs);
> +       perf_regs->xmm_regs =3D NULL;
> +
> +       __setup_perf_sample_data(event, iregs, data);
> +
> +       *regs =3D *iregs;
> +
> +again:
> +       header =3D at;
> +       next_record =3D at + sizeof(struct arch_pebs_header);
> +       if (header->basic) {
> +               struct arch_pebs_basic *basic =3D next_record;
> +               u16 retire =3D 0;
> +
> +               next_record =3D basic + 1;
> +
> +               if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT)
> +                       retire =3D basic->valid ? basic->retire : 0;
> +               __setup_pebs_basic_group(event, regs, data, sample_type,
> +                                basic->ip, basic->tsc, retire);
> +       }
> +
> +       /*
> +        * The record for MEMINFO is in front of GP
> +        * But PERF_SAMPLE_TRANSACTION needs gprs->ax.
> +        * Save the pointer here but process later.
> +        */
> +       if (header->aux) {
> +               meminfo =3D next_record;
> +               next_record =3D meminfo + 1;
> +       }
> +
> +       if (header->gpr) {
> +               gprs =3D next_record;
> +               next_record =3D gprs + 1;
> +
> +               __setup_pebs_gpr_group(event, regs,
> +                                      (struct pebs_gprs *)gprs,
> +                                      sample_type);
> +       }
> +
> +       if (header->aux) {
> +               u64 ax =3D gprs ? gprs->ax : 0;
> +
> +               __setup_pebs_meminfo_group(event, data, sample_type,
> +                                          meminfo->cache_latency,
> +                                          meminfo->instr_latency,
> +                                          meminfo->address, meminfo->aux=
,
> +                                          meminfo->tsx_tuning, ax);
> +       }
> +
> +       if (header->xmm) {
> +               struct pebs_xmm *xmm;
> +
> +               next_record +=3D sizeof(struct arch_pebs_xer_header);
> +
> +               xmm =3D next_record;
> +               perf_regs->xmm_regs =3D xmm->xmm;
> +               next_record =3D xmm + 1;
> +       }
> +
> +       if (header->lbr) {
> +               struct arch_pebs_lbr_header *lbr_header =3D next_record;
> +               struct lbr_entry *lbr;
> +               int num_lbr;
> +
> +               next_record =3D lbr_header + 1;
> +               lbr =3D next_record;
> +
> +               num_lbr =3D header->lbr =3D=3D ARCH_PEBS_LBR_NUM_VAR ?
> +                               lbr_header->depth :
> +                               header->lbr * ARCH_PEBS_BASE_LBR_ENTRIES;
> +               next_record +=3D num_lbr * sizeof(struct lbr_entry);
> +
> +               if (has_branch_stack(event)) {
> +                       intel_pmu_store_pebs_lbrs(lbr);
> +                       intel_pmu_lbr_save_brstack(data, cpuc, event);
> +               }
> +       }
> +
> +       /* Parse followed fragments if there are. */
> +       if (arch_pebs_record_continued(header)) {
> +               at =3D at + header->size;

If the header->size is 0, will it cause infinite loop?
I can see a 0 check below but not here.

Thanks,
CT

> +               goto again;
> +       }
> +}
> +
>  static inline void *
>  get_next_pebs_record_by_bit(void *base, void *top, int bit)
>  {
> @@ -2753,6 +2864,78 @@ static void intel_pmu_drain_pebs_icl(struct pt_reg=
s *iregs, struct perf_sample_d
>                                             setup_pebs_adaptive_sample_da=
ta);
>  }
>
> +static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
> +                                     struct perf_sample_data *data)
> +{
> +       short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] =3D {};
> +       void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
> +       struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> +       union arch_pebs_index index;
> +       struct x86_perf_regs perf_regs;
> +       struct pt_regs *regs =3D &perf_regs.regs;
> +       void *base, *at, *top;
> +       u64 mask;
> +
> +       rdmsrq(MSR_IA32_PEBS_INDEX, index.whole);
> +
> +       if (unlikely(!index.wr)) {
> +               intel_pmu_pebs_event_update_no_drain(cpuc, X86_PMC_IDX_MA=
X);
> +               return;
> +       }
> +
> +       base =3D cpuc->ds_pebs_vaddr;
> +       top =3D (void *)((u64)cpuc->ds_pebs_vaddr +
> +                      (index.wr << ARCH_PEBS_INDEX_WR_SHIFT));
> +
> +       index.wr =3D 0;
> +       index.full =3D 0;
> +       wrmsrq(MSR_IA32_PEBS_INDEX, index.whole);
> +
> +       mask =3D hybrid(cpuc->pmu, arch_pebs_cap).counters & cpuc->pebs_e=
nabled;
> +
> +       if (!iregs)
> +               iregs =3D &dummy_iregs;
> +
> +       /* Process all but the last event for each counter. */
> +       for (at =3D base; at < top;) {
> +               struct arch_pebs_header *header;
> +               struct arch_pebs_basic *basic;
> +               u64 pebs_status;
> +
> +               header =3D at;
> +
> +               if (WARN_ON_ONCE(!header->size))
> +                       break;
> +
> +               /* 1st fragment or single record must have basic group */
> +               if (!header->basic) {
> +                       at +=3D header->size;
> +                       continue;
> +               }
> +
> +               basic =3D at + sizeof(struct arch_pebs_header);
> +               pebs_status =3D mask & basic->applicable_counters;
> +               __intel_pmu_handle_pebs_record(iregs, regs, data, at,
> +                                              pebs_status, counts, last,
> +                                              setup_arch_pebs_sample_dat=
a);
> +
> +               /* Skip non-last fragments */
> +               while (arch_pebs_record_continued(header)) {
> +                       if (!header->size)
> +                               break;
> +                       at +=3D header->size;
> +                       header =3D at;
> +               }
> +
> +               /* Skip last fragment or the single record */
> +               at +=3D header->size;
> +       }
> +
> +       __intel_pmu_handle_last_pebs_record(iregs, regs, data, mask,
> +                                           counts, last,
> +                                           setup_arch_pebs_sample_data);
> +}
> +
>  static void __init intel_arch_pebs_init(void)
>  {
>         /*
> @@ -2762,6 +2945,7 @@ static void __init intel_arch_pebs_init(void)
>          */
>         x86_pmu.arch_pebs =3D 1;
>         x86_pmu.pebs_buffer_size =3D PEBS_BUFFER_SIZE;
> +       x86_pmu.drain_pebs =3D intel_pmu_drain_arch_pebs;
>         x86_pmu.pebs_capable =3D ~0ULL;
>
>         x86_pmu.pebs_enable =3D __intel_pmu_pebs_enable;
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-=
index.h
> index 9e1720d73244..fc7a4e7c718d 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -327,6 +327,12 @@
>                                          PERF_CAP_PEBS_FORMAT | PERF_CAP_=
PEBS_BASELINE | \
>                                          PERF_CAP_PEBS_TIMING_INFO)
>
> +/* Arch PEBS */
> +#define MSR_IA32_PEBS_BASE             0x000003f4
> +#define MSR_IA32_PEBS_INDEX            0x000003f5
> +#define ARCH_PEBS_OFFSET_MASK          0x7fffff
> +#define ARCH_PEBS_INDEX_WR_SHIFT       4
> +
>  #define MSR_IA32_RTIT_CTL              0x00000570
>  #define RTIT_CTL_TRACEEN               BIT(0)
>  #define RTIT_CTL_CYCLEACC              BIT(1)
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/per=
f_event.h
> index 0dfa06722bab..3b3848f0d339 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -437,6 +437,8 @@ static inline bool is_topdown_idx(int idx)
>  #define GLOBAL_STATUS_LBRS_FROZEN              BIT_ULL(GLOBAL_STATUS_LBR=
S_FROZEN_BIT)
>  #define GLOBAL_STATUS_TRACE_TOPAPMI_BIT                55
>  #define GLOBAL_STATUS_TRACE_TOPAPMI            BIT_ULL(GLOBAL_STATUS_TRA=
CE_TOPAPMI_BIT)
> +#define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT  54
> +#define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD      BIT_ULL(GLOBAL_STATUS_ARC=
H_PEBS_THRESHOLD_BIT)
>  #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT     48
>
>  #define GLOBAL_CTRL_EN_PERF_METRICS            BIT_ULL(48)
> @@ -507,6 +509,100 @@ struct pebs_cntr_header {
>
>  #define INTEL_CNTR_METRICS             0x3
>
> +/*
> + * Arch PEBS
> + */
> +union arch_pebs_index {
> +       struct {
> +               u64 rsvd:4,
> +                   wr:23,
> +                   rsvd2:4,
> +                   full:1,
> +                   en:1,
> +                   rsvd3:3,
> +                   thresh:23,
> +                   rsvd4:5;
> +       };
> +       u64 whole;
> +};
> +
> +struct arch_pebs_header {
> +       union {
> +               u64 format;
> +               struct {
> +                       u64 size:16,    /* Record size */
> +                           rsvd:14,
> +                           mode:1,     /* 64BIT_MODE */
> +                           cont:1,
> +                           rsvd2:3,
> +                           cntr:5,
> +                           lbr:2,
> +                           rsvd3:7,
> +                           xmm:1,
> +                           ymmh:1,
> +                           rsvd4:2,
> +                           opmask:1,
> +                           zmmh:1,
> +                           h16zmm:1,
> +                           rsvd5:5,
> +                           gpr:1,
> +                           aux:1,
> +                           basic:1;
> +               };
> +       };
> +       u64 rsvd6;
> +};
> +
> +struct arch_pebs_basic {
> +       u64 ip;
> +       u64 applicable_counters;
> +       u64 tsc;
> +       u64 retire      :16,    /* Retire Latency */
> +           valid       :1,
> +           rsvd        :47;
> +       u64 rsvd2;
> +       u64 rsvd3;
> +};
> +
> +struct arch_pebs_aux {
> +       u64 address;
> +       u64 rsvd;
> +       u64 rsvd2;
> +       u64 rsvd3;
> +       u64 rsvd4;
> +       u64 aux;
> +       u64 instr_latency       :16,
> +           pad2                :16,
> +           cache_latency       :16,
> +           pad3                :16;
> +       u64 tsx_tuning;
> +};
> +
> +struct arch_pebs_gprs {
> +       u64 flags, ip, ax, cx, dx, bx, sp, bp, si, di;
> +       u64 r8, r9, r10, r11, r12, r13, r14, r15, ssp;
> +       u64 rsvd;
> +};
> +
> +struct arch_pebs_xer_header {
> +       u64 xstate;
> +       u64 rsvd;
> +};
> +
> +#define ARCH_PEBS_LBR_NAN              0x0
> +#define ARCH_PEBS_LBR_NUM_8            0x1
> +#define ARCH_PEBS_LBR_NUM_16           0x2
> +#define ARCH_PEBS_LBR_NUM_VAR          0x3
> +#define ARCH_PEBS_BASE_LBR_ENTRIES     8
> +struct arch_pebs_lbr_header {
> +       u64 rsvd;
> +       u64 ctl;
> +       u64 depth;
> +       u64 ler_from;
> +       u64 ler_to;
> +       u64 ler_info;
> +};
> +
>  /*
>   * AMD Extended Performance Monitoring and Debug cpuid feature detection
>   */
> --
> 2.34.1
>
>
