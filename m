Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE16247DF9A
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962794; cv=pass; b=upaPs/1XFy5xncCL1BM/JEitQkJX8tIcoyKeAqkA3GQHG4PlAMrn9mHFNE/s8RcbW6xXfT6JIJfJ2BVfcmbf2K1BpI1dNmXYiI2+kOp559tzW53kQ6BltpWVo4SK8vrWehmLdeKnzDZJPjT8Xd3gW37u1m+cvwliBvEvea/YV0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962794; c=relaxed/simple;
	bh=vnktFy4VxJP8iijSoitChJIPN52dAGOqeql58zQMerw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9wLT0EC6MygnOO1j4FlRbOmqfzeAwoL66NRDU3twfTgu3nzclHfCzVx86HfwIu+aS6AU8IBDLl1TuquGHylewcYG5GfHxuvOVWvRmF8c82Syj7Z8y6ZJvLpOJWcW8QyM2TupYt82W6SDJe+2ON0V0LRRReNhKHj8RcVhZbE6yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsGNgVwn; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsGNgVwn"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1c4c7ddaf6so245864866b.3
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 13:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785962785; cv=none;
        d=google.com; s=arc-20260327;
        b=fA76Hcx5wEVSlWJuNmw+ZkTNoKgJJIaWfCMqVxTSoPn/IVRc5oEROVzi34rjaTsdLg
         vujXilSd6+1/hG26EV8976A7K3DsUATvuAYUkCMxptTiewZ/T9EqAGwykOe/skx/Dq3M
         t1APw5t5zi5wOoXGJZWAb2gzaJ6amclfl7uByZYzZXRNAaLP+W7rffzlORI+KvdTkRKG
         12LeMS5nMkCGMSEqfF15Ak38zSZI2OFGI23KuuqRU7ApLUATIQctLYpL/WIPQCILswW+
         MLRNI/UNT65lWllLVBwBaDVU1k2pmtxXzQpX2RoHbXLVrnbSWn8ym0gPo9wQvZ+ObJ5L
         TH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d6ehP1OOdismPnnYjEdSySDXWMWXnkbI0i0QBY0KayE=;
        fh=9heINQzC1/dNgk+eX3Jjxd4h8sk2Lis0ZGBgaqfz38o=;
        b=J/PZviYqFxSS/3uGAuMRZFckkXATA1zOEtetdXMQfax+np+U0HoUmy5Gt9aTL1G8mw
         NnmlkVD4ESJs9Rd4+K+OL5hJXGpGikyo8y0jrdcTCk3GQnv8WsIIq2VoVQGLYvQNok9M
         l2Qo38YC0GV9WJu2XRP0YYD3AwDikEsBrY5fvzGWgnls7LB+b1ODtDKtSxvVfuFDJBeJ
         i7lvRrql6qJXSawGECtyDnRMdZBpsVtA82LTOfNcSbM7gjQUxUFFhOp4KFrGVS0UJ9mL
         xRlbfEG56ltYhzj9QSjEg6qz2j7ioQrNt2US+YP81INN5x+lihoR2EWejJKZSlS5K09M
         Digg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785962785; x=1786567585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d6ehP1OOdismPnnYjEdSySDXWMWXnkbI0i0QBY0KayE=;
        b=NsGNgVwnoRKeBI7Wu8aP8zfI/6gAdNqCG8XtmxzVXEjKNH9QumamIIAFss53ksbomM
         Slk07LNkSsk5NWu8srEQWOJ/w4DOAYouJWgh1VVFZqy61SgJNv+LYX2MB0H9Ax7UFdx1
         mnNQTP2kjUJEyINVJAF315PC8CJpuoPSyD7j5FCwPhlghJypx54a9Owd4onXka6yb09a
         QW9RZu5gK3qErDUEnp0xaVSWP8HJ3YW9Y/4EAjI6B35V+uZFjwc7v1U177VaoQTfVvc/
         QE268ldVlQBfSAWaoXPiwhGiCPr6SUDzZyl1mCPCtPKFFzoOkyhHdST8rfL0zbGPLO1p
         Np/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785962785; x=1786567585;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d6ehP1OOdismPnnYjEdSySDXWMWXnkbI0i0QBY0KayE=;
        b=sMWCO2oHpUV8GtjoAxA+2mOB5AdUD0xiYmMdk+cLGjAt0zRDOGsxDL4avlRrCA5vvv
         RYrwxO57hBToweVa7c70xWmSwruDnKWBL49m36CDIsE0OViZ9oX8r+/U0mSp1VLw18em
         SdZze64stN6ZcQopYa/JQLoPM8ARTxRc6Wag712W3xtovIeQ1mBQcw0xYNDoAeHJwSuW
         coUWp78Myaux2GBL0HCo7kaR4PFmlRoUkRBkeLBy92GlAQfxlRwYu3XS+Pr4cY4FVfPx
         5Q/uMq7YuO6PtkzYVRIlQRFLAR1Osd7d7XUmOzNBkhRgLDRi7nMjPuvEyF3Y209ltRK/
         MTdQ==
X-Forwarded-Encrypted: i=1; AHgh+RpaGXJZ2gRLZCYkaaXUi76j5uTfC4Voi7laZYEF7hvktSWbrWiJJGVRH98c5Jx4CJmeBw4V0144ejWqQZVTd83j@vger.kernel.org
X-Gm-Message-State: AOJu0YyQxwid1q8JyJjezc646+SLeY4NQs3L12mlS0IsOvb99HKc4f1G
	fGzkd4a2hVqfyYHk8NwxQfcTxua9fqi6Nk5M27DYMjEME68hmdUqVcxFjfmhV5Do+pS8h66PDpe
	fRun7i7nfwnbo+vkv1L3xezxP/sRyZvE=
X-Gm-Gg: AR+sD10aI9wZtRw6jSgUCEda3WVGhgWApSxvk3fpFGIoaROJ/n87Is/HOr/vF9e15AZ
	c/IzFmtDqO6lShWAI6AoOubEJTEzjb8904xqB/kwL6HeTUYlgHu6ZlVkN5oTuV3bLxGYzT4fToA
	bIUP2SexAukvpLdBSBElI9saB4amUPJaQ+sItzZG3hhdRTPMYtCWNnxiVjR+zC48fM2T9ybJJPJ
	fsY8biRNCQnT2/xjE1ObskrI++RdQxVGqjfku0a+W3PCVaEIQes7fTtkma2vVDZrkels9/JNX2u
	HGR9edhtbCa+odo01aMJEo7Oleew7svi8kmBB4J/rXh9KTFh3fxK3513UsQjd3owv6+DwH7Ixdl
	bhY7R0I/LD1AP
X-Received: by 2002:a17:907:7ba5:b0:c1c:2c32:1163 with SMTP id
 a640c23a62f3a-c2039f3d9c8mr499157366b.25.1785962784949; Wed, 05 Aug 2026
 13:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616155716.2631508-1-puranjay@kernel.org> <20260616155716.2631508-4-puranjay@kernel.org>
 <8a24abbc-10bc-42bb-8fee-0a174d8f1751@linaro.org> <CANk7y0inRXCUKtuio3Cb03DvuNPq6yp1o+tsE8PZitrY0LaOPQ@mail.gmail.com>
 <6ee32efc-01be-4532-aa59-3948f59156c0@linaro.org> <CANk7y0hU_m6gJ9FpGfGUJg-Ok8PoXhKruny_0OkeOgLbCo6ZLA@mail.gmail.com>
 <9fa68534-2b12-420a-93b7-a6ada21c180e@linaro.org> <CANk7y0is-SB+hPhriwQ24v-UUTUfk9p01y1CQm=q_Y-=GXO04A@mail.gmail.com>
 <ffeea852-b55b-45b5-afcd-47dc4e6f6824@linaro.org> <CANk7y0gcj-kRCt-EgL6UK+Tc4xvJQkGz9F=HNpE86kB3fKxymA@mail.gmail.com>
 <2b402e4b-b916-4dba-bcb3-634ad58f1710@linaro.org>
In-Reply-To: <2b402e4b-b916-4dba-bcb3-634ad58f1710@linaro.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 5 Aug 2026 21:46:13 +0100
X-Gm-Features: AUfX_mzMtOJXAWmesZ33LljlU1SxNu7Lgt09GO4nloEUJiOeueVus0-9-TRT__o
Message-ID: <CANk7y0idVnFGvwKnSMnrW6_Ee1gFLWJmFrKBrjUbytgD0GVqHw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
To: James Clark <james.clark@linaro.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Leo Yan <leo.yan@arm.com>, Rob Herring <robh@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Shuah Khan <shuah@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Stephane Eranian <eranian@google.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Usama Arif <usama.arif@linux.dev>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 5:26=E2=80=AFPM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 05/08/2026 16:44, Puranjay Mohan wrote:
> > On Wed, Aug 5, 2026 at 4:14=E2=80=AFPM James Clark <james.clark@linaro.=
org> wrote:
> >>
> >>
> >>
> >> On 05/08/2026 15:43, Puranjay Mohan wrote:
> >>> On Wed, Aug 5, 2026 at 2:58=E2=80=AFPM James Clark <james.clark@linar=
o.org> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 05/08/2026 12:47, Puranjay Mohan wrote:
> >>>>> On Wed, Aug 5, 2026 at 11:07=E2=80=AFAM James Clark <james.clark@li=
naro.org> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 03/08/2026 7:54 pm, Puranjay Mohan wrote:
> >>>>>>> On Mon, Aug 3, 2026 at 12:07=E2=80=AFPM James Clark <james.clark@=
linaro.org> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 16/06/2026 16:57, Puranjay Mohan wrote:
> >>>>>>>>> Enable bpf_get_branch_snapshot() on ARM64 by implementing the
> >>>>>>>>> perf_snapshot_branch_stack static call for BRBE.
> >>>>>>>>>
> >>>>>>>>> BRBE is paused before masking exceptions to avoid branch buffer
> >>>>>>>>> pollution from trace_hardirqs_off(). Exceptions are then masked=
 with
> >>>>>>>>> local_daif_save() to prevent PMU overflow pseudo-NMIs from inte=
rfering.
> >>>>>>>>> If an overflow between pause and DAIF save re-enables BRBE, the=
 snapshot
> >>>>>>>>> detects this via BRBFCR_EL1.PAUSED and bails out.
> >>>>>>>>>
> >>>>>>>>> Branch records are read using perf_entry_from_brbe_regset() wit=
h a NULL
> >>>>>>>>> event pointer to bypass event-specific filtering. The buffer is
> >>>>>>>>> invalidated after reading.
> >>>>>>>>>
> >>>>>>>>> Introduce a for_each_brbe_entry() iterator to deduplicate bank
> >>>>>>>>> iteration between brbe_read_filtered_entries() and the snapshot=
.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> >>>>>>>>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> >>>>>>>>> ---
> >>>>>>>>>       drivers/perf/arm_brbe.c  | 128 ++++++++++++++++++++++++++=
++++++-------
> >>>>>>>>>       drivers/perf/arm_brbe.h  |   9 +++
> >>>>>>>>>       drivers/perf/arm_pmuv3.c |   5 +-
> >>>>>>>>>       3 files changed, 120 insertions(+), 22 deletions(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> >>>>>>>>> index effbdeacfcbb..a141ad7abcf2 100644
> >>>>>>>>> --- a/drivers/perf/arm_brbe.c
> >>>>>>>>> +++ b/drivers/perf/arm_brbe.c
> >>>>>>>>> @@ -9,6 +9,7 @@
> >>>>>>>>>       #include <linux/types.h>
> >>>>>>>>>       #include <linux/bitmap.h>
> >>>>>>>>>       #include <linux/perf/arm_pmu.h>
> >>>>>>>>> +#include <asm/daifflags.h>
> >>>>>>>>>       #include "arm_brbe.h"
> >>>>>>>>>
> >>>>>>>>>       #define BRBFCR_EL1_BRANCH_FILTERS (BRBFCR_EL1_DIRECT   | =
\
> >>>>>>>>> @@ -256,6 +257,14 @@ static bool valid_brbe_version(int brbe_ve=
rsion)
> >>>>>>>>>                  brbe_version =3D=3D ID_AA64DFR0_EL1_BRBE_BRBE_=
V1P1;
> >>>>>>>>>       }
> >>>>>>>>>
> >>>>>>>>> +static __always_inline bool cpu_has_brbe(void)
> >>>>>>>>
> >>>>>>>> This should be more like cpu_valid_brbe_version(). has_brbe() on=
ly
> >>>>>>>> implies that the CPU has BRBE, not that it's a version that the =
driver
> >>>>>>>> supports. And it's actually just a wrapper around valid_brbe_ver=
sion()
> >>>>>>>> that accesses the ID reg on that CPU, not a functionally differe=
nt check.
> >>>>>>>>
> >>>>>>>> But it also looks like valid_brbe_version() isn't called from an=
ywhere
> >>>>>>>> else, so why not delete that function and use its name for the n=
ew one?
> >>>>>>>
> >>>>>>> I will do that in next version
> >>>>>>>
> >>>>>>>>
> >>>>>>>>> +{
> >>>>>>>>> +     u64 aa64dfr0 =3D read_sysreg_s(SYS_ID_AA64DFR0_EL1);
> >>>>>>>>> +     int brbe =3D cpuid_feature_extract_unsigned_field(aa64dfr=
0, ID_AA64DFR0_EL1_BRBE_SHIFT);
> >>>>>>>>> +
> >>>>>>>>> +     return valid_brbe_version(brbe);
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>>       static void select_brbe_bank(int bank)
> >>>>>>>>>       {
> >>>>>>>>>           u64 brbfcr;
> >>>>>>>>> @@ -271,6 +280,20 @@ static void select_brbe_bank(int bank)
> >>>>>>>>>           isb();
> >>>>>>>>>       }
> >>>>>>>>>
> >>>>>>>>> +static inline void __brbe_advance(int *bank, int *idx, int nr_=
hw)
> >>>>>>>>> +{
> >>>>>>>>> +     if (++(*idx) >=3D BRBE_BANK_MAX_ENTRIES &&
> >>>>>>>>> +         *bank * BRBE_BANK_MAX_ENTRIES + *idx < nr_hw) {
> >>>>>>>>> +             *idx =3D 0;
> >>>>>>>>> +             select_brbe_bank(++(*bank));
> >>>>>>>>> +     }
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>> +#define for_each_brbe_entry(idx, nr_hw)                       =
               \
> >>>>>>>>> +     for (int __bank =3D (select_brbe_bank(0), 0), idx =3D 0; =
           \
> >>>>>>>>> +          __bank * BRBE_BANK_MAX_ENTRIES + idx < (nr_hw);     =
       \
> >>>>>>>>> +          __brbe_advance(&__bank, &idx, (nr_hw)))
> >>>>>>>>> +
> >>>>>>>>>       static bool __read_brbe_regset(struct brbe_regset *entry,=
 int idx)
> >>>>>>>>>       {
> >>>>>>>>>           entry->brbinf =3D get_brbinf_reg(idx);
> >>>>>>>>> @@ -474,11 +497,9 @@ unsigned int brbe_num_branch_records(const=
 struct arm_pmu *armpmu)
> >>>>>>>>>
> >>>>>>>>>       void brbe_probe(struct arm_pmu *armpmu)
> >>>>>>>>>       {
> >>>>>>>>> -     u64 brbidr, aa64dfr0 =3D read_sysreg_s(SYS_ID_AA64DFR0_EL=
1);
> >>>>>>>>> -     u32 brbe;
> >>>>>>>>> +     u64 brbidr;
> >>>>>>>>>
> >>>>>>>>> -     brbe =3D cpuid_feature_extract_unsigned_field(aa64dfr0, I=
D_AA64DFR0_EL1_BRBE_SHIFT);
> >>>>>>>>> -     if (!valid_brbe_version(brbe))
> >>>>>>>>> +     if (!cpu_has_brbe())
> >>>>>>>>>                   return;
> >>>>>>>>>
> >>>>>>>>>           brbidr =3D read_sysreg_s(SYS_BRBIDR0_EL1);
> >>>>>>>>> @@ -618,10 +639,10 @@ static bool perf_entry_from_brbe_regset(i=
nt index, struct perf_branch_entry *ent
> >>>>>>>>>
> >>>>>>>>>           brbe_set_perf_entry_type(entry, brbinf);
> >>>>>>>>>
> >>>>>>>>> -     if (!branch_sample_no_cycles(event))
> >>>>>>>>> +     if (!event || !branch_sample_no_cycles(event))
> >>>>>>>>>                   entry->cycles =3D brbinf_get_cycles(brbinf);
> >>>>>>>>>
> >>>>>>>>> -     if (!branch_sample_no_flags(event)) {
> >>>>>>>>> +     if (!event || !branch_sample_no_flags(event)) {
> >>>>>>>>>                   /* Mispredict info is available for source on=
ly and complete branch records. */
> >>>>>>>>>                   if (!brbe_record_is_target_only(brbinf)) {
> >>>>>>>>>                           entry->mispred =3D brbinf_get_mispred=
ict(brbinf);
> >>>>>>>>> @@ -774,32 +795,97 @@ void brbe_read_filtered_entries(struct pe=
rf_branch_stack *branch_stack,
> >>>>>>>>>       {
> >>>>>>>>>           struct arm_pmu *cpu_pmu =3D to_arm_pmu(event->pmu);
> >>>>>>>>>           int nr_hw =3D brbe_num_branch_records(cpu_pmu);
> >>>>>>>>> -     int nr_banks =3D DIV_ROUND_UP(nr_hw, BRBE_BANK_MAX_ENTRIE=
S);
> >>>>>>>>>           int nr_filtered =3D 0;
> >>>>>>>>>           u64 branch_sample_type =3D event->attr.branch_sample_=
type;
> >>>>>>>>>           DECLARE_BITMAP(event_type_mask, PERF_BR_ARM64_MAX);
> >>>>>>>>>
> >>>>>>>>>           prepare_event_branch_type_mask(branch_sample_type, ev=
ent_type_mask);
> >>>>>>>>>
> >>>>>>>>> -     for (int bank =3D 0; bank < nr_banks; bank++) {
> >>>>>>>>> -             int nr_remaining =3D nr_hw - (bank * BRBE_BANK_MA=
X_ENTRIES);
> >>>>>>>>> -             int nr_this_bank =3D min(nr_remaining, BRBE_BANK_=
MAX_ENTRIES);
> >>>>>>>>> +     for_each_brbe_entry(i, nr_hw) {
> >>>>>>>>> +             struct perf_branch_entry *pbe =3D &branch_stack->=
entries[nr_filtered];
> >>>>>>>>>
> >>>>>>>>> -             select_brbe_bank(bank);
> >>>>>>>>> +             if (!perf_entry_from_brbe_regset(i, pbe, event))
> >>>>>>>>> +                     break;
> >>>>>>>>>
> >>>>>>>>> -             for (int i =3D 0; i < nr_this_bank; i++) {
> >>>>>>>>> -                     struct perf_branch_entry *pbe =3D &branch=
_stack->entries[nr_filtered];
> >>>>>>>>> +             if (!filter_branch_record(pbe, branch_sample_type=
, event_type_mask))
> >>>>>>>>> +                     continue;
> >>>>>>>>>
> >>>>>>>>> -                     if (!perf_entry_from_brbe_regset(i, pbe, =
event))
> >>>>>>>>> -                             goto done;
> >>>>>>>>> +             nr_filtered++;
> >>>>>>>>> +     }
> >>>>>>>>>
> >>>>>>>>> -                     if (!filter_branch_record(pbe, branch_sam=
ple_type, event_type_mask))
> >>>>>>>>> -                             continue;
> >>>>>>>>> +     branch_stack->nr =3D nr_filtered;
> >>>>>>>>> +}
> >>>>>>>>>
> >>>>>>>>> -                     nr_filtered++;
> >>>>>>>>> -             }
> >>>>>>>>> +/*
> >>>>>>>>> + * Best-effort BRBE snapshot for BPF tracing. Pause BRBE to av=
oid
> >>>>>>>>> + * self-recording and return 0 if the snapshot state appears d=
isturbed.
> >>>>>>>>> + */
> >>>>>>>>> +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *e=
ntries, unsigned int cnt)
> >>>>>>>>> +{
> >>>>>>>>> +     unsigned long flags;
> >>>>>>>>> +     int nr_hw, nr_copied =3D 0;
> >>>>>>>>> +     u64 brbfcr, brbcr;
> >>>>>>>>> +
> >>>>>>>>> +     if (!cnt)
> >>>>>>>>> +             return 0;
> >>>>>>>>
> >>>>>>>> If you're trying to avoid branches before pausing BRBE, can't yo=
u check
> >>>>>>>> this after the pause?
> >>>>>>>
> >>>>>>> will drop this in the next version and this is just an optimizati=
on.
> >>>>>>>
> >>>>>>>>
> >>>>>>>>> +
> >>>>>>>>> +     /* Guard against running on a CPU without BRBE (e.g. big.=
LITTLE). */
> >>>>>>>>> +     if (!cpu_has_brbe())
> >>>>>>>>> +             return 0;
> >>>>>>>>> +
> >>>>>>>>> +     /*
> >>>>>>>>> +      * Pause BRBE first to avoid recording our own branches. =
The
> >>>>>>>>> +      * sysreg read/write and ISB are branchless, so pausing b=
efore
> >>>>>>>>> +      * checking BRBCR avoids polluting the buffer with our ow=
n
> >>>>>>>>> +      * conditional branches.
> >>>>>>>>> +      */
> >>>>>>>>> +     brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> >>>>>>>>> +     brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> >>>>>>>>> +     write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1=
);
> >>>>>>>>
> >>>>>>>> Can this work without first disabling interrupts? Sashiko pointe=
d it
> >>>>>>>> out, but I think it's correct. If you read an active state into =
brbfcr,
> >>>>>>>> then the PMU event fires and disables BRBE, then you disable int=
errupts,
> >>>>>>>> then you would restore an active state when it should be inactiv=
e.
> >>>>>>>> Surely the only way to do it properly is to disable interrupts b=
efore
> >>>>>>>> touching anything at all, if the PMU handler is also touching th=
e same
> >>>>>>>> registers?
> >>>>>>>>
> >>>>>>>> If you want to avoid trace_hardirqs_off() can you make a new
> >>>>>>>> raw_local_daif_save() that disables interrupts and then call
> >>>>>>>> trace_hardirqs_off() yourself after pausing BRBE? Or not call
> >>>>>>>> trace_hardirqs_off() at all? There is a comment mentioning somet=
hing
> >>>>>>>> like that in arch/arm64/kernel/suspend.c.
> >>>>>>>
> >>>>>>> Yes. I'll add raw_local_daif_save()/raw_local_daif_restore() and =
mask before
> >>>>>>> touching any BRBE register, which fixes the stale restore. trace_=
hardirqs_off()
> >>>>>>> then moves below the pause so lockdep still sees a balanced off/o=
n pair while
> >>>>>>> its branches land in an already paused buffer.
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Also, disabling interrupts doesn't stop the PMU event from overf=
lowing
> >>>>>>>> and changing the state of PAUSED either. I think this is another=
 path
> >>>>>>>> that leads to you restoring the wrong state, so don't you also n=
eed to
> >>>>>>>> disable the PMU?
> >>>>>>>
> >>>>>>> Hardware only sets PAUSED on a BRBE freeze event (RBHYTD), and a =
freeze needs
> >>>>>>> BRBE to not already be paused (RNXCWF). So once we have paused, n=
othing changes
> >>>>>>> underneath us and the PMU does not need disabling. It would not h=
elp anyway:
> >>>>>>> armv8pmu_stop() calls brbe_disable(), which zeroes BRBCR_EL1 and =
discards the
> >>>>>>> records we came to read.
> >>>>>>
> >>>>>> That does mean you throw away real freeze events while paused thou=
gh, in
> >>>>>> addition to the brbe_invalidate() you need to avoid non contiguous
> >>>>>> buffers. So it takes branches away from PMU events.
> >>>>>
> >>>>> RBHYTD gives a freeze two effects: PAUSED is set, and BRBTS_EL1 cap=
tures a
> >>>>> timestamp. Recording has already stopped because we paused, and the=
 driver never
> >>>>> reads BRBTS_EL1. On the way out we check PMOVSCLR_EL0 and leave PAU=
SED set if a
> >>>>> counter overflowed, so a pending overflow handler still finds a fro=
zen buffer.
> >>>>>
> >>>>>> So it takes branches away from PMU events.
> >>>>>
> >>>>> Yes, but that is brbe_invalidate(), not the pause. Interrupts are m=
asked and
> >>>>> nothing else runs on the CPU, so the only branches the pause suppre=
sses are the
> >>>>> snapshot's own.
> >>>>>
> >>>>>>>
> >>>>>>> You are right that a freeze can still land in the window between =
reading BRBFCR
> >>>>>>> and setting PAUSED, and restoring the value we read would then cl=
ear a PAUSED
> >>>>>>> bit the hardware set. So v6 checks PMOVSCLR_EL0 and leaves BRBE p=
aused if a
> >>>>>>> counter has overflowed. Reads of PMOVSCLR are non-destructive and=
 it stays set
> >>>>>>> until the overflow handler clears it, so it is still visible afte=
r we have set
> >>>>>>> PAUSED ourselves:
> >>>>>>>
> >>>>>>>             if (!valid_brbe_version())
> >>>>>>>                     return 0;
> >>>>>>>
> >>>>>>>             flags =3D raw_local_daif_save();
> >>>>>>>
> >>>>>>>             brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> >>>>>>>             brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> >>>>>>>
> >>>>>>>             write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR=
_EL1);
> >>>>>>>             isb();
> >>>>>>>
> >>>>>>>             trace_hardirqs_off();
> >>>>>>>
> >>>>>>>             /* BRBCR_EL1 is zero while the driver has BRBE disabl=
ed. */
> >>>>>>>             if (!brbcr)
> >>>>>>>                     goto restore;
> >>>>>>>
> >>>>>>>             ... read the records ...
> >>>>>>>
> >>>>>>
> >>>>>> Up to the point where you read the records you technically don't n=
eed
> >>>>>> any branches (if you don't do trace_hardirqs_off()) so you could d=
o the
> >>>>>> whole thing without pausing. Just disable interrupts, read every b=
ranch
> >>>>>> entry unconditionally, re-enable interrupts and then find the last=
 valid
> >>>>>> entry and do the branchy stuff after reading.
> >>>>>>
> >>>>>> I'm thinking out loud, but doesn't that make it a lot easier? And =
it
> >>>>>> avoids the brbe_invalidate() which takes the branches away from th=
e PMU
> >>>>>> event. It also avoids having to think too hard about racing with P=
MU
> >>>>>> events causing a freeze even after interrupts are disabled and aft=
er
> >>>>>> reading the freeze value:
> >>>>>>
> >>>>>>       raw_local_daif_save();
> >>>>>>       brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> >>>>>>       brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> >>>>>>       select_bank(0);
> >>>>>>       read_record(0);
> >>>>>>       read_record(1);
> >>>>>>       ...
> >>>>>>       select_bank(0);
> >>>>>>       read_record(0);
> >>>>>>       read_record(1);
> >>>>>>       ...
> >>>>>>       write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> >>>>>>       isb();
> >>>>>>       local_daif_restore();
> >>>>>>
> >>>>>>       /* Now do post processing, find last valid record, check if =
it was
> >>>>>> enabled by looking at brbcr etc. */
> >>>>>
> >>>>> MRS is not a branch, so that works, but three things would have to =
change:
> >>>>>
> >>>>> 1. perf_entry_from_brbe_regset() goes through BRBE_REGN_SWITCH, a 3=
2 case
> >>>>>       switch, because the register number has to be an immediate. g=
cc emits a jump
> >>>>>       table and the function has 52 branches in the object file. Th=
e read would
> >>>>>       need full unrolling.
> >>>>>
> >>>>
> >>>> Yes you would have to manually unroll it. I doubt the compiler would
> >>>> emit a branch for BRBE_REGN_SWITCH() because your indexes are static=
 if
> >>>> it's unrolled. But if it does you can change it to a sequence of
> >>>> read_sysreg_s()s.
> >>>>
> >>>> If you really want to be sure there are no branches, write it in a
> >>>> single asm block.
> >>>
> >>> I will try that approach in the next version.
> >>>
> >>>>> 2. RPGDLX needs an ISB before the reads, and Table D19-10 makes it
> >>>>>       IMPLEMENTATION DEFINED whether ISB itself generates a record.=
 When we pause,
> >>>>>       IZCHRF means the pausing ISB cannot pollute the buffer it is =
about to read.
> >>>>>
> >>>>
> >>>> I assume one potential extra record from the isb() is acceptible see=
ing
> >>>> as you already have two or more conditions plus a function call befo=
re
> >>>> the pause? Is the problem that you don't know whether to filter it o=
ut
> >>>> later because it's IMPDEF and isn't always there? You already don't =
know
> >>>> exactly how many branches there will be before the pause beause it's
> >>>> written in C. So I'm not sure what the exact issue here is.
> >>>>
> >>>>> 3. 64 record parts still need a bank switch, so BRBFCR_EL1 still ha=
s to be
> >>>>>       written and restored.
> >>>>>
> >>>>
> >>>> Yes that was included in my pseudo code example but it's still
> >>>> branchless. I did miss that you might need an isb() after disabling
> >>>> interrupts, but you added one for RPGDLX anyway.
> >>>>
> >>>>> Correctness would then depend on the read staying branchless, which=
 is not
> >>>>> checkable at build time and fails silently: a branch mid read shift=
s the buffer,
> >>>>
> >>>> Why would the compiler insert a branch between two read_sysreg_s()s,
> >>>> which are asm volatile? Is that allowed?
> >>>
> >>> You are right, I just over complicated it!
> >>>
> >>>>> giving a duplicate and a gap. 64 * 24 bytes of records also wants a=
 per-CPU
> >>>>> scratch buffer rather than the stack.
> >>>>>
> >>>>
> >>>> A per-CPU scratch buffer doesn't sound too bad. But aren't you in
> >>>> control of how many entries are available to write to? You can rejec=
t
> >>>> any calls that have fewer than 64 and always write directly to *entr=
ies.
> >>>>
> >>>> You could also compare with 'cnt' after reading each record and exit=
 the
> >>>> read section. Like you say below, branches not taken don't generate
> >>>> records, and once the branch is taken you stop reading so after that
> >>>> point generating records doesn't matter.
> >>>>
> >>>>> Happy to prototype it. What I would not do is pause without invalid=
ating:
> >>>>> records are from/to pairs, so a consumer walking across the hole re=
constructs a
> >>>>> call path that never happened. The invalidate was Mark's request af=
ter the RFC,
> >>>>> "to maintain record contiguity for other consumers", so dropping th=
e pause drops
> >>>>> that too.
> >>>>
> >>>> Well the point was to not have to pause at all, so there's no need t=
o
> >>>> invalidate either. Even if you did add a pause, as long as there are=
 no
> >>>> branches between the pause and resume you don't need an invalidate
> >>>> because you didn't miss any branches.
> >>>>
> >>>>>
> >>>>> I was thinking of this for v6:
> >>>>>
> >>>>>            flags =3D raw_local_daif_save();
> >>>>>
> >>>>>            /* The BRBE sysregs below are UNDEFINED without this. */
> >>>>>            if (!valid_brbe_version()) {
> >>>>
> >>>> You don't need to disable interrupts to call this, it's a constant. =
Or
> >>>> is it to stop migration?
> >>>
> >>> It was to stop migration.
> >>>
> >>
> >> Ah ok, so V5 wasn't correct then.
> >
> > Yes, It was buggy! I missed that one CPU could implement BRBE while
> > another doesn't
> >
> >>
> >> Separately to this, I'm also not sure how this BPF call is invoked. Is
> >> it supposed to target a CPU, or an event or a process? How do you know
> >> you are getting the branches from the CPU that you want?
> >
> > So, A BPF program can attach to a function's entry through ftrace or
> > kprobe and from there we call this helper to find out what branches
> > were taken to reach that function.
> > A BPF program runs on a CPU with migration always disabled, so it
>
> In that case you can check for BRBE support before disabling interrupts.
>
> So I think V5 wasn't buggy and you can carry on doing
> valid_brbe_version() at the same place in V6.
>
> > knows which cpu it is getting the branches from. And It can also
> > filter for a process as it knows which process is called the BPF
> > program, let's say a process does a syscall and we attach a bpf
> > program to it as the example I gave with the retsnoop tool in the
> > cover letter's Usage model section. A BPF program can also attach to a
> > tracepoint, or even to a perf event and this BPF helper can be called
> > from any of those contexts, but the filtering based on cpu or pid or
> > anything else is done by the BPF program itself, this helper should
> > just return the raw branch records.
> >
>
> Thanks for the explanation.
>
> >>>>
> >>>> V5 reads sysregs before disabling interrupts so I assume migration i=
sn't
> >>>> an issue here.
> >>>>
> >>>>>                    raw_local_daif_restore(flags);
> >>>>>                    return 0;
> >>>>>            }
> >>>>>
> >>>>>            brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> >>>>>            brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> >>>>>
> >>>>>            write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL=
1);
> >>>>>            isb();
> >>>>>
> >>>>>            /* BRBCR_EL1 is zero while the driver has BRBE disabled.=
 */
> >>>>>            if (!brbcr) {
> >>>>>                    write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> >>>>>                    isb();
> >>>>>                    raw_local_daif_restore(flags);
> >>>>>                    return 0;
> >>>>>            }
> >>>>>
> >>>>>            trace_hardirqs_off();
> >>>>>
> >>>>>            ... read the records ...
> >>>>>
> >>>>>            if (!(brbfcr & BRBFCR_EL1_PAUSED) &&
> >>>>>                !(read_pmovsclr() & (ARMV8_PMU_OVSR_P | ARMV8_PMU_OV=
SR_F)))
> >>>>>                    brbe_invalidate();
> >>>>>            else
> >>>>>                    brbfcr |=3D BRBFCR_EL1_PAUSED;
> >>>>>
> >>>>>            write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> >>>>>            isb();
> >>>>>            local_daif_restore(flags);
> >>>>>
> >>>>> Exceptions are masked before anything is sampled, BRBCR_EL1 is only=
 read and
> >>>>> never written, and BRBFCR_EL1 is written back from the value saved =
under the
> >>>>> mask. cpu_has_brbe() is now valid_brbe_version().
> >>>>>
> >>>>> Neither conditional costs a record: valid_brbe_version() falls thro=
ugh when BRBE
> >>>>> is present (RBBNSZ, only taken branches are recorded), and the BRBC=
R_EL1 test is
> >>>>
> >>>> Isn't the compiler free to invert it and make the happy path a taken
> >>>> branch. I don't think any of that can be assumed without writing in
> >>>> assembly.
> >>>>
> >>>>> after the pause. It cannot move later because BRBFCR_EL1 is UNDEFIN=
ED without
> >>>>> FEAT_BRBE.
> >>>>>
> >>>>> PMOVSCLR_EL0 is masked because PMCCNTR_EL0 is bit 31 and PMCR_EL0.N=
 is at most
> >>>>> 31, so the cycle counter is outside every range RNXCWF, RGXGWY, RPK=
TXQ and
> >>>>> RLDMVK name. Unmasked, a cycle counter overflow looked like a freez=
e.
> >>>>
> >>>> Sorry I didn't understand this bit. Can you elaborate?
> >>>>
> >>>>>
> >>>>> Do you think this version works?
> >>>>>
> >>>>> Thanks,
> >>>>> Puranjay
> >>>>
> >>>>
> >>>>    From your previous reply:
> >>>>
> >>>>      "Hardware only sets PAUSED on a BRBE freeze event (RBHYTD), and=
 a
> >>>>       freeze needs BRBE to not already be paused (RNXCWF). So once w=
e have
> >>>>       paused, nothing changes underneath us and the PMU does not nee=
d
> >>>>       disabling."
> >>>>
> >>>> I'm still not 100% convinced this is correct. You read BRBFCR_EL1 an=
d
> >>>> write PAUSED to it in separate instructions. The PMU can overflow an=
d
> >>>> change the PAUSED state between those two instructions leading to
> >>>> restoration of the wrong value.
> >>>
> >>> I was checking if the overflow happened and leaving it paused in that=
 case.
> >>>
> >>
> >> But couldn't it overflow after that check? I still think it's vulnerab=
le
> >> to the same issue unless you disable the PMU completely.
> >
> > yeah you are right, I missed that it can overflow after the check.
> >
> >>
> >>>> Isn't this non pausing version way simpler to understand, and also h=
as
> >>>> the benefit of not invalidating someone elses BRBE buffers. The only
> >>>> downside seems to be that it might have some assembly to make sure t=
he
> >>>> if statements are always not taken branches rather than inverted, bu=
t
> >>>> personally I don't think that makes it any harder to understand than=
 the
> >>>> branchy pausing version in V5:
> >>>>
> >>>>      #define read_record(i)
> >>>>        if (i >=3D cnt)                                       \
> >>>>           goto out;                                        \
> >>>>        isb(); /* Ensure our own exit branch isn't read? */ \
> >>>>        entries[i].inf =3D read_brbe_inf(i)                   \
> >>>>        if (!inf)                                           \
> >>>>           goto out;                                        \
> >>>>        entries[i].src =3D read_brb_src(i)                    \
> >>>>        entries[i].dst =3D read_brb_dst(i)                    \
> >>>>
> >>>>      raw_local_daif_save();
> >>>>
> >>>>      /* disable counters to stop BRBFCR_EL1.PAUSE state changing */
> >>>>      pmcr =3D armv8pmu_pmcr_read();
> >>>>      armv8pmu_pmcr_write(pmcr & ~ARMV8_PMU_PMCR_E);
> >>>>      isb();
> >>>>
> >>>>      brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> >>>>      brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> >>>>
> >>>>      select_bank(0);
> >>>>      read_record(0);
> >>>>      read_record(1);
> >>>>      ...
> >>>>      select_bank(1);
> >>>>      read_record(32);
> >>>>      read_record(33);
> >>>>      ...
> >>>>
> >>>> out:
> >>>>      write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> >>>>      isb();
> >>>>      armv8pmu_pmcr_write(pmcr);
> >>>>      raw_local_daif_restore();
> >>>>
> >>>>      /* Post process entries[n].inf etc into correct format */
> >>>
> >>> I will try out this approach and get back.

Hi James, I tried this approach without the PAUSE but there is a
problem, the hardware that I tested on creates a record for isb() and
when reading the banks, we need to do an isb() after bank selection
and it's recorded, so it shifts every record's index by one between
the two bank reads, leaving the two halves stitched from buffer states
one shift apart.
