Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A5A2D12F5
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899970; cv=pass; b=exOmSUNAuY3cJ2o7WPWXdZJWH2Jj+3Mm2P6rCIp7IsE7yXMpdsAmZcHL7nxJGqnczg1CE0qxNbbG8awDbgVPaYo/nMSs4ASc8gv+7SQG9Xnglf44hPSvVITO26WroUDiTzdWxa34MJ3gxMIddOcP0IEhVUCAkA0+CMQBzOQPfRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899970; c=relaxed/simple;
	bh=rxeerotoz/i8im58gFpTHn43alXxiw2ZmDatfi0R63A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cl1PNr4zYqkVZYZDyYA6/IO4ZHz8492gu6ojv430O7E+0kFhmfBlFLMHyUvIr0jz6wolvGOa0Xx/nXFnld36n1NyR57c2wqI0rgjhwhkulqnKqcMc35EMRCs9fZESp8DsK23Cq2BxY4chNlI85GN65kEiCG2FXVGNNlKQKzlK2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S0kXSORr; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S0kXSORr"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0d06cfa93so11595ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:19:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767899968; cv=none;
        d=google.com; s=arc-20240605;
        b=L5y1O3QOHR3749nT1u9dWNOVs0DBerDLLZaM2o6wxY0r+3oDOW9WKlu04jrY27wDzO
         Kis+oUTMTylHJKIXA2x5/vOZWNQBfciE0tlCrTbNLblFua9iBc6zhPoxjZdoDdazZSPG
         3AygPqHBVD1kQfmXXgd06XYg9Dn9otuwQvjHNW6TMs2kzxvDFUdM2qAhbbmfQfD3emKy
         V9/OLKEljg/jXpraeJiD90FW0pSzBBuWE42gRYwGvHf2ANuzMUrYABDnI518Q8fpnTLz
         5RHUuoc+lMqUeVUQ7sZ6PS+0C7uOgTsTtxn8CzVB5sB0IiYgQTM74H9MQrdBeQUDlgjl
         oGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wfMp4m13e+udwXOxJ9vqSrP2pn+cCuPSBga/27xwGBA=;
        fh=+h0hZktAU1GLIVZ2vooUw6+xglak3HxDyWiFbTQxOqw=;
        b=GbwIrg2+6iIZnX6hVDr4SLVAOe3OtWW7QHHe0LZKwITSTiiLL6SeMiI8Eqe79FMWL5
         0vV6m3DQvNDzwdoogIIiVWqCDKuGbZ0pBSCHSzgRZTlO0uQxnvY3lRcQLMHuNByJXzOr
         bYGU6HPZcqM9S9Pu85tySog31oNSNFnFEN22iD5k0VeQXywJj6bn/rur8+DOM3KVf8Hw
         nzrpNWx+nF2ERSu8pG7yJTQnRv/D3WNvugjkhjlc8W+yEfYKavd259z0ZclEjFABxops
         jYH0rDQHui2pjTym3EeXCqtITK8V5MV8HXiTS2DDU27pNAyMhu/D2jCklnmMbxG69SCn
         7SMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899968; x=1768504768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfMp4m13e+udwXOxJ9vqSrP2pn+cCuPSBga/27xwGBA=;
        b=S0kXSORrjijEkE8bQynyRI0S7fpYlY0d+K93/x9EAykMifnnjxaT6CtuY5m35mjKFz
         /AZJCNj504pBeZvYDfx0rPFjCt5qWx+o9sWqpPPtaJ1tLjqGT0RR73f8vxZZYUa9rm1A
         LHdhVmN9QhPrS8AwXjEpTeKDP3I79AzifcKx7hsdTcavlsvskfV36U49N2Drf4hg1/7G
         MObGpx0qCwZijbMx9gRqpKPrUKBbpOZOZM1miAu87gDlHeKWERThrEm79UEXtF2C3vVT
         Wq3TpDaZ0br2daBBa8E4CJmuzNDhOLIXhM3MfuKbNi0YkT85oAif3oZPfd6JdMpQKrBT
         MEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899968; x=1768504768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wfMp4m13e+udwXOxJ9vqSrP2pn+cCuPSBga/27xwGBA=;
        b=tN1Vf+G6cjUY6VmRNTGbIspDbV9QmDH/ub4qZkvsVdu+esZCXuGyhOB3+G657P3fVz
         7ZXe7eTR/4yxPxPBgYCsUoLMjCuxsPCy9qkm1ZExiwQ4+Pvemoj1Yn30mmRbyNgWIkEb
         1/TEJ0v7NgRtb1FHctz3EpeskpvSWSCChpCOgM+r4mXhUp3BXzF9dIwu/HTjy8YTpzvM
         Cv7YvEmFoEKzR/Npa3k80VU+AJB8QsdZEMGb5FYoxFwQGat6wt0ZlKC2UO9W/4wyGlL9
         qaibevzvI7Z+R5M0VSZ5DKEwAvoodWCrBgXLpNvnnegGNdELHGM2gTOCy1zlPALYcGdU
         4biw==
X-Forwarded-Encrypted: i=1; AJvYcCVm0P4BBgkETzoVdHsF1zU+Uw3CX2cYl5eOPMxkS4jMD6GB43j2PK/mk6O5SGT42uGngAbYxVUc2SJ32QtSK4j8@vger.kernel.org
X-Gm-Message-State: AOJu0YxmUGck7Th8LY+BkL1RPoDH2USrfhpdvBBSZDcqDLN6H+8dX1wm
	+xEVH+MxmwLwWlIjbOjhGpWc52lePFVQtjarhkdNrPWj0aSxKbQ8L0wEFEX4tX2e4EuYKIA32xp
	urYDuTDOryqE3tqmwtuKnmW3FQ+uGykEp9ad0dluF
X-Gm-Gg: AY/fxX5+RAznlElYBR+AENDXQcKBZ0Vxc/hMDDkY0nwzfd4rXiGl6Is21gq200wRqRT
	eUqGwOId1Gk/0ycO0x3b3+/tfCnNZQY+quX1qi2QpGKF1vHGC2+QxneZo2WKgkb4fvSiOe6Qdye
	pDPzGaoV7+u9vaoxKs2Fc2UNqJX548L+BOnXgSCHPvWX3wr+OvwiUZms9AgNzulddKOB0ahgKYw
	zh/KdsNyWAFv0aW3hJ19C1jWlkF0bGCASyjmH6pbmyXRSLaRsPStIx3EEGXx4CyjbZhcnqcXMP9
	6v0rTDZ9tiMjWFo/XDsUPWMZLA==
X-Received: by 2002:a17:903:41c4:b0:2a0:7fac:c031 with SMTP id
 d9443c01a7336-2a409ab1764mr426415ad.14.1767899967796; Thu, 08 Jan 2026
 11:19:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108184430.1210223-1-ctshao@google.com>
In-Reply-To: <20260108184430.1210223-1-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 8 Jan 2026 11:19:16 -0800
X-Gm-Features: AQt7F2q9AhP8JVbQcPsVpKMXeVN568ss7zLVfD0iJeCD0214kMbHs9NVns8bsUE
Message-ID: <CAP-5=fVLFVzitYZso2HB7dFgaNbJqW0pLE_AqMhc0ytW0PFvZw@mail.gmail.com>
Subject: Re: [PATCH] perf pmu intel: Adjust cpumaks for sub-NUMA clusters on Emeraldrapids
To: Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, ravi.bangoria@amd.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 10:45=E2=80=AFAM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> Similar to GNR [1], Emeraldrapids supports sub-NUMA clusters as well.
> Adjust cpumasks as the logic for GNR in [1].
>
> Tested on Emeraldrapids with SNC2 enabled:
>   $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a -- s=
leep 1
>
>    Performance counter stats for 'system wide':
>
>   N0       30        72125876670      UNC_CHA_CLOCKTICKS
>   N0        4         8815163648      UNC_M_CLOCKTICKS
>   N1       30        72124958844      UNC_CHA_CLOCKTICKS
>   N1        4         8815014974      UNC_M_CLOCKTICKS
>   N2       30        72121049022      UNC_CHA_CLOCKTICKS
>   N2        4         8814592626      UNC_M_CLOCKTICKS
>   N3       30        72117133854      UNC_CHA_CLOCKTICKS
>   N3        4         8814012840      UNC_M_CLOCKTICKS
>
>          1.001574118 seconds time elapsed
>
> [1] lore.kernel.org/20250515181417.491401-1-irogers@google.com
>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/perf/arch/x86/util/pmu.c | 45 +++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 17 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pm=
u.c
> index a3f96221758d..fad68a0f7b5d 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -22,20 +22,29 @@
>  #include "util/env.h"
>  #include "util/header.h"
>
> -static bool x86__is_intel_graniterapids(void)
> +static bool x86__is_snc_supported(void)
>  {
> -       static bool checked_if_graniterapids;
> -       static bool is_graniterapids;
> +       static bool checked_if_snc_supported;
> +       static bool is_supported;
>
> -       if (!checked_if_graniterapids) {
> -               const char *graniterapids_cpuid =3D "GenuineIntel-6-A[DE]=
";
> +       if (!checked_if_snc_supported) {
> +
> +               /* Emeraldrapids and Graniterapids support SNC configurat=
ion. */
> +               static const char *const supported_cpuids[] =3D {
> +                       "GenuineIntel-6-CF", /* Emeraldrapids */
> +                       "GenuineIntel-6-A[DE]", /* Graniterapids */
> +               };
>                 char *cpuid =3D get_cpuid_str((struct perf_cpu){0});
>
> -               is_graniterapids =3D cpuid && strcmp_cpuid_str(graniterap=
ids_cpuid, cpuid) =3D=3D 0;
> +               for (size_t i =3D 0; i < ARRAY_SIZE(supported_cpuids); i+=
+) {
> +                       is_supported =3D cpuid && strcmp_cpuid_str(suppor=
ted_cpuids[i], cpuid) =3D=3D 0;
> +                       if (is_supported)
> +                               break;
> +               }
>                 free(cpuid);
> -               checked_if_graniterapids =3D true;
> +               checked_if_snc_supported =3D true;
>         }
> -       return is_graniterapids;
> +       return checked_if_snc_supported;
>  }
>
>  static struct perf_cpu_map *read_sysfs_cpu_map(const char *sysfs_path)
> @@ -64,6 +73,7 @@ static int snc_nodes_per_l3_cache(void)
>                         read_sysfs_cpu_map("devices/system/cpu/cpu0/cache=
/index3/shared_cpu_list");
>
>                 snc_nodes =3D perf_cpu_map__nr(cache_cpus) / perf_cpu_map=
__nr(node_cpus);
> +
>                 perf_cpu_map__put(cache_cpus);
>                 perf_cpu_map__put(node_cpus);
>                 checked_snc =3D true;
> @@ -137,8 +147,8 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
>         // Compute the IMC SNC using lookup tables.
>         unsigned int imc_num;
>         int snc_nodes =3D snc_nodes_per_l3_cache();
> -       const u8 snc2_map[] =3D {1, 1, 0, 0, 1, 1, 0, 0};
> -       const u8 snc3_map[] =3D {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
> +       const u8 snc2_map[] =3D {0, 0, 1, 1};

Does this alter the behavior on GNR? ie 1,1,0,0 vs 0,0,1,1.

Thanks,
Ian

> +       const u8 snc3_map[] =3D {1, 1, 0, 0, 2, 2};
>         const u8 *snc_map;
>         size_t snc_map_len;
>
> @@ -161,11 +171,11 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
>                 pr_warning("Unexpected: unable to compute IMC number '%s'=
\n", pmu->name);
>                 return 0;
>         }
> -       if (imc_num >=3D snc_map_len) {
> +       if (imc_num >=3D snc_map_len * perf_cpu_map__nr(pmu->cpus)) {
>                 pr_warning("Unexpected IMC %d for SNC%d mapping\n", imc_n=
um, snc_nodes);
>                 return 0;
>         }
> -       return snc_map[imc_num];
> +       return snc_map[imc_num % snc_map_len];
>  }
>
>  static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
> @@ -205,7 +215,7 @@ static int uncore_cha_imc_compute_cpu_adjust(int pmu_=
snc)
>         return cpu_adjust[pmu_snc];
>  }
>
> -static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *p=
mu, bool cha)
> +static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, =
bool cha)
>  {
>         // With sub-NUMA clustering (SNC) there is a NUMA node per SNC in=
 the
>         // topology. For example, a two socket graniterapids machine may =
be set
> @@ -304,11 +314,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>                                 pmu->mem_events =3D perf_mem_events_intel=
_aux;
>                         else
>                                 pmu->mem_events =3D perf_mem_events_intel=
;
> -               } else if (x86__is_intel_graniterapids()) {
> +               } else if (x86__is_snc_supported()) {
>                         if (starts_with(pmu->name, "uncore_cha_"))
> -                               gnr_uncore_cha_imc_adjust_cpumask_for_snc=
(pmu, /*cha=3D*/true);
> -                       else if (starts_with(pmu->name, "uncore_imc_"))
> -                               gnr_uncore_cha_imc_adjust_cpumask_for_snc=
(pmu, /*cha=3D*/false);
> +                               uncore_cha_imc_adjust_cpumask_for_snc(pmu=
, /*cha=3D*/true);
> +                       else if (starts_with(pmu->name, "uncore_imc_") &&
> +                                !starts_with(pmu->name, "uncore_imc_free=
_running"))
> +                               uncore_cha_imc_adjust_cpumask_for_snc(pmu=
, /*cha=3D*/false);
>                 }
>         }
>  }
> --
> 2.52.0.457.g6b5491de43-goog
>
