Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61FA2550C7
	for <linux-perf-users@vger.kernel.org>; Thu, 15 May 2025 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328500; cv=none; b=sB1ySj50nO95lApdFRLIpj+9p3d+YKEoUP3ZVUAOmyGoiQQHrimGXjBCvsn9qrRShTdHDGYlqAgFxI4du/AXLkDfKQXLpq9aN2QIr59mRNHWHzxDrjthDBCaQv7bQuLPJZGpi6x0bl7hL/nBrryS9rkd8I8sBhpTPRGWjnPrJTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328500; c=relaxed/simple;
	bh=ZaUuu5sDYE82g5eRtyelATQ3QtWX8/G3oIE0+uijdt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnCw9rA3rzdvDpBI10J3WUHOJlhTPLvQPY8ro4Sk8h4yYjaTzVGogMGVMKu/H1CoxDMuDWvA7B+0gUrEU/cToJM80xITrqkpPdw872jWUplqRc1xd5DGNKsGSBnCp5VVQeW4W3D1mvD5Gn90T0wPcYaXtZ4kh5b8uP3/w4EdJAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xs/ISmvB; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xs/ISmvB"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3da76aea6d5so4395ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 15 May 2025 10:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747328496; x=1747933296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEXxcf8jVezm4hhZlGfp1oOcj9QgfqWp1O8soXS6zp8=;
        b=xs/ISmvBiLW6jhSIKVFQjXxGd+Xl5McvBa2I5A1nBt4P5MVK2kZP6oS+Q0aKVyTTST
         iJDCDZ+PnXH+jbKNMKAhGpEfMU63Dz+i77EgSzF6YCd4TV0ExbKilsKt9ICnBB4KlFvr
         Y2kiVzIlH5BZHjIvrVBWIjWFhGtEOnXVyLWydgjdkD7yHIVWZLYChH7JRd0FAibDdpa6
         5DZ9tEdsyIYfu/2AE0iv4H3hEjPo3LchxLFEnWVT4YKMqjtUIL5YD/pjPYvJNwDn32qI
         TdbKT8cZWNMn171ngxgc5avq3bdmcf4Oj41TQKNauCX5kypb9Dw39eAMC4sFI7GQXNIv
         gW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747328496; x=1747933296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEXxcf8jVezm4hhZlGfp1oOcj9QgfqWp1O8soXS6zp8=;
        b=VIRua0RSc7DxOHVhR9vaje9uDAQ35LihKmr6Xn25qSyixscR0SjXXJTRZRcjIGkLd4
         CNQHjNyO9ZA7ih0CLOItKo21bJfbvhzCcupjgM0nqMRwcSL9e5rvQsKw/E4UROS6MOsQ
         L7cb56EU/enxJkT0DgjKuOz5eXW8T+jnXpcTJwXUuSLIzadmBl+6E9Ns5ULASmWlKUO7
         SG2xZAHKZPdeIv0v2Ttwc55EYuavj7KbR9vtg4ic2bbG2QeEjlhieTEfv9u/1Wjk1PYs
         c/687WcORt7+fg39HJVgQmDJIyOsgpxH/a1OygPFfyZDHulWoinXMflvn6cXFEJcbGwp
         F/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUqKKKXo2NAMhnA1CFhNBNdH2ESQd/dM5wBtAh5ZVps41gT4o2kb4xay64ZaqGCxa+yueJ5WvTwJglF5kZcezXp@vger.kernel.org
X-Gm-Message-State: AOJu0YznFB+nIztAFNC1QhcVKy38GKPmQMv3r1hlcSsnojeGEN84miYD
	SutuNsp9Vly19Eg9wlRHdIW/A1xmickSQdXxSW0XqnpQuCja1u6+9CKNCw+ICms9uSUQBQrw7Cn
	AOriGbYaBbMV6tFupRZcg1z3GoSErFrl1SHrjeDwr
X-Gm-Gg: ASbGncsiYkdqTT93wM2fOT4mta9wbe9BQ4pCiJfu7XpL5tuCYOTTrMbpyURPJqrKa66
	TIuqAYnclFoG0JpazgqXTgLweR3/Idyqd0QxwNq6jJgUHz3i9pDkR/h0keku7LD1h3JkBSpM08B
	FDwS22FF+qnj9pySN9WTorwwq9DVXxBN5N+NpplzWRH6NuLABLU5MjI4Xj901w5A==
X-Google-Smtp-Source: AGHT+IHlnFsWr83+eL7jSyG5VQ49GP19H1yDohnU6rUJ++x3gcGbuMdKHC0HFKgKjm6+nk3PkKXkrhe4iSwVdk6lxrk=
X-Received: by 2002:a05:6e02:2306:b0:3cf:f8c0:417a with SMTP id
 e9e14a558f8ab-3db77f14049mr4476285ab.0.1747328495326; Thu, 15 May 2025
 10:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515043818.236807-1-irogers@google.com> <909e988c-6e7c-4de1-b5b3-d5de119e4f35@linux.intel.com>
In-Reply-To: <909e988c-6e7c-4de1-b5b3-d5de119e4f35@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 15 May 2025 10:01:23 -0700
X-Gm-Features: AX0GCFu6kJCSuPZuCfi9gYV9C4GIihEsiHuC3dZ8IfGachhWZRZBJUOc_jIPW_Q
Message-ID: <CAP-5=fUP=oENY8DFhGt4TFBJzyqbYaFRpj2huaJz4xfDu1GLmg@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmu intel: Adjust cpumaks for sub-NUMA clusters
 on graniterapids
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 9:06=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2025-05-15 12:38 a.m., Ian Rogers wrote:
> > On graniterapids the cache home agent (CHA) and memory controller
> > (IMC) PMUs all have their cpumask set to per-socket information. In
> > order for per NUMA node aggregation to work correctly the PMUs cpumask
> > needs to be set to CPUs for the relevant sub-NUMA grouping.
> >
> > For example, on a 2 socket graniterapids machine with sub NUMA
> > clustering of 3, for uncore_cha and uncore_imc PMUs the cpumask is
> > "0,120" leading to aggregation only on NUMA nodes 0 and 3:
> > ```
> > $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a slee=
p 1
> >
> >  Performance counter stats for 'system wide':
> >
> > N0        1    277,835,681,344      UNC_CHA_CLOCKTICKS
> > N0        1     19,242,894,228      UNC_M_CLOCKTICKS
> > N3        1    277,803,448,124      UNC_CHA_CLOCKTICKS
> > N3        1     19,240,741,498      UNC_M_CLOCKTICKS
> >
> >        1.002113847 seconds time elapsed
> > ```
> >
> > By updating the PMUs cpumasks to "0,120", "40,160" and "80,200" then
> > the correctly 6 NUMA node aggregations are achieved:
> > ```
> > $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a slee=
p 1
> >
> >  Performance counter stats for 'system wide':
> >
> > N0        1     92,748,667,796      UNC_CHA_CLOCKTICKS
> > N0        0      6,424,021,142      UNC_M_CLOCKTICKS
> > N1        0     92,753,504,424      UNC_CHA_CLOCKTICKS
> > N1        1      6,424,308,338      UNC_M_CLOCKTICKS
> > N2        0     92,751,170,084      UNC_CHA_CLOCKTICKS
> > N2        0      6,424,227,402      UNC_M_CLOCKTICKS
> > N3        1     92,745,944,144      UNC_CHA_CLOCKTICKS
> > N3        0      6,423,752,086      UNC_M_CLOCKTICKS
> > N4        0     92,725,793,788      UNC_CHA_CLOCKTICKS
> > N4        1      6,422,393,266      UNC_M_CLOCKTICKS
> > N5        0     92,717,504,388      UNC_CHA_CLOCKTICKS
> > N5        0      6,421,842,618      UNC_M_CLOCKTICKS
> >
> >        1.003406645 seconds time elapsed
> > ```
> >
> > In general, having the perf tool adjust cpumasks isn't desirable as
> > ideally the PMU driver would be advertising the correct cpumask.
> >
>
> Strictly speaking, the information used here is the CHA and IMC topology
> information, not a cpumask.
>
> The cpumask in the uncore driver implies the scope of the PMU. Usually,
> it's the first CPU of each socket/die.

I think it is understandable that things have diverged as previously
socket and NUMA topologies were equivalent. Should cpumasks be
documented like we have for the PMU names:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/Documentation/ABI/testing/sysfs-bus-event_source-devices?h=3Dperf-to=
ols-next
I think without documentation the behavior of the `perf tool` is the
expected use of the file. If the perf tool isn't behaving correctly
then it is a bug in the driver. I see a lot of such bugs, mainly not
on Intel platforms, where the cpumask is missing and then taken by the
perf tool to mean the cpumask is all online CPUs; which is very bad
for uncore devices leading to counts multiplied by the number of CPUs
and multiplexing. I think there is similar confusion over the meaning
of the CPUs in the cpumask. They are the CPUs perf should open an
event on, for uncore you can specify other CPUs and this may be a way
to spread kernel overhead, for core the meaning is different. In the
perf tool implementation we use cpumasks to guide setting the thread
affinity to try to lower the system call overheads. I worry different
people assume different things and then these things start fighting
against each other - such as setting a CPU to try to lower overhead
but instead incurring IPI overheads.

> The topology information discloses how the uncore units connect to the
> HW components, e.g., die, node...
> There should be another interface for it. An example is the UPI topology
> information.
> https://lore.kernel.org/lkml/20221117122833.3103580-7-alexander.antonov@l=
inux.intel.com/
>
> But I think utilizing the cpumask to imply the topology as this patch
> does should be a good idea.

I'm not sure how I'd hook up the topology information. On skylakex for
a UPI device I see:
```
$ ls /sys/devices/uncore_upi_0/
cpumask  die0  die1  format  perf_event_mux_interval_ms  power
subsystem  type  uevent
$ cat /sys/devices/uncore_upi_0/cpumask
0,18
$ cat /sys/devices/uncore_upi_0/die0
upi_1,die_1
$ cat /sys/devices/uncore_upi_0/die1
upi_1,die_0
```
There's work to connect this up with NUMA.

> But I still incline not to add it to the kernel at least for now. Because=
,
> - The current method is based on some assumptions, e.g., the hardware id
> and logical id of Notes and CHAs follow the ascending order. It should
> work for the vast majority of cases. But it's not reliable compared to
> retrieving from a register.
> - Perf tool is more flexible. It can be easily deployed on an old
> environment without the need to update the kernel.
> - The cpumask codes are shared among uncore PMUs in the uncore driver.
> It requires a big refactor to support per uncore PMU specific cpumask.
> It may not be worth doing it only for GNR.
>
> Let's support it in the perf tool x86 code for now. We may move it to
> the uncore driver later once the above items have changed.

Agreed. At least this patch is a proof of concept that doing this
fixes --per-node while keeping --per-socket also working.

> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/x86/util/pmu.c | 259 ++++++++++++++++++++++++++++++++-
> >  1 file changed, 254 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/=
pmu.c
> > index 8712cbbbc712..38c800c6e9c8 100644
> > --- a/tools/perf/arch/x86/util/pmu.c
> > +++ b/tools/perf/arch/x86/util/pmu.c
> > @@ -8,6 +8,8 @@
> >  #include <linux/perf_event.h>
> >  #include <linux/zalloc.h>
> >  #include <api/fs/fs.h>
> > +#include <api/io_dir.h>
> > +#include <internal/cpumap.h>
> >  #include <errno.h>
> >
> >  #include "../../../util/intel-pt.h"
> > @@ -16,7 +18,247 @@
> >  #include "../../../util/fncache.h"
> >  #include "../../../util/pmus.h"
> >  #include "mem-events.h"
> > +#include "util/debug.h"
> >  #include "util/env.h"
> > +#include "util/header.h"
> > +
> > +static bool x86__is_intel_graniterapids(void)
> > +{
> > +     static bool checked_if_graniterapids;
> > +     static bool is_graniterapids;
> > +
> > +     if (!checked_if_graniterapids) {
> > +             const char *graniterapids_cpuid =3D "GenuineIntel-6-A[DE]=
";
> > +             char *cpuid =3D get_cpuid_str((struct perf_cpu){0});
> > +
> > +             is_graniterapids =3D cpuid && strcmp_cpuid_str(graniterap=
ids_cpuid, cpuid) =3D=3D 0;
> > +             free(cpuid);
> > +             checked_if_graniterapids =3D true;
> > +     }
> > +     return is_graniterapids;
> > +}
> > +
> > +static struct perf_cpu_map *read_sysfs_cpu_map(const char *sysfs_path)
> > +{
> > +     struct perf_cpu_map *cpus;
> > +     char *buf =3D NULL;
> > +     size_t buf_len;
> > +
> > +     if (sysfs__read_str(sysfs_path, &buf, &buf_len) < 0)
> > +             return NULL;
> > +
> > +     cpus =3D perf_cpu_map__new(buf);
> > +     free(buf);
> > +     return cpus;
> > +}
> > +
> > +static int snc_nodes_per_l3_cache(void)
> > +{
> > +     static bool checked_snc;
> > +     static int snc_nodes;
> > +
> > +     if (!checked_snc) {
> > +             struct perf_cpu_map *node_cpus =3D
> > +                     read_sysfs_cpu_map("devices/system/node/node0/cpu=
list");
> > +             struct perf_cpu_map *cache_cpus =3D
> > +                     read_sysfs_cpu_map("devices/system/cpu/cpu0/cache=
/index3/shared_cpu_list");
> > +
> > +             snc_nodes =3D perf_cpu_map__nr(cache_cpus) / perf_cpu_map=
__nr(node_cpus);
> > +             perf_cpu_map__put(cache_cpus);
> > +             perf_cpu_map__put(node_cpus);
> > +             checked_snc =3D true;
> > +     }
> > +     return snc_nodes;
> > +}
> > +
> > +static bool starts_with(const char *str, const char *prefix)
> > +{
> > +     return !strncmp(prefix, str, strlen(prefix));
> > +}
> > +
> > +static int num_chas(void)
> > +{
> > +     static bool checked_chas;
> > +     static int num_chas;
> > +
> > +     if (!checked_chas) {
> > +             int fd =3D perf_pmu__event_source_devices_fd();
> > +             struct io_dir dir;
> > +             struct io_dirent64 *dent;
> > +
> > +             if (fd < 0)
> > +                     return -1;
> > +
> > +             io_dir__init(&dir, fd);
> > +
> > +             while ((dent =3D io_dir__readdir(&dir)) !=3D NULL) {
> > +                     /* Note, dent->d_type will be DT_LNK and so isn't=
 a useful filter. */
> > +                     if (starts_with(dent->d_name, "uncore_cha_"))
> > +                             num_chas++;
> > +             }
> > +             close(fd);
> > +             checked_chas =3D true;
> > +     }
> > +     return num_chas;
> > +}
> > +
> > +#define MAX_SNCS 6
> > +
> > +static int uncore_cha_snc(struct perf_pmu *pmu)
> > +{
> > +     // CHA SNC numbers are ordered correspond to the CHAs number.
> > +     unsigned int cha_num;
> > +     int num_cha, chas_per_node, cha_snc;
> > +     int snc_nodes =3D snc_nodes_per_l3_cache();
> > +
> > +     if (snc_nodes <=3D 1)
> > +             return 0;
> > +
> > +     num_cha =3D num_chas();
> > +     if (num_cha <=3D 0) {
> > +             pr_warning("Unexpected: no CHAs found\n");
> > +             return 0;
> > +     }
> > +
> > +     /* Compute SNC for PMU. */
> > +     if (sscanf(pmu->name, "uncore_cha_%u", &cha_num) !=3D 1) {
> > +             pr_warning("Unexpected: unable to compute CHA number '%s'=
\n", pmu->name);
> > +             return 0;
> > +     }
> > +     chas_per_node =3D num_cha / snc_nodes;
> > +     cha_snc =3D cha_num / chas_per_node;
> > +
> > +     /* Range check cha_snc. for unexpected out of bounds. */
> > +     return cha_snc >=3D MAX_SNCS ? 0 : cha_snc;
> > +}
> > +
> > +static int uncore_imc_snc(struct perf_pmu *pmu)
> > +{
> > +     // Compute the IMC SNC using lookup tables.
> > +     unsigned int imc_num;
> > +     int snc_nodes =3D snc_nodes_per_l3_cache();
> > +     const u8 snc2_map[] =3D {1, 1, 0, 0, 1, 1, 0, 0};
> > +     const u8 snc3_map[] =3D {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
> > +     const u8 *snc_map;
> > +     size_t snc_map_len;
> > +
> > +     switch (snc_nodes) {
> > +     case 2:
> > +             snc_map =3D snc2_map;
> > +             snc_map_len =3D ARRAY_SIZE(snc2_map);
> > +             break;
> > +     case 3:
> > +             snc_map =3D snc3_map;
> > +             snc_map_len =3D ARRAY_SIZE(snc3_map);
> > +             break;
> > +     default:
> > +             /* Error or no lookup support for SNC with >3 nodes. */
> > +             return 0;
> > +     }
> > +
> > +     /* Compute SNC for PMU. */
> > +     if (sscanf(pmu->name, "uncore_imc_%u", &imc_num) !=3D 1) {
> > +             pr_warning("Unexpected: unable to compute IMC number '%s'=
\n", pmu->name);
> > +             return 0;
> > +     }
> > +     if (imc_num >=3D snc_map_len) {
> > +             pr_warning("Unexpected IMC %d for SNC%d mapping\n", imc_n=
um, snc_nodes);
> > +             return 0;
> > +     }
> > +     return snc_map[imc_num];
> > +}
> > +
> > +static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
> > +{
> > +     static bool checked_cpu_adjust[MAX_SNCS];
> > +     static int cpu_adjust[MAX_SNCS];
> > +     struct perf_cpu_map *node_cpus;
> > +     char node_path[] =3D "devices/system/node/node0/cpulist";
> > +
> > +     /* Was adjust already computed? */
> > +     if (checked_cpu_adjust[pmu_snc])
> > +             return cpu_adjust[pmu_snc];
> > +
> > +     /* SNC0 doesn't need an adjust. */
> > +     if (pmu_snc =3D=3D 0) {
> > +             cpu_adjust[0] =3D 0;
> > +             checked_cpu_adjust[0] =3D true;
> > +             return 0;
> > +     }
> > +
> > +     /*
> > +      * Use NUMA topology to compute first CPU of the NUMA node, we wa=
nt to
> > +      * adjust CPU 0 to be this and similarly for other CPUs if there =
is >1
> > +      * socket.
> > +      */
> > +     node_path[24] =3D pmu_snc; // Shift node0 to be node<pmu_snc>.
>
> I think scnprintf should be a prefer way to update the idx. E.g.,
>
> #define NODE_PATH       "devices/system/node/node%d/cpulist"
>
> scnprintf(node_path, MAX_PATH, NODE_PATH, pmu_snc);

I'm concerned throughout the code about making things slow when
--per-node isn't a particular common option. Perhaps it will be for
graniterapids. The values of pmu_snc are 0 to 6 so this is sound but I
can cover this with an assert.

>
> > +     node_cpus =3D read_sysfs_cpu_map(node_path);
> > +     cpu_adjust[pmu_snc] =3D perf_cpu_map__cpu(node_cpus, 0).cpu;
> > +     checked_cpu_adjust[pmu_snc] =3D true;
> > +     perf_cpu_map__put(node_cpus);
> > +     return cpu_adjust[pmu_snc];
> > +}
> > +
> > +static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu =
*pmu, bool cha)
> > +{
> > +     // With sub-NUMA clustering (SNC) there is a NUMA node per SNC in=
 the
> > +     // topology. For example, a two socket graniterapids machine may =
be set
> > +     // up with 3-way SNC meaning there are 6 NUMA nodes that should b=
e
> > +     // displayed with --per-node. The cpumask of the CHA and IMC PMUs
> > +     // reflects per-socket information meaning, for example, uncore_c=
ha_60
> > +     // on a two socket graniterapids machine with 120 cores per socke=
t will
> > +     // have a cpumask of "0,120". This cpumask needs adjusting to "40=
,160"
> > +     // to reflect that uncore_cha_60 is used for the 2nd SNC of each
> > +     // socket. Without the adjustment events on uncore_cha_60 will ap=
pear in
> > +     // node 0 and node 3 (in our example 2 socket 3-way set up), but =
with
> > +     // the adjustment they will appear in node 1 and node 4. The numb=
er of
> > +     // CHAs is typically larger than the number of cores. The CHA num=
bers
> > +     // are assumed to split evenly and inorder wrt core numbers. Ther=
e are
> > +     // fewer memory IMC PMUs than cores and mapping is handled using =
lookup
> > +     // tables.
> > +     static struct perf_cpu_map *cha_adjusted[MAX_SNCS];
> > +     static struct perf_cpu_map *imc_adjusted[MAX_SNCS];
> > +     struct perf_cpu_map **adjusted =3D cha ? cha_adjusted : imc_adjus=
ted;
> > +     int idx, pmu_snc, cpu_adjust;
> > +     struct perf_cpu cpu;
> > +     bool alloc;
> > +
> > +     // Cpus from the kernel holds first CPU of each socket. e.g. 0,12=
0
> > +     assert(perf_cpu_map__cpu(pmu->cpus, 0).cpu =3D=3D 0);
>
> Can it just simply return if a non-0 is detected?
> In case, the uncore driver is updated later. This can be treated as a
> fallback solution.

Sure. The assert should fire in non-debug builds and was supposed to
catch if the kernel driver had changed wrt expectations in the code
here. Doing the return seems good as it should mean some level of
compatibility between the perf tool and different kernel driver
versions were the cpumask to change. I'll add it in v3.

Thanks,
Ian

> Thanks,
> Kan> +
> > +     pmu_snc =3D cha ? uncore_cha_snc(pmu) : uncore_imc_snc(pmu);
> > +     if (pmu_snc =3D=3D 0) {
> > +             // No adjustment necessary for the first SNC.
> > +             return;
> > +     }
> > +
> > +     alloc =3D adjusted[pmu_snc] =3D=3D NULL;
> > +     if (alloc) {
> > +             // Hold onto the perf_cpu_map globally to avoid recomputa=
tion.
> > +             cpu_adjust =3D uncore_cha_imc_compute_cpu_adjust(pmu_snc)=
;
> > +             adjusted[pmu_snc] =3D perf_cpu_map__empty_new(perf_cpu_ma=
p__nr(pmu->cpus));
> > +             if (!adjusted[pmu_snc])
> > +                     return;
> > +     }
> > +
> > +     perf_cpu_map__for_each_cpu(cpu, idx, pmu->cpus) {
> > +             // Compute the new cpu map values or if not allocating, a=
ssert
> > +             // that they match expectations. asserts will be removed =
to
> > +             // avoid overhead in NDEBUG builds.
> > +             if (alloc) {
> > +                     adjusted[pmu_snc]->map[idx].cpu =3D cpu.cpu + cpu=
_adjust;
> > +             } else if (idx =3D=3D 0) {
> > +                     cpu_adjust =3D perf_cpu_map__cpu(adjusted[pmu_snc=
], idx).cpu - cpu.cpu;
> > +                     assert(uncore_cha_imc_compute_cpu_adjust(pmu_snc)=
 =3D=3D cpu_adjust);
> > +             } else {
> > +                     assert(perf_cpu_map__cpu(adjusted[pmu_snc], idx).=
cpu =3D=3D
> > +                            cpu.cpu + cpu_adjust);
> > +             }
> > +     }
> > +
> > +     perf_cpu_map__put(pmu->cpus);
> > +     pmu->cpus =3D perf_cpu_map__get(adjusted[pmu_snc]);
> > +}
> >
> >  void perf_pmu__arch_init(struct perf_pmu *pmu)
> >  {
> > @@ -49,10 +291,17 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
> >
> >               perf_mem_events__loads_ldlat =3D 0;
> >               pmu->mem_events =3D perf_mem_events_amd_ldlat;
> > -     } else if (pmu->is_core) {
> > -             if (perf_pmu__have_event(pmu, "mem-loads-aux"))
> > -                     pmu->mem_events =3D perf_mem_events_intel_aux;
> > -             else
> > -                     pmu->mem_events =3D perf_mem_events_intel;
> > +     } else {
> > +             if (pmu->is_core) {
> > +                     if (perf_pmu__have_event(pmu, "mem-loads-aux"))
> > +                             pmu->mem_events =3D perf_mem_events_intel=
_aux;
> > +                     else
> > +                             pmu->mem_events =3D perf_mem_events_intel=
;
> > +             } else if (x86__is_intel_graniterapids()) {
> > +                     if (starts_with(pmu->name, "uncore_cha_"))
> > +                             gnr_uncore_cha_imc_adjust_cpumask_for_snc=
(pmu, /*cha=3D*/true);
> > +                     else if (starts_with(pmu->name, "uncore_imc_"))
> > +                             gnr_uncore_cha_imc_adjust_cpumask_for_snc=
(pmu, /*cha=3D*/false);
> > +             }
> >       }
> >  }
>
