Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D758830EF88
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Jan 2026 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327629; cv=none; b=ODQ6milofsW6/M6TN6P0pbec03Zi9HYUEf9IGl5xZXdacVPtjDbQHvnGLEdPiHdN2SO35ZIsvSW2glbFv5/JfRLWu0IRk/5rsAObnEEE7Ibbh09YJecJdwzRSVw1iyc+CQ1YzAwOIJnBusn5XgRrYwiErRuLHCiRL7SKxgcexZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327629; c=relaxed/simple;
	bh=CbkHHTOGyLq2d2Wz6NUEABr6rx1SrLla/Zj1UhiM9zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJXlWlM5OfNk4OESS8BweMctEVH7mxZ9tcpQBAIG0mj2Ai6rI1S52Co7SvoM2XSGTpi85UBWmOUGtgEwCh9739U9L+NQIn+JbMgRBcj0ZT9ZmyQsEFI40WvSDQ4jyxFl3maFLHN/n5+Bdh40Vv8p5Cg2MC5MkpUK10dUksZBbBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wiDJnv1K; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wiDJnv1K"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88fcc71dbf4so49474726d6.2
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jan 2026 10:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768327627; x=1768932427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvvP77AU8vIUVuvAKMWR5lOG/0thO0Fj2Q0NRepV7TA=;
        b=wiDJnv1Kn+wVUrBnkHBTZ0bwYDzpIVZw5LPO6AoupsS9HuwZzaGo26ejkVp/ljozoq
         0biARjkichcCfVv31D6z08O1zyR4r3/KwZ4zxJZjxNNru2lqnvzhuuEvOrFmO/wtBOZI
         K3jo6rn62T5NCL5ufPvsnb2q7MMNaMPPLOiENZhjRYKXGqGJVmtJ4qhSf7iWNLvPwsls
         f6JIU63VXVkujZi14CnfaFy0srGuLE5nL1z4WJpqHic4A1w7K0+7Q43hMNvE0MYjhX0h
         wT/+xle0EVxAW5w/RScNhMdKEkcLe6AGZM3wqIQNGLCdQL8+eFLBIcWEQ/PUjy1Qhwbp
         qnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768327627; x=1768932427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PvvP77AU8vIUVuvAKMWR5lOG/0thO0Fj2Q0NRepV7TA=;
        b=sZE0zDNVsONirbjOtVRzRKFSVFeBvr9nc0unFNEn4q1BywexWDf6F2jm+qv6eIxopU
         8ttONlDjg/5ecl8iq918xK1i4L5dJCwQtT5Ya/SBVePJscdJG1DiupDF1K7yrQIkqevW
         8WBtmFnhgCpagdr6Ibhb0fvAgOKvLislD+Y3sUXIcj6d65kssIRvFFDnlNiT7c0pnOTF
         Ow+rHwO7B9L/tmS11zTMFgRmmw6ja/W3iiNxrMLVLbHxlwLdr3igqmz8JiF0SKLA1KbH
         zg9b7tN8N+KAIt/DYwlVaD89f1SGld4d8bXk997AcAaaT213/MByziCBVG8tR7/x/B/1
         lDYg==
X-Forwarded-Encrypted: i=1; AJvYcCUNNMASCiy9GEJNCK/pphchCp5Cd2lEeullfB/0RaEK/fRfLwjK7zwcwiwgVt/dijPD4DmAOfEZ/qYTGUGRYWIe@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1JtEqXIQx3Nj/ClXbehXzclaMH1qYgpstr/yoXhRrF4nfzMwV
	VECWBH1XowjIZZyGlvcuNRrkHZI1AKVnSVypamKtb4jtFB8jkXtUhw6bzEy7AF602Gm2eMkUal/
	gIgiRCo6przWVIkX8qlRYj6CjNueuSgf2lofWH4mD
X-Gm-Gg: AY/fxX5LQhaurgftm/eEBJNRF6zYLEEWSDvf3A9XOBh0MEOtCCZcQBtXoKzQSEXLp0Q
	F8oYukggspj3+YHssbT7lrOO9sIcv2rDKZ3g2EDpEuDu1dROWKayCRR0rDJJ3BpQappI80tMqTw
	2Nbgnjk3Yg3x3aN7T+NYWYNm2OXhQ6jcpDph5Pd7HJbR4w2+75+AmZqamJYoFm8nKSlojf1qMxu
	NLusmtVHI2bsBcN593pGV1F/IraPFaCttXHjdg45zeW/PxG/VbOfjrNa8cae0pASauq3zpxKTxq
	odoJpA0DkzBC0MFp3hru1dW08/E00v62fmA3
X-Google-Smtp-Source: AGHT+IEwR9/9J53rtswqHSzOLZIgF4VgVSKyeVhyoZZ/uKHq0G/MmBm6lMUwLjFeNA6HHd3TRLRqkpW3uYPD+tcSeH4=
X-Received: by 2002:a05:6214:4287:b0:88f:d4b1:4c32 with SMTP id
 6a1803df08f44-890842e2f8fmr347673266d6.63.1768327626354; Tue, 13 Jan 2026
 10:07:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108184430.1210223-1-ctshao@google.com> <CAP-5=fVLFVzitYZso2HB7dFgaNbJqW0pLE_AqMhc0ytW0PFvZw@mail.gmail.com>
In-Reply-To: <CAP-5=fVLFVzitYZso2HB7dFgaNbJqW0pLE_AqMhc0ytW0PFvZw@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 13 Jan 2026 10:06:54 -0800
X-Gm-Features: AZwV_QjtCBdZDd0wVx1hcalmG2LS1ZZE_CXiDN3roeRJChqajciO6Ra5E24jW-w
Message-ID: <CAJpZYjVadSgX6eSczFsqxJpMSq8q67CkA_WA+8jf+atgUScBNA@mail.gmail.com>
Subject: Re: [PATCH] perf pmu intel: Adjust cpumaks for sub-NUMA clusters on Emeraldrapids
To: Ian Rogers <irogers@google.com>
Cc: Thomas Falcon <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, ravi.bangoria@amd.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping.

Thanks for your comment, Ian. To Intel team, can we get confirmation
of the GNR SNR2 configuration?

-CT

On Thu, Jan 8, 2026 at 11:19=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Jan 8, 2026 at 10:45=E2=80=AFAM Chun-Tse Shao <ctshao@google.com>=
 wrote:
> >
> > Similar to GNR [1], Emeraldrapids supports sub-NUMA clusters as well.
> > Adjust cpumasks as the logic for GNR in [1].
> >
> > Tested on Emeraldrapids with SNC2 enabled:
> >   $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a --=
 sleep 1
> >
> >    Performance counter stats for 'system wide':
> >
> >   N0       30        72125876670      UNC_CHA_CLOCKTICKS
> >   N0        4         8815163648      UNC_M_CLOCKTICKS
> >   N1       30        72124958844      UNC_CHA_CLOCKTICKS
> >   N1        4         8815014974      UNC_M_CLOCKTICKS
> >   N2       30        72121049022      UNC_CHA_CLOCKTICKS
> >   N2        4         8814592626      UNC_M_CLOCKTICKS
> >   N3       30        72117133854      UNC_CHA_CLOCKTICKS
> >   N3        4         8814012840      UNC_M_CLOCKTICKS
> >
> >          1.001574118 seconds time elapsed
> >
> > [1] lore.kernel.org/20250515181417.491401-1-irogers@google.com
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  tools/perf/arch/x86/util/pmu.c | 45 +++++++++++++++++++++-------------
> >  1 file changed, 28 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/=
pmu.c
> > index a3f96221758d..fad68a0f7b5d 100644
> > --- a/tools/perf/arch/x86/util/pmu.c
> > +++ b/tools/perf/arch/x86/util/pmu.c
> > @@ -22,20 +22,29 @@
> >  #include "util/env.h"
> >  #include "util/header.h"
> >
> > -static bool x86__is_intel_graniterapids(void)
> > +static bool x86__is_snc_supported(void)
> >  {
> > -       static bool checked_if_graniterapids;
> > -       static bool is_graniterapids;
> > +       static bool checked_if_snc_supported;
> > +       static bool is_supported;
> >
> > -       if (!checked_if_graniterapids) {
> > -               const char *graniterapids_cpuid =3D "GenuineIntel-6-A[D=
E]";
> > +       if (!checked_if_snc_supported) {
> > +
> > +               /* Emeraldrapids and Graniterapids support SNC configur=
ation. */
> > +               static const char *const supported_cpuids[] =3D {
> > +                       "GenuineIntel-6-CF", /* Emeraldrapids */
> > +                       "GenuineIntel-6-A[DE]", /* Graniterapids */
> > +               };
> >                 char *cpuid =3D get_cpuid_str((struct perf_cpu){0});
> >
> > -               is_graniterapids =3D cpuid && strcmp_cpuid_str(graniter=
apids_cpuid, cpuid) =3D=3D 0;
> > +               for (size_t i =3D 0; i < ARRAY_SIZE(supported_cpuids); =
i++) {
> > +                       is_supported =3D cpuid && strcmp_cpuid_str(supp=
orted_cpuids[i], cpuid) =3D=3D 0;
> > +                       if (is_supported)
> > +                               break;
> > +               }
> >                 free(cpuid);
> > -               checked_if_graniterapids =3D true;
> > +               checked_if_snc_supported =3D true;
> >         }
> > -       return is_graniterapids;
> > +       return checked_if_snc_supported;
> >  }
> >
> >  static struct perf_cpu_map *read_sysfs_cpu_map(const char *sysfs_path)
> > @@ -64,6 +73,7 @@ static int snc_nodes_per_l3_cache(void)
> >                         read_sysfs_cpu_map("devices/system/cpu/cpu0/cac=
he/index3/shared_cpu_list");
> >
> >                 snc_nodes =3D perf_cpu_map__nr(cache_cpus) / perf_cpu_m=
ap__nr(node_cpus);
> > +
> >                 perf_cpu_map__put(cache_cpus);
> >                 perf_cpu_map__put(node_cpus);
> >                 checked_snc =3D true;
> > @@ -137,8 +147,8 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
> >         // Compute the IMC SNC using lookup tables.
> >         unsigned int imc_num;
> >         int snc_nodes =3D snc_nodes_per_l3_cache();
> > -       const u8 snc2_map[] =3D {1, 1, 0, 0, 1, 1, 0, 0};
> > -       const u8 snc3_map[] =3D {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
> > +       const u8 snc2_map[] =3D {0, 0, 1, 1};
>
> Does this alter the behavior on GNR? ie 1,1,0,0 vs 0,0,1,1.
>
> Thanks,
> Ian
>
> > +       const u8 snc3_map[] =3D {1, 1, 0, 0, 2, 2};
> >         const u8 *snc_map;
> >         size_t snc_map_len;
> >
> > @@ -161,11 +171,11 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
> >                 pr_warning("Unexpected: unable to compute IMC number '%=
s'\n", pmu->name);
> >                 return 0;
> >         }
> > -       if (imc_num >=3D snc_map_len) {
> > +       if (imc_num >=3D snc_map_len * perf_cpu_map__nr(pmu->cpus)) {
> >                 pr_warning("Unexpected IMC %d for SNC%d mapping\n", imc=
_num, snc_nodes);
> >                 return 0;
> >         }
> > -       return snc_map[imc_num];
> > +       return snc_map[imc_num % snc_map_len];
> >  }
> >
> >  static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
> > @@ -205,7 +215,7 @@ static int uncore_cha_imc_compute_cpu_adjust(int pm=
u_snc)
> >         return cpu_adjust[pmu_snc];
> >  }
> >
> > -static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu =
*pmu, bool cha)
> > +static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu=
, bool cha)
> >  {
> >         // With sub-NUMA clustering (SNC) there is a NUMA node per SNC =
in the
> >         // topology. For example, a two socket graniterapids machine ma=
y be set
> > @@ -304,11 +314,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
> >                                 pmu->mem_events =3D perf_mem_events_int=
el_aux;
> >                         else
> >                                 pmu->mem_events =3D perf_mem_events_int=
el;
> > -               } else if (x86__is_intel_graniterapids()) {
> > +               } else if (x86__is_snc_supported()) {
> >                         if (starts_with(pmu->name, "uncore_cha_"))
> > -                               gnr_uncore_cha_imc_adjust_cpumask_for_s=
nc(pmu, /*cha=3D*/true);
> > -                       else if (starts_with(pmu->name, "uncore_imc_"))
> > -                               gnr_uncore_cha_imc_adjust_cpumask_for_s=
nc(pmu, /*cha=3D*/false);
> > +                               uncore_cha_imc_adjust_cpumask_for_snc(p=
mu, /*cha=3D*/true);
> > +                       else if (starts_with(pmu->name, "uncore_imc_") =
&&
> > +                                !starts_with(pmu->name, "uncore_imc_fr=
ee_running"))
> > +                               uncore_cha_imc_adjust_cpumask_for_snc(p=
mu, /*cha=3D*/false);
> >                 }
> >         }
> >  }
> > --
> > 2.52.0.457.g6b5491de43-goog
> >
