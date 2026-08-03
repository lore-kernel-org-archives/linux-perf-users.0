Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60514334CF
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785783292; cv=pass; b=bpJKRi+R0DaQM4r+XxnJVBV76sZRr/CkatjP/KpReTyee5oPivlnoe/k7nTTe1ZrkUxBwUijBEkuWtsmoyK7p4z6czX6z9okRgk8E85WHojX3Wujm7X68HSyH3HU3kd7XN+Hmpppg4qyco/ihpBo3iusgQu+JDXmxUKfBYYnsCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785783292; c=relaxed/simple;
	bh=nslW9JE0t9+4wF3BOQF76vvMcWmxIHMVVjC8H216PkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZ8guDhS+VfzT/p6nMKu6/gqrTZhHNRwBkV2XkJ7YpnJNdWKmSt/hescxAMtJU+Kj3s3NCQEUCmI74EbLnvIEyFPI2e8SYd1KrC675+sEW3+JS3On9zpqyr4/5yCw+D4smuIMgvfODq2V9AkQwGrC1YvbaAgfNlwCFBGy1Z6O58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2hEq1FF; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2hEq1FF"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1c4db7ca93so500237666b.2
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Aug 2026 11:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785783288; cv=none;
        d=google.com; s=arc-20260327;
        b=SGG374NzHmqxO5xS2n4Q4xIWZ2nXH7XFXEAyB1DFV2892WjgoIOzC6JYt3DAnfoWkX
         FUtz2xIJX7lp8jhypn3+o2Tzu6dJvyaTZ/1nkpVC0sk+K9t7IGsHUbwJ8cN4i1GxtzLF
         2LIi+AxxW+KywscBS3YRqfzv2l6R6VTnGjgnq8EZAW0QsEx7xOOKmmg5E3wnner/ajUR
         6P7VydiQxjf980B09tmKVTwMX0OBki40lOkrhgujeezNOVM0hffoEZ3nY9G9ZV6RG3LU
         9EV8XBWLaNstgJYSryaMiNlfqs2038avyHSXMjTQTyPJbfspCIyGNkkcyUuay8rY2P0Y
         +fTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x1AIPF5SDT4J7PNUPtkxqesvFiiIPup4Fza0Vbizlw8=;
        fh=ELwTvPD+jVb5Zj1noxAsn0oOmlb3LK9SY7RwelXmlVg=;
        b=H0OzudEILFClt6HmfK+q1qJFyaM7vrXRUfP/cJJDQGYMUPEH+DuxPxA22Wk69C6HTZ
         JINO30z8bZRnEffQNxgW0YNXwtL8hR/7b4scpr3Cxcw0doVdYVkWAosImCo9rn4/E8C4
         mTvVnVai3trXzQlCqux7hqJkBNMuHBhxrYIo3w3FOeZvZ0TFcBLSycMj+ifYMX4ledob
         G8XMihbcOUynb2HkskS+7iWN+yzQOqZhvkewVcKNkKfegadSEH/dtl3LGveaAczIkZh5
         lOB1FAE5qYwerdMBXLsyaCQYAHLguGxWsEFKdRFeG8ahs0CdzfY3D9couqEETzUeHeQ1
         qN9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785783288; x=1786388088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x1AIPF5SDT4J7PNUPtkxqesvFiiIPup4Fza0Vbizlw8=;
        b=G2hEq1FFiuJWtjyABgEJdUg8ZOnS9h7SkPiCd0yODXQ9FG6TKjZ9lSq3tl1707dRVf
         sAqhA7UIFlICSOXMyTH836OGIljd5bGBVwGEmWZHyxmdgKbEuafeDcxRlO3vDkWdEMsq
         +9HJRBoQB/NOMlUxpBt5+av/2xTf+rmxrFTPIXDq/uwXobvwSRLHXhUQGQ0lQW8tYHAa
         skCOMqM3jS95s8N49EcOJ4AUKihOF1WrjJKioXJJgI17FDyLKvX7rko8KtNm8evrw/El
         0PmYQOTbtunNDng/yjjPagmKKxbGU3Ecwj8+zE+Y3GJKbFBDfIwu7hz/9s6fWmy5s0ml
         Oa5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785783288; x=1786388088;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x1AIPF5SDT4J7PNUPtkxqesvFiiIPup4Fza0Vbizlw8=;
        b=o27UbUQL52+VaCSeXvtZo5UZ+OCm9EZ5LijBYTcS1h4LsJXD/z5RvPdlbvxi32ssUl
         8TahU6DnHEc2ZjKfdzOLedIUHIHSpf3YFU5acIJPmqi8DcfxhA78hMm1V3tWMdBu5gMz
         LfudIy+scF/WcuMRay9qXsLJouf6gpaNw49tofrlDdlN6dwGDTsG/0Errp918l6/P3/A
         pN3KdYZV8eqOHDwd19GXgf/vDD73+JJZWeIeoDR24Be0KnkvYvZX/sVXJt1TGan/6I7N
         SQETu6vB/4+q6bLQQK0W2xmZPhM4gfh5gedXo4tZRNyo0sX2ilenp15EUhDqG2Qu/bfx
         SKYQ==
X-Forwarded-Encrypted: i=1; AHgh+RqUolSe5NzAD23XaFNufX7IsetUWhHtZ5RqrvoMfRe7D9O3bauqr0Pled+hDbMBmreSmYQ50ozHoHYn3pnoT4cs@vger.kernel.org
X-Gm-Message-State: AOJu0YzzIH3q7jb+gV2d9m2iurEtHd1NzL8pn7+GfrDMznIiCzyKYcPc
	yDROJ1N7SazbB4wxGVaL8xwy2REPJhSADrSD+ZDQYiTwVKWcdSZhFfnyuBp114Y1Z4XleXI0lq/
	/MmzV1VYUJoxs83kcwDyPRNC/bDRCK5g=
X-Gm-Gg: AR+sD12/q7QZ8wLPnWVHHecXSEIlMO0/TtCKDu/9iyaEu+JrX7bfZ1ZiPGjGY54Ow8p
	rhOSpTJNE0zNdgp2upyW4oaXMdZb29xCKzagVOfBpDNNEUoFnFSGB4POdU8oiBkWGazHUKTfWr/
	PNmdJjgYbCYAGtiXicRt4opc+fBtXhLUpII4NYwBbEnHNyy7SIedQmrc8Fu/Ga6hacfN90gikcH
	bp5CamVz5uR2N65NfCaAcoHQgfKV0lMl4AE0Jx6BgVxVykboNvbNzotbpLQlhft0rZh/Btzfm/o
	d7I9+IrjTQZ4piqGy883sLEKn1OSHLdFtyV3ibIAxnH3QaZ2Eff+8IN6sERN
X-Received: by 2002:a17:907:1c22:b0:c15:d4f8:dade with SMTP id
 a640c23a62f3a-c1fe7eebb0amr1012287766b.2.1785783287476; Mon, 03 Aug 2026
 11:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616155716.2631508-1-puranjay@kernel.org> <20260616155716.2631508-4-puranjay@kernel.org>
 <8a24abbc-10bc-42bb-8fee-0a174d8f1751@linaro.org>
In-Reply-To: <8a24abbc-10bc-42bb-8fee-0a174d8f1751@linaro.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 3 Aug 2026 19:54:33 +0100
X-Gm-Features: AUfX_mwx8Ydt3A9LE8X-Qfww0uHrsaIvN1PiEerTcOucV_-waglDDq-7iwaK1XQ
Message-ID: <CANk7y0inRXCUKtuio3Cb03DvuNPq6yp1o+tsE8PZitrY0LaOPQ@mail.gmail.com>
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

On Mon, Aug 3, 2026 at 12:07=E2=80=AFPM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 16/06/2026 16:57, Puranjay Mohan wrote:
> > Enable bpf_get_branch_snapshot() on ARM64 by implementing the
> > perf_snapshot_branch_stack static call for BRBE.
> >
> > BRBE is paused before masking exceptions to avoid branch buffer
> > pollution from trace_hardirqs_off(). Exceptions are then masked with
> > local_daif_save() to prevent PMU overflow pseudo-NMIs from interfering.
> > If an overflow between pause and DAIF save re-enables BRBE, the snapsho=
t
> > detects this via BRBFCR_EL1.PAUSED and bails out.
> >
> > Branch records are read using perf_entry_from_brbe_regset() with a NULL
> > event pointer to bypass event-specific filtering. The buffer is
> > invalidated after reading.
> >
> > Introduce a for_each_brbe_entry() iterator to deduplicate bank
> > iteration between brbe_read_filtered_entries() and the snapshot.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >   drivers/perf/arm_brbe.c  | 128 ++++++++++++++++++++++++++++++++------=
-
> >   drivers/perf/arm_brbe.h  |   9 +++
> >   drivers/perf/arm_pmuv3.c |   5 +-
> >   3 files changed, 120 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> > index effbdeacfcbb..a141ad7abcf2 100644
> > --- a/drivers/perf/arm_brbe.c
> > +++ b/drivers/perf/arm_brbe.c
> > @@ -9,6 +9,7 @@
> >   #include <linux/types.h>
> >   #include <linux/bitmap.h>
> >   #include <linux/perf/arm_pmu.h>
> > +#include <asm/daifflags.h>
> >   #include "arm_brbe.h"
> >
> >   #define BRBFCR_EL1_BRANCH_FILTERS (BRBFCR_EL1_DIRECT   | \
> > @@ -256,6 +257,14 @@ static bool valid_brbe_version(int brbe_version)
> >              brbe_version =3D=3D ID_AA64DFR0_EL1_BRBE_BRBE_V1P1;
> >   }
> >
> > +static __always_inline bool cpu_has_brbe(void)
>
> This should be more like cpu_valid_brbe_version(). has_brbe() only
> implies that the CPU has BRBE, not that it's a version that the driver
> supports. And it's actually just a wrapper around valid_brbe_version()
> that accesses the ID reg on that CPU, not a functionally different check.
>
> But it also looks like valid_brbe_version() isn't called from anywhere
> else, so why not delete that function and use its name for the new one?

I will do that in next version

>
> > +{
> > +     u64 aa64dfr0 =3D read_sysreg_s(SYS_ID_AA64DFR0_EL1);
> > +     int brbe =3D cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA=
64DFR0_EL1_BRBE_SHIFT);
> > +
> > +     return valid_brbe_version(brbe);
> > +}
> > +
> >   static void select_brbe_bank(int bank)
> >   {
> >       u64 brbfcr;
> > @@ -271,6 +280,20 @@ static void select_brbe_bank(int bank)
> >       isb();
> >   }
> >
> > +static inline void __brbe_advance(int *bank, int *idx, int nr_hw)
> > +{
> > +     if (++(*idx) >=3D BRBE_BANK_MAX_ENTRIES &&
> > +         *bank * BRBE_BANK_MAX_ENTRIES + *idx < nr_hw) {
> > +             *idx =3D 0;
> > +             select_brbe_bank(++(*bank));
> > +     }
> > +}
> > +
> > +#define for_each_brbe_entry(idx, nr_hw)                               =
       \
> > +     for (int __bank =3D (select_brbe_bank(0), 0), idx =3D 0;         =
   \
> > +          __bank * BRBE_BANK_MAX_ENTRIES + idx < (nr_hw);            \
> > +          __brbe_advance(&__bank, &idx, (nr_hw)))
> > +
> >   static bool __read_brbe_regset(struct brbe_regset *entry, int idx)
> >   {
> >       entry->brbinf =3D get_brbinf_reg(idx);
> > @@ -474,11 +497,9 @@ unsigned int brbe_num_branch_records(const struct =
arm_pmu *armpmu)
> >
> >   void brbe_probe(struct arm_pmu *armpmu)
> >   {
> > -     u64 brbidr, aa64dfr0 =3D read_sysreg_s(SYS_ID_AA64DFR0_EL1);
> > -     u32 brbe;
> > +     u64 brbidr;
> >
> > -     brbe =3D cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64DF=
R0_EL1_BRBE_SHIFT);
> > -     if (!valid_brbe_version(brbe))
> > +     if (!cpu_has_brbe())
> >               return;
> >
> >       brbidr =3D read_sysreg_s(SYS_BRBIDR0_EL1);
> > @@ -618,10 +639,10 @@ static bool perf_entry_from_brbe_regset(int index=
, struct perf_branch_entry *ent
> >
> >       brbe_set_perf_entry_type(entry, brbinf);
> >
> > -     if (!branch_sample_no_cycles(event))
> > +     if (!event || !branch_sample_no_cycles(event))
> >               entry->cycles =3D brbinf_get_cycles(brbinf);
> >
> > -     if (!branch_sample_no_flags(event)) {
> > +     if (!event || !branch_sample_no_flags(event)) {
> >               /* Mispredict info is available for source only and compl=
ete branch records. */
> >               if (!brbe_record_is_target_only(brbinf)) {
> >                       entry->mispred =3D brbinf_get_mispredict(brbinf);
> > @@ -774,32 +795,97 @@ void brbe_read_filtered_entries(struct perf_branc=
h_stack *branch_stack,
> >   {
> >       struct arm_pmu *cpu_pmu =3D to_arm_pmu(event->pmu);
> >       int nr_hw =3D brbe_num_branch_records(cpu_pmu);
> > -     int nr_banks =3D DIV_ROUND_UP(nr_hw, BRBE_BANK_MAX_ENTRIES);
> >       int nr_filtered =3D 0;
> >       u64 branch_sample_type =3D event->attr.branch_sample_type;
> >       DECLARE_BITMAP(event_type_mask, PERF_BR_ARM64_MAX);
> >
> >       prepare_event_branch_type_mask(branch_sample_type, event_type_mas=
k);
> >
> > -     for (int bank =3D 0; bank < nr_banks; bank++) {
> > -             int nr_remaining =3D nr_hw - (bank * BRBE_BANK_MAX_ENTRIE=
S);
> > -             int nr_this_bank =3D min(nr_remaining, BRBE_BANK_MAX_ENTR=
IES);
> > +     for_each_brbe_entry(i, nr_hw) {
> > +             struct perf_branch_entry *pbe =3D &branch_stack->entries[=
nr_filtered];
> >
> > -             select_brbe_bank(bank);
> > +             if (!perf_entry_from_brbe_regset(i, pbe, event))
> > +                     break;
> >
> > -             for (int i =3D 0; i < nr_this_bank; i++) {
> > -                     struct perf_branch_entry *pbe =3D &branch_stack->=
entries[nr_filtered];
> > +             if (!filter_branch_record(pbe, branch_sample_type, event_=
type_mask))
> > +                     continue;
> >
> > -                     if (!perf_entry_from_brbe_regset(i, pbe, event))
> > -                             goto done;
> > +             nr_filtered++;
> > +     }
> >
> > -                     if (!filter_branch_record(pbe, branch_sample_type=
, event_type_mask))
> > -                             continue;
> > +     branch_stack->nr =3D nr_filtered;
> > +}
> >
> > -                     nr_filtered++;
> > -             }
> > +/*
> > + * Best-effort BRBE snapshot for BPF tracing. Pause BRBE to avoid
> > + * self-recording and return 0 if the snapshot state appears disturbed=
.
> > + */
> > +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries, =
unsigned int cnt)
> > +{
> > +     unsigned long flags;
> > +     int nr_hw, nr_copied =3D 0;
> > +     u64 brbfcr, brbcr;
> > +
> > +     if (!cnt)
> > +             return 0;
>
> If you're trying to avoid branches before pausing BRBE, can't you check
> this after the pause?

will drop this in the next version and this is just an optimization.

>
> > +
> > +     /* Guard against running on a CPU without BRBE (e.g. big.LITTLE).=
 */
> > +     if (!cpu_has_brbe())
> > +             return 0;
> > +
> > +     /*
> > +      * Pause BRBE first to avoid recording our own branches. The
> > +      * sysreg read/write and ISB are branchless, so pausing before
> > +      * checking BRBCR avoids polluting the buffer with our own
> > +      * conditional branches.
> > +      */
> > +     brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> > +     brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> > +     write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
>
> Can this work without first disabling interrupts? Sashiko pointed it
> out, but I think it's correct. If you read an active state into brbfcr,
> then the PMU event fires and disables BRBE, then you disable interrupts,
> then you would restore an active state when it should be inactive.
> Surely the only way to do it properly is to disable interrupts before
> touching anything at all, if the PMU handler is also touching the same
> registers?
>
> If you want to avoid trace_hardirqs_off() can you make a new
> raw_local_daif_save() that disables interrupts and then call
> trace_hardirqs_off() yourself after pausing BRBE? Or not call
> trace_hardirqs_off() at all? There is a comment mentioning something
> like that in arch/arm64/kernel/suspend.c.

Yes. I'll add raw_local_daif_save()/raw_local_daif_restore() and mask befor=
e
touching any BRBE register, which fixes the stale restore. trace_hardirqs_o=
ff()
then moves below the pause so lockdep still sees a balanced off/on pair whi=
le
its branches land in an already paused buffer.

>
> Also, disabling interrupts doesn't stop the PMU event from overflowing
> and changing the state of PAUSED either. I think this is another path
> that leads to you restoring the wrong state, so don't you also need to
> disable the PMU?

Hardware only sets PAUSED on a BRBE freeze event (RBHYTD), and a freeze nee=
ds
BRBE to not already be paused (RNXCWF). So once we have paused, nothing cha=
nges
underneath us and the PMU does not need disabling. It would not help anyway=
:
armv8pmu_stop() calls brbe_disable(), which zeroes BRBCR_EL1 and discards t=
he
records we came to read.

You are right that a freeze can still land in the window between reading BR=
BFCR
and setting PAUSED, and restoring the value we read would then clear a PAUS=
ED
bit the hardware set. So v6 checks PMOVSCLR_EL0 and leaves BRBE paused if a
counter has overflowed. Reads of PMOVSCLR are non-destructive and it stays =
set
until the overflow handler clears it, so it is still visible after we have =
set
PAUSED ourselves:

        if (!valid_brbe_version())
                return 0;

        flags =3D raw_local_daif_save();

        brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
        brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);

        write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
        isb();

        trace_hardirqs_off();

        /* BRBCR_EL1 is zero while the driver has BRBE disabled. */
        if (!brbcr)
                goto restore;

        ... read the records ...

        if ((brbfcr & BRBFCR_EL1_PAUSED) || read_pmovsclr())
                brbfcr |=3D BRBFCR_EL1_PAUSED;
        else
                brbe_invalidate();
restore:
        write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
        isb();
        local_daif_restore(flags);

If BRBE stays paused the records are left alone, they belong to the pending
overflow handler. Otherwise recording resumes and the records either side o=
f
the pause are not contiguous (RPKZCF), so they are discarded.

What do you think about this?

Thanks,
Puranjay
