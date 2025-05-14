Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF2219341F
	for <linux-perf-users@vger.kernel.org>; Wed, 14 May 2025 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235181; cv=none; b=AzRuqG26Iy5kxr1hPgOmtD5rz5sF2gPsaIx/im6qF3j3PdDtWBoHCXyeZgGbkD7rvpGWRPUJOUyuvG147h4Z1RucHSzIUbEEg3n7lDxpqUxDs1jvYebO6P5xhr3qDltTuk59RShWAmeNbgbWqJMVXijVJuPjCym+rQsBVMs3Vs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235181; c=relaxed/simple;
	bh=uddiBXfns1jrDxqIWdz/fdoSDUXWaACGKfK72ZuQznc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTWweChQ1cjm21cCoI7gmtuXpZ8UKXq8hYQb+BlAiEkVNLiT+kkAKrYFMyaIQyNBgY63Wuqrt5Aub9ljlT3r/QhiXQJZqbM2x3GHPxP40pyphycvfepTq9G3DcaVOZXz97+Cx+DQdKVHanaiMYbzT6s7I44HK5Ei9m8mWokI6d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=le7V90Ug; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="le7V90Ug"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d8c4222fc9so217735ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 May 2025 08:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747235179; x=1747839979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkgzUkfXCmvedHmU6BaHjndw0jKFFaalNvQaxBYipdo=;
        b=le7V90UgXwRIaJGTWK2PBc7fpFSb5pkxf5lRWXzm8DyBgo7xsSHUnPfWfljpquZ5l0
         SyAW81kJdmW5jbuvywX/wF2AC3n+ObdApR4RDpL+9nzWzco44xJHZCfUq8tI/oqlBp69
         TAB/nhSr/Df7dDh8oxe6WlFM7fudxumcNJu+VXuocw76TfbT3lPYtWTshVU8tWbkPlSc
         3mtHAqf1UOEU1X2B0YFZpS09ZA5vt0JLFjtwTWkc6gj7Ir0X+aKDRosh8hzc/1qQcxSo
         8CISVvsntSRhhmtAQd6l6gF1OnJsvWsYmQBTYys4X7+Cw/qW2KeejHA1JGXwjNWxHhOp
         WhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747235179; x=1747839979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkgzUkfXCmvedHmU6BaHjndw0jKFFaalNvQaxBYipdo=;
        b=mV6QlbYHC203886hun6W8Xsjr+I1a5wiUeiERed+XqgNpFwgFSzzNfXOyOEsAfkbbH
         8fZe1yHq64VqDnVGE8tzHjarMm9Xup9tms3OZ1lJO1eVIDWLMFvZJrQAvlPSDawQu9RE
         yPmOBFGVfVrlrV+uJgIwk6SMn+DZSdw3l5KnJRH8RTx0q74y8X4mS+GErFdbcEhEac/m
         7wOTp48H2Er0l9e+XpaLxAp4LYBeFRLFwujFakW3AmA+vGYstubdVendD76MIagi3tm2
         H3+d9mtLWk9n935NruOezlJJ6zMLL1It6SUBlQO+kR98mExb5LzbGuIlF0jqHudKkLxD
         QwlA==
X-Forwarded-Encrypted: i=1; AJvYcCXGaKxZ4p7JcOHl/9IK9ptZhCUzRSxbp0JibYQqPVWgU9ZPoQKfsCrNikn7Ku3lVeurIMZaemA+CjJZJm4HCAid@vger.kernel.org
X-Gm-Message-State: AOJu0YzF3sKF7FMqmhMqGiqmIzbbwqVeXS8NWEhYBgIJWwNxnp0DSHpL
	QDLtdSiEOJ8rSHixfbm7/FRWvd01qLuPJdR/Vdny7E0CW968C9RdwyAER/JakeLf9lR+isc841m
	AVzEtyMS5Jqouw6uw3E3MY514I2FXk44G1KwIyUWl
X-Gm-Gg: ASbGncsMi5/28fdK5fvesgrhUUQVCPzz8VbZzXyLTsfEBjxexEbRxlA0641czuMQGJ1
	JsS8b6wVzagmuS+VO7/KEk7p461vEcA08uT/lm69CcS9DWYJEp22U4yfdtfPVH+oHzg6ztvejmA
	8jOQPQDcgPx63GuBIpSZMGkCRafAQCqCDq8jyH7D5WZQijeooN9rdFqOuY80J7Ew==
X-Google-Smtp-Source: AGHT+IFVNC6+3emavSjEwwxvgiMd5+5fL/dKB9q1qMGe6V19QRWkIIrih1F3GExB9MeYQmzV+V3NXxfgz51SwQ4M1ag=
X-Received: by 2002:a05:6e02:1d98:b0:3d5:c583:221e with SMTP id
 e9e14a558f8ab-3db70650740mr3358415ab.19.1747235178588; Wed, 14 May 2025
 08:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513231813.13846-1-thomas.falcon@intel.com> <20250513231813.13846-2-thomas.falcon@intel.com>
In-Reply-To: <20250513231813.13846-2-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 May 2025 08:06:07 -0700
X-Gm-Features: AX0GCFt8eT-mW6DTfDoyxMz7aTn-ldsnwPc2eo_7KXt5LfpWOmXmwTd3diYbguY
Message-ID: <CAP-5=fU+8OdM+9jH_dKPiZJqyTJUdQcS-Hh3ynoYwocRw2RDLw@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] perf top: populate PMU capabilities data in perf_env
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 4:18=E2=80=AFPM Thomas Falcon <thomas.falcon@intel.=
com> wrote:
>
> Calling perf top with branch filters enabled on Intel CPU's
> with branch counters logging (A.K.A LBR event logging [1]) support
> results in a segfault.
>
> Thread 27 "perf" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7fffafff76c0 (LWP 949003)]
> perf_env__find_br_cntr_info (env=3D0xf66dc0 <perf_env>, nr=3D0x0, width=
=3D0x7fffafff62c0) at util/env.c:653
> 653                     *width =3D env->cpu_pmu_caps ? env->br_cntr_width=
 :
> (gdb) bt
>  #0  perf_env__find_br_cntr_info (env=3D0xf66dc0 <perf_env>, nr=3D0x0, wi=
dth=3D0x7fffafff62c0) at util/env.c:653
>  #1  0x00000000005b1599 in symbol__account_br_cntr (branch=3D0x7fffcc3db5=
80, evsel=3D0xfea2d0, offset=3D12, br_cntr=3D8) at util/annotate.c:345
>  #2  0x00000000005b17fb in symbol__account_cycles (addr=3D5658172, start=
=3D5658160, sym=3D0x7fffcc0ee420, cycles=3D539, evsel=3D0xfea2d0, br_cntr=
=3D8) at util/annotate.c:389
>  #3  0x00000000005b1976 in addr_map_symbol__account_cycles (ams=3D0x7fffc=
d7b01d0, start=3D0x7fffcd7b02b0, cycles=3D539, evsel=3D0xfea2d0, br_cntr=3D=
8) at util/annotate.c:422
>  #4  0x000000000068d57f in hist__account_cycles (bs=3D0x110d288, al=3D0x7=
fffafff6540, sample=3D0x7fffafff6760, nonany_branch_mode=3Dfalse, total_cyc=
les=3D0x0, evsel=3D0xfea2d0) at util/hist.c:2850
>  #5  0x0000000000446216 in hist_iter__top_callback (iter=3D0x7fffafff6590=
, al=3D0x7fffafff6540, single=3Dtrue, arg=3D0x7fffffff9e00) at builtin-top.=
c:737
>  #6  0x0000000000689787 in hist_entry_iter__add (iter=3D0x7fffafff6590, a=
l=3D0x7fffafff6540, max_stack_depth=3D127, arg=3D0x7fffffff9e00) at util/hi=
st.c:1359
>  #7  0x0000000000446710 in perf_event__process_sample (tool=3D0x7fffffff9=
e00, event=3D0x110d250, evsel=3D0xfea2d0, sample=3D0x7fffafff6760, machine=
=3D0x108c968) at builtin-top.c:845
>  #8  0x0000000000447735 in deliver_event (qe=3D0x7fffffffa120, qevent=3D0=
x10fc200) at builtin-top.c:1211
>  #9  0x000000000064ccae in do_flush (oe=3D0x7fffffffa120, show_progress=
=3Dfalse) at util/ordered-events.c:245
>  #10 0x000000000064d005 in __ordered_events__flush (oe=3D0x7fffffffa120, =
how=3DOE_FLUSH__TOP, timestamp=3D0) at util/ordered-events.c:324
>  #11 0x000000000064d0ef in ordered_events__flush (oe=3D0x7fffffffa120, ho=
w=3DOE_FLUSH__TOP) at util/ordered-events.c:342
>  #12 0x00000000004472a9 in process_thread (arg=3D0x7fffffff9e00) at built=
in-top.c:1120
>  #13 0x00007ffff6e7dba8 in start_thread (arg=3D<optimized out>) at pthrea=
d_create.c:448
>  #14 0x00007ffff6f01b8c in __GI___clone3 () at ../sysdeps/unix/sysv/linux=
/x86_64/clone3.S:78
>
> The cause is that perf_env__find_br_cntr_info tries to access a
> null pointer pmu_caps in the perf_env struct. A similar issue exists
> for homogeneous core systems which use the cpu_pmu_caps structure.
>
> Fix this by populating cpu_pmu_caps and pmu_caps structures with
> values from sysfs when calling perf top with branch stack sampling
> enabled.
>
> [1], LBR event logging introduced here:
> https://lore.kernel.org/all/20231025201626.3000228-5-kan.liang@linux.inte=
l.com/
>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
> v3: constify struct perf_pmu *pmu in __perf_env__read_core_pmu_caps()
>     use perf_pmus__find_core_pmu() instead of perf_pmus__scan_core(NULL)
>
> v2: update commit message with more meaningful stack trace from
>     gdb and indicate that affected systems are limited to CPU's
>     with LBR event logging support and that both hybrid and
>     non-hybrid core systems are affected.
> ---
>  tools/perf/builtin-top.c |   8 +++
>  tools/perf/util/env.c    | 114 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/env.h    |   1 +
>  3 files changed, 123 insertions(+)
>
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index f9f31391bddb..c9d679410591 100644
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
> index 36411749e007..6735786a1d22 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -416,6 +416,120 @@ static int perf_env__read_nr_cpus_avail(struct perf=
_env *env)
>         return env->nr_cpus_avail ? 0 : -ENOENT;
>  }
>
> +static int __perf_env__read_core_pmu_caps(const struct perf_pmu *pmu,
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
> +               pmu =3D perf_pmus__find_core_pmu();
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
