Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4598D21127D
	for <linux-perf-users@vger.kernel.org>; Thu,  1 May 2025 20:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746129666; cv=none; b=G7Ux3OD9KF1Pawg+FjFlUvXlQNa+41SntkBp/tvJ/dHPRQCrL2YvfZzjTEGlnALPj+Q2dxUztLp7PPNgsT4OB/2HIiEnzYcOaRiJsksRHCFX5Tx1WIuglEgd+OTaDtK5ZbAsN3FH70T+AYkPoEGm0rHglui8dzzh2Eu0ie36uCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746129666; c=relaxed/simple;
	bh=nT7irAcoMOVxGb/NBWDrICmDUO4Fi9T4Q/+UPfHwJHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gF3tdJhqoPf24j1xPXIUs1Xu2MkiWJ3mp/9F68Pv2goKShDoEPAMOumCylXgO65+src1tECAnAVQjohVixxxynumwH4LMk1JF8WY4VW9JpRHN1bmj9BexKxPiftVvbYei2rrjsBCWpqff/qgnLYDcTcZgd5Rckcp9oM7LV9O8bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E87/lPnX; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E87/lPnX"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d44cb27ef4so3205ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 May 2025 13:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746129664; x=1746734464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbGNADYFS0ijgDCzvqqK/aLm8mIJOEH7Kfr1J76MSj0=;
        b=E87/lPnX3+rbB+FJMoRpALb/cruAjVJKF+oW+MVXFDCva6odULkpVLd3XPaLaG3q5r
         jlfOJEkhBbSjrlRj/BjueR1+puyxVNLeorrQh7XyJjqjfyNG98O19973PfJIS8uIylac
         kmk+I0cUGtacvIR7WtywtMHldI7IwkR390TeEQNvVfgYZGcPQCNF/bENIIM1WHPF/WMG
         qKgx8HItSEMPimv/KilJPez2ZD3UW1Zsyg4ufF2PSJjupSaceEDcj1dWuqTTJl5MJzhy
         XlyAMk0AYyJ3+zE7T5yl+RbuUzJwAp8tnvtphnBWy8qmqBVbD3ICllyV7V/I3LrxQtBV
         ABSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746129664; x=1746734464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbGNADYFS0ijgDCzvqqK/aLm8mIJOEH7Kfr1J76MSj0=;
        b=Zy4UvTP4KZu+0H8+9sp42t4wtdjtXLRBl9+k8Z41e2sDuXQ+Z2N3zPpeNE6JpNP9P6
         1gCuYMQ2aaHmwC1OihwilrTnRRHE+EA6L9N4juClD1vbT2jeIZT8OrJC+ShWn57gCeLN
         3nxB1KPieqTFjkJCBTHuutWDz5XhZEkQYL9rox5MeGQ4oEMCSdoOBOZD0PY6p4yWbdbK
         i24ulB0H6kWiZivpL6YCGRW/ninOxGik0qrQzldJ0U39CRYyNUqEs2siU+R1QZzn2nHx
         MP5A0nBTUDIJQUktQZENH0u+103ceaiIiz4rRg/DWf6Yu/+W1LwQwJlnqyJh5ybz6q43
         slYw==
X-Forwarded-Encrypted: i=1; AJvYcCWx0IcUDTaZo1z3e8OTWXMp5yoTqEacBxKP/jKvXlig1R2jX1VIj7NmedDEDwleZbk4/E6ULckAAPk7hbLvY+jo@vger.kernel.org
X-Gm-Message-State: AOJu0YyC4Pw0szwEoI1SASfJJvwMGWihCxFmcYWd7BZbJZbnpxpRmHgP
	bxC0/RuIfYSS3LwKp2AOeRV6Zjo5VvjXLIBwXgpbHW8EOT7iO8iYNGK0JBHKrWqaiIJbaQsdupY
	NJKTqwNZMMP2Tr/Ai5tT/QDWDmfUODMznbUGTKBGS63DgH82BKqXVvouaXw==
X-Gm-Gg: ASbGncsILDSVBGREIMyNHlnkU8VAAYwpxAIIwA+IdrIbTMfovnX/qZSwSLypgfcP8Qh
	IXfMYZCEc+3h22QVDpzaz6b1ygtquZVjqNmr+Y2Qp+Q/kTmwpQrqzXX3dzp+abDpNxu3Q6CUf9v
	ZB2xE8ETVTCS4FKntYHsLVVMYrEgi96XCtGCS598hdzNQ01ho8Je0=
X-Google-Smtp-Source: AGHT+IGqKuhWOTauNjNyIlB24t+gYyxpSL6jy+DSqXmrJ9FLRCU+opH/3b7S5WP3C6dqiPo9MDbBzzSXY5lRDYWOmj0=
X-Received: by 2002:a05:6e02:1f85:b0:3cf:f8c0:417a with SMTP id
 e9e14a558f8ab-3d96f1464a4mr5191135ab.0.1746129663955; Thu, 01 May 2025
 13:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501184143.873536-1-thomas.falcon@intel.com>
In-Reply-To: <20250501184143.873536-1-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 May 2025 13:00:52 -0700
X-Gm-Features: ATxdqUE5xfxc7WcplfFQMIyTj7qjV2GnFDv3a4A_FPaFhgm8Z5dnRUBvdn2vWbE
Message-ID: <CAP-5=fXorDgm-oJS9kC6cxCEvS9-Gz5Uh_5V4MtzCYV3pXAxCA@mail.gmail.com>
Subject: Re: [PATCH] perf top: populate PMU capabilities data in perf_env
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 11:42=E2=80=AFAM Thomas Falcon <thomas.falcon@intel.=
com> wrote:
>
> Calling perf top with brach filters enabled on Intel hybrid CPU's
> with branch counter event logging support results in a segfault.
>
> $ ./perf top -e '{cpu_core/cpu-cycles/,cpu_core/event=3D0xc6,umask=3D0x3,=
\
>         frontend=3D0x11,name=3Dfrontend_retired_dsb_miss/}' -j any,counte=
r
> perf: Segmentation fault
> -------- backtrace --------
> ./perf() [0x55f460]
> /lib64/libc.so.6(+0x1a050) [0x7fd8be227050]
> ./perf() [0x57b4a7]
> ./perf() [0x561e5a]
> ./perf() [0x604a81]
> ./perf() [0x4395b5]
> ./perf() [0x601732]
> ./perf() [0x439bc1]
> ./perf() [0x5d35b3]
> ./perf() [0x43936c]
> /lib64/libc.so.6(+0x70ba8) [0x7fd8be27dba8]
> /lib64/libc.so.6(+0xf4b8c) [0x7fd8be301b8c]

Thanks Thomas. Could you generate this backtrace in GDB? I did write a
patch to symbolize backtraces like this:
https://lore.kernel.org/lkml/20250313052952.871958-2-irogers@google.com/
Sadly without any reviewed tags and unmerged - the code calls routines
that malloc so it isn't strictly sound if say the backtrace was needed
from a SEGV in the malloc implementation, it is nicely
self-referencing the perf APIs, ..

> The cause is that perf_env__find_br_cntr_info tries to access a
> null pointer pmu_caps in the perf_env struct. Presumably this would
> also be an issue when using the cpu_pmu_caps structure available for
> homogeneous core CPU's.

I'm a little confused in the top code, we have the global perf_env
being used and one in the session:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/builtin-top.c?h=3Dperf-tools-next#n649
```
ret =3D evlist__tui_browse_hists(top->evlist, help, &hbt, top->min_percent,
      &top->session->header.env, !top->record_opts.overwrite);
```
and the global perf_env:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/builtin-top.c?h=3Dperf-tools-next#n1641
```
status =3D perf_env__read_cpuid(&perf_env);
```

I kind of wish we didn't have the global one as what's the deal with
ownership with it.

> Fix this by populating cpu_pmu_caps and pmu_caps structures with
> values from sysfs when calling perf top with branch stack sampling
> enabled.

I wonder if we could encounter similar problems from say a perf script
handling live data and so some kind of lazy initialization should be
employed. It is hard to say without seeing the backtrace.

Thanks,
Ian

> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
>  tools/perf/builtin-top.c |   8 +++
>  tools/perf/util/env.c    | 114 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/env.h    |   1 +
>  3 files changed, 123 insertions(+)
>
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 1061f4eebc3f..c2688e4ef3c4 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1729,6 +1729,14 @@ int cmd_top(int argc, const char **argv)
>         if (opts->branch_stack && callchain_param.enabled)
>                 symbol_conf.show_branchflag_count =3D true;
>
> +       if (opts->branch_stack) {
> +               status =3D perf_env__read_core_pmu_caps(&perf_env);
> +               if (status) {
> +                       pr_err("PMU capability data is not available\n");
> +                       goto out_delete_evlist;
> +               }
> +       }
> +
>         sort__mode =3D SORT_MODE__TOP;
>         /* display thread wants entries to be collapsed in a different tr=
ee */
>         perf_hpp_list.need_collapse =3D 1;
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 36411749e007..37ed6dc52cf3 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -416,6 +416,120 @@ static int perf_env__read_nr_cpus_avail(struct perf=
_env *env)
>         return env->nr_cpus_avail ? 0 : -ENOENT;
>  }
>
> +static int __perf_env__read_core_pmu_caps(struct perf_pmu *pmu,
> +                                         int *nr_caps, char ***caps,
> +                                         unsigned int *max_branches,
> +                                         unsigned int *br_cntr_nr,
> +                                         unsigned int *br_cntr_width)
> +{
> +       struct perf_pmu_caps *pcaps =3D NULL;
> +       char *ptr, **tmp;
> +       int ret =3D 0;
> +
> +       *nr_caps =3D 0;
> +       *caps =3D NULL;
> +
> +       if (!pmu->nr_caps)
> +               return 0;
> +
> +       *caps =3D zalloc(sizeof(char *) * pmu->nr_caps);
> +       if (!*caps)
> +               return -ENOMEM;
> +
> +       tmp =3D *caps;
> +       list_for_each_entry(pcaps, &pmu->caps, list) {
> +
> +               if (asprintf(&ptr, "%s=3D%s", pcaps->name, pcaps->value) =
< 0) {
> +                       ret =3D -ENOMEM;
> +                       goto error;
> +               }
> +
> +               *tmp++ =3D ptr;
> +
> +               if (!strcmp(pcaps->name, "branches"))
> +                       *max_branches =3D atoi(pcaps->value);
> +
> +               if (!strcmp(pcaps->name, "branch_counter_nr"))
> +                       *br_cntr_nr =3D atoi(pcaps->value);
> +
> +               if (!strcmp(pcaps->name, "branch_counter_width"))
> +                       *br_cntr_width =3D atoi(pcaps->value);
> +       }
> +       *nr_caps =3D pmu->nr_caps;
> +       return 0;
> +error:
> +       while (tmp-- !=3D *caps)
> +               free(*tmp);
> +       free(*caps);
> +       *caps =3D NULL;
> +       *nr_caps =3D 0;
> +       return ret;
> +}
> +
> +int perf_env__read_core_pmu_caps(struct perf_env *env)
> +{
> +       struct perf_pmu *pmu =3D NULL;
> +       struct pmu_caps *pmu_caps;
> +       int nr_pmu =3D 0, i =3D 0, j;
> +       int ret;
> +
> +       nr_pmu =3D perf_pmus__num_core_pmus();
> +
> +       if (!nr_pmu)
> +               return -ENODEV;
> +
> +       if (nr_pmu =3D=3D 1) {
> +               pmu =3D perf_pmus__scan_core(NULL);
> +               if (!pmu)
> +                       return -ENODEV;
> +               ret =3D perf_pmu__caps_parse(pmu);
> +               if (ret < 0)
> +                       return ret;
> +               return __perf_env__read_core_pmu_caps(pmu, &env->nr_cpu_p=
mu_caps,
> +                                                     &env->cpu_pmu_caps,
> +                                                     &env->max_branches,
> +                                                     &env->br_cntr_nr,
> +                                                     &env->br_cntr_width=
);
> +       }
> +
> +       pmu_caps =3D zalloc(sizeof(*pmu_caps) * nr_pmu);
> +       if (!pmu_caps)
> +               return -ENOMEM;
> +
> +       while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
> +               if (perf_pmu__caps_parse(pmu) <=3D 0)
> +                       continue;
> +               ret =3D __perf_env__read_core_pmu_caps(pmu, &pmu_caps[i].=
nr_caps,
> +                                                    &pmu_caps[i].caps,
> +                                                    &pmu_caps[i].max_bra=
nches,
> +                                                    &pmu_caps[i].br_cntr=
_nr,
> +                                                    &pmu_caps[i].br_cntr=
_width);
> +               if (ret)
> +                       goto error;
> +
> +               pmu_caps[i].pmu_name =3D strdup(pmu->name);
> +               if (!pmu_caps[i].pmu_name) {
> +                       ret =3D -ENOMEM;
> +                       goto error;
> +               }
> +               i++;
> +       }
> +
> +       env->nr_pmus_with_caps =3D nr_pmu;
> +       env->pmu_caps =3D pmu_caps;
> +
> +       return 0;
> +error:
> +       for (i =3D 0; i < nr_pmu; i++) {
> +               for (j =3D 0; j < pmu_caps[i].nr_caps; j++)
> +                       free(pmu_caps[i].caps[j]);
> +               free(pmu_caps[i].caps);
> +               free(pmu_caps[i].pmu_name);
> +       }
> +       free(pmu_caps);
> +       return ret;
> +}
> +
>  const char *perf_env__raw_arch(struct perf_env *env)
>  {
>         return env && !perf_env__read_arch(env) ? env->arch : "unknown";
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index d90e343cf1fa..135a1f714905 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -152,6 +152,7 @@ struct btf_node;
>
>  extern struct perf_env perf_env;
>
> +int perf_env__read_core_pmu_caps(struct perf_env *env);
>  void perf_env__exit(struct perf_env *env);
>
>  int perf_env__kernel_is_64_bit(struct perf_env *env);
> --
> 2.49.0
>
