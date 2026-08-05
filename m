Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4369364EB6
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785944661; cv=pass; b=QTk6J6zuMczr3yjnv5b2qQbmKJqlOzgIgzAroa2QxuKH+awFpz39qVYHqeUBp6GvNBek40ybqqmmI4+iBrgjBwfNoAhpEB+rwC7XJwgznIArilTQAU6+Ng90Q8Qhw13UmaanPdW6mV8Bby5ZmxWlb51vHqnJL9SUHndRV2kxhUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785944661; c=relaxed/simple;
	bh=03HUqT1CobCpUSIkXEUSNtdWpgCeNvbKbbRcPE70siA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvoViXoTYzhSs9OGhx3Y1DWx+1IEIr3jVC8P2nqVJvOqIivwUebpsHrNpM92N8SsZccWD6Vr3AewDG4WSoCQDDpV5HqWiwiau2vj2p4UEa+pHr4q9h52XfMhG+iRJhHbfNgMY68/gTlM7bDyS8S9VNSglJgOsN52qbdYu6lOQws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ri52T/Ge; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri52T/Ge"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a144c8eea2so1375310a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 08:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785944657; cv=none;
        d=google.com; s=arc-20260327;
        b=VPFcTFcJhB+t3fZrAI3a+hkysHEwLqYSkcvTTe+1Vi9Xy92YSfnLmR7cai20rq9ywJ
         UyBfyaLZqQxx0HF9VkQ/4r6Fz/4oeRwNLiMQKnmLgBcLqKEyhTT1hMe4GxEtEckreqZ5
         fC52vhlsrrLzFUJIeS4wx5h62PwEZMuiZNrGT6eDs+LF378sIj0rjL4xK4xbN2rcqvR/
         H4Zu3pGeUEOny/5m6xJFCl3HW/GDcE7u2xTV/WzXlVU3xyfwCiiEADa2HcQcIal8SPRw
         2Gsj0GYMM62huOX6Nz0QJ+yFu9Vjnf/EULur/VXNRX2A7k6B1wQU2br38Uuml6zbXVTL
         e+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PtPUEU6K4nOHbG681U3DnztrdVloOBKzNVLP+ulTPO8=;
        fh=45nclNulhe471s3HqCfYhf/ymrTgtPY8LnCgnnUM/MA=;
        b=M4AEDCUHJniMmJNPI1HbDRs0m4Fc0DW+B0VaTKZJ2CmB8Up03hntFm0wUq/yXtX5Xp
         ldGFmrZ4atLPJwiDcs2S8z4drpHswyMCMSeTmymPi2BGfg6xHoF1KL9dLsJAWCbOS91t
         sGr/mFkqF6Wn2gc0eXCF6kYUIhLIFxqycqQQ9t63mOkP6kD9/vZiTqzzsbn27RUAUNgb
         u/yfgZiYQBaCy4I+86Esb2sXWYwJTFIx+I8YwziU0dmh3YS7qGd0gFQXmhMIAPQqoeAJ
         JHu9bSzc6skHHXOVw1yrXQCFfByP3S9/GnnsGhGrL0hLwM3u9RdTtNN32SwcguVH37m9
         qkrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785944657; x=1786549457; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PtPUEU6K4nOHbG681U3DnztrdVloOBKzNVLP+ulTPO8=;
        b=Ri52T/GeCoJqu8/d61mwhX27ScDRh1N1FzZxeIthOYe3Jfyj19ZqRZaBHDiTg7vcD5
         GIpM/8DJQ+37yxF5hgNta9jVPLZ1WLe5fpCjLKd4C5/EMKJdCDdbF3cWzIhWOPUFlfG9
         Gd+tt+39r4B8s07XyoqmOhxVY4aVDaEfOQxKWukjYmqoPLuwWZlokY4n7Y4Hpn65VTwv
         8VPfVdEgUQ/whr1hzg543d3RbaRN29OeUHfTSQSwd/UFsLEMqi0vu0TFESfybXkGQf+0
         RGwZ0BwYVDiU/TLmHwdlf72ICEc3QP1ZYwxkxGAtMpXknZf2Rp8EXZGzldFyGEt6O+OV
         qO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785944657; x=1786549457;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PtPUEU6K4nOHbG681U3DnztrdVloOBKzNVLP+ulTPO8=;
        b=FpEtPj8HHenbs2S3bIh+o+/SgrEBY60NO6+zZOY84pWtq+E/d8xPMj8ldN6Dx/Oebv
         aEP4fs5vHyzf+dty2a6y5uuu50qv1RK1v3rAJdp8DG0uMLCcUVN0zmcnnAmV2UOJQIGr
         BoCdAJsLf6rdOkfDU50NGHu8Ly1t969YapXLM/Bh0DJwBp37aQ271Girr5akCJo2AYfT
         ybFS8oyZ6BqV2rhHCUZWmv29RnfZ7a9lvw1YJlJaabXuXfvTyCotnRHkoFmp50Efw/LC
         Ip5M77YT23SPSwdYZj3cn742W4HnvycHajG2vMr2MaRXwPRx5wRXFYiKB5FauEfEMKgn
         pSuQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/cWebkbe9rqrtOcoOy+Ny4jyKl7+u2Xy/CRTKsOPazsS+81HrhNIB5dpEy3YpMGQdYqkAMIXiKkCo7fDZfr58@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc96/m3cKhXKaDKJzEe3SBth/SPPORIL7nk9NqsLbOzS4ivMgh
	c9h8qNEhJ4Mugd9f3i3hyLIhjNLkW5hpT0Dz7Lg10Md0a8TUlLHoGzzU2joqsWlBvYzq3FK33V2
	buq78wnlnM7i2HKRyAmf2kXT/ro1lpTg=
X-Gm-Gg: AR+sD12IuYML1NMOqrN42Seg9rnBKfwDp/a7iMvgAs+FurJCik4sERoV9DGD24wMfOZ
	/nNAau+BQcOxub7edai4kPjzZrJDkiua67rddr3VFXlstIbguQpX6Pw9pNY/2UenbN470GWJYhp
	uG6J4cVxMz0SneIewzfuo/cg9xTWxvZldh8N0XsbuURjyziDJX8tmOuJbmAEmepliKaSrxVBT6W
	yoBIkBqulkN06GFasRmkN5ryJDYkPHdJ/5OWkrMqR0mB0ZbZdRVKqarOu4CX6hbr+STwsl5xOr9
	lBLFIRnQj6DS0/mHY6aCT3WYCWVsepG0NK2zj8L3K2gRvE8Cfm1KLxJsi1//WMRonZmPPXIq
X-Received: by 2002:a17:907:1688:b0:c20:223e:940a with SMTP id
 a640c23a62f3a-c2039e699e3mr335339866b.21.1785944656604; Wed, 05 Aug 2026
 08:44:16 -0700 (PDT)
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
 <ffeea852-b55b-45b5-afcd-47dc4e6f6824@linaro.org>
In-Reply-To: <ffeea852-b55b-45b5-afcd-47dc4e6f6824@linaro.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 5 Aug 2026 16:44:02 +0100
X-Gm-Features: AUfX_mwSkNmLG_4KuocMiMKxbKSsF0wqXR8t9qAZcppzEjsHXiBYd-yJ5d-EIiE
Message-ID: <CANk7y0gcj-kRCt-EgL6UK+Tc4xvJQkGz9F=HNpE86kB3fKxymA@mail.gmail.com>
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

On Wed, Aug 5, 2026 at 4:14=E2=80=AFPM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 05/08/2026 15:43, Puranjay Mohan wrote:
> > On Wed, Aug 5, 2026 at 2:58=E2=80=AFPM James Clark <james.clark@linaro.=
org> wrote:
> >>
> >>
> >>
> >> On 05/08/2026 12:47, Puranjay Mohan wrote:
> >>> On Wed, Aug 5, 2026 at 11:07=E2=80=AFAM James Clark <james.clark@lina=
ro.org> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 03/08/2026 7:54 pm, Puranjay Mohan wrote:
> >>>>> On Mon, Aug 3, 2026 at 12:07=E2=80=AFPM James Clark <james.clark@li=
naro.org> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 16/06/2026 16:57, Puranjay Mohan wrote:
> >>>>>>> Enable bpf_get_branch_snapshot() on ARM64 by implementing the
> >>>>>>> perf_snapshot_branch_stack static call for BRBE.
> >>>>>>>
> >>>>>>> BRBE is paused before masking exceptions to avoid branch buffer
> >>>>>>> pollution from trace_hardirqs_off(). Exceptions are then masked w=
ith
> >>>>>>> local_daif_save() to prevent PMU overflow pseudo-NMIs from interf=
ering.
> >>>>>>> If an overflow between pause and DAIF save re-enables BRBE, the s=
napshot
> >>>>>>> detects this via BRBFCR_EL1.PAUSED and bails out.
> >>>>>>>
> >>>>>>> Branch records are read using perf_entry_from_brbe_regset() with =
a NULL
> >>>>>>> event pointer to bypass event-specific filtering. The buffer is
> >>>>>>> invalidated after reading.
> >>>>>>>
> >>>>>>> Introduce a for_each_brbe_entry() iterator to deduplicate bank
> >>>>>>> iteration between brbe_read_filtered_entries() and the snapshot.
> >>>>>>>
> >>>>>>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> >>>>>>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> >>>>>>> ---
> >>>>>>>      drivers/perf/arm_brbe.c  | 128 +++++++++++++++++++++++++++++=
+++-------
> >>>>>>>      drivers/perf/arm_brbe.h  |   9 +++
> >>>>>>>      drivers/perf/arm_pmuv3.c |   5 +-
> >>>>>>>      3 files changed, 120 insertions(+), 22 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> >>>>>>> index effbdeacfcbb..a141ad7abcf2 100644
> >>>>>>> --- a/drivers/perf/arm_brbe.c
> >>>>>>> +++ b/drivers/perf/arm_brbe.c
> >>>>>>> @@ -9,6 +9,7 @@
> >>>>>>>      #include <linux/types.h>
> >>>>>>>      #include <linux/bitmap.h>
> >>>>>>>      #include <linux/perf/arm_pmu.h>
> >>>>>>> +#include <asm/daifflags.h>
> >>>>>>>      #include "arm_brbe.h"
> >>>>>>>
> >>>>>>>      #define BRBFCR_EL1_BRANCH_FILTERS (BRBFCR_EL1_DIRECT   | \
> >>>>>>> @@ -256,6 +257,14 @@ static bool valid_brbe_version(int brbe_vers=
ion)
> >>>>>>>                 brbe_version =3D=3D ID_AA64DFR0_EL1_BRBE_BRBE_V1P=
1;
> >>>>>>>      }
> >>>>>>>
> >>>>>>> +static __always_inline bool cpu_has_brbe(void)
> >>>>>>
> >>>>>> This should be more like cpu_valid_brbe_version(). has_brbe() only
> >>>>>> implies that the CPU has BRBE, not that it's a version that the dr=
iver
> >>>>>> supports. And it's actually just a wrapper around valid_brbe_versi=
on()
> >>>>>> that accesses the ID reg on that CPU, not a functionally different=
 check.
> >>>>>>
> >>>>>> But it also looks like valid_brbe_version() isn't called from anyw=
here
> >>>>>> else, so why not delete that function and use its name for the new=
 one?
> >>>>>
> >>>>> I will do that in next version
> >>>>>
> >>>>>>
> >>>>>>> +{
> >>>>>>> +     u64 aa64dfr0 =3D read_sysreg_s(SYS_ID_AA64DFR0_EL1);
> >>>>>>> +     int brbe =3D cpuid_feature_extract_unsigned_field(aa64dfr0,=
 ID_AA64DFR0_EL1_BRBE_SHIFT);
> >>>>>>> +
> >>>>>>> +     return valid_brbe_version(brbe);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>>      static void select_brbe_bank(int bank)
> >>>>>>>      {
> >>>>>>>          u64 brbfcr;
> >>>>>>> @@ -271,6 +280,20 @@ static void select_brbe_bank(int bank)
> >>>>>>>          isb();
> >>>>>>>      }
> >>>>>>>
> >>>>>>> +static inline void __brbe_advance(int *bank, int *idx, int nr_hw=
)
> >>>>>>> +{
> >>>>>>> +     if (++(*idx) >=3D BRBE_BANK_MAX_ENTRIES &&
> >>>>>>> +         *bank * BRBE_BANK_MAX_ENTRIES + *idx < nr_hw) {
> >>>>>>> +             *idx =3D 0;
> >>>>>>> +             select_brbe_bank(++(*bank));
> >>>>>>> +     }
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +#define for_each_brbe_entry(idx, nr_hw)                         =
             \
> >>>>>>> +     for (int __bank =3D (select_brbe_bank(0), 0), idx =3D 0;   =
         \
> >>>>>>> +          __bank * BRBE_BANK_MAX_ENTRIES + idx < (nr_hw);       =
     \
> >>>>>>> +          __brbe_advance(&__bank, &idx, (nr_hw)))
> >>>>>>> +
> >>>>>>>      static bool __read_brbe_regset(struct brbe_regset *entry, in=
t idx)
> >>>>>>>      {
> >>>>>>>          entry->brbinf =3D get_brbinf_reg(idx);
> >>>>>>> @@ -474,11 +497,9 @@ unsigned int brbe_num_branch_records(const s=
truct arm_pmu *armpmu)
> >>>>>>>
> >>>>>>>      void brbe_probe(struct arm_pmu *armpmu)
> >>>>>>>      {
> >>>>>>> -     u64 brbidr, aa64dfr0 =3D read_sysreg_s(SYS_ID_AA64DFR0_EL1)=
;
> >>>>>>> -     u32 brbe;
> >>>>>>> +     u64 brbidr;
> >>>>>>>
> >>>>>>> -     brbe =3D cpuid_feature_extract_unsigned_field(aa64dfr0, ID_=
AA64DFR0_EL1_BRBE_SHIFT);
> >>>>>>> -     if (!valid_brbe_version(brbe))
> >>>>>>> +     if (!cpu_has_brbe())
> >>>>>>>                  return;
> >>>>>>>
> >>>>>>>          brbidr =3D read_sysreg_s(SYS_BRBIDR0_EL1);
> >>>>>>> @@ -618,10 +639,10 @@ static bool perf_entry_from_brbe_regset(int=
 index, struct perf_branch_entry *ent
> >>>>>>>
> >>>>>>>          brbe_set_perf_entry_type(entry, brbinf);
> >>>>>>>
> >>>>>>> -     if (!branch_sample_no_cycles(event))
> >>>>>>> +     if (!event || !branch_sample_no_cycles(event))
> >>>>>>>                  entry->cycles =3D brbinf_get_cycles(brbinf);
> >>>>>>>
> >>>>>>> -     if (!branch_sample_no_flags(event)) {
> >>>>>>> +     if (!event || !branch_sample_no_flags(event)) {
> >>>>>>>                  /* Mispredict info is available for source only =
and complete branch records. */
> >>>>>>>                  if (!brbe_record_is_target_only(brbinf)) {
> >>>>>>>                          entry->mispred =3D brbinf_get_mispredict=
(brbinf);
> >>>>>>> @@ -774,32 +795,97 @@ void brbe_read_filtered_entries(struct perf=
_branch_stack *branch_stack,
> >>>>>>>      {
> >>>>>>>          struct arm_pmu *cpu_pmu =3D to_arm_pmu(event->pmu);
> >>>>>>>          int nr_hw =3D brbe_num_branch_records(cpu_pmu);
> >>>>>>> -     int nr_banks =3D DIV_ROUND_UP(nr_hw, BRBE_BANK_MAX_ENTRIES)=
;
> >>>>>>>          int nr_filtered =3D 0;
> >>>>>>>          u64 branch_sample_type =3D event->attr.branch_sample_typ=
e;
> >>>>>>>          DECLARE_BITMAP(event_type_mask, PERF_BR_ARM64_MAX);
> >>>>>>>
> >>>>>>>          prepare_event_branch_type_mask(branch_sample_type, event=
_type_mask);
> >>>>>>>
> >>>>>>> -     for (int bank =3D 0; bank < nr_banks; bank++) {
> >>>>>>> -             int nr_remaining =3D nr_hw - (bank * BRBE_BANK_MAX_=
ENTRIES);
> >>>>>>> -             int nr_this_bank =3D min(nr_remaining, BRBE_BANK_MA=
X_ENTRIES);
> >>>>>>> +     for_each_brbe_entry(i, nr_hw) {
> >>>>>>> +             struct perf_branch_entry *pbe =3D &branch_stack->en=
tries[nr_filtered];
> >>>>>>>
> >>>>>>> -             select_brbe_bank(bank);
> >>>>>>> +             if (!perf_entry_from_brbe_regset(i, pbe, event))
> >>>>>>> +                     break;
> >>>>>>>
> >>>>>>> -             for (int i =3D 0; i < nr_this_bank; i++) {
> >>>>>>> -                     struct perf_branch_entry *pbe =3D &branch_s=
tack->entries[nr_filtered];
> >>>>>>> +             if (!filter_branch_record(pbe, branch_sample_type, =
event_type_mask))
> >>>>>>> +                     continue;
> >>>>>>>
> >>>>>>> -                     if (!perf_entry_from_brbe_regset(i, pbe, ev=
ent))
> >>>>>>> -                             goto done;
> >>>>>>> +             nr_filtered++;
> >>>>>>> +     }
> >>>>>>>
> >>>>>>> -                     if (!filter_branch_record(pbe, branch_sampl=
e_type, event_type_mask))
> >>>>>>> -                             continue;
> >>>>>>> +     branch_stack->nr =3D nr_filtered;
> >>>>>>> +}
> >>>>>>>
> >>>>>>> -                     nr_filtered++;
> >>>>>>> -             }
> >>>>>>> +/*
> >>>>>>> + * Best-effort BRBE snapshot for BPF tracing. Pause BRBE to avoi=
d
> >>>>>>> + * self-recording and return 0 if the snapshot state appears dis=
turbed.
> >>>>>>> + */
> >>>>>>> +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *ent=
ries, unsigned int cnt)
> >>>>>>> +{
> >>>>>>> +     unsigned long flags;
> >>>>>>> +     int nr_hw, nr_copied =3D 0;
> >>>>>>> +     u64 brbfcr, brbcr;
> >>>>>>> +
> >>>>>>> +     if (!cnt)
> >>>>>>> +             return 0;
> >>>>>>
> >>>>>> If you're trying to avoid branches before pausing BRBE, can't you =
check
> >>>>>> this after the pause?
> >>>>>
> >>>>> will drop this in the next version and this is just an optimization=
.
> >>>>>
> >>>>>>
> >>>>>>> +
> >>>>>>> +     /* Guard against running on a CPU without BRBE (e.g. big.LI=
TTLE). */
> >>>>>>> +     if (!cpu_has_brbe())
> >>>>>>> +             return 0;
> >>>>>>> +
> >>>>>>> +     /*
> >>>>>>> +      * Pause BRBE first to avoid recording our own branches. Th=
e
> >>>>>>> +      * sysreg read/write and ISB are branchless, so pausing bef=
ore
> >>>>>>> +      * checking BRBCR avoids polluting the buffer with our own
> >>>>>>> +      * conditional branches.
> >>>>>>> +      */
> >>>>>>> +     brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> >>>>>>> +     brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> >>>>>>> +     write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> >>>>>>
> >>>>>> Can this work without first disabling interrupts? Sashiko pointed =
it
> >>>>>> out, but I think it's correct. If you read an active state into br=
bfcr,
> >>>>>> then the PMU event fires and disables BRBE, then you disable inter=
rupts,
> >>>>>> then you would restore an active state when it should be inactive.
> >>>>>> Surely the only way to do it properly is to disable interrupts bef=
ore
> >>>>>> touching anything at all, if the PMU handler is also touching the =
same
> >>>>>> registers?
> >>>>>>
> >>>>>> If you want to avoid trace_hardirqs_off() can you make a new
> >>>>>> raw_local_daif_save() that disables interrupts and then call
> >>>>>> trace_hardirqs_off() yourself after pausing BRBE? Or not call
> >>>>>> trace_hardirqs_off() at all? There is a comment mentioning somethi=
ng
> >>>>>> like that in arch/arm64/kernel/suspend.c.
> >>>>>
> >>>>> Yes. I'll add raw_local_daif_save()/raw_local_daif_restore() and ma=
sk before
> >>>>> touching any BRBE register, which fixes the stale restore. trace_ha=
rdirqs_off()
> >>>>> then moves below the pause so lockdep still sees a balanced off/on =
pair while
> >>>>> its branches land in an already paused buffer.
> >>>>>
> >>>>>>
> >>>>>> Also, disabling interrupts doesn't stop the PMU event from overflo=
wing
> >>>>>> and changing the state of PAUSED either. I think this is another p=
ath
> >>>>>> that leads to you restoring the wrong state, so don't you also nee=
d to
> >>>>>> disable the PMU?
> >>>>>
> >>>>> Hardware only sets PAUSED on a BRBE freeze event (RBHYTD), and a fr=
eeze needs
> >>>>> BRBE to not already be paused (RNXCWF). So once we have paused, not=
hing changes
> >>>>> underneath us and the PMU does not need disabling. It would not hel=
p anyway:
> >>>>> armv8pmu_stop() calls brbe_disable(), which zeroes BRBCR_EL1 and di=
scards the
> >>>>> records we came to read.
> >>>>
> >>>> That does mean you throw away real freeze events while paused though=
, in
> >>>> addition to the brbe_invalidate() you need to avoid non contiguous
> >>>> buffers. So it takes branches away from PMU events.
> >>>
> >>> RBHYTD gives a freeze two effects: PAUSED is set, and BRBTS_EL1 captu=
res a
> >>> timestamp. Recording has already stopped because we paused, and the d=
river never
> >>> reads BRBTS_EL1. On the way out we check PMOVSCLR_EL0 and leave PAUSE=
D set if a
> >>> counter overflowed, so a pending overflow handler still finds a froze=
n buffer.
> >>>
> >>>> So it takes branches away from PMU events.
> >>>
> >>> Yes, but that is brbe_invalidate(), not the pause. Interrupts are mas=
ked and
> >>> nothing else runs on the CPU, so the only branches the pause suppress=
es are the
> >>> snapshot's own.
> >>>
> >>>>>
> >>>>> You are right that a freeze can still land in the window between re=
ading BRBFCR
> >>>>> and setting PAUSED, and restoring the value we read would then clea=
r a PAUSED
> >>>>> bit the hardware set. So v6 checks PMOVSCLR_EL0 and leaves BRBE pau=
sed if a
> >>>>> counter has overflowed. Reads of PMOVSCLR are non-destructive and i=
t stays set
> >>>>> until the overflow handler clears it, so it is still visible after =
we have set
> >>>>> PAUSED ourselves:
> >>>>>
> >>>>>            if (!valid_brbe_version())
> >>>>>                    return 0;
> >>>>>
> >>>>>            flags =3D raw_local_daif_save();
> >>>>>
> >>>>>            brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> >>>>>            brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> >>>>>
> >>>>>            write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL=
1);
> >>>>>            isb();
> >>>>>
> >>>>>            trace_hardirqs_off();
> >>>>>
> >>>>>            /* BRBCR_EL1 is zero while the driver has BRBE disabled.=
 */
> >>>>>            if (!brbcr)
> >>>>>                    goto restore;
> >>>>>
> >>>>>            ... read the records ...
> >>>>>
> >>>>
> >>>> Up to the point where you read the records you technically don't nee=
d
> >>>> any branches (if you don't do trace_hardirqs_off()) so you could do =
the
> >>>> whole thing without pausing. Just disable interrupts, read every bra=
nch
> >>>> entry unconditionally, re-enable interrupts and then find the last v=
alid
> >>>> entry and do the branchy stuff after reading.
> >>>>
> >>>> I'm thinking out loud, but doesn't that make it a lot easier? And it
> >>>> avoids the brbe_invalidate() which takes the branches away from the =
PMU
> >>>> event. It also avoids having to think too hard about racing with PMU
> >>>> events causing a freeze even after interrupts are disabled and after
> >>>> reading the freeze value:
> >>>>
> >>>>      raw_local_daif_save();
> >>>>      brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> >>>>      brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> >>>>      select_bank(0);
> >>>>      read_record(0);
> >>>>      read_record(1);
> >>>>      ...
> >>>>      select_bank(0);
> >>>>      read_record(0);
> >>>>      read_record(1);
> >>>>      ...
> >>>>      write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> >>>>      isb();
> >>>>      local_daif_restore();
> >>>>
> >>>>      /* Now do post processing, find last valid record, check if it =
was
> >>>> enabled by looking at brbcr etc. */
> >>>
> >>> MRS is not a branch, so that works, but three things would have to ch=
ange:
> >>>
> >>> 1. perf_entry_from_brbe_regset() goes through BRBE_REGN_SWITCH, a 32 =
case
> >>>      switch, because the register number has to be an immediate. gcc =
emits a jump
> >>>      table and the function has 52 branches in the object file. The r=
ead would
> >>>      need full unrolling.
> >>>
> >>
> >> Yes you would have to manually unroll it. I doubt the compiler would
> >> emit a branch for BRBE_REGN_SWITCH() because your indexes are static i=
f
> >> it's unrolled. But if it does you can change it to a sequence of
> >> read_sysreg_s()s.
> >>
> >> If you really want to be sure there are no branches, write it in a
> >> single asm block.
> >
> > I will try that approach in the next version.
> >
> >>> 2. RPGDLX needs an ISB before the reads, and Table D19-10 makes it
> >>>      IMPLEMENTATION DEFINED whether ISB itself generates a record. Wh=
en we pause,
> >>>      IZCHRF means the pausing ISB cannot pollute the buffer it is abo=
ut to read.
> >>>
> >>
> >> I assume one potential extra record from the isb() is acceptible seein=
g
> >> as you already have two or more conditions plus a function call before
> >> the pause? Is the problem that you don't know whether to filter it out
> >> later because it's IMPDEF and isn't always there? You already don't kn=
ow
> >> exactly how many branches there will be before the pause beause it's
> >> written in C. So I'm not sure what the exact issue here is.
> >>
> >>> 3. 64 record parts still need a bank switch, so BRBFCR_EL1 still has =
to be
> >>>      written and restored.
> >>>
> >>
> >> Yes that was included in my pseudo code example but it's still
> >> branchless. I did miss that you might need an isb() after disabling
> >> interrupts, but you added one for RPGDLX anyway.
> >>
> >>> Correctness would then depend on the read staying branchless, which i=
s not
> >>> checkable at build time and fails silently: a branch mid read shifts =
the buffer,
> >>
> >> Why would the compiler insert a branch between two read_sysreg_s()s,
> >> which are asm volatile? Is that allowed?
> >
> > You are right, I just over complicated it!
> >
> >>> giving a duplicate and a gap. 64 * 24 bytes of records also wants a p=
er-CPU
> >>> scratch buffer rather than the stack.
> >>>
> >>
> >> A per-CPU scratch buffer doesn't sound too bad. But aren't you in
> >> control of how many entries are available to write to? You can reject
> >> any calls that have fewer than 64 and always write directly to *entrie=
s.
> >>
> >> You could also compare with 'cnt' after reading each record and exit t=
he
> >> read section. Like you say below, branches not taken don't generate
> >> records, and once the branch is taken you stop reading so after that
> >> point generating records doesn't matter.
> >>
> >>> Happy to prototype it. What I would not do is pause without invalidat=
ing:
> >>> records are from/to pairs, so a consumer walking across the hole reco=
nstructs a
> >>> call path that never happened. The invalidate was Mark's request afte=
r the RFC,
> >>> "to maintain record contiguity for other consumers", so dropping the =
pause drops
> >>> that too.
> >>
> >> Well the point was to not have to pause at all, so there's no need to
> >> invalidate either. Even if you did add a pause, as long as there are n=
o
> >> branches between the pause and resume you don't need an invalidate
> >> because you didn't miss any branches.
> >>
> >>>
> >>> I was thinking of this for v6:
> >>>
> >>>           flags =3D raw_local_daif_save();
> >>>
> >>>           /* The BRBE sysregs below are UNDEFINED without this. */
> >>>           if (!valid_brbe_version()) {
> >>
> >> You don't need to disable interrupts to call this, it's a constant. Or
> >> is it to stop migration?
> >
> > It was to stop migration.
> >
>
> Ah ok, so V5 wasn't correct then.

Yes, It was buggy! I missed that one CPU could implement BRBE while
another doesn't

>
> Separately to this, I'm also not sure how this BPF call is invoked. Is
> it supposed to target a CPU, or an event or a process? How do you know
> you are getting the branches from the CPU that you want?

So, A BPF program can attach to a function's entry through ftrace or
kprobe and from there we call this helper to find out what branches
were taken to reach that function.
A BPF program runs on a CPU with migration always disabled, so it
knows which cpu it is getting the branches from. And It can also
filter for a process as it knows which process is called the BPF
program, let's say a process does a syscall and we attach a bpf
program to it as the example I gave with the retsnoop tool in the
cover letter's Usage model section. A BPF program can also attach to a
tracepoint, or even to a perf event and this BPF helper can be called
from any of those contexts, but the filtering based on cpu or pid or
anything else is done by the BPF program itself, this helper should
just return the raw branch records.

> >>
> >> V5 reads sysregs before disabling interrupts so I assume migration isn=
't
> >> an issue here.
> >>
> >>>                   raw_local_daif_restore(flags);
> >>>                   return 0;
> >>>           }
> >>>
> >>>           brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> >>>           brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> >>>
> >>>           write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> >>>           isb();
> >>>
> >>>           /* BRBCR_EL1 is zero while the driver has BRBE disabled. */
> >>>           if (!brbcr) {
> >>>                   write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> >>>                   isb();
> >>>                   raw_local_daif_restore(flags);
> >>>                   return 0;
> >>>           }
> >>>
> >>>           trace_hardirqs_off();
> >>>
> >>>           ... read the records ...
> >>>
> >>>           if (!(brbfcr & BRBFCR_EL1_PAUSED) &&
> >>>               !(read_pmovsclr() & (ARMV8_PMU_OVSR_P | ARMV8_PMU_OVSR_=
F)))
> >>>                   brbe_invalidate();
> >>>           else
> >>>                   brbfcr |=3D BRBFCR_EL1_PAUSED;
> >>>
> >>>           write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> >>>           isb();
> >>>           local_daif_restore(flags);
> >>>
> >>> Exceptions are masked before anything is sampled, BRBCR_EL1 is only r=
ead and
> >>> never written, and BRBFCR_EL1 is written back from the value saved un=
der the
> >>> mask. cpu_has_brbe() is now valid_brbe_version().
> >>>
> >>> Neither conditional costs a record: valid_brbe_version() falls throug=
h when BRBE
> >>> is present (RBBNSZ, only taken branches are recorded), and the BRBCR_=
EL1 test is
> >>
> >> Isn't the compiler free to invert it and make the happy path a taken
> >> branch. I don't think any of that can be assumed without writing in
> >> assembly.
> >>
> >>> after the pause. It cannot move later because BRBFCR_EL1 is UNDEFINED=
 without
> >>> FEAT_BRBE.
> >>>
> >>> PMOVSCLR_EL0 is masked because PMCCNTR_EL0 is bit 31 and PMCR_EL0.N i=
s at most
> >>> 31, so the cycle counter is outside every range RNXCWF, RGXGWY, RPKTX=
Q and
> >>> RLDMVK name. Unmasked, a cycle counter overflow looked like a freeze.
> >>
> >> Sorry I didn't understand this bit. Can you elaborate?
> >>
> >>>
> >>> Do you think this version works?
> >>>
> >>> Thanks,
> >>> Puranjay
> >>
> >>
> >>   From your previous reply:
> >>
> >>     "Hardware only sets PAUSED on a BRBE freeze event (RBHYTD), and a
> >>      freeze needs BRBE to not already be paused (RNXCWF). So once we h=
ave
> >>      paused, nothing changes underneath us and the PMU does not need
> >>      disabling."
> >>
> >> I'm still not 100% convinced this is correct. You read BRBFCR_EL1 and
> >> write PAUSED to it in separate instructions. The PMU can overflow and
> >> change the PAUSED state between those two instructions leading to
> >> restoration of the wrong value.
> >
> > I was checking if the overflow happened and leaving it paused in that c=
ase.
> >
>
> But couldn't it overflow after that check? I still think it's vulnerable
> to the same issue unless you disable the PMU completely.

yeah you are right, I missed that it can overflow after the check.

>
> >> Isn't this non pausing version way simpler to understand, and also has
> >> the benefit of not invalidating someone elses BRBE buffers. The only
> >> downside seems to be that it might have some assembly to make sure the
> >> if statements are always not taken branches rather than inverted, but
> >> personally I don't think that makes it any harder to understand than t=
he
> >> branchy pausing version in V5:
> >>
> >>     #define read_record(i)
> >>       if (i >=3D cnt)                                       \
> >>          goto out;                                        \
> >>       isb(); /* Ensure our own exit branch isn't read? */ \
> >>       entries[i].inf =3D read_brbe_inf(i)                   \
> >>       if (!inf)                                           \
> >>          goto out;                                        \
> >>       entries[i].src =3D read_brb_src(i)                    \
> >>       entries[i].dst =3D read_brb_dst(i)                    \
> >>
> >>     raw_local_daif_save();
> >>
> >>     /* disable counters to stop BRBFCR_EL1.PAUSE state changing */
> >>     pmcr =3D armv8pmu_pmcr_read();
> >>     armv8pmu_pmcr_write(pmcr & ~ARMV8_PMU_PMCR_E);
> >>     isb();
> >>
> >>     brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> >>     brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> >>
> >>     select_bank(0);
> >>     read_record(0);
> >>     read_record(1);
> >>     ...
> >>     select_bank(1);
> >>     read_record(32);
> >>     read_record(33);
> >>     ...
> >>
> >> out:
> >>     write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> >>     isb();
> >>     armv8pmu_pmcr_write(pmcr);
> >>     raw_local_daif_restore();
> >>
> >>     /* Post process entries[n].inf etc into correct format */
> >
> > I will try out this approach and get back.
> >
> > Thanks,
> > Puranjay
>
> Nice, hope it can work.
>
