Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1851D798E
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020390; cv=pass; b=TB/gDz/yrst/iiVY85Cey9z2HPQ6/NnENkIJKYl7eSscuY8qDa0TP2/dl/mdvb1/OoZ6j+HpoN/FP5xt1t6/IVkSRjkUebSASu9l7UGVbJDmhx2dsSPDTOnFMux4qp5sNSDUeyiVbvkVnPJQTJl1MiF25Gmj2+nmfYzdhyofD3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020390; c=relaxed/simple;
	bh=AYHaLspbkrta7+6qCU6AnR4OIIS1y3tRKVdhFX7k2y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vif4v6ziJvajhsLGUnV7iAeeR8XdxmqwZbkKUxVzsto91OPt/2VLElgBVPrZTsMWx2BphI5e7nuxhv7ECMl5BHtd3VvOcocktDD+PDT+nsHVCvIbLepIJ5bbdyGZqEyUmbazE2//up5EfdSt0Th9c81T08AZ7wb9HKTCoFIWQq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bpj3tpto; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bpj3tpto"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1671ec8692so286111266b.0
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Aug 2026 05:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786020385; cv=none;
        d=google.com; s=arc-20260327;
        b=IE6O8W7CHFfT2mcoPOhGWUbY64X5yKJcs+oLXIVAuwOqO6FDk38st6oGJiVmUGSUyB
         5HlyWLVa+olgGAoKu8XlVXsDDYMXVmX2Qwev6Enh11GXWRiDPN5vO60xgPKLu/XOHyHB
         QHXGejOhqkYd6eCGm51RIBOTAQdzs5f1b4cs24ceXkvR9mHhyKnc1AzvoSWv2nlrxYSG
         Mx/uA0qlHVaiGG7adkpZD5snjuOKj5duAKLJKpGOO/eJykvgdEPMzUMaRdYgklGz6MHz
         2kBTWrCMkc1X6gOH1KZRBVofF1c+fgXDazDcyRIMW9FCJgNx410KQ/KJvXoKjjCnDimo
         4k9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jE46dPrWgLMyaX2AdXwIcbag9vzRwy757B6rpfy4ykI=;
        fh=t8iA5IHLQHzXjfQSPE49fhqX4KWwZj2K+thwGjRC+Fc=;
        b=aPYDfEXFs6eeGYGTZtXFI0EeJMZSmycZ3mdxid1CZfCVci3xYSkY7OIaQnhEpB40Yf
         Bg01Tfh/ER08c1psSLuaUQ+AbRx0Nly6SZgrH9T7gdWNsZaZh3BJJjhBFEU6O0tDMJMP
         fgACqaTjfh+pAjCqbYXceIJrm6Vj/HUvTgEvPdlijJ2Bzv/sYJ8nuqimuSOiCUoBb1Mo
         yzzRTdMmAqiA6QgO4JgLoEG3fYxLZZSbZ62YjxVRxVJcE7U84FvvRMSXwDLSE6lMlHz4
         1rK1Rs86KYB5InAd9FlmtX6p0cq6an6dMMnLmMAIFZX1eBuR9+J1f113p5N0PlgBSDvs
         ifZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786020385; x=1786625185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jE46dPrWgLMyaX2AdXwIcbag9vzRwy757B6rpfy4ykI=;
        b=Bpj3tpto3lwI9w9jfAEvI+2yh+zi3f3fKZ300CFtJm7IXtuvQwBlMCPTZQOA1nGX/m
         n6FxMlI1qej35U7Q59fzu6urR6ODy/5sTo/rHBBDfuEmeGA674MMeP9FrCr1ov8z3LEi
         l9tpO0j8xmJsN7PbYQsFY3SbTJSKqSCUZw+ia/M1r3ueoRYg/o11qV+f9QXbrP/bR45c
         rVbc9HVDD2jDlUgDuC+xFThTYfTU6DRVllLxmcvwJypvNozGV3mgFM4gkhum8uVXSz+4
         r3NXyWOLCIs5HUWIjbC6pqCxPzUJuAOjrOKBjcm9dcpAbbcp52srtRK/MpDo3Ibl7EiL
         avZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786020385; x=1786625185;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jE46dPrWgLMyaX2AdXwIcbag9vzRwy757B6rpfy4ykI=;
        b=qpOK41wq7IWGe+Aqy75k5BrapKc8lnwbXH0K/58Gf5X6tg3iTmvzmdpHNmJMw3a+Bi
         bwZIX0r67khHSr4EEyIFp6ndWK3mgQWB+sdgx+vbCCDlBEOMFn4qvjRQ9X/i/QBybsKM
         52JFEkyNbEl5DNOGF521IpHVhjlVpTMAdAkQji0ImbCCQmW0R2wraYYf7C2CGRCL/eOG
         YPF1ZukXXmL0tFh15ai6Jx++U5DEYVYxv7o1z1m9B451TGB3AMdUoamLZxjDmFftENyj
         draFK6fGoh01FKC2Lebi/pk6o7XgRrmALywcKMkPI6gkkxJnLDDF6I5SPUeOMtHahqc8
         0zfg==
X-Forwarded-Encrypted: i=1; AHgh+RoEauzsOzacZC0u6PbeanCOh4e+blScxSbJEfDGCLrfhun/e2WGEh9QNENT+rWQqNn0CZ4+SUsFKOMcnYGxSDbd@vger.kernel.org
X-Gm-Message-State: AOJu0YzcSUO9HpRNAHRdIPj7SnxFRAM1V/CEDh3/DDmZbA3fbaVZpF4L
	GpjxY1ffMrZIsATQ4BJ6iY96UBJconYMt13xDFurp+VKgII7aMWieGwctxmRtR7qw8G3Wg1+QUN
	FIKXx6MA21IOPI11MdpIjupsK3Iigo38=
X-Gm-Gg: AR+sD12kqcsyesEC5L+BgXeOlXl0Oh3ifOcmvPFIWRHT9nenJpV8X1CyCdFje7m8LEh
	PgzoWnPujGJwGSzII40XNmASxlnZBL6KgxDgT9cgJ5u2XqrA5b8NNGhZP0d2b/XTGc7M2dTF9cS
	RPZRgpi7/GV/04HWfmWFV2gDSqg7ipe1pHQgw/Etp+zzU1cozeywNFTrd1eVthYW65NuYmbeQ7k
	zNQnrtMucc/SYbE6vcRrvAsxCkGAgmovWVblW5gW1Pkc9dxJxf6IqaCd6OPnUXyHyC+aCKK0nOp
	M/wTBlW9DUfVChPj5HIlv6+uss1ihQAasmAKEOpuO7kMOOv33UJm7PIc6eCI
X-Received: by 2002:a17:907:988:b0:c20:1ec5:feb8 with SMTP id
 a640c23a62f3a-c2039d1b02dmr775135766b.29.1786020384958; Thu, 06 Aug 2026
 05:46:24 -0700 (PDT)
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
 <2b402e4b-b916-4dba-bcb3-634ad58f1710@linaro.org> <CANk7y0idVnFGvwKnSMnrW6_Ee1gFLWJmFrKBrjUbytgD0GVqHw@mail.gmail.com>
In-Reply-To: <CANk7y0idVnFGvwKnSMnrW6_Ee1gFLWJmFrKBrjUbytgD0GVqHw@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 6 Aug 2026 13:46:10 +0100
X-Gm-Features: AUfX_mw6FB12S8Lnwv2VQ1XJbjPgBcloPD6VY6ZgwxBqaNuszxtt3ozhU3A2IbM
Message-ID: <CANk7y0ir1w5zsSajcnaR-QYqM_Y0xKNO2MOcNFAWF3x=padt-g@mail.gmail.com>
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

On Wed, Aug 5, 2026 at 9:46=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.com=
> wrote:
>
> On Wed, Aug 5, 2026 at 5:26=E2=80=AFPM James Clark <james.clark@linaro.or=
g> wrote:
> >
> >
> >
> > On 05/08/2026 16:44, Puranjay Mohan wrote:
> > > On Wed, Aug 5, 2026 at 4:14=E2=80=AFPM James Clark <james.clark@linar=
o.org> wrote:
> > >>
> > >>
> > >>
> > >> On 05/08/2026 15:43, Puranjay Mohan wrote:
> > >>> On Wed, Aug 5, 2026 at 2:58=E2=80=AFPM James Clark <james.clark@lin=
aro.org> wrote:
> > >>>>
> > >>>>
> > >>>>
> > >>>> On 05/08/2026 12:47, Puranjay Mohan wrote:
> > >>>>> On Wed, Aug 5, 2026 at 11:07=E2=80=AFAM James Clark <james.clark@=
linaro.org> wrote:
> > >>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>> On 03/08/2026 7:54 pm, Puranjay Mohan wrote:
> > >>>>>>> On Mon, Aug 3, 2026 at 12:07=E2=80=AFPM James Clark <james.clar=
k@linaro.org> wrote:
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> On 16/06/2026 16:57, Puranjay Mohan wrote:
> > >>>>>>>>> Enable bpf_get_branch_snapshot() on ARM64 by implementing the
> > >>>>>>>>> perf_snapshot_branch_stack static call for BRBE.
> > >>>>>>>>>
> > >>>>>>>>> BRBE is paused before masking exceptions to avoid branch buff=
er
> > >>>>>>>>> pollution from trace_hardirqs_off(). Exceptions are then mask=
ed with
> > >>>>>>>>> local_daif_save() to prevent PMU overflow pseudo-NMIs from in=
terfering.
> > >>>>>>>>> If an overflow between pause and DAIF save re-enables BRBE, t=
he snapshot
> > >>>>>>>>> detects this via BRBFCR_EL1.PAUSED and bails out.
> > >>>>>>>>>
> > >>>>>>>>> Branch records are read using perf_entry_from_brbe_regset() w=
ith a NULL
> > >>>>>>>>> event pointer to bypass event-specific filtering. The buffer =
is
> > >>>>>>>>> invalidated after reading.
> > >>>>>>>>>
> > >>>>>>>>> Introduce a for_each_brbe_entry() iterator to deduplicate ban=
k
> > >>>>>>>>> iteration between brbe_read_filtered_entries() and the snapsh=
ot.
> > >>>>>>>>>
> > >>>>>>>>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > >>>>>>>>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > >>>>>>>>> ---
> > >>>>>>>>>       drivers/perf/arm_brbe.c  | 128 ++++++++++++++++++++++++=
++++++++-------
> > >>>>>>>>>       drivers/perf/arm_brbe.h  |   9 +++
> > >>>>>>>>>       drivers/perf/arm_pmuv3.c |   5 +-
> > >>>>>>>>>       3 files changed, 120 insertions(+), 22 deletions(-)
> > >>>>>>>>>
> > >>>>>>>>> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.=
c
> > >>>>>>>>> index effbdeacfcbb..a141ad7abcf2 100644
> > >>>>>>>>> --- a/drivers/perf/arm_brbe.c
> > >>>>>>>>> +++ b/drivers/perf/arm_brbe.c
> > >>>>>>>>> @@ -9,6 +9,7 @@
> > >>>>>>>>>       #include <linux/types.h>
> > >>>>>>>>>       #include <linux/bitmap.h>
> > >>>>>>>>>       #include <linux/perf/arm_pmu.h>
> > >>>>>>>>> +#include <asm/daifflags.h>
> > >>>>>>>>>       #include "arm_brbe.h"
> > >>>>>>>>>
> > >>>>>>>>>       #define BRBFCR_EL1_BRANCH_FILTERS (BRBFCR_EL1_DIRECT   =
| \
> > >>>>>>>>> @@ -256,6 +257,14 @@ static bool valid_brbe_version(int brbe_=
version)
> > >>>>>>>>>                  brbe_version =3D=3D ID_AA64DFR0_EL1_BRBE_BRB=
E_V1P1;
> > >>>>>>>>>       }
> > >>>>>>>>>
> > >>>>>>>>> +static __always_inline bool cpu_has_brbe(void)
> > >>>>>>>>
> > >>>>>>>> This should be more like cpu_valid_brbe_version(). has_brbe() =
only
> > >>>>>>>> implies that the CPU has BRBE, not that it's a version that th=
e driver
> > >>>>>>>> supports. And it's actually just a wrapper around valid_brbe_v=
ersion()
> > >>>>>>>> that accesses the ID reg on that CPU, not a functionally diffe=
rent check.
> > >>>>>>>>
> > >>>>>>>> But it also looks like valid_brbe_version() isn't called from =
anywhere
> > >>>>>>>> else, so why not delete that function and use its name for the=
 new one?
> > >>>>>>>
> > >>>>>>> I will do that in next version
> > >>>>>>>
> > >>>>>>>>
> > >>>>>>>>> +{
> > >>>>>>>>> +     u64 aa64dfr0 =3D read_sysreg_s(SYS_ID_AA64DFR0_EL1);
> > >>>>>>>>> +     int brbe =3D cpuid_feature_extract_unsigned_field(aa64d=
fr0, ID_AA64DFR0_EL1_BRBE_SHIFT);
> > >>>>>>>>> +
> > >>>>>>>>> +     return valid_brbe_version(brbe);
> > >>>>>>>>> +}
> > >>>>>>>>> +
> > >>>>>>>>>       static void select_brbe_bank(int bank)
> > >>>>>>>>>       {
> > >>>>>>>>>           u64 brbfcr;
> > >>>>>>>>> @@ -271,6 +280,20 @@ static void select_brbe_bank(int bank)
> > >>>>>>>>>           isb();
> > >>>>>>>>>       }
> > >>>>>>>>>
> > >>>>>>>>> +static inline void __brbe_advance(int *bank, int *idx, int n=
r_hw)
> > >>>>>>>>> +{
> > >>>>>>>>> +     if (++(*idx) >=3D BRBE_BANK_MAX_ENTRIES &&
> > >>>>>>>>> +         *bank * BRBE_BANK_MAX_ENTRIES + *idx < nr_hw) {
> > >>>>>>>>> +             *idx =3D 0;
> > >>>>>>>>> +             select_brbe_bank(++(*bank));
> > >>>>>>>>> +     }
> > >>>>>>>>> +}
> > >>>>>>>>> +
> > >>>>>>>>> +#define for_each_brbe_entry(idx, nr_hw)                     =
                 \
> > >>>>>>>>> +     for (int __bank =3D (select_brbe_bank(0), 0), idx =3D 0=
;            \
> > >>>>>>>>> +          __bank * BRBE_BANK_MAX_ENTRIES + idx < (nr_hw);   =
         \
> > >>>>>>>>> +          __brbe_advance(&__bank, &idx, (nr_hw)))
> > >>>>>>>>> +
> > >>>>>>>>>       static bool __read_brbe_regset(struct brbe_regset *entr=
y, int idx)
> > >>>>>>>>>       {
> > >>>>>>>>>           entry->brbinf =3D get_brbinf_reg(idx);
> > >>>>>>>>> @@ -474,11 +497,9 @@ unsigned int brbe_num_branch_records(con=
st struct arm_pmu *armpmu)
> > >>>>>>>>>
> > >>>>>>>>>       void brbe_probe(struct arm_pmu *armpmu)
> > >>>>>>>>>       {
> > >>>>>>>>> -     u64 brbidr, aa64dfr0 =3D read_sysreg_s(SYS_ID_AA64DFR0_=
EL1);
> > >>>>>>>>> -     u32 brbe;
> > >>>>>>>>> +     u64 brbidr;
> > >>>>>>>>>
> > >>>>>>>>> -     brbe =3D cpuid_feature_extract_unsigned_field(aa64dfr0,=
 ID_AA64DFR0_EL1_BRBE_SHIFT);
> > >>>>>>>>> -     if (!valid_brbe_version(brbe))
> > >>>>>>>>> +     if (!cpu_has_brbe())
> > >>>>>>>>>                   return;
> > >>>>>>>>>
> > >>>>>>>>>           brbidr =3D read_sysreg_s(SYS_BRBIDR0_EL1);
> > >>>>>>>>> @@ -618,10 +639,10 @@ static bool perf_entry_from_brbe_regset=
(int index, struct perf_branch_entry *ent
> > >>>>>>>>>
> > >>>>>>>>>           brbe_set_perf_entry_type(entry, brbinf);
> > >>>>>>>>>
> > >>>>>>>>> -     if (!branch_sample_no_cycles(event))
> > >>>>>>>>> +     if (!event || !branch_sample_no_cycles(event))
> > >>>>>>>>>                   entry->cycles =3D brbinf_get_cycles(brbinf)=
;
> > >>>>>>>>>
> > >>>>>>>>> -     if (!branch_sample_no_flags(event)) {
> > >>>>>>>>> +     if (!event || !branch_sample_no_flags(event)) {
> > >>>>>>>>>                   /* Mispredict info is available for source =
only and complete branch records. */
> > >>>>>>>>>                   if (!brbe_record_is_target_only(brbinf)) {
> > >>>>>>>>>                           entry->mispred =3D brbinf_get_mispr=
edict(brbinf);
> > >>>>>>>>> @@ -774,32 +795,97 @@ void brbe_read_filtered_entries(struct =
perf_branch_stack *branch_stack,
> > >>>>>>>>>       {
> > >>>>>>>>>           struct arm_pmu *cpu_pmu =3D to_arm_pmu(event->pmu);
> > >>>>>>>>>           int nr_hw =3D brbe_num_branch_records(cpu_pmu);
> > >>>>>>>>> -     int nr_banks =3D DIV_ROUND_UP(nr_hw, BRBE_BANK_MAX_ENTR=
IES);
> > >>>>>>>>>           int nr_filtered =3D 0;
> > >>>>>>>>>           u64 branch_sample_type =3D event->attr.branch_sampl=
e_type;
> > >>>>>>>>>           DECLARE_BITMAP(event_type_mask, PERF_BR_ARM64_MAX);
> > >>>>>>>>>
> > >>>>>>>>>           prepare_event_branch_type_mask(branch_sample_type, =
event_type_mask);
> > >>>>>>>>>
> > >>>>>>>>> -     for (int bank =3D 0; bank < nr_banks; bank++) {
> > >>>>>>>>> -             int nr_remaining =3D nr_hw - (bank * BRBE_BANK_=
MAX_ENTRIES);
> > >>>>>>>>> -             int nr_this_bank =3D min(nr_remaining, BRBE_BAN=
K_MAX_ENTRIES);
> > >>>>>>>>> +     for_each_brbe_entry(i, nr_hw) {
> > >>>>>>>>> +             struct perf_branch_entry *pbe =3D &branch_stack=
->entries[nr_filtered];
> > >>>>>>>>>
> > >>>>>>>>> -             select_brbe_bank(bank);
> > >>>>>>>>> +             if (!perf_entry_from_brbe_regset(i, pbe, event)=
)
> > >>>>>>>>> +                     break;
> > >>>>>>>>>
> > >>>>>>>>> -             for (int i =3D 0; i < nr_this_bank; i++) {
> > >>>>>>>>> -                     struct perf_branch_entry *pbe =3D &bran=
ch_stack->entries[nr_filtered];
> > >>>>>>>>> +             if (!filter_branch_record(pbe, branch_sample_ty=
pe, event_type_mask))
> > >>>>>>>>> +                     continue;
> > >>>>>>>>>
> > >>>>>>>>> -                     if (!perf_entry_from_brbe_regset(i, pbe=
, event))
> > >>>>>>>>> -                             goto done;
> > >>>>>>>>> +             nr_filtered++;
> > >>>>>>>>> +     }
> > >>>>>>>>>
> > >>>>>>>>> -                     if (!filter_branch_record(pbe, branch_s=
ample_type, event_type_mask))
> > >>>>>>>>> -                             continue;
> > >>>>>>>>> +     branch_stack->nr =3D nr_filtered;
> > >>>>>>>>> +}
> > >>>>>>>>>
> > >>>>>>>>> -                     nr_filtered++;
> > >>>>>>>>> -             }
> > >>>>>>>>> +/*
> > >>>>>>>>> + * Best-effort BRBE snapshot for BPF tracing. Pause BRBE to =
avoid
> > >>>>>>>>> + * self-recording and return 0 if the snapshot state appears=
 disturbed.
> > >>>>>>>>> + */
> > >>>>>>>>> +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry =
*entries, unsigned int cnt)
> > >>>>>>>>> +{
> > >>>>>>>>> +     unsigned long flags;
> > >>>>>>>>> +     int nr_hw, nr_copied =3D 0;
> > >>>>>>>>> +     u64 brbfcr, brbcr;
> > >>>>>>>>> +
> > >>>>>>>>> +     if (!cnt)
> > >>>>>>>>> +             return 0;
> > >>>>>>>>
> > >>>>>>>> If you're trying to avoid branches before pausing BRBE, can't =
you check
> > >>>>>>>> this after the pause?
> > >>>>>>>
> > >>>>>>> will drop this in the next version and this is just an optimiza=
tion.
> > >>>>>>>
> > >>>>>>>>
> > >>>>>>>>> +
> > >>>>>>>>> +     /* Guard against running on a CPU without BRBE (e.g. bi=
g.LITTLE). */
> > >>>>>>>>> +     if (!cpu_has_brbe())
> > >>>>>>>>> +             return 0;
> > >>>>>>>>> +
> > >>>>>>>>> +     /*
> > >>>>>>>>> +      * Pause BRBE first to avoid recording our own branches=
. The
> > >>>>>>>>> +      * sysreg read/write and ISB are branchless, so pausing=
 before
> > >>>>>>>>> +      * checking BRBCR avoids polluting the buffer with our =
own
> > >>>>>>>>> +      * conditional branches.
> > >>>>>>>>> +      */
> > >>>>>>>>> +     brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> > >>>>>>>>> +     brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> > >>>>>>>>> +     write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_E=
L1);
> > >>>>>>>>
> > >>>>>>>> Can this work without first disabling interrupts? Sashiko poin=
ted it
> > >>>>>>>> out, but I think it's correct. If you read an active state int=
o brbfcr,
> > >>>>>>>> then the PMU event fires and disables BRBE, then you disable i=
nterrupts,
> > >>>>>>>> then you would restore an active state when it should be inact=
ive.
> > >>>>>>>> Surely the only way to do it properly is to disable interrupts=
 before
> > >>>>>>>> touching anything at all, if the PMU handler is also touching =
the same
> > >>>>>>>> registers?
> > >>>>>>>>
> > >>>>>>>> If you want to avoid trace_hardirqs_off() can you make a new
> > >>>>>>>> raw_local_daif_save() that disables interrupts and then call
> > >>>>>>>> trace_hardirqs_off() yourself after pausing BRBE? Or not call
> > >>>>>>>> trace_hardirqs_off() at all? There is a comment mentioning som=
ething
> > >>>>>>>> like that in arch/arm64/kernel/suspend.c.
> > >>>>>>>
> > >>>>>>> Yes. I'll add raw_local_daif_save()/raw_local_daif_restore() an=
d mask before
> > >>>>>>> touching any BRBE register, which fixes the stale restore. trac=
e_hardirqs_off()
> > >>>>>>> then moves below the pause so lockdep still sees a balanced off=
/on pair while
> > >>>>>>> its branches land in an already paused buffer.
> > >>>>>>>
> > >>>>>>>>
> > >>>>>>>> Also, disabling interrupts doesn't stop the PMU event from ove=
rflowing
> > >>>>>>>> and changing the state of PAUSED either. I think this is anoth=
er path
> > >>>>>>>> that leads to you restoring the wrong state, so don't you also=
 need to
> > >>>>>>>> disable the PMU?
> > >>>>>>>
> > >>>>>>> Hardware only sets PAUSED on a BRBE freeze event (RBHYTD), and =
a freeze needs
> > >>>>>>> BRBE to not already be paused (RNXCWF). So once we have paused,=
 nothing changes
> > >>>>>>> underneath us and the PMU does not need disabling. It would not=
 help anyway:
> > >>>>>>> armv8pmu_stop() calls brbe_disable(), which zeroes BRBCR_EL1 an=
d discards the
> > >>>>>>> records we came to read.
> > >>>>>>
> > >>>>>> That does mean you throw away real freeze events while paused th=
ough, in
> > >>>>>> addition to the brbe_invalidate() you need to avoid non contiguo=
us
> > >>>>>> buffers. So it takes branches away from PMU events.
> > >>>>>
> > >>>>> RBHYTD gives a freeze two effects: PAUSED is set, and BRBTS_EL1 c=
aptures a
> > >>>>> timestamp. Recording has already stopped because we paused, and t=
he driver never
> > >>>>> reads BRBTS_EL1. On the way out we check PMOVSCLR_EL0 and leave P=
AUSED set if a
> > >>>>> counter overflowed, so a pending overflow handler still finds a f=
rozen buffer.
> > >>>>>
> > >>>>>> So it takes branches away from PMU events.
> > >>>>>
> > >>>>> Yes, but that is brbe_invalidate(), not the pause. Interrupts are=
 masked and
> > >>>>> nothing else runs on the CPU, so the only branches the pause supp=
resses are the
> > >>>>> snapshot's own.
> > >>>>>
> > >>>>>>>
> > >>>>>>> You are right that a freeze can still land in the window betwee=
n reading BRBFCR
> > >>>>>>> and setting PAUSED, and restoring the value we read would then =
clear a PAUSED
> > >>>>>>> bit the hardware set. So v6 checks PMOVSCLR_EL0 and leaves BRBE=
 paused if a
> > >>>>>>> counter has overflowed. Reads of PMOVSCLR are non-destructive a=
nd it stays set
> > >>>>>>> until the overflow handler clears it, so it is still visible af=
ter we have set
> > >>>>>>> PAUSED ourselves:
> > >>>>>>>
> > >>>>>>>             if (!valid_brbe_version())
> > >>>>>>>                     return 0;
> > >>>>>>>
> > >>>>>>>             flags =3D raw_local_daif_save();
> > >>>>>>>
> > >>>>>>>             brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> > >>>>>>>             brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> > >>>>>>>
> > >>>>>>>             write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBF=
CR_EL1);
> > >>>>>>>             isb();
> > >>>>>>>
> > >>>>>>>             trace_hardirqs_off();
> > >>>>>>>
> > >>>>>>>             /* BRBCR_EL1 is zero while the driver has BRBE disa=
bled. */
> > >>>>>>>             if (!brbcr)
> > >>>>>>>                     goto restore;
> > >>>>>>>
> > >>>>>>>             ... read the records ...
> > >>>>>>>
> > >>>>>>
> > >>>>>> Up to the point where you read the records you technically don't=
 need
> > >>>>>> any branches (if you don't do trace_hardirqs_off()) so you could=
 do the
> > >>>>>> whole thing without pausing. Just disable interrupts, read every=
 branch
> > >>>>>> entry unconditionally, re-enable interrupts and then find the la=
st valid
> > >>>>>> entry and do the branchy stuff after reading.
> > >>>>>>
> > >>>>>> I'm thinking out loud, but doesn't that make it a lot easier? An=
d it
> > >>>>>> avoids the brbe_invalidate() which takes the branches away from =
the PMU
> > >>>>>> event. It also avoids having to think too hard about racing with=
 PMU
> > >>>>>> events causing a freeze even after interrupts are disabled and a=
fter
> > >>>>>> reading the freeze value:
> > >>>>>>
> > >>>>>>       raw_local_daif_save();
> > >>>>>>       brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> > >>>>>>       brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> > >>>>>>       select_bank(0);
> > >>>>>>       read_record(0);
> > >>>>>>       read_record(1);
> > >>>>>>       ...
> > >>>>>>       select_bank(0);
> > >>>>>>       read_record(0);
> > >>>>>>       read_record(1);
> > >>>>>>       ...
> > >>>>>>       write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> > >>>>>>       isb();
> > >>>>>>       local_daif_restore();
> > >>>>>>
> > >>>>>>       /* Now do post processing, find last valid record, check i=
f it was
> > >>>>>> enabled by looking at brbcr etc. */
> > >>>>>
> > >>>>> MRS is not a branch, so that works, but three things would have t=
o change:
> > >>>>>
> > >>>>> 1. perf_entry_from_brbe_regset() goes through BRBE_REGN_SWITCH, a=
 32 case
> > >>>>>       switch, because the register number has to be an immediate.=
 gcc emits a jump
> > >>>>>       table and the function has 52 branches in the object file. =
The read would
> > >>>>>       need full unrolling.
> > >>>>>
> > >>>>
> > >>>> Yes you would have to manually unroll it. I doubt the compiler wou=
ld
> > >>>> emit a branch for BRBE_REGN_SWITCH() because your indexes are stat=
ic if
> > >>>> it's unrolled. But if it does you can change it to a sequence of
> > >>>> read_sysreg_s()s.
> > >>>>
> > >>>> If you really want to be sure there are no branches, write it in a
> > >>>> single asm block.
> > >>>
> > >>> I will try that approach in the next version.
> > >>>
> > >>>>> 2. RPGDLX needs an ISB before the reads, and Table D19-10 makes i=
t
> > >>>>>       IMPLEMENTATION DEFINED whether ISB itself generates a recor=
d. When we pause,
> > >>>>>       IZCHRF means the pausing ISB cannot pollute the buffer it i=
s about to read.
> > >>>>>
> > >>>>
> > >>>> I assume one potential extra record from the isb() is acceptible s=
eeing
> > >>>> as you already have two or more conditions plus a function call be=
fore
> > >>>> the pause? Is the problem that you don't know whether to filter it=
 out
> > >>>> later because it's IMPDEF and isn't always there? You already don'=
t know
> > >>>> exactly how many branches there will be before the pause beause it=
's
> > >>>> written in C. So I'm not sure what the exact issue here is.
> > >>>>
> > >>>>> 3. 64 record parts still need a bank switch, so BRBFCR_EL1 still =
has to be
> > >>>>>       written and restored.
> > >>>>>
> > >>>>
> > >>>> Yes that was included in my pseudo code example but it's still
> > >>>> branchless. I did miss that you might need an isb() after disablin=
g
> > >>>> interrupts, but you added one for RPGDLX anyway.
> > >>>>
> > >>>>> Correctness would then depend on the read staying branchless, whi=
ch is not
> > >>>>> checkable at build time and fails silently: a branch mid read shi=
fts the buffer,
> > >>>>
> > >>>> Why would the compiler insert a branch between two read_sysreg_s()=
s,
> > >>>> which are asm volatile? Is that allowed?
> > >>>
> > >>> You are right, I just over complicated it!
> > >>>
> > >>>>> giving a duplicate and a gap. 64 * 24 bytes of records also wants=
 a per-CPU
> > >>>>> scratch buffer rather than the stack.
> > >>>>>
> > >>>>
> > >>>> A per-CPU scratch buffer doesn't sound too bad. But aren't you in
> > >>>> control of how many entries are available to write to? You can rej=
ect
> > >>>> any calls that have fewer than 64 and always write directly to *en=
tries.
> > >>>>
> > >>>> You could also compare with 'cnt' after reading each record and ex=
it the
> > >>>> read section. Like you say below, branches not taken don't generat=
e
> > >>>> records, and once the branch is taken you stop reading so after th=
at
> > >>>> point generating records doesn't matter.
> > >>>>
> > >>>>> Happy to prototype it. What I would not do is pause without inval=
idating:
> > >>>>> records are from/to pairs, so a consumer walking across the hole =
reconstructs a
> > >>>>> call path that never happened. The invalidate was Mark's request =
after the RFC,
> > >>>>> "to maintain record contiguity for other consumers", so dropping =
the pause drops
> > >>>>> that too.
> > >>>>
> > >>>> Well the point was to not have to pause at all, so there's no need=
 to
> > >>>> invalidate either. Even if you did add a pause, as long as there a=
re no
> > >>>> branches between the pause and resume you don't need an invalidate
> > >>>> because you didn't miss any branches.
> > >>>>
> > >>>>>
> > >>>>> I was thinking of this for v6:
> > >>>>>
> > >>>>>            flags =3D raw_local_daif_save();
> > >>>>>
> > >>>>>            /* The BRBE sysregs below are UNDEFINED without this. =
*/
> > >>>>>            if (!valid_brbe_version()) {
> > >>>>
> > >>>> You don't need to disable interrupts to call this, it's a constant=
. Or
> > >>>> is it to stop migration?
> > >>>
> > >>> It was to stop migration.
> > >>>
> > >>
> > >> Ah ok, so V5 wasn't correct then.
> > >
> > > Yes, It was buggy! I missed that one CPU could implement BRBE while
> > > another doesn't
> > >
> > >>
> > >> Separately to this, I'm also not sure how this BPF call is invoked. =
Is
> > >> it supposed to target a CPU, or an event or a process? How do you kn=
ow
> > >> you are getting the branches from the CPU that you want?
> > >
> > > So, A BPF program can attach to a function's entry through ftrace or
> > > kprobe and from there we call this helper to find out what branches
> > > were taken to reach that function.
> > > A BPF program runs on a CPU with migration always disabled, so it
> >
> > In that case you can check for BRBE support before disabling interrupts=
.
> >
> > So I think V5 wasn't buggy and you can carry on doing
> > valid_brbe_version() at the same place in V6.
> >
> > > knows which cpu it is getting the branches from. And It can also
> > > filter for a process as it knows which process is called the BPF
> > > program, let's say a process does a syscall and we attach a bpf
> > > program to it as the example I gave with the retsnoop tool in the
> > > cover letter's Usage model section. A BPF program can also attach to =
a
> > > tracepoint, or even to a perf event and this BPF helper can be called
> > > from any of those contexts, but the filtering based on cpu or pid or
> > > anything else is done by the BPF program itself, this helper should
> > > just return the raw branch records.
> > >
> >
> > Thanks for the explanation.
> >
> > >>>>
> > >>>> V5 reads sysregs before disabling interrupts so I assume migration=
 isn't
> > >>>> an issue here.
> > >>>>
> > >>>>>                    raw_local_daif_restore(flags);
> > >>>>>                    return 0;
> > >>>>>            }
> > >>>>>
> > >>>>>            brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> > >>>>>            brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> > >>>>>
> > >>>>>            write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_=
EL1);
> > >>>>>            isb();
> > >>>>>
> > >>>>>            /* BRBCR_EL1 is zero while the driver has BRBE disable=
d. */
> > >>>>>            if (!brbcr) {
> > >>>>>                    write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> > >>>>>                    isb();
> > >>>>>                    raw_local_daif_restore(flags);
> > >>>>>                    return 0;
> > >>>>>            }
> > >>>>>
> > >>>>>            trace_hardirqs_off();
> > >>>>>
> > >>>>>            ... read the records ...
> > >>>>>
> > >>>>>            if (!(brbfcr & BRBFCR_EL1_PAUSED) &&
> > >>>>>                !(read_pmovsclr() & (ARMV8_PMU_OVSR_P | ARMV8_PMU_=
OVSR_F)))
> > >>>>>                    brbe_invalidate();
> > >>>>>            else
> > >>>>>                    brbfcr |=3D BRBFCR_EL1_PAUSED;
> > >>>>>
> > >>>>>            write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> > >>>>>            isb();
> > >>>>>            local_daif_restore(flags);
> > >>>>>
> > >>>>> Exceptions are masked before anything is sampled, BRBCR_EL1 is on=
ly read and
> > >>>>> never written, and BRBFCR_EL1 is written back from the value save=
d under the
> > >>>>> mask. cpu_has_brbe() is now valid_brbe_version().
> > >>>>>
> > >>>>> Neither conditional costs a record: valid_brbe_version() falls th=
rough when BRBE
> > >>>>> is present (RBBNSZ, only taken branches are recorded), and the BR=
BCR_EL1 test is
> > >>>>
> > >>>> Isn't the compiler free to invert it and make the happy path a tak=
en
> > >>>> branch. I don't think any of that can be assumed without writing i=
n
> > >>>> assembly.
> > >>>>
> > >>>>> after the pause. It cannot move later because BRBFCR_EL1 is UNDEF=
INED without
> > >>>>> FEAT_BRBE.
> > >>>>>
> > >>>>> PMOVSCLR_EL0 is masked because PMCCNTR_EL0 is bit 31 and PMCR_EL0=
.N is at most
> > >>>>> 31, so the cycle counter is outside every range RNXCWF, RGXGWY, R=
PKTXQ and
> > >>>>> RLDMVK name. Unmasked, a cycle counter overflow looked like a fre=
eze.
> > >>>>
> > >>>> Sorry I didn't understand this bit. Can you elaborate?
> > >>>>
> > >>>>>
> > >>>>> Do you think this version works?
> > >>>>>
> > >>>>> Thanks,
> > >>>>> Puranjay
> > >>>>
> > >>>>
> > >>>>    From your previous reply:
> > >>>>
> > >>>>      "Hardware only sets PAUSED on a BRBE freeze event (RBHYTD), a=
nd a
> > >>>>       freeze needs BRBE to not already be paused (RNXCWF). So once=
 we have
> > >>>>       paused, nothing changes underneath us and the PMU does not n=
eed
> > >>>>       disabling."
> > >>>>
> > >>>> I'm still not 100% convinced this is correct. You read BRBFCR_EL1 =
and
> > >>>> write PAUSED to it in separate instructions. The PMU can overflow =
and
> > >>>> change the PAUSED state between those two instructions leading to
> > >>>> restoration of the wrong value.
> > >>>
> > >>> I was checking if the overflow happened and leaving it paused in th=
at case.
> > >>>
> > >>
> > >> But couldn't it overflow after that check? I still think it's vulner=
able
> > >> to the same issue unless you disable the PMU completely.
> > >
> > > yeah you are right, I missed that it can overflow after the check.
> > >
> > >>
> > >>>> Isn't this non pausing version way simpler to understand, and also=
 has
> > >>>> the benefit of not invalidating someone elses BRBE buffers. The on=
ly
> > >>>> downside seems to be that it might have some assembly to make sure=
 the
> > >>>> if statements are always not taken branches rather than inverted, =
but
> > >>>> personally I don't think that makes it any harder to understand th=
an the
> > >>>> branchy pausing version in V5:
> > >>>>
> > >>>>      #define read_record(i)
> > >>>>        if (i >=3D cnt)                                       \
> > >>>>           goto out;                                        \
> > >>>>        isb(); /* Ensure our own exit branch isn't read? */ \
> > >>>>        entries[i].inf =3D read_brbe_inf(i)                   \
> > >>>>        if (!inf)                                           \
> > >>>>           goto out;                                        \
> > >>>>        entries[i].src =3D read_brb_src(i)                    \
> > >>>>        entries[i].dst =3D read_brb_dst(i)                    \
> > >>>>
> > >>>>      raw_local_daif_save();
> > >>>>
> > >>>>      /* disable counters to stop BRBFCR_EL1.PAUSE state changing *=
/
> > >>>>      pmcr =3D armv8pmu_pmcr_read();
> > >>>>      armv8pmu_pmcr_write(pmcr & ~ARMV8_PMU_PMCR_E);
> > >>>>      isb();
> > >>>>
> > >>>>      brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> > >>>>      brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> > >>>>
> > >>>>      select_bank(0);
> > >>>>      read_record(0);
> > >>>>      read_record(1);
> > >>>>      ...
> > >>>>      select_bank(1);
> > >>>>      read_record(32);
> > >>>>      read_record(33);
> > >>>>      ...
> > >>>>
> > >>>> out:
> > >>>>      write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> > >>>>      isb();
> > >>>>      armv8pmu_pmcr_write(pmcr);
> > >>>>      raw_local_daif_restore();
> > >>>>
> > >>>>      /* Post process entries[n].inf etc into correct format */
> > >>>
> > >>> I will try out this approach and get back.
>
> Hi James, I tried this approach without the PAUSE but there is a
> problem, the hardware that I tested on creates a record for isb() and
> when reading the banks, we need to do an isb() after bank selection
> and it's recorded, so it shifts every record's index by one between
> the two bank reads, leaving the two halves stitched from buffer states
> one shift apart.

So, I think we have to pause but with your suggestion about disabling
counters there is no race left:

int brbe_snapshot_branch_stack(struct perf_branch_entry *entries,
unsigned int cnt)
{
        u64 brbidr, brbfcr, brbcr, pmcr;
        int nr_hw, nr_copied =3D 0;
        unsigned long flags;

        /*
         * Other BRBE sysreg accesses are UNDEFINED without this. The calle=
r
         * runs with migration disabled, so this is the CPU they are read o=
n.
         */
        if (!valid_brbe_version())
                return 0;

        /*
         * brbe_enable()/brbe_disable() run from the overflow interrupt and
         * from event add/remove IPIs, so mask before sampling any state.
         */
        flags =3D raw_local_daif_save();

        /*
         * BRBFCR_EL1 is read here and written back below, and a BRBE freez=
e
         * event in between would set BRBFCR_EL1.PAUSED behind that. Stoppi=
ng
         * the counters keeps PMOVSCLR_EL0 from gaining a bit, which is wha=
t
         * every freeze condition in Arm ARM (DDI 0487 M.a) D19.3 requires.
         */
        pmcr =3D read_pmcr();
        write_pmcr(pmcr & ~ARMV8_PMU_PMCR_E);
        isb();

        brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
        brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);

        write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
        isb();
        trace_hardirqs_off();

        /*
         * The pause has taken effect: the branches below generate no recor=
ds,
         * and every D19.3 freeze condition also requires that generation i=
s
         * not paused, so the counters can be started again.
         */
        write_pmcr(pmcr);

        /* Records outlive brbe_disable(), so report nothing while
BRBE is off. */
        if (brbcr) {
                brbidr =3D read_sysreg_s(SYS_BRBIDR0_EL1);
                nr_hw =3D min_t(int, FIELD_GET(BRBIDR0_EL1_NUMREC_MASK, brb=
idr),
                              BRBIDR0_EL1_NUMREC_64);

                for_each_brbe_entry(i, nr_hw) {
                        if (nr_copied >=3D cnt)
                                break;

                        if (!perf_entry_from_brbe_regset(i,
&entries[nr_copied], NULL))
                                break;

                        nr_copied++;
                }
        }

        /*
         * Branches were missed while paused, so discard the buffer rather
         * than leave a hole in it. BRBE that arrived frozen stopped before
         * this ran, so its records are still contiguous and belong to
         * whoever froze it.
         */
        if (!(brbfcr & BRBFCR_EL1_PAUSED))
                brbe_invalidate();

        write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
        isb();
        local_daif_restore(flags);

        return nr_copied;
}


What do you think about this version? Is this acceptable?
