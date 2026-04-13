Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894291DED63
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776086153; cv=pass; b=L9CcHIu2uTpRzP7TNmznCo+Z7K+IbEmcGiiRRDMrRo0hqUrZCWh4fzdt9wJr438Zit/mD5iPs0Fsz1HWl4PyeTYqEXzbqs8ZhIBLhjPwU3sS+EKXYacfS5qfsFowNa3R0WGuQUml0gPffRByAn2V8Q83lvZolLAIpl8/pypjozA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776086153; c=relaxed/simple;
	bh=rbtQWmZpZtpEyQaDLGpE4qXR8j+SUOJWytm4qdxIGUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dN3sjXx5BfyHEPkQcb9x5WrqQYoLLeVodAx1aT948448vIEqjRH53M2j9CjjCZrbYg5Y7x+/d7uha9w2U60+r/PcrMC6h44B+bW1nV1nobYX5SwMeUItFKLjj4RpBMqKPjRQzgV+tx91JS/DKiu/l17JsIhGRhB7aHORRd2VeO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hn1HtZxD; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn1HtZxD"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66e129e457dso4405726a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 06:15:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776086150; cv=none;
        d=google.com; s=arc-20240605;
        b=AalOkEjadmKPspwQjliny0253T48fTEEOtbMp5okFQ/45Jxff5GN4lQu4svObvFVQb
         9f+Y0b0NMbLFsSEeZ8D5PVDP+QZJ1mBods1obP4MdcagLfVySC8nV/24Hpbrdzpon3e1
         FhJ7bH61T4TQZQOAlBCeWzlLIzMGTS9k15PuRG9KcBy3sgGxhzEXlaJJ9OpffOhwPGMx
         AfShEK78XbwIeu+NZ5VRS/f2CAQNKqhG7FjLLxsKllFl2pHnPb+AOioI1ZBngl9Ghr7l
         1C2vFp/CmCVjgK13fPzq2Riby14lpcyFXiAF6oHksxrSAlLaVWtKxAO1KWgqu8iwkTTT
         29EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TWFfKp/TWghMUUA6IzgBnGVqi4hfkBllldqvNPSkdJ0=;
        fh=zbh6ccMJ2RjK8uvrn2jgVV8M5KB4YNPiIvq7WBUne8E=;
        b=biMuwJEIxhCjKRQcRXp/GKxL4TehlH1g/Z4ApOOchQgL7Y6lhFi86NL1YpfI/OlWa4
         dQUgvnG70Em3TSMLbXuX53LH+QBgwnQi9eehVgYtcgp2eCIWIo/5N2g0RMR5QeycSxtl
         N3SIfPD2ms0tVH1abNlH194sSkUmVJwitcKapu2ii3PFvRRi2kRw6j5+LGCv2wA935qQ
         VMz49QMWJqbwawjDLJDs7axcEjFBz54OUq4DPvPpGKadBVpt3ft6ikMRi121Tia+6QLT
         mXY76mXO7u5HUkEbCgeTywpmXjFL+/C26RvYGvf2lBTWACj+qxVGCkLIMU4Kb0lA3z75
         yVbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776086150; x=1776690950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWFfKp/TWghMUUA6IzgBnGVqi4hfkBllldqvNPSkdJ0=;
        b=Hn1HtZxD+r5eaGMFBOEWLOrq4Lqnxuj/JTC1pm0ATJsrv//E+/ISmNl+/2H2DF97Bk
         bb7yiHHEV9MK3L07Nmt0M8axyc1aE0wKfjq5E/DGqXW9cLD97TsczqB+9v6C1n0SMOAo
         CFnaL4YHvcyXrlPmvsF/hUub8pCOQttQCceXMkLfaTCKWbUxC2P1NI5h8lj5bo6l7qFi
         TXNYwqjCaW/YSkZOneXwBfsgHVxf4yHfE4RBTBJXIdrLIIhcjq78vi0zxszf/PbWgRbv
         bKQINsQolbYVA+/Hgyiny80dtEkKyfJUKvCHitIbXhaUsBxgCed5KscGgW1qsf8XqVuA
         B8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776086150; x=1776690950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TWFfKp/TWghMUUA6IzgBnGVqi4hfkBllldqvNPSkdJ0=;
        b=iRfkfP7djKzEkTSCkS8yjJRMGJvW79ht8UtgRh5h229/eHoznPHf2E+U0Pe6Pfpk8T
         ddqaFzQRrTJb4yPxjmNauZNr/+C2B4UpdBY57d5k4iRZoK70mWFRMkSzu/NMOkfLCI9l
         z47NetrQBz71FnxtYCkszXaEjd0WEIL2amFEMZhvwLmkQeF/almf6h5sK9xDJIgRocx8
         mzcAXugDTUlkjTLQyOohyNhQa0d12Ag9WwF2SwkVXLYk3ukZeCAnbBrBaYqzUa+cXWVo
         Ghgz5jpCNKAHfikwlkEmlp/EkrqunoMcc32GBX0WDu7vZ7TYkTzfsvxLSAqb9Q2vboGY
         ODeA==
X-Forwarded-Encrypted: i=1; AFNElJ+O4BhganZOlxSXEGLBaWZZredQtOf0l2bL9cNPHR28Wf0CYFQLUhpVE3bXzQfULk+eBni2OFR+xgk32/adQJcY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4AsOicj11oedz+tTlQl81Ew6+XqGHkXLGuVUilMMYUZO+CJo3
	Pza+29+bIZpIVwwnX0Us7Y2iowNMalI1ShCCNwPwmKZSNXASgWCgN/9aKPFKkt4Zldbm3+XDe4k
	RninmnMMLOGBc8+2kjx3FvMU/gKzkUUE=
X-Gm-Gg: AeBDievF1+vH22T1XUvtI4LQdNudiZzRk55btBXuyHdCgLm1IN/ni772hQ69fwa8J2d
	Jcbrh6+UzK/Ev4ce0uY5w8PPQZGtvJLulKnIITEi23itxlDqrwcHeZpxtpsHLXS/XnPs6y9ul5I
	YDEeHvbwOovlSPDc8klg/hmxNXqe+D7gEj34R9H+cC67PgJtcRY6/M15ZPR6306X0MWsEdIC+TZ
	zRkRBRY6xqdwGpyMjVfTaSqaUnihuWxNu10l1A87u6WYV+FZtgzi06wC8tkJy/ggSRTcBaFaLrS
	6CsyCO+kg5W6AbLPdRydJwU=
X-Received: by 2002:a17:907:3d51:b0:b9b:4519:7914 with SMTP id
 a640c23a62f3a-b9d729665efmr793693166b.33.1776086149384; Mon, 13 Apr 2026
 06:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318171706.2840512-1-puranjay@kernel.org> <20260318171706.2840512-4-puranjay@kernel.org>
 <20260410192300.GA1050337-robh@kernel.org>
In-Reply-To: <20260410192300.GA1050337-robh@kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 13 Apr 2026 14:15:36 +0100
X-Gm-Features: AQROBzCue1TP9mde88YkHmv2yOUt3MzeMPylxtPFcG41TotdWLOxWFNqGRjveP0
Message-ID: <CANk7y0h1m1ECB7ud2Sw0_PTRq3bPstSm_CGg=nwU8d4yruxdfw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
To: Rob Herring <robh@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Leo Yan <leo.yan@arm.com>, 
	Breno Leitao <leitao@debian.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 8:23=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Wed, Mar 18, 2026 at 10:16:57AM -0700, Puranjay Mohan wrote:
> > Enable the bpf_get_branch_snapshot() BPF helper on ARM64 by implementin=
g
> > the perf_snapshot_branch_stack static call for ARM's Branch Record Buff=
er
> > Extension (BRBE).
> >
> > The BPF helper bpf_get_branch_snapshot() allows BPF programs to capture
> > hardware branch records on-demand. This was previously only available o=
n
> > x86 (Intel LBR) but not on ARM64 despite BRBE being available since
> > ARMv9.
> >
> > BRBE is paused before disabling interrupts because local_irq_save() can
> > trigger trace_hardirqs_off() which performs stack walking and pollutes
> > the branch buffer. The sysreg read/write and ISB used to pause BRBE are
> > branchless, so pausing first avoids this pollution.
> >
> > All exceptions are masked after pausing BRBE using local_daif_save() to
> > prevent pseudo-NMI from PMU counter overflow from interfering with the
> > snapshot read. A PMU overflow arriving between the pause and
> > local_daif_save() can re-enable BRBE via the interrupt handler; the
> > snapshot detects this by re-checking BRBFCR_EL1.PAUSED and bailing out.
> >
> > Branch records are read using the existing perf_entry_from_brbe_regset(=
)
> > helper with a NULL event pointer, which bypasses event-specific filteri=
ng
> > and captures all recorded branches. The BPF program is responsible for
> > filtering entries based on its own criteria. The BRBE buffer is
> > invalidated after reading to maintain contiguity for other consumers.
> >
> > On heterogeneous big.LITTLE systems, only some CPUs may implement
> > FEAT_BRBE. The perf_snapshot_branch_stack static call is system-wide, s=
o
> > a per-CPU brbe_active flag is used to prevent BRBE sysreg access on CPU=
s
> > that do not implement FEAT_BRBE, where such access would be UNDEFINED.
>
> Is this something you've seen? IIRC, the existing assumption is all CPUs
> have FEAT_BRBE or that perf has been limited to those CPUs. It is
> allowed that the number of records can vary.

I just added it as a safeguard, but if you say that it is not
possible, I will remove this in the next version.

>
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  drivers/perf/arm_brbe.c  | 79 +++++++++++++++++++++++++++++++++++++++-
> >  drivers/perf/arm_brbe.h  |  9 +++++
> >  drivers/perf/arm_pmuv3.c |  5 ++-
> >  3 files changed, 90 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> > index ba554e0c846c..527c2d5ebba6 100644
> > --- a/drivers/perf/arm_brbe.c
> > +++ b/drivers/perf/arm_brbe.c
> > @@ -8,9 +8,13 @@
> >   */
> >  #include <linux/types.h>
> >  #include <linux/bitmap.h>
> > +#include <linux/percpu.h>
> >  #include <linux/perf/arm_pmu.h>
> > +#include <asm/daifflags.h>
> >  #include "arm_brbe.h"
> >
> > +static DEFINE_PER_CPU(bool, brbe_active);
> > +
> >  #define BRBFCR_EL1_BRANCH_FILTERS (BRBFCR_EL1_DIRECT   | \
> >                                  BRBFCR_EL1_INDIRECT | \
> >                                  BRBFCR_EL1_RTN      | \
> > @@ -533,6 +537,8 @@ void brbe_enable(const struct arm_pmu *arm_pmu)
> >       /* Finally write SYS_BRBFCR_EL to unpause BRBE */
> >       write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> >       /* Synchronization in PMCR write ensures ordering WRT PMU enablin=
g */
> > +
> > +     this_cpu_write(brbe_active, true);
> >  }
> >
> >  void brbe_disable(void)
> > @@ -544,6 +550,7 @@ void brbe_disable(void)
> >        */
> >       write_sysreg_s(BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> >       write_sysreg_s(0, SYS_BRBCR_EL1);
> > +     this_cpu_write(brbe_active, false);
> >  }
> >
> >  static const int brbe_type_to_perf_type_map[BRBINFx_EL1_TYPE_DEBUG_EXI=
T + 1][2] =3D {
> > @@ -618,10 +625,10 @@ static bool perf_entry_from_brbe_regset(int index=
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
> > @@ -803,3 +810,71 @@ void brbe_read_filtered_entries(struct perf_branch=
_stack *branch_stack,
> >  done:
> >       branch_stack->nr =3D nr_filtered;
> >  }
> > +
> > +/*
> > + * Best-effort BRBE snapshot for BPF tracing. Pause BRBE to avoid
> > + * self-recording and return 0 if the snapshot state appears disturbed=
.
> > + */
> > +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries, =
unsigned int cnt)
> > +{
> > +     unsigned long flags;
> > +     int nr_hw, nr_banks, nr_copied =3D 0;
> > +     u64 brbidr, brbfcr, brbcr;
> > +
> > +     if (!cnt || !__this_cpu_read(brbe_active))
> > +             return 0;
> > +
> > +     /* Pause BRBE first to avoid recording our own branches. */
> > +     brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> > +     brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> > +     write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> > +     isb();
>
> Is there something that guarantees BRBE is enabled when you enter this
> function and that it is not disabled in this window? A context switch
> could disable it unless it's a global event for example.

The user space program handling this BPF program should create a
system wide event in the expected use case. But you are right that it
is not guaranteed to be enabled, I will check and return early in that
case.

>
> > +
> > +     /* Block local exception delivery while reading the buffer. */
> > +     flags =3D local_daif_save();
> > +
> > +     /*
> > +      * A PMU overflow before local_daif_save() could have re-enabled
> > +      * BRBE, clearing the PAUSED bit. The overflow handler already
> > +      * restored BRBE to its correct state, so just bail out.
> > +      */
> > +     if (!(read_sysreg_s(SYS_BRBFCR_EL1) & BRBFCR_EL1_PAUSED)) {
> > +             local_daif_restore(flags);
> > +             return 0;
> > +     }
> > +
> > +     brbidr =3D read_sysreg_s(SYS_BRBIDR0_EL1);
> > +     if (!valid_brbidr(brbidr))
>
> This is not possibly true if brbe_active is true. If BRBIDR is not
> valid, then we would have rejected any event requesting branch stack.

Will remove it in the next version.

>
> > +             goto out;
> > +
> > +     nr_hw =3D FIELD_GET(BRBIDR0_EL1_NUMREC_MASK, brbidr);
> > +     nr_banks =3D DIV_ROUND_UP(nr_hw, BRBE_BANK_MAX_ENTRIES);
> > +
> > +     for (int bank =3D 0; bank < nr_banks; bank++) {
> > +             int nr_remaining =3D nr_hw - (bank * BRBE_BANK_MAX_ENTRIE=
S);
> > +             int nr_this_bank =3D min(nr_remaining, BRBE_BANK_MAX_ENTR=
IES);
> > +
> > +             select_brbe_bank(bank);
> > +
> > +             for (int i =3D 0; i < nr_this_bank; i++) {
>
> I don't love all this being duplicated. Perhaps an iterator would help
> here (and the other copy):
>
> static void next_slot(int *bank, int *bank_idx, int nr_hw)
> {
>         *bank_idx++;
>         if (*bank_idx + (*bank * BRBE_BANK_MAX_ENTRIES) =3D=3D nr_hw)
>                 bank =3D BRBE_MAX_BANKS;
>         else if ((*bank_idx % BRBE_BANK_MAX_ENTRIES) =3D=3D 0) {
>                 *bank_idx =3D 0;
>                 select_brbe_bank(++(*bank));
>         }
>
> }
>
> #define for_each_bank_slot(i, nr_hw) \
> for (int bank =3D 0, int i =3D 0; bank < BRBE_MAX_BANKS; next_slot(&bank,
> &i))
>
> Then here you just have:
>
> for_each_bank_slot(i, FIELD_GET(BRBIDR0_EL1_NUMREC_MASK, brbidr)) {
>         ...
> }
>
> Feel free to come up with better naming. :)

Will add this to the next version, thanks

>
> > +                     if (nr_copied >=3D cnt)
> > +                             goto done;
> > +
> > +                     if (!perf_entry_from_brbe_regset(i, &entries[nr_c=
opied], NULL))
> > +                             goto done;
> > +
> > +                     nr_copied++;
> > +             }
> > +     }
> > +
> > +done:
> > +     brbe_invalidate();
> > +out:
> > +     /* Restore BRBCR before unpausing via BRBFCR, matching brbe_enabl=
e(). */
> > +     write_sysreg_s(brbcr, SYS_BRBCR_EL1);
> > +     isb();
> > +     write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> > +     local_daif_restore(flags);
> > +
> > +     return nr_copied;
> > +}
