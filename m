Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281F01C3C18
	for <linux-perf-users@vger.kernel.org>; Thu, 15 May 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747324969; cv=none; b=G2teRnuygSuG104w2ArwPtGAQS2N9UsoQOBO0RjspVessMC0mdp+iIBSMvxAqvauBJZSaP8LvjKSyJuJryKU/iiXkRI+9+AbR2gua70nhXj7czh5q6piOO+aOdeCUgO/8zOaKPDGdcbNqOfeKJw5NmWpeMEAsNb+wynsb/3DHcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747324969; c=relaxed/simple;
	bh=Rc4Pu6VyAswNcuUEpx3gO4Q6RzhT7vATPJgDkGOFsoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=h6lGpnFEXSVawHzEIRZDaE91OsIWJVAmaP3MSf1IQ9O4jNrxqVJvVS/9B7Z77169ltC6a00SqiD+QvQm88J8Unld7PpNzbWk/o2//FMaC0TG/dvOAsS72jtamY+ePXgNOXfU78t7rDJ8Wa3LSmQ3Bu6zHxhDUfZv3G4z+RIMuIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WmuLAo3b; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WmuLAo3b"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3da76aea6d5so193315ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 15 May 2025 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747324966; x=1747929766; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNEiTtEIDHNlmVia2GFQ0qpG7Qornhf6jQbb4JLwMZc=;
        b=WmuLAo3bw79dSh279pRM1IzSHuxQ7o4ZUYfBH4ILAXr26wLHXIDqqR4TN35VwXkNNe
         ht/4q5KLrCvxniG/SvNq4YqRBjTHJ1u+QiJIa7M2enD69ngbbaasxFIvIPvA2fA5pfkI
         sKYMXUUy7lAC3yetbtalplwQLmUGgGzV5TnC/hD1ylJjCD/yeGUGRoUtklxiNxfLV/JE
         i1tVVLQItbOCARySddWVdzOdjnLRTwI8OBNeiBwgBV6ci5cB5PqaoHExe0UQc7bkFOhg
         AGX5RjgxghlzzVyiEATRh7769/UBz+P9hAG+Lw4X39W48ggciSru/VVva2OSm+enmy1O
         XY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747324966; x=1747929766;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNEiTtEIDHNlmVia2GFQ0qpG7Qornhf6jQbb4JLwMZc=;
        b=mOjrnC1iD5OYzCwQsUenvxQHdpXnpCRXFCCrKnA+aLDWO2AW0MCrXyGoKmkVklfRuO
         CWa549ZuFfCmjNl6ph2xL5OpI2Gu7Piefj3twOo9HV0AoWx9tI/yplPpsVcK1EKXWpZo
         cWfiaKv3zIXc86VcMPQBueF38en7ypov3usDiExL4il2K6b0Ty2zzfYBapJBVGSGV9yl
         hrNJlWCeJ0Ei5kmrsUL7fxR2u4tP05B8aoKLRfueALtMDRFCnwhNtKO0sAHkc0cUOGfK
         +/mYjDla2gWFCBkhWpqMLcfzWz7+WUNOsJB9zhAQqVCyotcqk5dk9ynyLcTGl6XtcLkh
         7W8A==
X-Forwarded-Encrypted: i=1; AJvYcCWsWnqWQvjjsl6+2H2rQDmesU4i6v8tSd7cYrDxJI+D1UF8lg7kyjIfQSAhx8QCjJoE/nVCGC3/WYRWnxtL4pQE@vger.kernel.org
X-Gm-Message-State: AOJu0YyGjFI5yiu7EVkwXdqKjN2c9ba/qNT18d3MgVwQXO1SFHq7nsGC
	OhmIuQYuJNu6piu0Yd75fFqegCN+8Um4McXXhYl7THzCkZiFS5cgTKlkJaRiIFCQWaEU/Oa6qTO
	PYjv0XFUHpoQLvY33s7tODmVx+/1udCzxuK0HyFUx
X-Gm-Gg: ASbGncukvEd1Pz917efnffgoTwyxEAgR3TLF7lJLCSUYusOxmQ9STdtOexNrRd8dbaH
	NQMC3n59MBlwW1O37L0ukghAufyaD3XUyoYKoEMJY8aBCpNwMfPP+KYLGXKftHfd+L3ygM8bStN
	ZC7aZGP5hvbxWGwexlaW00zzgDqnBaZ2Z6HSyicSaUVSLV/k2wSWsy2Ty7TcJp0w==
X-Google-Smtp-Source: AGHT+IFpemWKANP9mtqDnN7Vt/CLxQCe62NgTtJigvz88wyC9hkL3RWXBmQvnO2zaNlIff5knuED7OA82oyhfIe76GU=
X-Received: by 2002:a05:6e02:216e:b0:3d5:e202:6f05 with SMTP id
 e9e14a558f8ab-3db780673b7mr4845115ab.18.1747324965695; Thu, 15 May 2025
 09:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515043818.236807-1-irogers@google.com>
In-Reply-To: <20250515043818.236807-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 15 May 2025 09:02:34 -0700
X-Gm-Features: AX0GCFs7Uwtz4onl_u0xC4oHn__ywbBwH1lBS0hW5-D4un_TiodmjMrTGQICijM
Message-ID: <CAP-5=fV0jEcphF9CW0jNbr6XkebgqADzcvuFgjeuUO6pAtGSzQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmu intel: Adjust cpumaks for sub-NUMA clusters
 on graniterapids
To: Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 9:38=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On graniterapids the cache home agent (CHA) and memory controller
> (IMC) PMUs all have their cpumask set to per-socket information. In
> order for per NUMA node aggregation to work correctly the PMUs cpumask
> needs to be set to CPUs for the relevant sub-NUMA grouping.
>
> For example, on a 2 socket graniterapids machine with sub NUMA
> clustering of 3, for uncore_cha and uncore_imc PMUs the cpumask is
> "0,120" leading to aggregation only on NUMA nodes 0 and 3:
> ```
> $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a sleep =
1
>
>  Performance counter stats for 'system wide':
>
> N0        1    277,835,681,344      UNC_CHA_CLOCKTICKS
> N0        1     19,242,894,228      UNC_M_CLOCKTICKS
> N3        1    277,803,448,124      UNC_CHA_CLOCKTICKS
> N3        1     19,240,741,498      UNC_M_CLOCKTICKS
>
>        1.002113847 seconds time elapsed
> ```
>
> By updating the PMUs cpumasks to "0,120", "40,160" and "80,200" then
> the correctly 6 NUMA node aggregations are achieved:
> ```
> $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a sleep =
1
>
>  Performance counter stats for 'system wide':
>
> N0        1     92,748,667,796      UNC_CHA_CLOCKTICKS
> N0        0      6,424,021,142      UNC_M_CLOCKTICKS
> N1        0     92,753,504,424      UNC_CHA_CLOCKTICKS
> N1        1      6,424,308,338      UNC_M_CLOCKTICKS
> N2        0     92,751,170,084      UNC_CHA_CLOCKTICKS
> N2        0      6,424,227,402      UNC_M_CLOCKTICKS
> N3        1     92,745,944,144      UNC_CHA_CLOCKTICKS
> N3        0      6,423,752,086      UNC_M_CLOCKTICKS
> N4        0     92,725,793,788      UNC_CHA_CLOCKTICKS
> N4        1      6,422,393,266      UNC_M_CLOCKTICKS
> N5        0     92,717,504,388      UNC_CHA_CLOCKTICKS
> N5        0      6,421,842,618      UNC_M_CLOCKTICKS
>
>        1.003406645 seconds time elapsed
> ```
>
> In general, having the perf tool adjust cpumasks isn't desirable as
> ideally the PMU driver would be advertising the correct cpumask.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/util/pmu.c | 259 ++++++++++++++++++++++++++++++++-
>  1 file changed, 254 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pm=
u.c
> index 8712cbbbc712..38c800c6e9c8 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -8,6 +8,8 @@
>  #include <linux/perf_event.h>
>  #include <linux/zalloc.h>
>  #include <api/fs/fs.h>
> +#include <api/io_dir.h>
> +#include <internal/cpumap.h>
>  #include <errno.h>
>
>  #include "../../../util/intel-pt.h"
> @@ -16,7 +18,247 @@
>  #include "../../../util/fncache.h"
>  #include "../../../util/pmus.h"
>  #include "mem-events.h"
> +#include "util/debug.h"
>  #include "util/env.h"
> +#include "util/header.h"
> +
> +static bool x86__is_intel_graniterapids(void)
> +{
> +       static bool checked_if_graniterapids;
> +       static bool is_graniterapids;
> +
> +       if (!checked_if_graniterapids) {
> +               const char *graniterapids_cpuid =3D "GenuineIntel-6-A[DE]=
";
> +               char *cpuid =3D get_cpuid_str((struct perf_cpu){0});
> +
> +               is_graniterapids =3D cpuid && strcmp_cpuid_str(graniterap=
ids_cpuid, cpuid) =3D=3D 0;
> +               free(cpuid);
> +               checked_if_graniterapids =3D true;
> +       }
> +       return is_graniterapids;
> +}
> +
> +static struct perf_cpu_map *read_sysfs_cpu_map(const char *sysfs_path)
> +{
> +       struct perf_cpu_map *cpus;
> +       char *buf =3D NULL;
> +       size_t buf_len;
> +
> +       if (sysfs__read_str(sysfs_path, &buf, &buf_len) < 0)
> +               return NULL;
> +
> +       cpus =3D perf_cpu_map__new(buf);
> +       free(buf);
> +       return cpus;
> +}
> +
> +static int snc_nodes_per_l3_cache(void)
> +{
> +       static bool checked_snc;
> +       static int snc_nodes;
> +
> +       if (!checked_snc) {
> +               struct perf_cpu_map *node_cpus =3D
> +                       read_sysfs_cpu_map("devices/system/node/node0/cpu=
list");
> +               struct perf_cpu_map *cache_cpus =3D
> +                       read_sysfs_cpu_map("devices/system/cpu/cpu0/cache=
/index3/shared_cpu_list");
> +
> +               snc_nodes =3D perf_cpu_map__nr(cache_cpus) / perf_cpu_map=
__nr(node_cpus);
> +               perf_cpu_map__put(cache_cpus);
> +               perf_cpu_map__put(node_cpus);
> +               checked_snc =3D true;
> +       }
> +       return snc_nodes;
> +}
> +
> +static bool starts_with(const char *str, const char *prefix)
> +{
> +       return !strncmp(prefix, str, strlen(prefix));
> +}
> +
> +static int num_chas(void)
> +{
> +       static bool checked_chas;
> +       static int num_chas;
> +
> +       if (!checked_chas) {
> +               int fd =3D perf_pmu__event_source_devices_fd();
> +               struct io_dir dir;
> +               struct io_dirent64 *dent;
> +
> +               if (fd < 0)
> +                       return -1;
> +
> +               io_dir__init(&dir, fd);
> +
> +               while ((dent =3D io_dir__readdir(&dir)) !=3D NULL) {
> +                       /* Note, dent->d_type will be DT_LNK and so isn't=
 a useful filter. */
> +                       if (starts_with(dent->d_name, "uncore_cha_"))
> +                               num_chas++;
> +               }
> +               close(fd);
> +               checked_chas =3D true;
> +       }
> +       return num_chas;
> +}
> +
> +#define MAX_SNCS 6
> +
> +static int uncore_cha_snc(struct perf_pmu *pmu)
> +{
> +       // CHA SNC numbers are ordered correspond to the CHAs number.
> +       unsigned int cha_num;
> +       int num_cha, chas_per_node, cha_snc;
> +       int snc_nodes =3D snc_nodes_per_l3_cache();
> +
> +       if (snc_nodes <=3D 1)
> +               return 0;
> +
> +       num_cha =3D num_chas();
> +       if (num_cha <=3D 0) {
> +               pr_warning("Unexpected: no CHAs found\n");
> +               return 0;
> +       }
> +
> +       /* Compute SNC for PMU. */
> +       if (sscanf(pmu->name, "uncore_cha_%u", &cha_num) !=3D 1) {
> +               pr_warning("Unexpected: unable to compute CHA number '%s'=
\n", pmu->name);
> +               return 0;
> +       }
> +       chas_per_node =3D num_cha / snc_nodes;
> +       cha_snc =3D cha_num / chas_per_node;
> +
> +       /* Range check cha_snc. for unexpected out of bounds. */
> +       return cha_snc >=3D MAX_SNCS ? 0 : cha_snc;
> +}
> +
> +static int uncore_imc_snc(struct perf_pmu *pmu)
> +{
> +       // Compute the IMC SNC using lookup tables.
> +       unsigned int imc_num;
> +       int snc_nodes =3D snc_nodes_per_l3_cache();
> +       const u8 snc2_map[] =3D {1, 1, 0, 0, 1, 1, 0, 0};
> +       const u8 snc3_map[] =3D {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
> +       const u8 *snc_map;
> +       size_t snc_map_len;
> +
> +       switch (snc_nodes) {
> +       case 2:
> +               snc_map =3D snc2_map;
> +               snc_map_len =3D ARRAY_SIZE(snc2_map);
> +               break;
> +       case 3:
> +               snc_map =3D snc3_map;
> +               snc_map_len =3D ARRAY_SIZE(snc3_map);
> +               break;
> +       default:
> +               /* Error or no lookup support for SNC with >3 nodes. */
> +               return 0;
> +       }
> +
> +       /* Compute SNC for PMU. */
> +       if (sscanf(pmu->name, "uncore_imc_%u", &imc_num) !=3D 1) {
> +               pr_warning("Unexpected: unable to compute IMC number '%s'=
\n", pmu->name);
> +               return 0;
> +       }
> +       if (imc_num >=3D snc_map_len) {
> +               pr_warning("Unexpected IMC %d for SNC%d mapping\n", imc_n=
um, snc_nodes);
> +               return 0;
> +       }
> +       return snc_map[imc_num];
> +}
> +
> +static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
> +{
> +       static bool checked_cpu_adjust[MAX_SNCS];
> +       static int cpu_adjust[MAX_SNCS];
> +       struct perf_cpu_map *node_cpus;
> +       char node_path[] =3D "devices/system/node/node0/cpulist";
> +
> +       /* Was adjust already computed? */
> +       if (checked_cpu_adjust[pmu_snc])
> +               return cpu_adjust[pmu_snc];
> +
> +       /* SNC0 doesn't need an adjust. */
> +       if (pmu_snc =3D=3D 0) {
> +               cpu_adjust[0] =3D 0;
> +               checked_cpu_adjust[0] =3D true;
> +               return 0;
> +       }
> +
> +       /*
> +        * Use NUMA topology to compute first CPU of the NUMA node, we wa=
nt to
> +        * adjust CPU 0 to be this and similarly for other CPUs if there =
is >1
> +        * socket.
> +        */
> +       node_path[24] =3D pmu_snc; // Shift node0 to be node<pmu_snc>.

Sorry I migrated a patch badly and this should be "+=3D", will fix in v2
along with the reference count checker.

Thanks,
Ian

> +       node_cpus =3D read_sysfs_cpu_map(node_path);
> +       cpu_adjust[pmu_snc] =3D perf_cpu_map__cpu(node_cpus, 0).cpu;
> +       checked_cpu_adjust[pmu_snc] =3D true;
> +       perf_cpu_map__put(node_cpus);
> +       return cpu_adjust[pmu_snc];
> +}
> +
> +static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *p=
mu, bool cha)
> +{
> +       // With sub-NUMA clustering (SNC) there is a NUMA node per SNC in=
 the
> +       // topology. For example, a two socket graniterapids machine may =
be set
> +       // up with 3-way SNC meaning there are 6 NUMA nodes that should b=
e
> +       // displayed with --per-node. The cpumask of the CHA and IMC PMUs
> +       // reflects per-socket information meaning, for example, uncore_c=
ha_60
> +       // on a two socket graniterapids machine with 120 cores per socke=
t will
> +       // have a cpumask of "0,120". This cpumask needs adjusting to "40=
,160"
> +       // to reflect that uncore_cha_60 is used for the 2nd SNC of each
> +       // socket. Without the adjustment events on uncore_cha_60 will ap=
pear in
> +       // node 0 and node 3 (in our example 2 socket 3-way set up), but =
with
> +       // the adjustment they will appear in node 1 and node 4. The numb=
er of
> +       // CHAs is typically larger than the number of cores. The CHA num=
bers
> +       // are assumed to split evenly and inorder wrt core numbers. Ther=
e are
> +       // fewer memory IMC PMUs than cores and mapping is handled using =
lookup
> +       // tables.
> +       static struct perf_cpu_map *cha_adjusted[MAX_SNCS];
> +       static struct perf_cpu_map *imc_adjusted[MAX_SNCS];
> +       struct perf_cpu_map **adjusted =3D cha ? cha_adjusted : imc_adjus=
ted;
> +       int idx, pmu_snc, cpu_adjust;
> +       struct perf_cpu cpu;
> +       bool alloc;
> +
> +       // Cpus from the kernel holds first CPU of each socket. e.g. 0,12=
0
> +       assert(perf_cpu_map__cpu(pmu->cpus, 0).cpu =3D=3D 0);
> +
> +       pmu_snc =3D cha ? uncore_cha_snc(pmu) : uncore_imc_snc(pmu);
> +       if (pmu_snc =3D=3D 0) {
> +               // No adjustment necessary for the first SNC.
> +               return;
> +       }
> +
> +       alloc =3D adjusted[pmu_snc] =3D=3D NULL;
> +       if (alloc) {
> +               // Hold onto the perf_cpu_map globally to avoid recomputa=
tion.
> +               cpu_adjust =3D uncore_cha_imc_compute_cpu_adjust(pmu_snc)=
;
> +               adjusted[pmu_snc] =3D perf_cpu_map__empty_new(perf_cpu_ma=
p__nr(pmu->cpus));
> +               if (!adjusted[pmu_snc])
> +                       return;
> +       }
> +
> +       perf_cpu_map__for_each_cpu(cpu, idx, pmu->cpus) {
> +               // Compute the new cpu map values or if not allocating, a=
ssert
> +               // that they match expectations. asserts will be removed =
to
> +               // avoid overhead in NDEBUG builds.
> +               if (alloc) {
> +                       adjusted[pmu_snc]->map[idx].cpu =3D cpu.cpu + cpu=
_adjust;
> +               } else if (idx =3D=3D 0) {
> +                       cpu_adjust =3D perf_cpu_map__cpu(adjusted[pmu_snc=
], idx).cpu - cpu.cpu;
> +                       assert(uncore_cha_imc_compute_cpu_adjust(pmu_snc)=
 =3D=3D cpu_adjust);
> +               } else {
> +                       assert(perf_cpu_map__cpu(adjusted[pmu_snc], idx).=
cpu =3D=3D
> +                              cpu.cpu + cpu_adjust);
> +               }
> +       }
> +
> +       perf_cpu_map__put(pmu->cpus);
> +       pmu->cpus =3D perf_cpu_map__get(adjusted[pmu_snc]);
> +}
>
>  void perf_pmu__arch_init(struct perf_pmu *pmu)
>  {
> @@ -49,10 +291,17 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>
>                 perf_mem_events__loads_ldlat =3D 0;
>                 pmu->mem_events =3D perf_mem_events_amd_ldlat;
> -       } else if (pmu->is_core) {
> -               if (perf_pmu__have_event(pmu, "mem-loads-aux"))
> -                       pmu->mem_events =3D perf_mem_events_intel_aux;
> -               else
> -                       pmu->mem_events =3D perf_mem_events_intel;
> +       } else {
> +               if (pmu->is_core) {
> +                       if (perf_pmu__have_event(pmu, "mem-loads-aux"))
> +                               pmu->mem_events =3D perf_mem_events_intel=
_aux;
> +                       else
> +                               pmu->mem_events =3D perf_mem_events_intel=
;
> +               } else if (x86__is_intel_graniterapids()) {
> +                       if (starts_with(pmu->name, "uncore_cha_"))
> +                               gnr_uncore_cha_imc_adjust_cpumask_for_snc=
(pmu, /*cha=3D*/true);
> +                       else if (starts_with(pmu->name, "uncore_imc_"))
> +                               gnr_uncore_cha_imc_adjust_cpumask_for_snc=
(pmu, /*cha=3D*/false);
> +               }
>         }
>  }
> --
> 2.49.0.1045.g170613ef41-goog
>
