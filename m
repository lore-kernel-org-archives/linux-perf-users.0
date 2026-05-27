Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5428F507
	for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920330; cv=pass; b=R6inlQ1kX9KXm2ESuePks8rooKOStMRFmkLsMauTSzUmz1l3YoiPyedZ1Y8waNvD0dE7jJd2qTbWQc3+S/keuNTEF/OUTWKxodrR6Q5XIj1KdfdyRWuEoDq9JDJV0Vb+mAlnZBLQ4rqEjTuE5M5kCJkC1bt/o9nkSXDctQ0bw+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920330; c=relaxed/simple;
	bh=mPH7uvP5ty1pHu9yS5nlnzmX5VndKbDJEwifNNvl3Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9SKrdqj2RJOem2Jmin5vYpnNWZYNac766yVXGodjDm2i2AtU3fIbSZuK1utZKEeQSRVyP/u37Y1ACEdIqTBP1deW2Pv9F89j3y/jAE7wQijbVVP58CalxNHOhcQtOnUq8/kBfvseAlGOPMzmPGjbLYxvpVVUIGbjOS2ouiFUo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/PsuRt0; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/PsuRt0"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3025d725a05so27215123eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 15:18:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779920328; cv=none;
        d=google.com; s=arc-20240605;
        b=ZOABaNYGUzoCgCOkzyY6VzeyrRsaAiJ4qS1vlCV4JzghCAAVat2KjeWEaBw++OGd/M
         vWIxWjsSo8PfT3kLp7KNBswVquEKWMfJQJ/I3tg77iVAc0WFacA3AXzib551965kDwkF
         4aNFsqtG5glrZillf9MBZZmfxEXdHbBvRuLMdHRPmbo01z7+6oT5kPY0IDcNZC2S6ThQ
         4lRY3bszIJ8sFjs4craPL+PW0cKhDxleD1IHTc7+X8z8+4NUJoRMwtdBb5tL1z40Bm5E
         6nfd3n1kLnQFEmN8E/22TNhPzHUNAuVqYDEl2OymGVHICeLrPVTfTwcrHjGi1OGLFSEM
         kEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O0PepEl7OOQ/9oV+3PTgdW99zFfErv/70LiojODNWIA=;
        fh=bTy4FliDKrg8m6RkyYDEhUOiFgnBbu00+QbxG94+SM8=;
        b=jt4eNghL5C8OCH3Xw2XWLm2tL91oudGv5DIWOVBD0JJwy8Ur3LlDQxV6MmN2mHoIlK
         VhRYTVTIAGUBPL6j6FZntfJ9B59VufgAJ64rSYmaezd1EiPU9uUFGD4HEj5f30bwt6Fq
         dL8xNJbqM9PZVV3GRqfrXby0RgMyCQf/TbUEVRwQskX+51engy+FjAxb12EkOY4YEfg9
         fxjK//xhpgLH63y3QgKRzaoNaPOELAWs46n0zgH597jcSuAt+INful2g+7Lm4rKY+f0+
         1SkeYKb4CiNV6qK2WIvC6WycJn/WOKvtcuWH8gSCBFaefmi4/kD+8zKDvfuv7H1+NIGi
         KQJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779920328; x=1780525128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0PepEl7OOQ/9oV+3PTgdW99zFfErv/70LiojODNWIA=;
        b=e/PsuRt0NmsnwvaYV6kq7L2daq8n5B0DTlWGfvK2xKmlxkwzSnlEWsLcQx2XMhkNOH
         ZQAhn/J7sOoPzIpXQEqn8fSpd2NHZoJtVAy6fr9a920XgBd9/ym4e43SIt7//mMgaHB/
         Q1/3tbhtsUH+vecqfS8F1QwE6H4cAx65NpIAzLtOglCWu5ujv1w41og1kXgLAspJFPMS
         Ei08iAQUdDXoaROMIu8UUEH7rkk/17AHPof5RY4SWtNfU4X2fgpZeOmcFuUCfNsEP5UO
         Bs0yJXxn6HncGockJ7qZOuZ3iAQH22LuEYSfJRRcWQPkq1FfIKQC+36zZg0o/F50BpCm
         lAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779920328; x=1780525128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O0PepEl7OOQ/9oV+3PTgdW99zFfErv/70LiojODNWIA=;
        b=IlfkyV1zjXEjSbLcBlCdoTC8PXXZoyL2pXnFr7Zs37uMkIJzGHDMsXIWF4nTmiLD7A
         Lw/fAKwkOH00LFyHUvxFH66/xlNKDcM4gCYCUsLfRtT9NFCafQAkfDG5NxzWYs0/3Tdp
         UFMXown5iSV55SChx5BRT5+ckDea8xFfbJw/s0gKSvvlbkcHoXtUg6Fy55hUR621B0Ej
         7krsk3mUaLSsXapg06wURZmTk4fXe0UuuYna49URm7fFK+UwRyKE/Mq92mISFZgSbT26
         myYLK8Zo/z/xdJgiXo/U9BdZ7wb5GZfe1x/lCqZ9bIroZMRqBfz18lA9qTkZpjCcEq/b
         awtg==
X-Forwarded-Encrypted: i=1; AFNElJ/eRf2z5UVL56LVviu8XfJlPy/h6OEeWtc8P5QSBsSnCWbFHukfXMhKt8z4mYRahroV6Rz3TTdagaijU5OmjXl7@vger.kernel.org
X-Gm-Message-State: AOJu0YypadCwjzK2ypro+jzOoxLqUw6xgs1QOi4Sk2F8gb95Aw5QZUDC
	1C/QLLbxS/Bmq8mPKI2jJzTnZsLbHDkcjKzSV6AjjqB4Ssz3F48jl7Jq0yQ65nXX0cBIRPuhEec
	zEKJ8fU4o3NzPZbs9GXdtXHIgwWHlZGh5nWmeg378
X-Gm-Gg: Acq92OEvNXNswHBHc7fjBbuD18f2n/O4UgCrFMUzcgRrKWdWFc1Z4R12MNFRlLIMjSZ
	pjsDsRPvkkV1sElYywnGorgqgzoTrJj3VvuKtQ+Ah66bbPGrstjQW63S4E1/QKNI140Kboo1bpG
	NqVDBZy92zHft/7V7b5cDsV7C3WUfWpWf/ZwMyj+ZzJ1ArTfMFTt4CZ9jW5HgaIQ6pP86rLfqhk
	QJOPPnxatnoSQdYxI8dUQGRKeX/JycuBgFkiVgWFjY3OSzqEB5hxARW3gBwmRJeqA7MTt7wpiGE
	LQbaZXm6c5wJRgJzXroSsyECtVWrsh46Nj5gOk6Tbf+87N/E
X-Received: by 2002:a05:7300:818a:b0:2ed:6f94:9d94 with SMTP id
 5a478bee46e88-30449156e51mr11867413eec.19.1779920327336; Wed, 27 May 2026
 15:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515172710.428474-1-ctshao@google.com> <20260527221406.3826216-1-ctshao@google.com>
In-Reply-To: <20260527221406.3826216-1-ctshao@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Wed, 27 May 2026 15:18:35 -0700
X-Gm-Features: AVHnY4KbUNrpXe3fzKtYnR2Kl-m-kVnaacmmweUMuFAw7TLJOqsetAECaLv60a0
Message-ID: <CAJpZYjXfZwx3zYxgox8g_ZsnhEDq+_pMdaA32-o9j38y7+u9RA@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] perf pmu intel: Generalize SNC cpumask adjustment
 for multiple platforms
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Zide Chen <zide.chen@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Accidentally in reply to the previous version of patchset, will
resend. Sorry for the interruption.

On Wed, May 27, 2026 at 3:14=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> Prepare for supporting more Intel platforms with sub-NUMA clustering by
> generalizing the GNR specific logic.
>
> Reviewed-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> Assisted-by: Gemini:gemini-3.1-pro-preview
> ---
> v7:
>   Fixed based on Sashiko review:
>   - Refactor PMU initialization to be fully thread-safe using
>     pthread_once and pthread_mutex locks.
>   - Fix a critical bounds check bug on single-socket systems.
>   - Fix potential divide-by-zero crash in uncore_cha_snc.
>   - Avoid spurious warnings on non-SNC systems.
>   - Avoid silent and inconsistent uncore mappings on unsupported SNC
>     configurations.
>   - Resolve checkpatch linter warnings.
>
> v6: lore.kernel.org/20260515172710.428474-1-ctshao@google.com
>   Make string literal.
>   Add SPR into SNC2.
>
> v5: lore.kernel.org/20260407203918.3178481-1-ctshao@google.com
>   Split patch.
>
> v4: lore.kernel.org/20260402205300.1953706-1-ctshao@google.com
>   Rebase.
>
> v3: lore.kernel.org/20260212223942.3832857-1-ctshao@google.com
>   Fix a typo.
>
> v2: lore.kernel.org/20260205232220.1980168-1-ctshao@google.com
>   Split EMR and GNR in the SNC2 IMC cpu map.
>
> v1: lore.kernel.org/20260108184430.1210223-1-ctshao@google.com
>
>  tools/perf/arch/x86/util/pmu.c | 199 +++++++++++++++++++++------------
>  1 file changed, 130 insertions(+), 69 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pm=
u.c
> index 7c9d238922a6..9b00d5720fb7 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <pthread.h>
>  #include <string.h>
>  #include <stdio.h>
>  #include <sys/types.h>
> @@ -22,20 +23,31 @@
>  #include "util/env.h"
>  #include "util/header.h"
>
> -static bool x86__is_intel_graniterapids(void)
> -{
> -       static bool checked_if_graniterapids;
> -       static bool is_graniterapids;
> +#define GENUINE_INTEL_GNR "GenuineIntel-6-A[DE]"
>
> -       if (!checked_if_graniterapids) {
> -               const char *graniterapids_cpuid =3D "GenuineIntel-6-A[DE]=
";
> -               char *cpuid =3D get_cpuid_str((struct perf_cpu){0});
> +static bool cached_snc_supported;
> +static pthread_once_t snc_support_once =3D PTHREAD_ONCE_INIT;
>
> -               is_graniterapids =3D cpuid && strcmp_cpuid_str(graniterap=
ids_cpuid, cpuid) =3D=3D 0;
> -               free(cpuid);
> -               checked_if_graniterapids =3D true;
> +static void init_snc_support(void)
> +{
> +       /* Graniterapids supports SNC configuration. */
> +       static const char *const supported_cpuids[] =3D {
> +               GENUINE_INTEL_GNR, /* Graniterapids */
> +       };
> +       char *cpuid =3D get_cpuid_str((struct perf_cpu){0});
> +
> +       for (size_t i =3D 0; i < ARRAY_SIZE(supported_cpuids); i++) {
> +               cached_snc_supported =3D cpuid && strcmp_cpuid_str(suppor=
ted_cpuids[i], cpuid) =3D=3D 0;
> +               if (cached_snc_supported)
> +                       break;
>         }
> -       return is_graniterapids;
> +       free(cpuid);
> +}
> +
> +static bool x86__is_snc_supported(void)
> +{
> +       pthread_once(&snc_support_once, init_snc_support);
> +       return cached_snc_supported;
>  }
>
>  static struct perf_cpu_map *read_sysfs_cpu_map(const char *sysfs_path)
> @@ -52,49 +64,58 @@ static struct perf_cpu_map *read_sysfs_cpu_map(const =
char *sysfs_path)
>         return cpus;
>  }
>
> -static int snc_nodes_per_l3_cache(void)
> +static int cached_snc_nodes;
> +static pthread_once_t snc_nodes_once =3D PTHREAD_ONCE_INIT;
> +
> +static void init_snc_nodes(void)
>  {
> -       static bool checked_snc;
> -       static int snc_nodes;
> -
> -       if (!checked_snc) {
> -               struct perf_cpu_map *node_cpus =3D
> -                       read_sysfs_cpu_map("devices/system/node/node0/cpu=
list");
> -               struct perf_cpu_map *cache_cpus =3D
> -                       read_sysfs_cpu_map("devices/system/cpu/cpu0/cache=
/index3/shared_cpu_list");
> -
> -               snc_nodes =3D perf_cpu_map__nr(cache_cpus) / perf_cpu_map=
__nr(node_cpus);
> -               perf_cpu_map__put(cache_cpus);
> -               perf_cpu_map__put(node_cpus);
> -               checked_snc =3D true;
> -       }
> -       return snc_nodes;
> +       struct perf_cpu_map *node_cpus =3D
> +               read_sysfs_cpu_map("devices/system/node/node0/cpulist");
> +       struct perf_cpu_map *cache_cpus =3D
> +               read_sysfs_cpu_map("devices/system/cpu/cpu0/cache/index3/=
shared_cpu_list");
> +
> +       if (node_cpus && cache_cpus)
> +               cached_snc_nodes =3D perf_cpu_map__nr(cache_cpus) / perf_=
cpu_map__nr(node_cpus);
> +       else
> +               cached_snc_nodes =3D 0;
> +       perf_cpu_map__put(cache_cpus);
> +       perf_cpu_map__put(node_cpus);
>  }
>
> -static int num_chas(void)
> +static int snc_nodes_per_l3_cache(void)
>  {
> -       static bool checked_chas;
> -       static int num_chas;
> +       pthread_once(&snc_nodes_once, init_snc_nodes);
> +       return cached_snc_nodes;
> +}
>
> -       if (!checked_chas) {
> -               int fd =3D perf_pmu__event_source_devices_fd();
> -               struct io_dir dir;
> -               struct io_dirent64 *dent;
> +static int cached_num_chas;
> +static pthread_once_t num_chas_once =3D PTHREAD_ONCE_INIT;
>
> -               if (fd < 0)
> -                       return -1;
> +static void init_num_chas(void)
> +{
> +       int fd =3D perf_pmu__event_source_devices_fd();
> +       struct io_dir dir;
> +       struct io_dirent64 *dent;
>
> -               io_dir__init(&dir, fd);
> +       if (fd < 0) {
> +               cached_num_chas =3D -1;
> +               return;
> +       }
>
> -               while ((dent =3D io_dir__readdir(&dir)) !=3D NULL) {
> -                       /* Note, dent->d_type will be DT_LNK and so isn't=
 a useful filter. */
> -                       if (strstarts(dent->d_name, "uncore_cha_"))
> -                               num_chas++;
> -               }
> -               close(fd);
> -               checked_chas =3D true;
> +       io_dir__init(&dir, fd);
> +
> +       while ((dent =3D io_dir__readdir(&dir)) !=3D NULL) {
> +               /* Note, dent->d_type will be DT_LNK and so isn't a usefu=
l filter. */
> +               if (strstarts(dent->d_name, "uncore_cha_"))
> +                       cached_num_chas++;
>         }
> -       return num_chas;
> +       close(fd);
> +}
> +
> +static int num_chas(void)
> +{
> +       pthread_once(&num_chas_once, init_num_chas);
> +       return cached_num_chas;
>  }
>
>  #define MAX_SNCS 6
> @@ -121,46 +142,73 @@ static int uncore_cha_snc(struct perf_pmu *pmu)
>                 return 0;
>         }
>         chas_per_node =3D num_cha / snc_nodes;
> +       if (chas_per_node =3D=3D 0) {
> +               pr_warning("Unexpected: chas_per_node is 0 (num_cha=3D%d,=
 snc_nodes=3D%d)\n",
> +                          num_cha, snc_nodes);
> +               return 0;
> +       }
>         cha_snc =3D cha_num / chas_per_node;
>
>         /* Range check cha_snc. for unexpected out of bounds. */
>         return cha_snc >=3D MAX_SNCS ? 0 : cha_snc;
>  }
>
> -static int uncore_imc_snc(struct perf_pmu *pmu)
> +static const u8 *cached_imc_snc_map;
> +static size_t cached_imc_snc_map_len;
> +static pthread_once_t imc_snc_map_once =3D PTHREAD_ONCE_INIT;
> +
> +static void init_snc_map(void)
>  {
> -       // Compute the IMC SNC using lookup tables.
> -       unsigned int imc_num;
>         int snc_nodes =3D snc_nodes_per_l3_cache();
> -       const u8 snc2_map[] =3D {1, 1, 0, 0, 1, 1, 0, 0};
> -       const u8 snc3_map[] =3D {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
> -       const u8 *snc_map;
> -       size_t snc_map_len;
> +       char *cpuid;
> +       static const u8 gnr_snc2_map[] =3D { 1, 1, 0, 0 };
> +       static const u8 snc3_map[] =3D { 1, 1, 0, 0, 2, 2 };
>
>         switch (snc_nodes) {
>         case 2:
> -               snc_map =3D snc2_map;
> -               snc_map_len =3D ARRAY_SIZE(snc2_map);
> +               cpuid =3D get_cpuid_str((struct perf_cpu){ 0 });
> +               if (cpuid) {
> +                       if (strcmp_cpuid_str(GENUINE_INTEL_GNR, cpuid) =
=3D=3D 0) {
> +                               cached_imc_snc_map =3D gnr_snc2_map;
> +                               cached_imc_snc_map_len =3D ARRAY_SIZE(gnr=
_snc2_map);
> +                       }
> +                       free(cpuid);
> +               }
>                 break;
>         case 3:
> -               snc_map =3D snc3_map;
> -               snc_map_len =3D ARRAY_SIZE(snc3_map);
> +               cached_imc_snc_map =3D snc3_map;
> +               cached_imc_snc_map_len =3D ARRAY_SIZE(snc3_map);
>                 break;
>         default:
>                 /* Error or no lookup support for SNC with >3 nodes. */
> -               return 0;
> +               break;
>         }
>
> +       if (!cached_imc_snc_map)
> +               pr_warning("Unexpected: can not find snc map config\n");
> +}
> +
> +static int uncore_imc_snc(struct perf_pmu *pmu)
> +{
> +       // Compute the IMC SNC using lookup tables.
> +       unsigned int imc_num;
> +       int snc_nodes =3D snc_nodes_per_l3_cache();
> +
> +       if (snc_nodes <=3D 1)
> +               return 0;
> +
> +       pthread_once(&imc_snc_map_once, init_snc_map);
> +
>         /* Compute SNC for PMU. */
>         if (sscanf(pmu->name, "uncore_imc_%u", &imc_num) !=3D 1) {
>                 pr_warning("Unexpected: unable to compute IMC number '%s'=
\n", pmu->name);
>                 return 0;
>         }
> -       if (imc_num >=3D snc_map_len) {
> -               pr_warning("Unexpected IMC %d for SNC%d mapping\n", imc_n=
um, snc_nodes);
> +
> +       if (!cached_imc_snc_map)
>                 return 0;
> -       }
> -       return snc_map[imc_num];
> +
> +       return cached_imc_snc_map[imc_num % cached_imc_snc_map_len];
>  }
>
>  static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
> @@ -200,7 +248,9 @@ static int uncore_cha_imc_compute_cpu_adjust(int pmu_=
snc)
>         return cpu_adjust[pmu_snc];
>  }
>
> -static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *p=
mu, bool cha)
> +static pthread_mutex_t pmu_adjust_mutex =3D PTHREAD_MUTEX_INITIALIZER;
> +
> +static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, =
bool cha)
>  {
>         // With sub-NUMA clustering (SNC) there is a NUMA node per SNC in=
 the
>         // topology. For example, a two socket graniterapids machine may =
be set
> @@ -231,9 +281,11 @@ static void gnr_uncore_cha_imc_adjust_cpumask_for_sn=
c(struct perf_pmu *pmu, bool
>                 return;
>         }
>
> +       pthread_mutex_lock(&pmu_adjust_mutex);
> +
>         pmu_snc =3D cha ? uncore_cha_snc(pmu) : uncore_imc_snc(pmu);
>         if (pmu_snc =3D=3D 0) {
> -               // No adjustment necessary for the first SNC.
> +               pthread_mutex_unlock(&pmu_adjust_mutex);
>                 return;
>         }
>
> @@ -242,8 +294,10 @@ static void gnr_uncore_cha_imc_adjust_cpumask_for_sn=
c(struct perf_pmu *pmu, bool
>                 // Hold onto the perf_cpu_map globally to avoid recomputa=
tion.
>                 cpu_adjust =3D uncore_cha_imc_compute_cpu_adjust(pmu_snc)=
;
>                 adjusted[pmu_snc] =3D perf_cpu_map__empty_new(perf_cpu_ma=
p__nr(pmu->cpus));
> -               if (!adjusted[pmu_snc])
> +               if (!adjusted[pmu_snc]) {
> +                       pthread_mutex_unlock(&pmu_adjust_mutex);
>                         return;
> +               }
>         }
>
>         perf_cpu_map__for_each_cpu(cpu, idx, pmu->cpus) {
> @@ -263,6 +317,8 @@ static void gnr_uncore_cha_imc_adjust_cpumask_for_snc=
(struct perf_pmu *pmu, bool
>
>         perf_cpu_map__put(pmu->cpus);
>         pmu->cpus =3D perf_cpu_map__get(adjusted[pmu_snc]);
> +
> +       pthread_mutex_unlock(&pmu_adjust_mutex);
>  }
>
>  void perf_pmu__arch_init(struct perf_pmu *pmu)
> @@ -300,11 +356,16 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>                                 pmu->mem_events =3D perf_mem_events_intel=
_aux;
>                         else
>                                 pmu->mem_events =3D perf_mem_events_intel=
;
> -               } else if (x86__is_intel_graniterapids()) {
> -                       if (strstarts(pmu->name, "uncore_cha_"))
> -                               gnr_uncore_cha_imc_adjust_cpumask_for_snc=
(pmu, /*cha=3D*/true);
> -                       else if (strstarts(pmu->name, "uncore_imc_"))
> -                               gnr_uncore_cha_imc_adjust_cpumask_for_snc=
(pmu, /*cha=3D*/false);
> +               } else if (x86__is_snc_supported()) {
> +                       int snc_nodes =3D snc_nodes_per_l3_cache();
> +
> +                       if (snc_nodes =3D=3D 2 || snc_nodes =3D=3D 3) {
> +                               if (strstarts(pmu->name, "uncore_cha_"))
> +                                       uncore_cha_imc_adjust_cpumask_for=
_snc(pmu, /*cha=3D*/true);
> +                               else if (strstarts(pmu->name, "uncore_imc=
_") &&
> +                                        !strstarts(pmu->name, "uncore_im=
c_free_running"))
> +                                       uncore_cha_imc_adjust_cpumask_for=
_snc(pmu, /*cha=3D*/false);
> +                       }
>                 }
>         }
>  }
> --
> 2.54.0.823.g6e5bcc1fc9-goog
>
