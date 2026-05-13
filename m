Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9E9181334
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 00:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778632390; cv=pass; b=DJIPtluKYhJJp1xTn/AwSGCKdCnI+GOwiH/vFBkgcU1CWdjgEjLvGYx6+h6BLQVZl6WmOtUQ3eGZTKv+4f55BRtqAyO5toz6npsNKNSSYJ386Yggv+EY0IAUV/JSOIcaT3Sr809vclPC9oN2ht6RObUch03iY9q9ftplwGHJP1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778632390; c=relaxed/simple;
	bh=Nxdn77Qik02CKXHSibHlxB3fZweBPlYDncBUd9tn+Zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CB3PrWLKQwexNfSZlOvoEtvtkbKUnoAfAHAymcxjcZFdUrEpE0bnmo7d9TA6wt13E0g3LjfEf7w2/LisEz/EaRNe84pv5bWCBP2/6jfZ1K62wa9Ok2Ppi27lEZ033gaatVBBC9iPkAHEFUOX0bheAL3izLuaK1gJ9mxYt8eWjK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nqaOeN2v; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nqaOeN2v"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b46da8c48eso195ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778632388; cv=none;
        d=google.com; s=arc-20240605;
        b=Mf78+bY54Jn0YMTbMMy+aNqdbC4OIkz4fUI/xITd7XjO0JELusAGB+q58z1ZNch/xL
         0N+4eg7t6dxo3GSW70NpQPMyNaC440ZSTPu/0ewqYRGhS/WERVcK8obLL0/BptzWeN2v
         GnS6cAyq6/UMLMON1cGpdvvhvB8xCPwdDfwURGCE1UbWSxlcNU3qDZh1McznvUV+n+vN
         zxJbmrM6dpr4dBbF1Z16Qf9306TXKaRiGRDkWRDo28IvztE68ZyhMYBZp/KZSfXG9jTK
         smevOQqz2y/N4WU4u9V9oOuef7iPWLgJ0GZnhtN6j5Jl6iLkEjAKTSqcsqJciROjBIvH
         Emvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W55jeuHg08NmKlpnuBgbYu1bu29oVoYrUAME1/cjysU=;
        fh=P3NULRPnZMnN6V6bjjgEfSgA+I8/0gBh/ONGMp1URVQ=;
        b=Nz8HjECj9cIoZRjSvBch4ROx2VENJrRcWm3cDAwH3lh8AEm6ePVXseNctPd4lbIq7I
         ZNur4xsqohBYPB9NEbqw4WfOvzt62CUPEQqY8s6oCicFzPW9pIUZ2QPiGXSWAFCmmvv7
         yD9ZQUBB5muQhj2MLhrdD0DYHZ0Y5JJeiQgbfQt8Z9GNAshOMxTnnk7CR+7NPi+HZ5bR
         TEY5aRVE601Ci3SB0RpzQJT0oCYOb6aQUZCY8nb6T/Ccx1WIhfUn+WaP7ZclU1/zmO16
         /pWwqqr9wikfq1cz+//a6Cq6KZqz2+TPc+UeJzusaqqy69OmxcubD7MXppElOipsDEEL
         kT8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778632388; x=1779237188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W55jeuHg08NmKlpnuBgbYu1bu29oVoYrUAME1/cjysU=;
        b=nqaOeN2vnqiEjt0cyegByzKD73eD63h9TvTFM5ndI0+fYdnxLcNz0o1XTq4wleB1Rp
         ABb8MlbTs6IrbJ2Yx1GcEp50WeozfZsY8iu/R1lwYqRxZ3PScTTgbRJmEtDM9YVLGacW
         CWZmGL9dyB/bnEpdE1g1NIvcS66yjcTwxsGJGv4cCaaLtMpmxSW3qIIt8sDFsK4X2auY
         Rzk1aoqq9d+qWQxThzlpEwsXGZ8RoCjwIPK4bNzGDyBjKqJcXIh8Meh/SLp0VPNerK7m
         8kFmVDAIb0yYa0gqTXKLftfa/FIO5CoK+3r+Y8u7Rx7YIVk7O7vo2zGHTkjrARiftyUQ
         tfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778632388; x=1779237188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W55jeuHg08NmKlpnuBgbYu1bu29oVoYrUAME1/cjysU=;
        b=QMEt/tghesHQxo5wB7QP3eUtPOpEgrveB68f9kXBDMMJEGlIK5B3UVxkHDYBC0FuvV
         LgRqUDIl559g8j7zfAt+I4F2o/lhJ1SR2yx/Ge1fU6siiQeHYpCXfWWlAvoXBAoUsS54
         hlsj/pykUmBuSoWyCXgLxR8zuuVGM6xzwMt/He9H2W/p31FbJ2WUlPiTw1XB1S+r+4bc
         N0RW/v4btGB47pI9yEzh4591cvY9bInGlNtvtsh4PQ7FEDIrQp86xsDAbDrHF7NtLZf2
         4jwS0aSqVqAd+yUkbyr7EKzH84A1nRyENG7/ZgEwzgkFzMfEDb67ZzNV4pbc0cIgXRfX
         Hh5A==
X-Forwarded-Encrypted: i=1; AFNElJ+bhWOLDxoNJZvKXf+LJrozdV3ZplHLgx1v8Z4iPYBQJQKn8TgWAtGYtAevsSzg8DGBw6FCrBJ/sYfPktgdOl4a@vger.kernel.org
X-Gm-Message-State: AOJu0YzOHAB5DABTUOTV8DnD23Q6ahwXbTtuOCu3poeNy2HNWlni4dRj
	Iaxir9YYWkQSyUpf0KTYiocF4M6ct6gGsx4LGZCyobm8KRpRuY/3pOEMt9tGx5B4Uxmzn5Bs5w1
	0agmAR17sf6tmmYTo2e3fEG3HX9OOIGf0HPgXKvBj
X-Gm-Gg: Acq92OEvmc0PSn+zY7dqNwsr9rRJjVOk4VykFJVIQkIvP1R5sB5PK4d6AifCdN83jHE
	lHp9mjUDIkePcgUpc5Tkn+pJSdXdlVyaVb+xd3qr1HRCDyeDBgC1umUEt/WVZopVn9Ia+JbQnoD
	2TU/JdKJRdSMokVmnrqwkUjDnuMyGDEO03SBQG0sp5rqbHaHLYYT7S3LiU/x4Ke6aB7O7hM1EWi
	hVKF8oTkn9s0bcrGurCO9jCz0Gq9AWWD17qIFDY58qKDcpQ7TmkxN6PwlcJ3WmcJTJ7eHNg1fE0
	iteu/NlUKAuKcZVsmy4=
X-Received: by 2002:a17:902:cf4b:b0:2b4:6153:e541 with SMTP id
 d9443c01a7336-2bd2c0a2cabmr1020025ad.3.1778632387765; Tue, 12 May 2026
 17:33:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512233048.9577-1-zide.chen@intel.com> <20260512233048.9577-7-zide.chen@intel.com>
In-Reply-To: <20260512233048.9577-7-zide.chen@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 May 2026 17:32:55 -0700
X-Gm-Features: AVHnY4JMV4PPoRraNqKtQyPhOqWs413voGL1CLYKgHsvcuFwDn3eroP0M7pizvE
Message-ID: <CAP-5=fWuG4Q4TbnK+Y-tiet9o9=at4BVPf_RdXbWY_Vvd5zR4w@mail.gmail.com>
Subject: Re: [PATCH 6/7] perf/x86/intel/uncore: Fix uncore_box ref/unref
 ordering on CPU hotplug
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
> In uncore_event_cpu_online(), uncore_box_ref() was called before
> uncore_change_context().  uncore_box_ref() gates on box->cpu >=3D 0,
> but box->cpu is still -1 at that point because uncore_change_context()
> has not run yet.  As a result, the box is never initialized on the
> first CPU to come online in a die, leaving it permanently
> uninitialized in the single-CPU-per-die case.
>
> Thus, cpu_refcnt is one count below the true value, and in the CPU
> offline path, the box will be torn down on the second-to-last CPU.
>
> In uncore_event_cpu_offline(), uncore_box_unref() was called after
> uncore_change_context(), so box->cpu is already -1 when the collector
> CPU goes offline, which prevents it from tearing down the box.
>
> Fix by swapping the call order in both paths so that
> uncore_box_{ref,unref}() runs at the point where box->cpu reflects
> the correct context.
>
> Fixes: c74443d92f68 ("perf/x86/uncore: Support per PMU cpumask")
> Signed-off-by: Zide Chen <zide.chen@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  arch/x86/events/intel/uncore.c | 56 ++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 27 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index 922ba299533e..399f434e1a7d 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1574,9 +1574,15 @@ static int uncore_event_cpu_offline(unsigned int c=
pu)
>  {
>         int die, target;
>
> +       /* Clear the references */
> +       die =3D topology_logical_die_id(cpu);
> +       uncore_box_unref(uncore_msr_uncores, die);
> +       uncore_box_unref(uncore_mmio_uncores, die);
> +
>         /* Check if exiting cpu is used for collecting uncore events */
>         if (!cpumask_test_and_clear_cpu(cpu, &uncore_cpu_mask))
> -               goto unref;
> +               return 0;
> +
>         /* Find a new cpu to collect uncore events */
>         target =3D cpumask_any_but(topology_die_cpumask(cpu), cpu);
>
> @@ -1589,20 +1595,14 @@ static int uncore_event_cpu_offline(unsigned int =
cpu)
>         uncore_change_context(uncore_msr_uncores, cpu, target);
>         uncore_change_context(uncore_mmio_uncores, cpu, target);
>         uncore_change_context(uncore_pci_uncores, cpu, target);
> -
> -unref:
> -       /* Clear the references */
> -       die =3D topology_logical_die_id(cpu);
> -       uncore_box_unref(uncore_msr_uncores, die);
> -       uncore_box_unref(uncore_mmio_uncores, die);
>         return 0;
>  }
>
> -static int allocate_boxes(struct intel_uncore_type **types,
> +static void allocate_boxes(struct intel_uncore_type **types,
>                          unsigned int die, unsigned int cpu)
>  {
>         struct intel_uncore_box *box, *tmp;
> -       struct intel_uncore_type *type;
> +       struct intel_uncore_type *type, **start =3D types;
>         struct intel_uncore_pmu *pmu;
>         LIST_HEAD(allocated);
>         int i;
> @@ -1627,14 +1627,21 @@ static int allocate_boxes(struct intel_uncore_typ=
e **types,
>                 list_del_init(&box->active_list);
>                 box->pmu->boxes[die] =3D box;
>         }
> -       return 0;
> +       return;
>
>  cleanup:
>         list_for_each_entry_safe(box, tmp, &allocated, active_list) {
>                 list_del_init(&box->active_list);
>                 kfree(box);
>         }
> -       return -ENOMEM;
> +
> +       /* mark the PMU broken to prevent future ussage. */
> +       for (; *start; start++) {
> +               type =3D *start;
> +               pmu =3D type->pmus;
> +               for (i =3D 0; i < type->num_boxes; i++, pmu++)
> +                       uncore_pmu_set_broken(pmu);
> +       }
>  }
>
>  static int uncore_box_ref(struct intel_uncore_type **types,
> @@ -1643,11 +1650,7 @@ static int uncore_box_ref(struct intel_uncore_type=
 **types,
>         struct intel_uncore_type *type;
>         struct intel_uncore_pmu *pmu;
>         struct intel_uncore_box *box;
> -       int i, ret;
> -
> -       ret =3D allocate_boxes(types, die, cpu);
> -       if (ret)
> -               return ret;
> +       int i;
>
>         for (; *types; types++) {
>                 type =3D *types;
> @@ -1664,27 +1667,26 @@ static int uncore_box_ref(struct intel_uncore_typ=
e **types,
>
>  static int uncore_event_cpu_online(unsigned int cpu)
>  {
> -       int die, target, msr_ret, mmio_ret;
> +       int die, target;
>
>         die =3D topology_logical_die_id(cpu);
> -       msr_ret =3D uncore_box_ref(uncore_msr_uncores, die, cpu);
> -       mmio_ret =3D uncore_box_ref(uncore_mmio_uncores, die, cpu);
> +       allocate_boxes(uncore_msr_uncores, die, cpu);
> +       allocate_boxes(uncore_mmio_uncores, die, cpu);
>
>         /*
>          * Check if there is an online cpu in the package
>          * which collects uncore events already.
>          */
>         target =3D cpumask_any_and(&uncore_cpu_mask, topology_die_cpumask=
(cpu));
> -       if (target < nr_cpu_ids)
> -               return 0;
> -
> -       cpumask_set_cpu(cpu, &uncore_cpu_mask);
> -
> -       if (!msr_ret)
> +       if (target >=3D nr_cpu_ids) {
> +               cpumask_set_cpu(cpu, &uncore_cpu_mask);
>                 uncore_change_context(uncore_msr_uncores, -1, cpu);
> -       if (!mmio_ret)
>                 uncore_change_context(uncore_mmio_uncores, -1, cpu);
> -       uncore_change_context(uncore_pci_uncores, -1, cpu);
> +               uncore_change_context(uncore_pci_uncores, -1, cpu);
> +       }
> +
> +       uncore_box_ref(uncore_msr_uncores, die, cpu);
> +       uncore_box_ref(uncore_mmio_uncores, die, cpu);
>         return 0;
>  }
>
> --
> 2.54.0
>
