Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D755C33375B
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Feb 2026 22:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770936119; cv=pass; b=uKzbmH4vZYcMtLVE/DQmEcCItmO7Odd9Yif9465fPsSzTywJLK0nLMfUIYzRTZ9r/IYLsnMHQI5tcOXM2eRGejkpnUwKUsgL8VbyjeUQ/VBjD+8SXH3m/9se+g5eM8AJ8BUR2qKjNYAUCjhMRq8OI0XV7nK5IOP7f4qc7LHJvtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770936119; c=relaxed/simple;
	bh=tfoRXFQ5gXmtUTVK0EZ1t91wPTaOHH92wlnHYEe4YP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HedoBg0wAVN1UbDj4L1R2Hb8cqsqudcqOc48IaTDrTT7WlzEmLw92pRSa/v0Gra7qSnkBDs4XPwasnhSGlrRM9p4loz8uvGzAfcJJMj0SuVUZBO8f4dHUWI7tH6SI9SnQfS5nQ/6YXuey7GOCrgarYrRs2RQDA1Djnliz7+sr8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pobRTw3G; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pobRTw3G"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50698970941so4398011cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Feb 2026 14:41:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770936114; cv=none;
        d=google.com; s=arc-20240605;
        b=ajSIUIbDC2pTcrRiy1gWIFZ8xAdOx6fo/q673Lz+X1oMuYiTJ8i1vzg/+D+ydJ0FgT
         4TCWjcRBwUw5gx3UKW+u9fT1W2eBdI8o0Yx9f9TvF1qHbZx0ilqtLrJrHe14s5GF4CQG
         jiNwr+GCBjJhcT4bJQVlACGn4pOM+KBvY21DR8yqay1ySUdmlvD5Gqkom8mGhLVtds6k
         xE6jHTG0GFqiCUUgMj32xeytE+lwIk7xlrA0Z7rmd+dyiZJKldfMW8xUUyzS6YxEbXNx
         oG/mIW9Dz+nwnLGhX5Gtxy+8IT0APxrMHxNOuOOvxlwJ8ufhMAv823ygK++8ZcFuchZx
         RkVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dCZnkd4mFXz0Es9C5PunIvSEx5RHnJ7OKSbEJnA9vrU=;
        fh=t080Ve9ABgZ0mf3gsuFne0rHZrXkyuDmuEBr1oLDgEk=;
        b=ZY/ZSyGhOHuACGm7re8YJ+VokFYtvAH/bMgGc/8FHKJt1y+R5qcjj7FiraPF6khyLK
         5x4x+2Lvsl3QY3kiRQnCl1oLLYzJFNWORZiV9FVFaApKYB+c6D8qnvBAYjKD7LQk3V7L
         p9Bt8MbBBsefiCVFGhlhz0bGmZ5AxCxZKv8ExfWHr11d1wwf0ADdfNJr19HwlhY2WufK
         q2xo0oPZ6YcBlpAItKxySn7WHgvDM7+okiRcDcE0/fN8Ussm81Kxr1DGcTlZxpRAVo/H
         Bs4gwejsDXvv8Bh+zorKpxCxa2TcyFMpNf3rpeWILLiyjyPRZgf1W8S3AC/yhSS3u8g6
         XrTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770936114; x=1771540914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCZnkd4mFXz0Es9C5PunIvSEx5RHnJ7OKSbEJnA9vrU=;
        b=pobRTw3GfbTjyGijR0TIB7hu05O2M+kBmQzA8RjnVjoVufV/fjU258EyNaSY7dOSEl
         2V0wldG5UPg3N9TFA7DmaaiZkRsNKCTlwlp1qA0SY0E+wY4t/je1MgUrb24zNHo/hxSB
         i+btOVu5YSDosCJpxM6+1iI0jEUCfezyEdWP4Pse1Q8hjEFxSs2T8iGzq962T0cNUlSG
         0UYXZ2QVOBfomYw6wBaaQtt1BXdCZc+6JTb+D1wcwLIHanjSM9jRV9KQtiZNEstIvHsm
         AVod8DIaOqGUGLGjLUds78a5bsdxtZfJRdi2ehtBcYaK5liG79thPSCCzj99HQTQN68T
         TtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770936114; x=1771540914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dCZnkd4mFXz0Es9C5PunIvSEx5RHnJ7OKSbEJnA9vrU=;
        b=vomuecRB/wAtZKU5C/HxQVyruwY/tnkR8hCEeFMpH5HNMPmB5qrprzCOVYKkjrsl9O
         oSJMujWtJC36UqOQF7NcqBeSJxwwY+MSCw4ZRthhdejeXKNoTErSHBaRFUmcSivi0y9M
         5iclWRoa9xpMUJDMlHMepBDkG0xpDRD9MJBj9YAH0WogaXmGD/CqPwqIa05DRoc+FvGO
         97SRffOC08b6l6AEjcbkGmLX0s7IGQ8Wjic92zFETuUjrXZCZWQrV8AOKWuyrqgQ+dCg
         uL0PO5VDXZtIZEEop5netp3KvAamTM6+pj7uEVKJjUJ+jkbhuwFDL8BkDGgdd3oW1zW7
         BU6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaP36ODQH3S0hGmrvLKlGfAnDndW/puoWsUur+eVADamaQK2jzAe/7eXYzVcWX4R8sMHNp4ih5PfYtDLFLZDvT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1fSaDQF2zoJV9gsoforFUuV4P0tccUqdWdXqeUdUhjOl+6V/8
	bNhjfHOcTWKvgRdtOkQO1yxx02YkA1ru71+e4B1GFtzAzS+cvjsgHeeHujT2YVdl2s8jD2s3liD
	fTBqaWb4el1pArMKkhxXSP5VS33mo7zzSI70a1Gvh
X-Gm-Gg: AZuq6aJ41yHM7micbPTTJHM3Ar2jTIjVovAl4gBp+ZZtT+xk6kUbLuhn1I8rbSE5caO
	I6CKNzkpYMacUPK3P8Yi4cCjTwfKvCJp0NayVKPMzSsQ0Mtcw2dbaHyf9yke5vZjsFQrPFrIRwQ
	DfABq9Vr/h24RHkHYLmpMShB/wXJlKdBgrF2nL3QU8kCncNZB7uiNxR+J2xMZ78XAOsjY1AdCAx
	o+JL4EpVFY6EvHez7Rezpl2N1R9B+xXUZsXN1XFdOc/kjZnVPOzJacJ2+bRa0ona2YwIz4J9aiQ
	8tgtbEQGzc6GUowK1KvKntoyAnRex3OXfo6eGg==
X-Received: by 2002:ac8:5952:0:b0:4f1:e9da:e876 with SMTP id
 d75a77b69052e-506a6a59eacmr4812661cf.62.1770936113217; Thu, 12 Feb 2026
 14:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205232220.1980168-1-ctshao@google.com> <ad625513-70a8-444d-a389-226715d2a86d@intel.com>
In-Reply-To: <ad625513-70a8-444d-a389-226715d2a86d@intel.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Thu, 12 Feb 2026 14:41:42 -0800
X-Gm-Features: AZwV_QjZpapCkRxxwXguNqVux9KlIO1r3QBI6RNaTYsatitqNkJM__bcvUjOdBU
Message-ID: <CAJpZYjU9QYWE-314fp_S97WUS-EZfvVPef4PcsAUfY+tiDvV0g@mail.gmail.com>
Subject: Re: [PATCH v2] perf pmu intel: Adjust cpumaks for sub-NUMA clusters
 on Emeraldrapids
To: "Chen, Zide" <zide.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, ravi.bangoria@amd.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the finding. Please check my v3 patch:
https://lore.kernel.org/20260212223942.3832857-1-ctshao@google.com

-CT


-CT

On Fri, Feb 6, 2026 at 3:46=E2=80=AFPM Chen, Zide <zide.chen@intel.com> wro=
te:
>
>
>
> On 2/5/2026 3:21 PM, Chun-Tse Shao wrote:
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
> > v2:
> >   Split EMR and GNR in the SNC2 IMC cpu map.
> >
> > v1: lore.kernel.org/20260108184430.1210223-1-ctshao@google.com
> >
> >  tools/perf/arch/x86/util/pmu.c | 95 ++++++++++++++++++++++------------
> >  1 file changed, 63 insertions(+), 32 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/=
pmu.c
> > index a3f96221758d..dbe876cd1b08 100644
> > --- a/tools/perf/arch/x86/util/pmu.c
> > +++ b/tools/perf/arch/x86/util/pmu.c
> > @@ -22,20 +22,29 @@
> >  #include "util/env.h"
> >  #include "util/header.h"
> >
> > -static bool x86__is_intel_graniterapids(void)
> > +static bool x86__is_snc_supported(void)
> >  {
> > -     static bool checked_if_graniterapids;
> > -     static bool is_graniterapids;
> > +     static bool checked_if_snc_supported;
> > +     static bool is_supported;
> >
> > -     if (!checked_if_graniterapids) {
> > -             const char *graniterapids_cpuid =3D "GenuineIntel-6-A[DE]=
";
> > +     if (!checked_if_snc_supported) {
> > +
> > +             /* Emeraldrapids and Graniterapids support SNC configurat=
ion. */
> > +             static const char *const supported_cpuids[] =3D {
> > +                     "GenuineIntel-6-CF", /* Emeraldrapids */
> > +                     "GenuineIntel-6-A[DE]", /* Graniterapids */
> > +             };
> >               char *cpuid =3D get_cpuid_str((struct perf_cpu){0});
> >
> > -             is_graniterapids =3D cpuid && strcmp_cpuid_str(graniterap=
ids_cpuid, cpuid) =3D=3D 0;
> > +             for (size_t i =3D 0; i < ARRAY_SIZE(supported_cpuids); i+=
+) {
> > +                     is_supported =3D cpuid && strcmp_cpuid_str(suppor=
ted_cpuids[i], cpuid) =3D=3D 0;
> > +                     if (is_supported)
> > +                             break;
> > +             }
> >               free(cpuid);
> > -             checked_if_graniterapids =3D true;
> > +             checked_if_snc_supported =3D true;
> >       }
> > -     return is_graniterapids;
> > +     return checked_if_snc_supported;
>
> This appears to be a typo, supposed to be is_supported.
>
> >  }
> >
> >  static struct perf_cpu_map *read_sysfs_cpu_map(const char *sysfs_path)
> > @@ -64,6 +73,7 @@ static int snc_nodes_per_l3_cache(void)
> >                       read_sysfs_cpu_map("devices/system/cpu/cpu0/cache=
/index3/shared_cpu_list");
> >
> >               snc_nodes =3D perf_cpu_map__nr(cache_cpus) / perf_cpu_map=
__nr(node_cpus);
> > +
> >               perf_cpu_map__put(cache_cpus);
> >               perf_cpu_map__put(node_cpus);
> >               checked_snc =3D true;
> > @@ -137,23 +147,42 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
> >       // Compute the IMC SNC using lookup tables.
> >       unsigned int imc_num;
> >       int snc_nodes =3D snc_nodes_per_l3_cache();
> > -     const u8 snc2_map[] =3D {1, 1, 0, 0, 1, 1, 0, 0};
> > -     const u8 snc3_map[] =3D {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
> > -     const u8 *snc_map;
> > -     size_t snc_map_len;
> > -
> > -     switch (snc_nodes) {
> > -     case 2:
> > -             snc_map =3D snc2_map;
> > -             snc_map_len =3D ARRAY_SIZE(snc2_map);
> > -             break;
> > -     case 3:
> > -             snc_map =3D snc3_map;
> > -             snc_map_len =3D ARRAY_SIZE(snc3_map);
> > -             break;
> > -     default:
> > -             /* Error or no lookup support for SNC with >3 nodes. */
> > -             return 0;
> > +     char *cpuid;
> > +     static const u8 emr_snc2_map[] =3D { 0, 0, 1, 1 };
> > +     static const u8 gnr_snc2_map[] =3D { 1, 1, 0, 0 };
> > +     static const u8 snc3_map[] =3D { 1, 1, 0, 0, 2, 2 };
> > +     static const u8 *snc_map =3D NULL;
> > +     static size_t snc_map_len;
> > +
> > +     /* snc_map is not inited yet. We only look up once to avoid expen=
sive operations. */
> > +     if (!snc_map) {
> > +             switch (snc_nodes) {
> > +             case 2:
> > +                     cpuid =3D get_cpuid_str((struct perf_cpu){ 0 });
> > +                     if (cpuid) {
> > +                             if (strcmp_cpuid_str("GenuineIntel-6-CF",=
 cpuid) =3D=3D 0) {
> > +                                     snc_map =3D emr_snc2_map;
> > +                                     snc_map_len =3D ARRAY_SIZE(emr_sn=
c2_map);
> > +                             } else if (strcmp_cpuid_str("GenuineIntel=
-6-A[DE]", cpuid) =3D=3D 0) {
> > +                                     snc_map =3D gnr_snc2_map;
> > +                                     snc_map_len =3D ARRAY_SIZE(gnr_sn=
c2_map);
> > +                             }
> > +                             free(cpuid);
> > +                     }
> > +                     break;
> > +             case 3:
> > +                     snc_map =3D snc3_map;
> > +                     snc_map_len =3D ARRAY_SIZE(snc3_map);
> > +                     break;
> > +             default:
> > +                     /* Error or no lookup support for SNC with >3 nod=
es. */
> > +                     return 0;
> > +             }
> > +
> > +             if (!snc_map) {
> > +                     pr_warning("Unexpected: can not find snc map conf=
ig");
> > +                     return 0;
> > +             }
> >       }
> >
> >       /* Compute SNC for PMU. */
> > @@ -161,11 +190,12 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
> >               pr_warning("Unexpected: unable to compute IMC number '%s'=
\n", pmu->name);
> >               return 0;
> >       }
> > -     if (imc_num >=3D snc_map_len) {
> > +     if (imc_num >=3D snc_map_len * perf_cpu_map__nr(pmu->cpus)) {
> >               pr_warning("Unexpected IMC %d for SNC%d mapping\n", imc_n=
um, snc_nodes);
> >               return 0;
> >       }
> > -     return snc_map[imc_num];
> > +
> > +     return snc_map[imc_num % snc_map_len];
> >  }
> >
> >  static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
> > @@ -205,7 +235,7 @@ static int uncore_cha_imc_compute_cpu_adjust(int pm=
u_snc)
> >       return cpu_adjust[pmu_snc];
> >  }
> >
> > -static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu =
*pmu, bool cha)
> > +static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu=
, bool cha)
> >  {
> >       // With sub-NUMA clustering (SNC) there is a NUMA node per SNC in=
 the
> >       // topology. For example, a two socket graniterapids machine may =
be set
> > @@ -304,11 +334,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
> >                               pmu->mem_events =3D perf_mem_events_intel=
_aux;
> >                       else
> >                               pmu->mem_events =3D perf_mem_events_intel=
;
> > -             } else if (x86__is_intel_graniterapids()) {
> > +             } else if (x86__is_snc_supported()) {
> >                       if (starts_with(pmu->name, "uncore_cha_"))
> > -                             gnr_uncore_cha_imc_adjust_cpumask_for_snc=
(pmu, /*cha=3D*/true);
> > -                     else if (starts_with(pmu->name, "uncore_imc_"))
> > -                             gnr_uncore_cha_imc_adjust_cpumask_for_snc=
(pmu, /*cha=3D*/false);
> > +                             uncore_cha_imc_adjust_cpumask_for_snc(pmu=
, /*cha=3D*/true);
> > +                     else if (starts_with(pmu->name, "uncore_imc_") &&
> > +                              !starts_with(pmu->name, "uncore_imc_free=
_running"))
> > +                             uncore_cha_imc_adjust_cpumask_for_snc(pmu=
, /*cha=3D*/false);
> >               }
> >       }
> >  }
> > --
> > 2.53.0.rc2.204.g2597b5adb4-goog
> >
> >
>
