Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098051A6808
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 00:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778632135; cv=pass; b=jf5N0AQ+GERGHnG54TQN9Y7OpLmGiI/R2xxRH8YZz2WhzC3OaSp4bF+UkuFM9EGXbXdBOSZiiYO9maqkrb9MADDjaIly1GUmtnl/NMgkNRzP1ZxokJ52yxC7KHpy5jOFlW1mfAAGOjolUKiznmw6wdX+OQ6mZX0ICoI0SH8/bgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778632135; c=relaxed/simple;
	bh=8DTXS2K54cgTo5K+U304aLkWJw9e2GD/aGjzA8LQo9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9Q0kav5ZN1QeRueauXKIVDdbAVjXhPa6ViShh46CCZ++BbzaBfSdfsAq+M4lXTYJ/XXzC74+y5+pcJucvvbRvvVtQXN77aCpRec5NrucNsgb/U9KAHCM0oujJOz9kAdS8ScGhAJ7XrvP5hjIt1uEMb+eVjhGT0U7Djmi6vJAu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nkzcz6dG; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nkzcz6dG"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so645ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:28:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778632133; cv=none;
        d=google.com; s=arc-20240605;
        b=AOo/0FeOVeVp/2wOV5sWKIhG+DotdmZrq5euN15KF2NSFy4qL7JP3sZK7wrO3/glZJ
         Ro5MPJkmT7o4AbMolJhiy+LlIdt/H1HVAm4tuZ931fsEXYfrS3oVUGsx8QNFQyxzp0oa
         HdO3fjBrNNhesOsVWysFQu+u/KbmQmZKBDuk+7ALLv40f0HHTBHrXYP+V6NEuh29DGPu
         DbVacI65XeCwoWOwTOmkKx/XxuFeyHN4JlbBKLy76czGIqNJWRuyjj8s+k5VBuvJ/ldE
         Pt7nvil9JD1pNzeMgSdch28pBKnXAyMcEn+eZ6k21fRkdN08GalP4ZEZfc/ecIz6SoYY
         IEMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G444+Z/MQpgVeFSW0VnetdsWWHaQNFc6l1lr4O2f7GY=;
        fh=FHRQWZmLqRK3oluDo4ClOatb+G9DuT1j48o3+EitmNc=;
        b=GEOYBaEeoQoLs9JYpVJ3gZAsEQE4+JBhU/PEe8dk/0E1keL6uYunrjU48b4Hen228n
         WqP89K3nHBIMrOu0k4Umqu1MOTbFx+3RylNQ5uB3uMJ6OBwpENslIDDCKYNISWRDKnI5
         k9xUkfoirAwGVdACTha5qO9YZkphz2EzM1m9ph/oo8SEMOfdJbz9g+SthZievhd47UW1
         kBngDB+liDdNW61Vfjd3s6F5fQfB1pSYs+6gPJhIcYLbTLopunLAb9dNZHZg6KHd0lJ8
         IyDgyJJYAGnB78TKuNCyAHVv8/7iRXNj6eX7DBOTgItIy4TWxBPoQWxQHHlWyinkXfJJ
         JP9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778632133; x=1779236933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G444+Z/MQpgVeFSW0VnetdsWWHaQNFc6l1lr4O2f7GY=;
        b=Nkzcz6dGlH1xXGZ1IOSVuX9Nd3BM251G16Oa3YIahVyJbG5HVAkGmuWN7H8Tl7zXuq
         IwrlARsNOKrxFJRPKS1X0wEi9xJ7dtZuQ6hvcvt61L2GgNA83SLInX10q030jdzOYshO
         ZRpH9PvppPx9h6O/64CY2uUgymdcfIqxd4Lu6MC/YKPlsn2hcEpoGoTrda2pv81LrWc0
         r7qFdrpCsykribhGABUWN0w6Yn599vcpa/eOm24dbkW279lmsFT6CV7xYMNB7qlvhU6Y
         fdFqbMfvpYA8iclyvPCHSzKVSK1ccmc9aTMijdegmq+KiMtXwvkenT8gUqWxsiQv/rLx
         zdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778632133; x=1779236933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G444+Z/MQpgVeFSW0VnetdsWWHaQNFc6l1lr4O2f7GY=;
        b=YWeUPUiK74k50my3zIr7k4RZnfevucRVnfse8GypbmYlVjGtQ/PQ8uWgVDPtNpF+y0
         swR8uPIy0Xszs8wP6Q5l9EsR1mPha4SfewJBp0i1fSFjYd+DVuIcFNgaTy9JqxVal6LC
         gK5gavaLgQwMo8etIJVglN+/+pCfc6iuiU9pjxh9/1y5EtFN7PbMR8LLspK8KcOivUnj
         J8U5OWIZRKDLCmawVSK3zwV6WWf6R/dahmuT/ZSE7KZD7+8swVpLd6Ph0nohWYo7sL4F
         aSJFRmORLnCXRoI+0wuvaaSna/atx7m1IxXyHtdFblJ02LSykvnaM1NPVjVW6TwODtiQ
         YK0A==
X-Forwarded-Encrypted: i=1; AFNElJ8R6yNJbaLjyGLDtmt6sdc28vGHosytnVvnWmHaHCDoVJiKhVHLa5Pb0bPt9ABaUFiZmwm4Oz/Yk5TdkaInFzYf@vger.kernel.org
X-Gm-Message-State: AOJu0YwcEbsOjwfRURpcBOJ10KxR9i/qQCUTiMHIJV0L3nBDxPui4FMZ
	MH8+avJRft5eVLCZbMGFfBhqYq8EksJeGng/ARDw0rE0FbifrSyzlNgK3pNdtgR4+dLf+cDISp2
	9xwL3cEU+177b1H9ogZTPelucT9hMwaJ5yNI83VoL
X-Gm-Gg: Acq92OGJGtIoTlNvzhCijhLeiNYVbGdCDodBIqoO7MS5F8WQmu1KMpQ9HiMxkS1GRyZ
	IaKQvjEtuY5i6A20RrgG5h8+grOJQHJ4wXqt2ANTlSBCAZ6PR/gFWM70vtHKKtPa1I4eG+oA2de
	MeCfxpfIcv6G62mMK0804751tUTouA4t2Dfzx9B6qcYwo38dw8ysLkCe0XV+E2DwaP3migFJ1dZ
	ohZ88Z1K0tTSuPQ9eoq/ZEoiGbPd5oYl/D2IJ8ZMhyujArjJudeirFNLT6OxaqlV3pvsOui2Nvw
	fzxD9ak8JNqKjctGfc1iuwfvt1GhQA==
X-Received: by 2002:a17:902:db0d:b0:2bd:907:2ce5 with SMTP id
 d9443c01a7336-2bd2c0f09a7mr1000545ad.7.1778632132403; Tue, 12 May 2026
 17:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512233048.9577-1-zide.chen@intel.com> <20260512233048.9577-6-zide.chen@intel.com>
In-Reply-To: <20260512233048.9577-6-zide.chen@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 May 2026 17:28:40 -0700
X-Gm-Features: AVHnY4J_uQPNqwPQltKpCB4R34xis7lbNZj-QoJ_XYAFa03jIjIAlvM_wBYyciY
Message-ID: <CAP-5=fXi2Rm8=UE3+5fMCKFO7TaTKOE_BUnVc7w24487tAYr-Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] perf/x86/intel/uncore: Introduce PMU flags and broken state
To: Zide Chen <zide.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 4:39=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> Replace the boolean 'registered' field in intel_uncore_pmu with an
> unsigned long 'flags' field, and add a PMU_BROKEN flag to track box
> setup failures.
>
> When any box fails to initialize, the PMU is marked broken.  Broken
> PMUs reject new event assignments and skip future box setup attempts.
> If the PMU was already registered, it remains so to avoid disrupting
> in-flight events on other boxes.
>
> To prevent retry loops, die_refcnt and cpu_refcnt are not decremented
> on failure, and broken PMUs are skipped in the CPU hotplug and box
> allocation paths.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  arch/x86/events/intel/uncore.c     | 36 +++++++++++++++++++++++-------
>  arch/x86/events/intel/uncore.h     | 12 +++++++++-
>  arch/x86/events/intel/uncore_snb.c |  2 +-
>  3 files changed, 40 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index 00ed4e5047ac..922ba299533e 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -757,7 +757,7 @@ static int uncore_pmu_event_init(struct perf_event *e=
vent)
>
>         pmu =3D uncore_event_to_pmu(event);
>         /* no device found for this pmu */
> -       if (!pmu->registered)
> +       if (!uncore_pmu_available(pmu))
>                 return -ENOENT;
>
>         /* Sampling not supported yet */
> @@ -953,16 +953,16 @@ static int uncore_pmu_register(struct intel_uncore_=
pmu *pmu)
>
>         ret =3D perf_pmu_register(&pmu->pmu, pmu->name, -1);
>         if (!ret)
> -               pmu->registered =3D true;
> +               uncore_pmu_set_registered(pmu);
>         return ret;
>  }
>
>  static void uncore_pmu_unregister(struct intel_uncore_pmu *pmu)
>  {
> -       if (!pmu->registered)
> +       if (!uncore_pmu_registered(pmu))
>                 return;
>         perf_pmu_unregister(&pmu->pmu);
> -       pmu->registered =3D false;
> +       WRITE_ONCE(pmu->flags, 0);
>  }
>
>  static void uncore_free_boxes(struct intel_uncore_pmu *pmu)
> @@ -1155,7 +1155,13 @@ static int uncore_box_setup(struct intel_uncore_pm=
u *pmu,
>
>         /* die_refcnt tracks online dies, not only functioning boxes. */
>         dies =3D atomic_inc_return(&pmu->die_refcnt);
> -       uncore_box_init(box);
> +
> +       if (uncore_pmu_broken(pmu))
> +               return -ENODEV;
> +
> +       ret =3D uncore_box_init(box);
> +       if (ret)
> +               goto err;
>
>         /* First active box registers the pmu. */
>         if (dies > 1)
> @@ -1167,6 +1173,19 @@ static int uncore_box_setup(struct intel_uncore_pm=
u *pmu,
>
>         return 0;
>  err:
> +       /*
> +        * On failure on any box, mark the per-package PMU as broken rega=
rdless
> +        * of whether it was registered or not.
> +        *
> +        * Don't decrement die_refcnt to prevent any future CPU online
> +        * event or PCI probe, from retrying the failed PMU registration.
> +        *
> +        * Don't decrement cpu_refcnt to avoid other in-die CPUs from
> +        * trying to set up the PMU box again.
> +        *
> +        * Don't kfree box; MSR and MMIO boxes are freed at module exit o=
nly.
> +        */
> +       uncore_pmu_set_broken(pmu);
>         uncore_box_exit(box);
>         return ret;
>  }
> @@ -1502,7 +1521,8 @@ static void uncore_change_type_ctx(struct intel_unc=
ore_type *type, int old_cpu,
>
>                 if (old_cpu < 0) {
>                         WARN_ON_ONCE(box->cpu !=3D -1);
> -                       if (uncore_die_has_box(type, die, pmu->pmu_idx)) =
{
> +                       if (uncore_die_has_box(type, die, pmu->pmu_idx) &=
&
> +                           !uncore_pmu_broken(pmu)) {
>                                 box->cpu =3D new_cpu;
>                                 cpumask_set_cpu(new_cpu, &pmu->cpu_mask);
>                         }
> @@ -1512,7 +1532,7 @@ static void uncore_change_type_ctx(struct intel_unc=
ore_type *type, int old_cpu,
>                 WARN_ON_ONCE(box->cpu !=3D -1 && box->cpu !=3D old_cpu);
>                 box->cpu =3D -1;
>                 cpumask_clear_cpu(old_cpu, &pmu->cpu_mask);
> -               if (new_cpu < 0)
> +               if (new_cpu < 0 || uncore_pmu_broken(pmu))
>                         continue;
>
>                 if (!uncore_die_has_box(type, die, pmu->pmu_idx))
> @@ -1592,7 +1612,7 @@ static int allocate_boxes(struct intel_uncore_type =
**types,
>                 type =3D *types;
>                 pmu =3D type->pmus;
>                 for (i =3D 0; i < type->num_boxes; i++, pmu++) {
> -                       if (pmu->boxes[die])
> +                       if (pmu->boxes[die] || uncore_pmu_broken(pmu))
>                                 continue;
>                         box =3D uncore_alloc_box(type, cpu_to_node(cpu));
>                         if (!box)
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncor=
e.h
> index 5ee05545116a..4d3a99bf1455 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -146,13 +146,23 @@ struct intel_uncore_pmu {
>         struct pmu                      pmu;
>         char                            name[UNCORE_PMU_NAME_LEN];
>         int                             pmu_idx;
> -       bool                            registered;
> +       unsigned long                   flags;
>         atomic_t                        die_refcnt;
>         cpumask_t                       cpu_mask;
>         struct intel_uncore_type        *type;
>         struct intel_uncore_box         **boxes;
>  };
>
> +#define PMU_REGISTERED_BIT     0
> +#define PMU_BROKEN_BIT         1
> +
> +#define uncore_pmu_registered(pmu)     test_bit(PMU_REGISTERED_BIT, &(pm=
u)->flags)
> +#define uncore_pmu_broken(pmu)         test_bit(PMU_BROKEN_BIT, &(pmu)->=
flags)
> +#define uncore_pmu_available(pmu)      (uncore_pmu_registered(pmu) &&  \
> +                                        !uncore_pmu_broken(pmu))
> +#define uncore_pmu_set_registered(pmu) set_bit(PMU_REGISTERED_BIT, &(pmu=
)->flags)
> +#define uncore_pmu_set_broken(pmu)     set_bit(PMU_BROKEN_BIT, &(pmu)->f=
lags)
> +
>  struct intel_uncore_extra_reg {
>         raw_spinlock_t lock;
>         u64 config, config1, config2;
> diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/u=
ncore_snb.c
> index c5347920541c..055131c508ff 100644
> --- a/arch/x86/events/intel/uncore_snb.c
> +++ b/arch/x86/events/intel/uncore_snb.c
> @@ -940,7 +940,7 @@ static int snb_uncore_imc_event_init(struct perf_even=
t *event)
>
>         pmu =3D uncore_event_to_pmu(event);
>         /* no device found for this pmu */
> -       if (!pmu->registered)
> +       if (!uncore_pmu_available(pmu))
>                 return -ENOENT;
>
>         /* Sampling not supported yet */
> --
> 2.54.0
>
