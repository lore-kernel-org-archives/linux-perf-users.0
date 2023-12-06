Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wTdUuk6k"
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A54ED5F
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 13:01:26 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bf09be81bso175e87.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 13:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701896484; x=1702501284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTMXuJCEqJHPLeXHn67bXo6PdSm/hRexkrXp0Gjs9Qo=;
        b=wTdUuk6k9qP/kYQesLiOVFwqMAWXAynKzdPdwtKWR2TzBo0OzNtjs7uz8rMp6rhcjZ
         nvFI2CXIPISpwdBu0fKSg3Trqh9g4bYsog2GLjZFXGq9ABrzcTy+gN7EBekPhDsLEZNg
         rQ+U9HOJm7bY7+UwHT1O/685+uh1QMgQpBU+u+N7gvQZBbXplWXNCSnov5pSJM6skCX6
         Fpv9Wx3lYYUC3EOlzosuUBhGEkWbElyvyP9rrOyh4bUbaexuFWrnydzFxT/FwYXhKiQM
         kbrlTcUM/XNQx3f9ATGOgUu5UZhqGlH9G/XWTCSACJZ2o+q5pnwwUtTm068mEp9m6/oo
         r4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896484; x=1702501284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTMXuJCEqJHPLeXHn67bXo6PdSm/hRexkrXp0Gjs9Qo=;
        b=bVZvoSk71/x621YYrwD4aRVQbhjE9aI4jaB3Sas2YTnSGwl/pC2VJR2/tGrz7jbXAQ
         tNnYA8ljLeRNV1OjHVUlid5Vd5tn3EyT2ihqkEItXVsPSaB+fvEFdLSv8ptu24aY5IU9
         8qTKClAxFRMUszJatCgXwn9Jsm8ipjPhZVXLX1LmC3B5IbWTGV+GtfhCeOJF4JiUpRXf
         JSVK7qVNPs9bQfMhKz1O87BBTi+q2hYR5FGRc/mn73uktdo8h2SwwAf0Wuk7GEvA3aUz
         o2K/WopYLo3MhXX6DPxl7VOjbV7eISNfdf8KF+UeUA6po38T49tPLprrULpbFiqXvFT+
         T4JQ==
X-Gm-Message-State: AOJu0YyJlEyJgOSKHB8YLljL3IOkEF8BsB/pUDCcJ4OcJlyBJyOmPK7J
	WvSA1JbJoapmwJLKz3a3AmkiCD4fB9ppdR9WL2Ih6w==
X-Google-Smtp-Source: AGHT+IFhw3nzwc7N4hOSx4Ms83EqUqIgbK+VAvDT2QBLn7SOyO4tGTAOakXgIdsTy6PZYygQYPnrKSis5reQJ4O6iLU=
X-Received: by 2002:a05:6512:e81:b0:50b:ea5c:2823 with SMTP id
 bi1-20020a0565120e8100b0050bea5c2823mr91354lfb.2.1701896483955; Wed, 06 Dec
 2023 13:01:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206201324.184059-1-kan.liang@linux.intel.com> <20231206201324.184059-2-kan.liang@linux.intel.com>
In-Reply-To: <20231206201324.184059-2-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 6 Dec 2023 13:01:12 -0800
Message-ID: <CAP-5=fWD9EVHxR+2KE5JPGw_-+rDUbFVE04LNK+n1b3Mo53jqw@mail.gmail.com>
Subject: Re: [PATCH 1/6] perf mem: Add mem_events into the supported perf_pmu
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com, 
	mike.leach@linaro.org, leo.yan@linaro.org, yuhaixin.yhx@linux.alibaba.com, 
	renyu.zj@linux.alibaba.com, tmricht@linux.ibm.com, ravi.bangoria@amd.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 12:13=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> With the mem_events, perf doesn't need to read sysfs for each PMU to
> find the mem-events-supported PMU. The patch also makes it possible to
> clean up the related __weak functions later.
>
> The patch is only to add the mem_events into the perf_pmu for all ARCHs.
> It will be used in the later cleanup patches.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/arch/arm64/util/mem-events.c | 4 ++--
>  tools/perf/arch/arm64/util/mem-events.h | 7 +++++++
>  tools/perf/arch/arm64/util/pmu.c        | 6 ++++++
>  tools/perf/arch/s390/util/pmu.c         | 3 +++
>  tools/perf/arch/x86/util/mem-events.c   | 4 ++--
>  tools/perf/arch/x86/util/mem-events.h   | 9 +++++++++
>  tools/perf/arch/x86/util/pmu.c          | 7 +++++++
>  tools/perf/util/mem-events.c            | 2 +-
>  tools/perf/util/mem-events.h            | 1 +
>  tools/perf/util/pmu.c                   | 4 +++-
>  tools/perf/util/pmu.h                   | 7 +++++++
>  11 files changed, 48 insertions(+), 6 deletions(-)
>  create mode 100644 tools/perf/arch/arm64/util/mem-events.h
>  create mode 100644 tools/perf/arch/x86/util/mem-events.h
>
> diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/ar=
m64/util/mem-events.c
> index 3bcc5c7035c2..aaa4804922b4 100644
> --- a/tools/perf/arch/arm64/util/mem-events.c
> +++ b/tools/perf/arch/arm64/util/mem-events.c
> @@ -4,7 +4,7 @@
>
>  #define E(t, n, s) { .tag =3D t, .name =3D n, .sysfs_name =3D s }
>
> -static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] =3D {
> +struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] =3D {
>         E("spe-load",   "arm_spe_0/ts_enable=3D1,pa_enable=3D1,load_filte=
r=3D1,store_filter=3D0,min_latency=3D%u/",       "arm_spe_0"),
>         E("spe-store",  "arm_spe_0/ts_enable=3D1,pa_enable=3D1,load_filte=
r=3D0,store_filter=3D1/",                      "arm_spe_0"),
>         E("spe-ldst",   "arm_spe_0/ts_enable=3D1,pa_enable=3D1,load_filte=
r=3D1,store_filter=3D1,min_latency=3D%u/",       "arm_spe_0"),
> @@ -17,7 +17,7 @@ struct perf_mem_event *perf_mem_events__ptr(int i)
>         if (i >=3D PERF_MEM_EVENTS__MAX)
>                 return NULL;
>
> -       return &perf_mem_events[i];
> +       return &perf_mem_events_arm[i];
>  }
>
>  const char *perf_mem_events__name(int i, const char *pmu_name __maybe_un=
used)
> diff --git a/tools/perf/arch/arm64/util/mem-events.h b/tools/perf/arch/ar=
m64/util/mem-events.h
> new file mode 100644
> index 000000000000..5fc50be4be38
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/mem-events.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ARM64_MEM_EVENTS_H
> +#define _ARM64_MEM_EVENTS_H
> +
> +extern struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX];
> +
> +#endif /* _ARM64_MEM_EVENTS_H */
> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/uti=
l/pmu.c
> index 2a4eab2d160e..69673fcf4a61 100644
> --- a/tools/perf/arch/arm64/util/pmu.c
> +++ b/tools/perf/arch/arm64/util/pmu.c
> @@ -8,6 +8,12 @@
>  #include <api/fs/fs.h>
>  #include <math.h>
>
> +void perf_pmu__arch_init(struct perf_pmu *pmu)
> +{
> +       if (strcmp(pmu->name, "arm_spe_0"))
> +               pmu->mem_events =3D perf_mem_events_arm;
> +}
> +
>  const struct pmu_metrics_table *pmu_metrics_table__find(void)
>  {
>         struct perf_pmu *pmu;
> diff --git a/tools/perf/arch/s390/util/pmu.c b/tools/perf/arch/s390/util/=
pmu.c
> index 886c30e001fa..225d7dc2379c 100644
> --- a/tools/perf/arch/s390/util/pmu.c
> +++ b/tools/perf/arch/s390/util/pmu.c
> @@ -19,4 +19,7 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>             !strcmp(pmu->name, S390_PMUPAI_EXT) ||
>             !strcmp(pmu->name, S390_PMUCPUM_CF))
>                 pmu->selectable =3D true;
> +
> +       if (pmu->is_core)
> +               pmu->mem_events =3D perf_mem_events;
>  }
> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/=
util/mem-events.c
> index 191b372f9a2d..2b81d229982c 100644
> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -16,13 +16,13 @@ static char mem_stores_name[100];
>
>  #define E(t, n, s) { .tag =3D t, .name =3D n, .sysfs_name =3D s }
>
> -static struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX]=
 =3D {
> +struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX] =3D {
>         E("ldlat-loads",        "%s/mem-loads,ldlat=3D%u/P",      "%s/eve=
nts/mem-loads"),
>         E("ldlat-stores",       "%s/mem-stores/P",              "%s/event=
s/mem-stores"),
>         E(NULL,                 NULL,                           NULL),
>  };
>
> -static struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] =
=3D {
> +struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] =3D {
>         E(NULL,         NULL,           NULL),
>         E(NULL,         NULL,           NULL),
>         E("mem-ldst",   "ibs_op//",     "ibs_op"),
> diff --git a/tools/perf/arch/x86/util/mem-events.h b/tools/perf/arch/x86/=
util/mem-events.h
> new file mode 100644
> index 000000000000..3959e427f482
> --- /dev/null
> +++ b/tools/perf/arch/x86/util/mem-events.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _X86_MEM_EVENTS_H
> +#define _X86_MEM_EVENTS_H
> +
> +extern struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX]=
;
> +
> +extern struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX];
> +
> +#endif /* _X86_MEM_EVENTS_H */
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pm=
u.c
> index 469555ae9b3c..7e69f4f2e363 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -15,6 +15,7 @@
>  #include "../../../util/pmu.h"
>  #include "../../../util/fncache.h"
>  #include "../../../util/pmus.h"
> +#include "mem-events.h"
>  #include "env.h"
>
>  void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
> @@ -30,6 +31,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_=
unused)
>                 pmu->selectable =3D true;
>         }
>  #endif
> +
> +       if (x86__is_amd_cpu()) {
> +               if (strcmp(pmu->name, "ibs_op"))
> +                       pmu->mem_events =3D perf_mem_events_amd;
> +       } else if (pmu->is_core)
> +               pmu->mem_events =3D perf_mem_events_intel;
>  }
>
>  int perf_pmus__num_mem_pmus(void)
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 3a2e3687878c..0a8f415f5efe 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -19,7 +19,7 @@ unsigned int perf_mem_events__loads_ldlat =3D 30;
>
>  #define E(t, n, s) { .tag =3D t, .name =3D n, .sysfs_name =3D s }
>
> -static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] =3D {
> +struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] =3D {
>         E("ldlat-loads",        "cpu/mem-loads,ldlat=3D%u/P",     "cpu/ev=
ents/mem-loads"),
>         E("ldlat-stores",       "cpu/mem-stores/P",             "cpu/even=
ts/mem-stores"),
>         E(NULL,                 NULL,                           NULL),
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index b40ad6ea93fc..8c5694b2d0b0 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -34,6 +34,7 @@ enum {
>  };
>
>  extern unsigned int perf_mem_events__loads_ldlat;
> +extern struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX];
>
>  int perf_mem_events__parse(const char *str);
>  int perf_mem_events__init(void);
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 3c9609944a2f..3d4373b8ab63 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -986,8 +986,10 @@ static int pmu_max_precise(int dirfd, struct perf_pm=
u *pmu)
>  }
>
>  void __weak
> -perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
> +perf_pmu__arch_init(struct perf_pmu *pmu)
>  {
> +       if (pmu->is_core)
> +               pmu->mem_events =3D perf_mem_events;
>  }
>
>  struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, con=
st char *name)
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 424c3fee0949..e35d985206db 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -10,6 +10,8 @@
>  #include <stdio.h>
>  #include "parse-events.h"
>  #include "pmu-events/pmu-events.h"
> +#include "map_symbol.h"

nit: unused?

> +#include "mem-events.h"
>
>  struct evsel_config_term;
>  struct perf_cpu_map;
> @@ -162,6 +164,11 @@ struct perf_pmu {
>                  */
>                 bool exclude_guest;
>         } missing_features;
> +
> +       /**
> +        * @mem_events: List of the supported mem events
> +        */
> +       struct perf_mem_event *mem_events;
>  };
>
>  /** @perf_pmu__fake: A special global PMU used for testing. */
> --
> 2.35.1
>
