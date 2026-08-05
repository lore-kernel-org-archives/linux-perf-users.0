Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9034843848C
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930476; cv=pass; b=Uj/GNufSCsb/Y8KUXNIoqWobOIsRJlUtKxSgk5f+J6aJGC7uA+PRYHLvcef7J9bBKiSFc9+bJPXXMpfBTRi++dzyR5O4jGy/efrqqWFjucWtScv4RSQ7JjjMu1xRMlO0UeMFU2SfjPGCGOYYgUL2q8ZqJaNSSsPsc/YVyUIoIMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930476; c=relaxed/simple;
	bh=j67LDSbOeJv3HPTWDnRAxcfSw8KGj1KS17UrQpx+Dg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGVD8vA4ydNXKG8VjA3g5EWpCECxnchv4g6GNQXVU0Fob2fR4fwuHN8eC0F+2nA97OUzs+zGlh7AB7eFoeWRptCcn55KBD4x0TSrZyz/m5u7Q3w1lrFyHIc0lLSkTsdGMfn+yDcURY7pIx6tsWMmdaXK4rZeh1rq1bfx6yu+xvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilz6agU4; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilz6agU4"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15b1da6b82so98943366b.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 04:47:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785930473; cv=none;
        d=google.com; s=arc-20260327;
        b=Dlj+Tp62nhES40TuvfB93YggDyO+KrB7Eeonpb5KkkUe3nWuRErLuRgUAlUS8/y2Ox
         kqiBATagrupQavDta1Jrhioh6SrQdElRe5qWRi8DYHicBDcSEC0wEsamBQ2p/BG7dBCs
         aFWWXIH3ymmsC8LPmrUIchSJQIumpLLsONZP2yxcUVhGCynbu+ZT0ELaFGLlmFpuxIl0
         mt9voFgQG8f3LcKgo0LPgZ6TKWniEiFNh87MmqR+4gabg93fsUhbSrBB78yF9QxuXSDT
         lZduAyF8XCY88YBFuuTQ4k5VvgiHOb8lvDjoq+T5MfoZfa/ElOQ8+4bNMKjc9Y8jOPMv
         cbHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3UAVk8fCaTvm9E7QhuLg8S14/K+7SSYssW7sMyZymmA=;
        fh=ACtGIiyuzui0VKxqC+83reOFZHth1bilFWN6rdun1RY=;
        b=W9vgQDWEJCXWiftZJ5srnhGOgGpQk7rIdIlBjQbOvNAyc1WkO7x/HTMc/7L+optOI8
         uMRiwY+Lmd7ktFgZBtQrpsKFv+HQifws7IaVMgHcrrzI3QEQBEoTH81BqJut8d5eV4Kx
         XAgQmTsm4k0HMBw0KZKmwulVM0wLI6hO/2owOy9Kjm/kEUzQnINN14IIZAauKtNzjDGl
         JcJDa453b/f9ANiBRQU07DzuyLJ+uc6sieidu2vC4bqNP22GxypRNhKAec9FM4KVNKm7
         jJLxYuJONVb2qbZpWkRlor1LFayU/U/EOjsUHqTCOXWZUD39ZLEzhwoBx7XsIFi1ooQF
         uC5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785930473; x=1786535273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3UAVk8fCaTvm9E7QhuLg8S14/K+7SSYssW7sMyZymmA=;
        b=ilz6agU4rvkBc0aoQucMMs8+PUBe35naUoX0LLzJyrQ6lybSxEIO8vJJiSWfGP2GJR
         5GzmQVJL5fV8Umf3G0oK8IbPihdMzDCoqRuURhX7k4c6QtjtrQ/6IyDZUoMvzm0l/tUr
         pQJ+pPvae8wsvTgrt+aj2bbdloG5ScZIWxpqqjInnZJgZkJLi5LSXhTw0YEPcu3I0cmO
         fOU+6BddP88xem/bKPvmuRl4WnVk1pM9AUh2feDrxS7hV1JWoFTRwlKgoyQTIn/bUJ+V
         a1TLBXz77cWu/BeUR1DTv/fSFj305X3ui0oyx7if1dI+KuKVq9KdsZKKZLIn0b9xd6cM
         4Yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785930473; x=1786535273;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3UAVk8fCaTvm9E7QhuLg8S14/K+7SSYssW7sMyZymmA=;
        b=XXQeG+7AljLGfcc4KwvTBfyUZOsLOHd1MRAbw/HjfQc/YVtSxZNsCdKzMnrejaIC+y
         zZ5zJLStE0tpryH75UVDRT4Wlyc/ClyL9xMk9T5FjAfqE98+rA33bySJVNZ7GLhoxUZI
         HQPXhAGW1C0ogJp0H8d/soZ88afLlTsq7WYeH09rd6B8fD1bPBBv6WX62p8PKWUAayJq
         c6r4Q4LtzxBaUzf1fpl0Z1mcYytViNlV1ehNzQAUj6VZLVUGuhD2VP0lLsT890veLXNv
         mQUGzTnpb8PbXtW6SMkseUnJJBWNJFbMDek+zqSEIG+cy1qeQoEhh1qDiH2eC+++BYZP
         GliA==
X-Forwarded-Encrypted: i=1; AHgh+Ro0kcKCrQOsIkkx7jjD926k5/c8JQuzW7pjsnVROYL1vHS9XcZrBQABbNvcJha2vCp2ZRAoWSq+ptnkUx7mtmZZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwXM5qF4NIuNzXvOs2blM5tldjEOReyYTKxGaPei+02KP9eRu9f
	bPx+galowXmA/Lb9E5+fz70OqfXZXbgRsxhXLd2zXWG0q+14xHX6jEMe9BmYvgyJBfakLSFUNU/
	zCz9oEmdxjCUUlXbLu2d7P2gQf8NbTdg=
X-Gm-Gg: AR+sD11jLQKPlWdDOvmlDrw92ZSLDWfC/7ZrIzp6/JVQbifXAeuBN7PG+nrXj6Vhcv2
	8dHPHSAkkko1PFEvKKurGB+Q3nbZZR30W9LbnVNk+JPVlvShVG8RsqJSXKB8m8v2ojNLrtyMw+s
	Tigs8J2aHPxFYgioVBzMRGOqvwahC2Gbrh/qc9VT5IrE7Z3iq6Oj4ZkW1kcUK6DAH5r2dWFTK0R
	WjeKM4ZIRVZyA7ujUmHE89PGgD1boxCshMVqrD0OEvaGB8G7dvx0RN69ALpNE/PBUNG0ftM5I8L
	2reByyJfTwn449V64NChURQSA0Rpeb9mcwCQtTjgRhYy0iAlVPr1CrWqj4yv
X-Received: by 2002:a17:907:1ca0:b0:c20:2299:1ddb with SMTP id
 a640c23a62f3a-c2039abc09cmr360640866b.3.1785930472532; Wed, 05 Aug 2026
 04:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616155716.2631508-1-puranjay@kernel.org> <20260616155716.2631508-4-puranjay@kernel.org>
 <8a24abbc-10bc-42bb-8fee-0a174d8f1751@linaro.org> <CANk7y0inRXCUKtuio3Cb03DvuNPq6yp1o+tsE8PZitrY0LaOPQ@mail.gmail.com>
 <6ee32efc-01be-4532-aa59-3948f59156c0@linaro.org>
In-Reply-To: <6ee32efc-01be-4532-aa59-3948f59156c0@linaro.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 5 Aug 2026 12:47:38 +0100
X-Gm-Features: AUfX_mzBURrEDNjJEyg21SVA5RFbwL54hNf7iDxco6mEuBZj-ZYLCBD7SSDGaSk
Message-ID: <CANk7y0hU_m6gJ9FpGfGUJg-Ok8PoXhKruny_0OkeOgLbCo6ZLA@mail.gmail.com>
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

On Wed, Aug 5, 2026 at 11:07=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 03/08/2026 7:54 pm, Puranjay Mohan wrote:
> > On Mon, Aug 3, 2026 at 12:07=E2=80=AFPM James Clark <james.clark@linaro=
.org> wrote:
> >>
> >>
> >>
> >> On 16/06/2026 16:57, Puranjay Mohan wrote:
> >>> Enable bpf_get_branch_snapshot() on ARM64 by implementing the
> >>> perf_snapshot_branch_stack static call for BRBE.
> >>>
> >>> BRBE is paused before masking exceptions to avoid branch buffer
> >>> pollution from trace_hardirqs_off(). Exceptions are then masked with
> >>> local_daif_save() to prevent PMU overflow pseudo-NMIs from interferin=
g.
> >>> If an overflow between pause and DAIF save re-enables BRBE, the snaps=
hot
> >>> detects this via BRBFCR_EL1.PAUSED and bails out.
> >>>
> >>> Branch records are read using perf_entry_from_brbe_regset() with a NU=
LL
> >>> event pointer to bypass event-specific filtering. The buffer is
> >>> invalidated after reading.
> >>>
> >>> Introduce a for_each_brbe_entry() iterator to deduplicate bank
> >>> iteration between brbe_read_filtered_entries() and the snapshot.
> >>>
> >>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> >>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> >>> ---
> >>>    drivers/perf/arm_brbe.c  | 128 ++++++++++++++++++++++++++++++++---=
----
> >>>    drivers/perf/arm_brbe.h  |   9 +++
> >>>    drivers/perf/arm_pmuv3.c |   5 +-
> >>>    3 files changed, 120 insertions(+), 22 deletions(-)
> >>>
> >>> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> >>> index effbdeacfcbb..a141ad7abcf2 100644
> >>> --- a/drivers/perf/arm_brbe.c
> >>> +++ b/drivers/perf/arm_brbe.c
> >>> @@ -9,6 +9,7 @@
> >>>    #include <linux/types.h>
> >>>    #include <linux/bitmap.h>
> >>>    #include <linux/perf/arm_pmu.h>
> >>> +#include <asm/daifflags.h>
> >>>    #include "arm_brbe.h"
> >>>
> >>>    #define BRBFCR_EL1_BRANCH_FILTERS (BRBFCR_EL1_DIRECT   | \
> >>> @@ -256,6 +257,14 @@ static bool valid_brbe_version(int brbe_version)
> >>>               brbe_version =3D=3D ID_AA64DFR0_EL1_BRBE_BRBE_V1P1;
> >>>    }
> >>>
> >>> +static __always_inline bool cpu_has_brbe(void)
> >>
> >> This should be more like cpu_valid_brbe_version(). has_brbe() only
> >> implies that the CPU has BRBE, not that it's a version that the driver
> >> supports. And it's actually just a wrapper around valid_brbe_version()
> >> that accesses the ID reg on that CPU, not a functionally different che=
ck.
> >>
> >> But it also looks like valid_brbe_version() isn't called from anywhere
> >> else, so why not delete that function and use its name for the new one=
?
> >
> > I will do that in next version
> >
> >>
> >>> +{
> >>> +     u64 aa64dfr0 =3D read_sysreg_s(SYS_ID_AA64DFR0_EL1);
> >>> +     int brbe =3D cpuid_feature_extract_unsigned_field(aa64dfr0, ID_=
AA64DFR0_EL1_BRBE_SHIFT);
> >>> +
> >>> +     return valid_brbe_version(brbe);
> >>> +}
> >>> +
> >>>    static void select_brbe_bank(int bank)
> >>>    {
> >>>        u64 brbfcr;
> >>> @@ -271,6 +280,20 @@ static void select_brbe_bank(int bank)
> >>>        isb();
> >>>    }
> >>>
> >>> +static inline void __brbe_advance(int *bank, int *idx, int nr_hw)
> >>> +{
> >>> +     if (++(*idx) >=3D BRBE_BANK_MAX_ENTRIES &&
> >>> +         *bank * BRBE_BANK_MAX_ENTRIES + *idx < nr_hw) {
> >>> +             *idx =3D 0;
> >>> +             select_brbe_bank(++(*bank));
> >>> +     }
> >>> +}
> >>> +
> >>> +#define for_each_brbe_entry(idx, nr_hw)                             =
         \
> >>> +     for (int __bank =3D (select_brbe_bank(0), 0), idx =3D 0;       =
     \
> >>> +          __bank * BRBE_BANK_MAX_ENTRIES + idx < (nr_hw);           =
 \
> >>> +          __brbe_advance(&__bank, &idx, (nr_hw)))
> >>> +
> >>>    static bool __read_brbe_regset(struct brbe_regset *entry, int idx)
> >>>    {
> >>>        entry->brbinf =3D get_brbinf_reg(idx);
> >>> @@ -474,11 +497,9 @@ unsigned int brbe_num_branch_records(const struc=
t arm_pmu *armpmu)
> >>>
> >>>    void brbe_probe(struct arm_pmu *armpmu)
> >>>    {
> >>> -     u64 brbidr, aa64dfr0 =3D read_sysreg_s(SYS_ID_AA64DFR0_EL1);
> >>> -     u32 brbe;
> >>> +     u64 brbidr;
> >>>
> >>> -     brbe =3D cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64=
DFR0_EL1_BRBE_SHIFT);
> >>> -     if (!valid_brbe_version(brbe))
> >>> +     if (!cpu_has_brbe())
> >>>                return;
> >>>
> >>>        brbidr =3D read_sysreg_s(SYS_BRBIDR0_EL1);
> >>> @@ -618,10 +639,10 @@ static bool perf_entry_from_brbe_regset(int ind=
ex, struct perf_branch_entry *ent
> >>>
> >>>        brbe_set_perf_entry_type(entry, brbinf);
> >>>
> >>> -     if (!branch_sample_no_cycles(event))
> >>> +     if (!event || !branch_sample_no_cycles(event))
> >>>                entry->cycles =3D brbinf_get_cycles(brbinf);
> >>>
> >>> -     if (!branch_sample_no_flags(event)) {
> >>> +     if (!event || !branch_sample_no_flags(event)) {
> >>>                /* Mispredict info is available for source only and co=
mplete branch records. */
> >>>                if (!brbe_record_is_target_only(brbinf)) {
> >>>                        entry->mispred =3D brbinf_get_mispredict(brbin=
f);
> >>> @@ -774,32 +795,97 @@ void brbe_read_filtered_entries(struct perf_bra=
nch_stack *branch_stack,
> >>>    {
> >>>        struct arm_pmu *cpu_pmu =3D to_arm_pmu(event->pmu);
> >>>        int nr_hw =3D brbe_num_branch_records(cpu_pmu);
> >>> -     int nr_banks =3D DIV_ROUND_UP(nr_hw, BRBE_BANK_MAX_ENTRIES);
> >>>        int nr_filtered =3D 0;
> >>>        u64 branch_sample_type =3D event->attr.branch_sample_type;
> >>>        DECLARE_BITMAP(event_type_mask, PERF_BR_ARM64_MAX);
> >>>
> >>>        prepare_event_branch_type_mask(branch_sample_type, event_type_=
mask);
> >>>
> >>> -     for (int bank =3D 0; bank < nr_banks; bank++) {
> >>> -             int nr_remaining =3D nr_hw - (bank * BRBE_BANK_MAX_ENTR=
IES);
> >>> -             int nr_this_bank =3D min(nr_remaining, BRBE_BANK_MAX_EN=
TRIES);
> >>> +     for_each_brbe_entry(i, nr_hw) {
> >>> +             struct perf_branch_entry *pbe =3D &branch_stack->entrie=
s[nr_filtered];
> >>>
> >>> -             select_brbe_bank(bank);
> >>> +             if (!perf_entry_from_brbe_regset(i, pbe, event))
> >>> +                     break;
> >>>
> >>> -             for (int i =3D 0; i < nr_this_bank; i++) {
> >>> -                     struct perf_branch_entry *pbe =3D &branch_stack=
->entries[nr_filtered];
> >>> +             if (!filter_branch_record(pbe, branch_sample_type, even=
t_type_mask))
> >>> +                     continue;
> >>>
> >>> -                     if (!perf_entry_from_brbe_regset(i, pbe, event)=
)
> >>> -                             goto done;
> >>> +             nr_filtered++;
> >>> +     }
> >>>
> >>> -                     if (!filter_branch_record(pbe, branch_sample_ty=
pe, event_type_mask))
> >>> -                             continue;
> >>> +     branch_stack->nr =3D nr_filtered;
> >>> +}
> >>>
> >>> -                     nr_filtered++;
> >>> -             }
> >>> +/*
> >>> + * Best-effort BRBE snapshot for BPF tracing. Pause BRBE to avoid
> >>> + * self-recording and return 0 if the snapshot state appears disturb=
ed.
> >>> + */
> >>> +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries=
, unsigned int cnt)
> >>> +{
> >>> +     unsigned long flags;
> >>> +     int nr_hw, nr_copied =3D 0;
> >>> +     u64 brbfcr, brbcr;
> >>> +
> >>> +     if (!cnt)
> >>> +             return 0;
> >>
> >> If you're trying to avoid branches before pausing BRBE, can't you chec=
k
> >> this after the pause?
> >
> > will drop this in the next version and this is just an optimization.
> >
> >>
> >>> +
> >>> +     /* Guard against running on a CPU without BRBE (e.g. big.LITTLE=
). */
> >>> +     if (!cpu_has_brbe())
> >>> +             return 0;
> >>> +
> >>> +     /*
> >>> +      * Pause BRBE first to avoid recording our own branches. The
> >>> +      * sysreg read/write and ISB are branchless, so pausing before
> >>> +      * checking BRBCR avoids polluting the buffer with our own
> >>> +      * conditional branches.
> >>> +      */
> >>> +     brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> >>> +     brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> >>> +     write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> >>
> >> Can this work without first disabling interrupts? Sashiko pointed it
> >> out, but I think it's correct. If you read an active state into brbfcr=
,
> >> then the PMU event fires and disables BRBE, then you disable interrupt=
s,
> >> then you would restore an active state when it should be inactive.
> >> Surely the only way to do it properly is to disable interrupts before
> >> touching anything at all, if the PMU handler is also touching the same
> >> registers?
> >>
> >> If you want to avoid trace_hardirqs_off() can you make a new
> >> raw_local_daif_save() that disables interrupts and then call
> >> trace_hardirqs_off() yourself after pausing BRBE? Or not call
> >> trace_hardirqs_off() at all? There is a comment mentioning something
> >> like that in arch/arm64/kernel/suspend.c.
> >
> > Yes. I'll add raw_local_daif_save()/raw_local_daif_restore() and mask b=
efore
> > touching any BRBE register, which fixes the stale restore. trace_hardir=
qs_off()
> > then moves below the pause so lockdep still sees a balanced off/on pair=
 while
> > its branches land in an already paused buffer.
> >
> >>
> >> Also, disabling interrupts doesn't stop the PMU event from overflowing
> >> and changing the state of PAUSED either. I think this is another path
> >> that leads to you restoring the wrong state, so don't you also need to
> >> disable the PMU?
> >
> > Hardware only sets PAUSED on a BRBE freeze event (RBHYTD), and a freeze=
 needs
> > BRBE to not already be paused (RNXCWF). So once we have paused, nothing=
 changes
> > underneath us and the PMU does not need disabling. It would not help an=
yway:
> > armv8pmu_stop() calls brbe_disable(), which zeroes BRBCR_EL1 and discar=
ds the
> > records we came to read.
>
> That does mean you throw away real freeze events while paused though, in
> addition to the brbe_invalidate() you need to avoid non contiguous
> buffers. So it takes branches away from PMU events.

RBHYTD gives a freeze two effects: PAUSED is set, and BRBTS_EL1 captures a
timestamp. Recording has already stopped because we paused, and the driver =
never
reads BRBTS_EL1. On the way out we check PMOVSCLR_EL0 and leave PAUSED set =
if a
counter overflowed, so a pending overflow handler still finds a frozen buff=
er.

> So it takes branches away from PMU events.

Yes, but that is brbe_invalidate(), not the pause. Interrupts are masked an=
d
nothing else runs on the CPU, so the only branches the pause suppresses are=
 the
snapshot's own.

> >
> > You are right that a freeze can still land in the window between readin=
g BRBFCR
> > and setting PAUSED, and restoring the value we read would then clear a =
PAUSED
> > bit the hardware set. So v6 checks PMOVSCLR_EL0 and leaves BRBE paused =
if a
> > counter has overflowed. Reads of PMOVSCLR are non-destructive and it st=
ays set
> > until the overflow handler clears it, so it is still visible after we h=
ave set
> > PAUSED ourselves:
> >
> >          if (!valid_brbe_version())
> >                  return 0;
> >
> >          flags =3D raw_local_daif_save();
> >
> >          brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> >          brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> >
> >          write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> >          isb();
> >
> >          trace_hardirqs_off();
> >
> >          /* BRBCR_EL1 is zero while the driver has BRBE disabled. */
> >          if (!brbcr)
> >                  goto restore;
> >
> >          ... read the records ...
> >
>
> Up to the point where you read the records you technically don't need
> any branches (if you don't do trace_hardirqs_off()) so you could do the
> whole thing without pausing. Just disable interrupts, read every branch
> entry unconditionally, re-enable interrupts and then find the last valid
> entry and do the branchy stuff after reading.
>
> I'm thinking out loud, but doesn't that make it a lot easier? And it
> avoids the brbe_invalidate() which takes the branches away from the PMU
> event. It also avoids having to think too hard about racing with PMU
> events causing a freeze even after interrupts are disabled and after
> reading the freeze value:
>
>    raw_local_daif_save();
>    brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
>    brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
>    select_bank(0);
>    read_record(0);
>    read_record(1);
>    ...
>    select_bank(0);
>    read_record(0);
>    read_record(1);
>    ...
>    write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
>    isb();
>    local_daif_restore();
>
>    /* Now do post processing, find last valid record, check if it was
> enabled by looking at brbcr etc. */

MRS is not a branch, so that works, but three things would have to change:

1. perf_entry_from_brbe_regset() goes through BRBE_REGN_SWITCH, a 32 case
   switch, because the register number has to be an immediate. gcc emits a =
jump
   table and the function has 52 branches in the object file. The read woul=
d
   need full unrolling.

2. RPGDLX needs an ISB before the reads, and Table D19-10 makes it
   IMPLEMENTATION DEFINED whether ISB itself generates a record. When we pa=
use,
   IZCHRF means the pausing ISB cannot pollute the buffer it is about to re=
ad.

3. 64 record parts still need a bank switch, so BRBFCR_EL1 still has to be
   written and restored.

Correctness would then depend on the read staying branchless, which is not
checkable at build time and fails silently: a branch mid read shifts the bu=
ffer,
giving a duplicate and a gap. 64 * 24 bytes of records also wants a per-CPU
scratch buffer rather than the stack.

Happy to prototype it. What I would not do is pause without invalidating:
records are from/to pairs, so a consumer walking across the hole reconstruc=
ts a
call path that never happened. The invalidate was Mark's request after the =
RFC,
"to maintain record contiguity for other consumers", so dropping the pause =
drops
that too.

I was thinking of this for v6:

        flags =3D raw_local_daif_save();

        /* The BRBE sysregs below are UNDEFINED without this. */
        if (!valid_brbe_version()) {
                raw_local_daif_restore(flags);
                return 0;
        }

        brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
        brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);

        write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
        isb();

        /* BRBCR_EL1 is zero while the driver has BRBE disabled. */
        if (!brbcr) {
                write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
                isb();
                raw_local_daif_restore(flags);
                return 0;
        }

        trace_hardirqs_off();

        ... read the records ...

        if (!(brbfcr & BRBFCR_EL1_PAUSED) &&
            !(read_pmovsclr() & (ARMV8_PMU_OVSR_P | ARMV8_PMU_OVSR_F)))
                brbe_invalidate();
        else
                brbfcr |=3D BRBFCR_EL1_PAUSED;

        write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
        isb();
        local_daif_restore(flags);

Exceptions are masked before anything is sampled, BRBCR_EL1 is only read an=
d
never written, and BRBFCR_EL1 is written back from the value saved under th=
e
mask. cpu_has_brbe() is now valid_brbe_version().

Neither conditional costs a record: valid_brbe_version() falls through when=
 BRBE
is present (RBBNSZ, only taken branches are recorded), and the BRBCR_EL1 te=
st is
after the pause. It cannot move later because BRBFCR_EL1 is UNDEFINED witho=
ut
FEAT_BRBE.

PMOVSCLR_EL0 is masked because PMCCNTR_EL0 is bit 31 and PMCR_EL0.N is at m=
ost
31, so the cycle counter is outside every range RNXCWF, RGXGWY, RPKTXQ and
RLDMVK name. Unmasked, a cycle counter overflow looked like a freeze.

Do you think this version works?

Thanks,
Puranjay
