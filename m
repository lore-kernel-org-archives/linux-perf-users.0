Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605EE3264DF
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774463170; cv=pass; b=slUoduU2W3fRPNkWsHBlElY2BS0pGIeX7bmlCcbEKnklEIBdGqFZJe0iNMxomXUBSylzX6rOvDkqAb+nOkZwx7BqLNpTyCunSRphCFd7ffxNhehpv8HibMu6gd/ffjynntboQGLXMaSpLwIC0CkrSiNYd3p9fe2fHvbsIXHr6TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774463170; c=relaxed/simple;
	bh=fA3VTS6HbS9raAOyqVgq5AmlEV1NhdzoHIq4riBKQ2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2lM4chT/L8j4L8O4OkF96weVHUs36J7CWAikY6KErocbR93JTCzl8aWZvsaXqdIagtb7cPuVO4sjbiq/kOzqAjF4vJLSeQKIR/4njCRt5Z1WJd9XS0vzS6SukMVsmPl4BBk//RBXeFAIaF9Y91UGCvRBC+whLsZGXDPuU63LJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=movej8jj; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="movej8jj"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-128ce536fe0so1390c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 11:26:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774463166; cv=none;
        d=google.com; s=arc-20240605;
        b=Jq93kGp7EZZ5LVxg0RgqBzuwaIMa/7QuHNqYyPgyCmxcR/JkkCefDjsHUHlKeJBx15
         QddPu/AQZPG3pfMHz0NlSgY5LwrYVBiNw+1wP+wANXvubt63nvPWTBZTkn/o/o3ERUui
         9fyhQlWLT+6Bx9d0kDGqhHhQ8ChbOvIYt1L30uUL5scoaHmYMQhjF38clowSm2VCgREQ
         niHIZCKQIrFxk+xz9KkrV7Kka3ySBIKyAeFIHEz0p27EUyL40GVEz+CtBdbfdru9GvFi
         aUC2CoVCjfT4bbL/CU9UQYZbYHL/eloipx5f28fj7sS9/WP4ziOHEj+Aai67RfWp+dny
         B9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+Zfnaxe1etiJdBCoB4L7gtblWpxqqKGPqrtf4yXdaVY=;
        fh=kzUuYCqSvhG4akwnELRev2YG7l6K27metUvYXTnbT2M=;
        b=YJ/JgXzVYZB0te1EczocePA86rngkmX25uxem6gHlM0PppYJIJ53A4SyggWWaeSi9R
         QQ1y4EPW3dk+dhkn9GPZOK/iwUClfHqzLxczNPc2SDbY/fGPFuTuqtJjl9cI9pZud7gp
         gK9VfsyGu0sqJTp794kGjoEWY2GELERAlWiXWlV0t3qccSRs9Qjj4AKa8WUIXhocWRsu
         Ufxyjkd5lzu73W9EpyXrb+1ohNkmoJgVAiNDnd9qhhWGAL4wXRZj5u0zmtVjTgczcpL4
         BVd6trLS8ECccAQ9FogUEaKh4x6dE8kLU/gSyH7zM7imTNnmi+ZDidYaAoJRt9eYpdWm
         uYGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774463166; x=1775067966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Zfnaxe1etiJdBCoB4L7gtblWpxqqKGPqrtf4yXdaVY=;
        b=movej8jjKgGVrvgsCwNtYxJB/5FOsM0yAb0jJT5Mcun1FG+YlB/QFif6FgUGyTNxGn
         AenAm2euBxDa/5DC/9NLVYMYvkwzF4Cj1LQz1fsBLjf7OK9SVZhptEycIa5z8E8SnXRN
         7UlbD0rGocTD49bXiOZP2rGUK/njYfXaCvbLQnMGqkXEGqhkZv8qlizQPQs5wZyLdn0t
         Pz7DS9/xfDDtljOoj8hnmf6CIbyl2bWfKfXGXSdm+KceKwb5BtxCcsxi4za47C8j5MVn
         y0vMgZtXxo29OxDbDScBYLbaWqRfeC5Twd22Qtr86G3+HAVj73gzurKr2aexsgR2ZWcW
         5SOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774463166; x=1775067966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Zfnaxe1etiJdBCoB4L7gtblWpxqqKGPqrtf4yXdaVY=;
        b=AztkcomuPCmgOP0HqkhXDybc708QGT2qLcWES4IrQ0rEwdjHx52MkaeYbC6aLM2y9C
         ddoZ26bDUCKDvJ354gRPsQKLelzqTf9gvIuWV9QMdUja7tlfwX2KhcJ1aWvyTElzl9zz
         2eYDI5+gQN9MveN+bOlYYsFXpBhpZIbDD+rXGnEBlO7Y4vQJm1w5W4KnM6zpqYoZOT6J
         e4i7Dc6VuWgI48B4VJaGBUHuVXDlQyGvsHjUopqp9mQ+kJdYZwM+6hylJZvjCynVTLUZ
         1vKdpCskSvw7FkLOmBqXRHM7Mb9JwmJi27MmqE3JCQylrLIv/lYvBtmB7ayWeHtlDZwu
         SkYw==
X-Forwarded-Encrypted: i=1; AJvYcCVIQ7LYEGNqBRogoGwipa7RwefgOxuwQAX9AFKRNhBwbtT4VUJzoOHaMuWAyDQ0iFWzyeQtnZUsb6X7Jp2GTDfx@vger.kernel.org
X-Gm-Message-State: AOJu0YyTaxT39kdhUnNpFWD00KNT12LodqfMkjfsXuLWSHLfTLIJ4MZr
	fVITWlsHegwRm4PGojJ+5P/F/iDWWOQt5VReZAwTvs5TtuYLMnRWMSC1BMu3f91DhqXvb9hVDz9
	yrjk6a73anQGnHvcKUc7D9R9PTkIraGeRdu+xvyB1TIJh+qsnuLTVemx9
X-Gm-Gg: ATEYQzxxbuajqVNSwYSZJKdCycB8MTVJHOtN+KRwAcvYvlGoi1dSumnQNjCQieTA83w
	Role1f4VTLl4Mu/4y25aOt2lpjDMKYLWZW1QBa/OjRKypqX13W63kn3qVV3Ow60zOaP4fP5jr87
	fQQ1LGV6okugk6nhI36UCYq4mKq6b0Ho62QVrHdJWnbcHmQoX+S743lem1U8xi7W63oGMl7tr3g
	KLMMqjWmWupBgnnhK5OzK/FSJsy6A5Lut86F2wBrwV0jpBEuL4PpmqCnc8R3BsaZu5LJJntGM9N
	1NGI1Eeu9lGVEZbSHRzfdA5NQfUPXh2XgPHkyA==
X-Received: by 2002:a05:7022:6606:b0:11a:2c18:9e70 with SMTP id
 a92af1059eb24-12aa946bd16mr395c88.11.1774463165843; Wed, 25 Mar 2026 11:26:05
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325-perf_stat-v2-1-d986ef5b9327@debian.org>
In-Reply-To: <20260325-perf_stat-v2-1-d986ef5b9327@debian.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Mar 2026 11:25:54 -0700
X-Gm-Features: AQROBzAP_hOjRTa73dmwyNb96P8wcP6Kx5vmO06admrQPBvia23ys0HwW1WGXPk
Message-ID: <CAP-5=fWE5d1frE+3CoRshWVPLe_Mmp_LHNcqoVSCdhxGgJXAVw@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Fix crash on arm64
To: Breno Leitao <leitao@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Denis Yaroshevskiy <dyaroshev@meta.com>, Dmitry Ilvokhin <d@ilvokhin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 3:25=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Perf stat is crashing on arm64 hosts with the following issue:
>
>         # make -C tools/perf DEBUG=3D1
>         # perf stat sleep 1
>         perf: util/evsel.c:2034: get_group_fd: Assertion `!(!leader->core=
.fd)' failed.
>         [1]    1220794 IOT instruction (core dumped)  ./perf stat
>
> The sorting function introduced by commit a745c0831c15c ("perf stat:
> Sort default events/metrics") compares events based on their individual
> properties. This can cause events from different groups to be
> interleaved, resulting in group members appearing before their leaders
> in the sorted evlist.
>
> When the iterator opens events in list order, a group member may be
> processed before its leader has been opened.
>
> For example, CPU_CYCLES (idx=3D32) with leader STALL_SLOT_BACKEND (idx=3D=
37)
> could be sorted before its leader, causing the crash when CPU_CYCLES
> tries to get its group fd from the not-yet-opened leader.
>
> Fix this by comparing events based on their leader's attributes instead
> of their own attributes when the events are in different groups. This
> ensures all members of a group share the same sort key as their leader,
> keeping groups together and guaranteeing leaders are opened before their
> members.
>
> Reported-by: Denis Yaroshevskiy <dyaroshev@meta.com>
> Fixes: a745c0831c15c ("perf stat: Sort default events/metrics")
> Tested-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Ah, this is the separate sorting for perf stat output and not the
parse-events sorting. This sorting happens after we've regrouped for
PMUs, etc. and so the invariants I expect shouldn't be broken by the
change. Fwiw, the Intel hybrid sorting isn't impacted:

Before:
```
$ perf stat -a sleep 1

 Performance counter stats for 'system wide':

            22,355      context-switches                 #    792.6
cs/sec  cs_per_second
         28,205.79 msec cpu-clock                        #     27.6
CPUs  CPUs_utilized
               477      cpu-migrations                   #     16.9
migrations/sec  migrations_per_second
               294      page-faults                      #     10.4
faults/sec  page_faults_per_second
         1,796,969      cpu_core/branch-misses/          #      2.0 %
branch_miss_rate
        90,819,614      cpu_core/branches/               #      3.2
M/sec  branch_frequency
       465,688,306      cpu_core/cpu-cycles/             #      0.0
GHz  cycles_frequency
       435,799,882      cpu_core/instructions/           #      0.9
instructions  insn_per_cycle
         2,239,373      cpu_atom/branch-misses/          #      4.6 %
branch_miss_rate         (49.78%)
        48,356,802      cpu_atom/branches/               #      1.7
M/sec  branch_frequency     (50.17%)
       477,205,378      cpu_atom/cpu-cycles/             #      0.0
GHz  cycles_frequency       (50.37%)
       236,677,090      cpu_atom/instructions/           #      0.5
instructions  insn_per_cycle  (50.35%)
             TopdownL1 (cpu_core)                        #      7.1 %
tma_bad_speculation
                                                         #     40.2 %
tma_frontend_bound
                                                         #     35.7 %
tma_backend_bound
                                                         #     17.1 %
tma_retiring
             TopdownL1 (cpu_atom)                        #     32.7 %
tma_backend_bound        (59.74%)
                                                         #     37.8 %
tma_frontend_bound       (59.54%)
                                                         #     17.2 %
tma_bad_speculation
                                                         #     12.3 %
tma_retiring             (59.62%)

       1.006767726 seconds time elapsed
```

After:
```
$ perf stat -a sleep 1

 Performance counter stats for 'system wide':

            21,329      context-switches                 #    758.5
cs/sec  cs_per_second
         28,120.76 msec cpu-clock                        #     27.7
CPUs  CPUs_utilized
               482      cpu-migrations                   #     17.1
migrations/sec  migrations_per_second
               217      page-faults                      #      7.7
faults/sec  page_faults_per_second
         1,606,877      cpu_core/branch-misses/          #      1.8 %
branch_miss_rate
        90,472,412      cpu_core/branches/               #      3.2
M/sec  branch_frequency
       459,566,033      cpu_core/cpu-cycles/             #      0.0
GHz  cycles_frequency
       482,577,042      cpu_core/instructions/           #      1.1
instructions  insn_per_cycle
         2,430,046      cpu_atom/branch-misses/          #      7.0 %
branch_miss_rate         (49.85%)
        35,031,345      cpu_atom/branches/               #      1.2
M/sec  branch_frequency     (50.20%)
       494,493,558      cpu_atom/cpu-cycles/             #      0.0
GHz  cycles_frequency       (50.22%)
       190,397,854      cpu_atom/instructions/           #      0.4
instructions  insn_per_cycle  (50.24%)
             TopdownL1 (cpu_core)                        #      6.6 %
tma_bad_speculation
                                                         #     35.9 %
tma_frontend_bound
                                                         #     38.2 %
tma_backend_bound
                                                         #     19.3 %
tma_retiring
             TopdownL1 (cpu_atom)                        #     30.2 %
tma_backend_bound        (59.74%)
                                                         #     38.8 %
tma_frontend_bound       (59.71%)
                                                         #     21.7 %
tma_bad_speculation
                                                         #      9.3 %
tma_retiring             (59.68%)

       1.005096844 seconds time elapsed
```

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian


> ---
> Cc; linux-arm-kernel@lists.infradead.org
> ---
> Changes in v2:
> - No changes from V1, just resending the exact same patch.
> - Link to v1: https://patch.msgid.link/20260205-perf_stat-v1-1-e433b0c918=
af@debian.org
> ---
>  tools/perf/builtin-stat.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 73c2ba7e30760..a97b9d0de3f58 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1917,25 +1917,33 @@ static int default_evlist_evsel_cmp(void *priv __=
maybe_unused,
>         const struct evsel *lhs =3D container_of(lhs_core, struct evsel, =
core);
>         const struct perf_evsel *rhs_core =3D container_of(r, struct perf=
_evsel, node);
>         const struct evsel *rhs =3D container_of(rhs_core, struct evsel, =
core);
> +       const struct evsel *lhs_leader =3D evsel__leader(lhs);
> +       const struct evsel *rhs_leader =3D evsel__leader(rhs);
>
> -       if (evsel__leader(lhs) =3D=3D evsel__leader(rhs)) {
> +       if (lhs_leader =3D=3D rhs_leader) {
>                 /* Within the same group, respect the original order. */
>                 return lhs_core->idx - rhs_core->idx;
>         }
>
> +       /*
> +        * Compare using leader's attributes so that all members of a gro=
up
> +        * stay together. This ensures leaders are opened before their me=
mbers.
> +        */
> +
>         /* Sort default metrics evsels first, and default show events bef=
ore those. */
> -       if (lhs->default_metricgroup !=3D rhs->default_metricgroup)
> -               return lhs->default_metricgroup ? -1 : 1;
> +       if (lhs_leader->default_metricgroup !=3D rhs_leader->default_metr=
icgroup)
> +               return lhs_leader->default_metricgroup ? -1 : 1;
>
> -       if (lhs->default_show_events !=3D rhs->default_show_events)
> -               return lhs->default_show_events ? -1 : 1;
> +       if (lhs_leader->default_show_events !=3D rhs_leader->default_show=
_events)
> +               return lhs_leader->default_show_events ? -1 : 1;
>
>         /* Sort by PMU type (prefers legacy types first). */
> -       if (lhs->pmu !=3D rhs->pmu)
> -               return lhs->pmu->type - rhs->pmu->type;
> +       if (lhs_leader->pmu !=3D rhs_leader->pmu)
> +               return lhs_leader->pmu->type - rhs_leader->pmu->type;
>
> -       /* Sort by name. */
> -       return strcmp(evsel__name((struct evsel *)lhs), evsel__name((stru=
ct evsel *)rhs));
> +       /* Sort by leader's name. */
> +       return strcmp(evsel__name((struct evsel *)lhs_leader),
> +                     evsel__name((struct evsel *)rhs_leader));
>  }
>
>  /*
>
> ---
> base-commit: 85964cdcad0fac9a0eb7b87a0f9d88cc074b854c
> change-id: 20260205-perf_stat-a0a2a37e21c5
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>
