From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf top for arm64?
Date: Tue, 10 Dec 2019 17:36:55 +0100
Message-ID: <20191210163655.GG14123@krava>
References: <1573045254-39833-1-git-send-email-john.garry@huawei.com>
 <20191106140036.GA6259@kernel.org>
 <418023e7-a50d-cb6f-989f-2e6d114ce5d8@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <418023e7-a50d-cb6f-989f-2e6d114ce5d8@huawei.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, namhyung@kernel.org, mark.rutland@arm.com, will@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linuxarm <linuxarm@huawei.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Tue, Dec 10, 2019 at 04:13:49PM +0000, John Garry wrote:
> Hi all,
>=20
> I find to my surprise that "perf top" does not work for arm64:
>=20
> root@ubuntu:/home/john/linux# tools/perf/perf top
> Couldn't read the cpuid for this machine: No such file or directory

there was recent change that check on cpuid and quits:
  608127f73779 perf top: Initialize perf_env->cpuid, needed by the per arch=
 annotation init routine

Arnaldo,
maybe this should be just a warning/info, because it seems to be related
to annotations only..?

get_cpuid is defined only for s390/x86/powerpc, so I guess it won't work
on the rest as well

jirka

>=20
> That's v5.5-rc1 release.
>=20
> It seems that we are just missing an arm64 version of get_cpuid() - with =
the
> patch below, I now get as hoped:
>=20
>    PerfTop:   32857 irqs/sec  kernel:85.0%  exact:  0.0% lost: 0/0 drop: =
0/0
> [4000Hz cycles],  (all, 64 CPUs)
> -------------------------------------------------------------------------=
------
>=20
>      8.99%  [kernel]          [k] arm_smmu_cmdq_issue_cmdlist
>      5.80%  [kernel]          [k] __softirqentry_text_start
>      4.49%  [kernel]          [k] _raw_spin_unlock_irqrestore
>      3.48%  [kernel]          [k] el0_svc_common.constprop.2
>      3.37%  [kernel]          [k] _raw_write_lock_irqsave
>      3.28%  [kernel]          [k] __local_bh_enable_ip
>      3.05%  [kernel]          [k] __blk_complete_request
>      2.07%  [kernel]          [k] queued_spin_lock_slowpath
>      1.93%  [vdso]            [.] 0x0000000000000484
>=20
>=20
> Was this just missed? Or is there a good reason to omit?
>=20
> Thanks,
> John
>=20
> --->8---
>=20
> Subject: [PATCH] perf: Add perf top support for arm64
>=20
> Copied from get_cpuid_str() essentially...
>=20
> Signed-off-by: John Garry <john.garry@huawei.com>
>=20
> diff --git a/tools/perf/arch/arm64/util/header.c
> b/tools/perf/arch/arm64/util/header.c
> index a32e4b72a98f..ecd1f86e29cc 100644
> --- a/tools/perf/arch/arm64/util/header.c
> +++ b/tools/perf/arch/arm64/util/header.c
> @@ -1,10 +1,12 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <perf/cpumap.h>
> +#include <util/cpumap.h>
>  #include <internal/cpumap.h>
>  #include <api/fs/fs.h>
>  #include "debug.h"
>  #include "header.h"
> +#include <errno.h>
>=20
>  #define MIDR "/regs/identification/midr_el1"
>  #define MIDR_SIZE 19
> @@ -12,6 +14,59 @@
>  #define MIDR_VARIANT_SHIFT      20
>  #define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)
>=20
> +int
> +get_cpuid(char *buffer, size_t sz)
> +{
> +=09char *buf =3D NULL;
> +=09char path[PATH_MAX];
> +=09const char *sysfs =3D sysfs__mountpoint();
> +=09int cpu;
> +=09u64 midr =3D 0;
> +=09FILE *file;
> +
> +=09if (!sysfs)
> +=09=09return EINVAL;
> +
> +=09buf =3D malloc(MIDR_SIZE);
> +=09if (!buf)
> +=09=09return EINVAL;
> +
> +=09/* read midr from list of cpus mapped to this pmu */
> +=09for (cpu =3D 0; cpu < cpu__max_present_cpu(); cpu++) {
> +=09=09scnprintf(path, sz, "%s/devices/system/cpu/cpu%d"MIDR,
> +=09=09=09=09sysfs, cpu);
> +
> +=09=09file =3D fopen(path, "r");
> +=09=09if (!file) {
> +=09=09=09pr_debug("fopen failed for file %s\n", path);
> +=09=09=09continue;
> +=09=09}
> +
> +=09=09if (!fgets(buf, MIDR_SIZE, file)) {
> +=09=09=09fclose(file);
> +=09=09=09continue;
> +=09=09}
> +=09=09fclose(file);
> +
> +=09=09/* Ignore/clear Variant[23:20] and
> +=09=09 * Revision[3:0] of MIDR
> +=09=09 */
> +=09=09midr =3D strtoul(buf, NULL, 16);
> +=09=09midr &=3D (~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK));
> +=09=09scnprintf(buffer, MIDR_SIZE, "0x%016lx", midr);
> +=09=09/* got midr break loop */
> +=09=09break;
> +=09}
> +
> +=09if (!midr) {
> +=09=09pr_err("failed to get cpuid string\n");
> +=09=09free(buf);
> +=09=09return EINVAL;
> +=09}
> +=09return 0;
> +}
> +
>=20
