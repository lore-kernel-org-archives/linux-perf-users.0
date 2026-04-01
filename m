Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C0A477983
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061522; cv=pass; b=EZ27T3b2jt6ZdJMOuC+++25D7FIebRNmI5CDSyTsp4Sz/uBanHM8bryWYFLn2/W55fBNLahOFCRG/pXhwsHM8ugbbzS878OEhDZyI8ZaNmwY4mntZ9AF6qNtemXCReC3yaroIGWVZu8aNo8ttq3r7eyTeWcPa42j5AgJmM6UDP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061522; c=relaxed/simple;
	bh=R7YWh0oll30gDFPfNPmwQO4JYJ4cfRwWBRWkKeKZE7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqUmAioyVKPb8qJvi5ImDOUs60MsWhB98uvwHNI4zE3LnPG0RR+C+JafjsZK0/xspSz3uEYXjSCkTub5oXMSv5uXxPSPpYeMmTyZVDqQM6G0JZwDQ/LLNER258XkzTeI3QfZu/nrI49cnfsXdmA7xL5S7u8oAEP92K0WMYF3gHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iYy9kDwY; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iYy9kDwY"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-509069a7a7fso3191cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 09:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775061517; cv=none;
        d=google.com; s=arc-20240605;
        b=W8UzYezjU7DAaxBrMKM5fF3smMHxJMDywpdRa7qULJu7OW7DG6kM4qC0TY84HnrFnU
         SH1fcMWhdbJ4OSa6BHeG+kIDm2TtXX0jfD7aQI5+obmWk1wT5IrxRKJ5S/UDo0i2tZZh
         1e1oPE1v2PLs4rrJi13U99PqjnK8qkUnq50EP/ePgge6eZgpZpIgFnZwUkwkUvIWeay0
         NrhQcpPxmjmqgXyYrGg6SF2TvNqXMmVqVRXhNuctGf5hyAC/mczKXbTO/dtCZkwbU42I
         XCwbPY6rPaVgwbU+S2cDtEWdWWEPbiMcNkaEbOf5r3306sYXvCg1pdrm3W5OVnL3uB5S
         XsrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ay596QS6OHnxfOrTTjBz6KQQ1PnBNWvUbgzVsrgd5mE=;
        fh=3Y70IX5zXw1aG0RtEIbKNwmFgf7GiczuhBilUueg7tM=;
        b=hvwejhoO3ETzP80NLCF1VduLRt38FTh7cFV9VyuXorzhd09f2dIGCk50pBZ6SHN64v
         9aoBODkMbou4VfsbVdGWFIZbM5xbgPmRtFZNTLz8DOFnH/sJq0HQRstsCrah4yeS97ck
         DdO6fIWX4+Cr0fKut6PlRf5iTQ85B70IIhF4ja8m6BYfpNnNbtBWMbFaRslwvH7dpbgr
         FrAKJ04ER5i3h0gT4a+of2NjCj+RJk+5OuI2e49JREvL3TacUL1bXl8PvS8ctTrKT28T
         A60igfDF309YVBkkLCnG5KGUqe7IVcfTUUp8iw67vxPnWy/gN8SHT2NRI84ncPB8v3BF
         6lEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775061517; x=1775666317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ay596QS6OHnxfOrTTjBz6KQQ1PnBNWvUbgzVsrgd5mE=;
        b=iYy9kDwYXCwim/hMvalQSTpHT7NGy/1vUKhajwrHN4FN6AquJHnivZEsMiqk9Nvq7W
         G/kAYw2iMaE1io3OupY5l7d5ZDrc5TQN0Q1QdcJwckPmpbllo61McDNAzVzKnYtomGup
         rFHBBf0wumqgdS/ku9l4UhtxhNgNDSbLcqZvji/ZwNInhOA1vVgi6DUVVJn5ItPlGneo
         id12WLv//9UjGKmcUKwDwFXPuG4uRpUbY1wKcbyZ/ZDlWB/HvaqZxAVg2ADUuHCKyhwO
         eR4hUpbz92pXWC8QFP2GPXCACbDC+XcC3X7p9s6R/fK56r7Me2++oEi+WKmEr6dWyRlh
         wiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775061517; x=1775666317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ay596QS6OHnxfOrTTjBz6KQQ1PnBNWvUbgzVsrgd5mE=;
        b=dtbIJtt/VhMeqJx8O6VAQalaJmtOLLqMPEO/d9fuIdcYK8ejINtS4TqeU0wrmJ3V9T
         Ha+ytCu8hW/D/cHCiFBUlaDVmccQlPU6DCvw2KZDghTYsA/dd1oVvUw+pOGKsHnJ5EnK
         k1u1pAbjxh1BHcnUuCqs8URIo0RamZT+YLFp62GwCqyoRjgMzKlGtVSQgH7eN5gFHqir
         RZesHLrd/htpRaMIbHIr4RNGoFLfW3gSemlkED+gSbdefayv7tY+unCTXZauE/3DhqoN
         I/QW1QzV4v1ziTyulOG405Q0quwCchxuz4LQbX5ZzY0hjMftzUUllfRp/y4CyAWHMWPZ
         smKA==
X-Forwarded-Encrypted: i=1; AJvYcCXrKGkESA1+lZDXCnD4efIYQTndcyAfMIb6Cf/DBpsz6ZbKTh+WtNInLVN/Gadg/Qqs6Yy0P1dxtgwOh5ssuvnL@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtu8XGXH3ouVTIzrjihjCy5lKvlcwrM1kOV9E1e4Vp3wP9+qna
	o4MriWdkfEYhPXMQOPz1oLkDraGWTsivBOTJzIOs/rMaDJbgRAPdkEarFYKkaIF8ixEZ9MkI1MM
	9B3HdygI02j0h0ajuh2Zwj8d6isfaakReS/w/qbXh
X-Gm-Gg: ATEYQzzDPnn/YjaELOMQfeT2kLDSmIJMEyq64yJaqlKbhlAPFLdZuAY7CUFOOn4H00t
	hwBGFepHHTZ8Nljq6m8RWxhPJ1N0r9kmW+cocmIHBSOhJSLWan49RkQ4RFXIxtMDfQJyZIg1hJO
	pac9jKzvHw5fS3q3KCVgWerS8H5e3um/DqCABF6UiEwUYYLC2pYpGS+LDmaNnab04MTfOp0Ug1f
	MhbbmXJmBOb1WcadSCU2/6qwlmdBkrVx4LKwUPkrzkauHVzdbpWwmbMDO87HEt98lAlvASbn8l4
	CsnILZk/MC5mpH+KGUDfx60uvkOQcPI5nUtvlTud+4tnxXM=
X-Received: by 2002:a17:903:f8e:b0:2b0:aee4:afe7 with SMTP id
 d9443c01a7336-2b275818201mr4435ad.10.1775061516467; Wed, 01 Apr 2026 09:38:36
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212223942.3832857-1-ctshao@google.com> <bb9a1471-6996-47e9-a81e-8de58ab32fb2@intel.com>
In-Reply-To: <bb9a1471-6996-47e9-a81e-8de58ab32fb2@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 09:38:24 -0700
X-Gm-Features: AQROBzBb8Vd21-uYCvQaZUCJvMTY5YuKmmk6D7vCzMgJisqdbJM5iUqPm2fye0o
Message-ID: <CAP-5=fXFzmKx+buppcNBQWhEP2UyCobPwYRC-L-unpmDL=2_Wg@mail.gmail.com>
Subject: Re: [PATCH v3] perf pmu intel: Adjust cpumaks for sub-NUMA clusters
 on Emeraldrapids
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, ravi.bangoria@amd.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 4:08=E2=80=AFPM Chen, Zide <zide.chen@intel.com> wr=
ote:
>
> On 2/12/2026 2:39 PM, Chun-Tse Shao wrote:
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
>
> LGTM.
>
> Reviewed-by: Zide Chen <zide.chen@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> > v3:
> >   Fix a typo.
> >
> > v2: lore.kernel.org/20260205232220.1980168-1-ctshao@google.com
> >   Split EMR and GNR in the SNC2 IMC cpu map.
> >
> > v1: lore.kernel.org/20260108184430.1210223-1-ctshao@google.com
> >
> >  tools/perf/arch/x86/util/pmu.c | 95 ++++++++++++++++++++++------------
> >  1 file changed, 63 insertions(+), 32 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/=
pmu.c
> > index a3f96221758d..2215984349f5 100644
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
> > +     return is_supported;
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
> > +     static const u8 *snc_map;
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
> > 2.53.0.273.g2a3d683680-goog
> >
> >
>
