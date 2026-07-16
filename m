Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA3E15A864
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 03:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784171761; cv=pass; b=TDIPTjElZLiL9nbc/ViDB1u6lYA5qxpVq5CM+In2j19DLEzXGhpFDeeoYZVeQNhs6VXXJaerguXBVE4YyUEf35vaKl0y8fv5WL3gMKMmuih/Lqyu/Ckq7bW4Q7ZLgelmQ7M5jxY83V/M8nkO97V8i7BzPpPnwaHv4EiZSLFo/oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784171761; c=relaxed/simple;
	bh=KlfdTkVZR+yWmKlWm5EgI2tj2WONiX0ecXlBu6SiaAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtLqK5eKTF6ZfS7KUKGgiygBZMuimf8+bnlIvrosA+2dOYtGb1NnpBMnBffHKf6jsbSyE+B2eSZYQ1l7aP4d1wTkrgoasYE2TcxBCpL42KgHBnMd2ctjAm9LQgDBGxELZq7lT+uh+ZEmfvWr5FQa/ydRcmWCGKH7suqg2sNsjo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uVWH12RV; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uVWH12RV"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cacef7d299so40465ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 20:15:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784171759; cv=none;
        d=google.com; s=arc-20260327;
        b=G0dJeOYlTvWklCeFIaIbtmz8o3NEV7RRhiB9gFvSpNy0k/YntHY4G+VnNhgx6eGsKl
         wQ27LP/7KPv+nwqQhBp1EI3MU6qI8rus93FFe8IDnbPUH9ZJF7W0DZulHnP89XxnhAHl
         AKkNx/veFYz1wPcPZfZ84xixEsZPV/W//1xBGDOICJoGG1lVMOy6PkaK+XBTHmjt8ptc
         h9+3FhS8izwmHYgo4GDN0f0wwA3dvO6Rjk3crTtIic663lZCMaM1698roBB42VBwU2dV
         lWb/AbvkykGxi/hJN50SiH9uo3HbfUVU1kYzXB+PYZVTZ1FYgmfWlbcz1enI83ZI5J19
         cvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SPvoGXB1qk7uNOdy9A8bM8LHf/Lhh9Szpco8G55HbaI=;
        fh=8lVcCIZ8g6+Xd8VnIgQuqPK2hZjGjqeqe9jxemiuUI0=;
        b=fsz4PTTgY3ED/AwpF88Ao7kP5zu9sjvw+WlkulEh5WGzpioRhY2N+1j+u8daF9luQt
         Z8a2p8VyVlK6Nal095PBKSof/AKZ7j4flO8Z9aptC05RlW2mqPbZF9j5+sqjQ7juW9sz
         XY0lYWrOAdx+nbIiTNM2dF77rDYMte/qBYKCycK7XSt83g0hfHvHVMzdMHDJiOrAgMiV
         K1+NRHttSkov+KfKmJoMPxVnAD/pELF4yrzcIZEwq/Tzcr7yJsjdbLYOr9oAb+rO9x2k
         QTVOqEqMB3mNQS13lqBVp3Mt0SZdeYsXjokD2Svq88ZLzS32rYbtB3hteVVd3RAUgdwT
         Sgwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784171759; x=1784776559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SPvoGXB1qk7uNOdy9A8bM8LHf/Lhh9Szpco8G55HbaI=;
        b=uVWH12RVDPdN6746JlexZaetFhSjp08tGDXJb6cRLqs0F4oiy9p2lfHRDj+npfmhX+
         F6d7c2S5Ny07aunEdm27mc0hLvhdOMml28B7qGUHFMCW+pMcdR+729JW3ReSJ9AwzI7G
         N2OyuVaNKHA0UuZpYYx2KV0O3/P25uNCPqdE1a4PmpfxQX69eKKI5NwOZTXqgjwHvkq2
         R/3FONlpjpfxtM+FloQ86XjlOrPI8UsYW41upTdRHkq7QPdWpanpTClcRTwWojFq6Mil
         gLhmTKBoJFNV9BDsOG1rbxpPOf/IfMDOPeaUrf+iBsrl3n+ZPqlHrk9/Gpsl9368j0Nw
         CdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784171759; x=1784776559;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SPvoGXB1qk7uNOdy9A8bM8LHf/Lhh9Szpco8G55HbaI=;
        b=EB/IC+k4QVCP3L3V3T48inqJIg4ZACw0swyQFp/4tYVPPuyfNlZ+rEW0igYyE3uHDW
         u43e/FWGalEPK0SCr1l2IzFj1rL/eIMwmTo21Q5lIHninU1BPs89gXvIKEJaCS+Blbyl
         lbWqbz9HFOSmZLRCdpKNVmLwRwXRELaFAj3A9rWKlPhm8hpaksnXe1JjZX843blPD2eb
         sW3+MhNMHLL5izXi5NRh91wb/NelzTGDxvu/MC3+OKkTwO2mQNCiMmTBfFbdQCtd6nVH
         R+0kef1nvuDxOUXXiFlxJWwNfBq87CTbPn0OjJ+6GCEZ1YF/lV1bTpYDH3svgrkT58wd
         iqlA==
X-Forwarded-Encrypted: i=1; AHgh+RqldMfxoAAlXD2htw1Hxo5R/e/Vq8WlhzY7Ve4JmPR4AB2ogGgvG5qb9f5crwVHDkIPk1ofzwSlCTlo0v8VCYcY@vger.kernel.org
X-Gm-Message-State: AOJu0YwPJ6MJ7FcRB3e0BsmUW6kdDKCv2Vm3NJgFRoR2W+rzrRBnRexh
	1LHg0fdCNsv+mekb105i4OUMAqI0llIrCnA0MZtUEMWW85RbkDLiAiNyEWkMN2h3aPLOucR1rkv
	5kg/7ne+Gd7G4BZXS9vJ2rarw9S8CrAdLy7Htm46M
X-Gm-Gg: AfdE7cm7W8oPsORrmTjqxtZ9/SxSOnGslKDPQLu1NbiChMYgTepH7+k07RzS/HhdFPW
	xjZFE0/RQ3WalQsrvQIv1/5Ef+suLs4nS3MJrsA5UZPSonoiV7cjXmXRNMQuBrWFvg0UKKGylw8
	brp3+dszStsamDHI4sdq6Yw0EYhMq8XMrjwaj96T8/OZNlhh/WMjdj7ck88PiLmHOopQzv5LR2M
	7zwvGHKRhSJ6zJEToIjwTagMzByHacE7+EmEqGYLxO76X/kYjajd2jLQRA1+kU=
X-Received: by 2002:a17:902:e78f:b0:2b7:b03d:9dce with SMTP id
 d9443c01a7336-2cf1a6c3ba5mr1887855ad.18.1784171758316; Wed, 15 Jul 2026
 20:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715203055.2981363-1-ctshao@google.com>
In-Reply-To: <20260715203055.2981363-1-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 Jul 2026 20:15:46 -0700
X-Gm-Features: AUfX_mzrTa1de065kr3pqOvUlRkhELzkXZE1qAcSxT33ZZyJrcxQvdNQZSIobkQ
Message-ID: <CAP-5=fWByxhcT0RY_NgXeFADEg4zUiWBbBrEHXMLV3pjqAQ97Q@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Include PMU name and split uncore events
 per PMU in metric-only JSON output
To: Chun-Tse Shao <ctshao@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 1:30=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> When running `perf stat` with `-A` (--no-aggr) and `--metric-only` in
> JSON output mode (`-j`), `perf stat` evaluates metric expressions
> across all matching PMUs (including uncore PMUs like `uncore_iio_0`,
> `uncore_iio_1`, etc.).
>
> However, `perf stat` previously formatted JSON output by printing only
> "cpu" : "<id>" and grouping all metric values on a single line per CPU
> without identifying which PMU instance evaluated each metric. As a
> result, when an uncore event spans multiple PMU boxes, `perf stat`
> printed repeated, ambiguous metric keys without PMU names.
>
> Fix this by:
> 1. Including "pmu" : "<pmu_name>" in print_aggr_id_json when evsel->pmu
>    is a non-core or hybrid PMU in AGGR_NONE mode (-A).
> 2. Starting a new JSON metric line in AGGR_NONE mode (-A) whenever the
>    underlying PMU instance changes across PMU events.
> 3. Updating perf_json_output_lint.py to recognize the new "pmu" key in
>    the JSON test suite.
>
> Example output:
>   $ perf stat -M iio_bandwidth_read -a -A --metric-only -j -I 1000
>   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_0", "MB/s  =
iio_bandwidth_read" : "0.0"}
>   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_1", "MB/s  =
iio_bandwidth_read" : "0.1"}
>   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_11", "MB/s =
 iio_bandwidth_read" : "0.0"}
>   ...
>   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_0", "MB/s =
 iio_bandwidth_read" : "0.0"}
>   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_1", "MB/s =
 iio_bandwidth_read" : "0.0"}
>   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_11", "MB/s=
  iio_bandwidth_read" : "0.0"}
>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> Assisted-by: Gemini:gemini-3.1-pro-preview

Reviewed-by: Ian Rogers <irogers@google.com>

Nit: It may be nice to include the before output (i.e., without the
PMU showing that differentiation isn't possible) in the commit
message.

Thanks,
Ian

> ---
>
> v2:
>   - Fix print_metric_begin() initialization in print_no_aggr_metric()
>     to ensure tool events always open lines cleanly.
>   - Simplify and fix PMU line-split transition tracking when switching
>     between different PMU instances or transitioning from tool events.
>   - Add bounds check on aggr_map index in print_no_aggr_metric() to
>     prevent out-of-bounds array reads if sysfs CPU topology is incomplete=
.
>
> v1: lore.kernel.org/20260714174052.1826692-1-ctshao@google.com
>
>  .../tests/shell/lib/perf_json_output_lint.py  |  1 +
>  tools/perf/util/stat-display.c                | 48 ++++++++++++++-----
>  2 files changed, 37 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/=
perf/tests/shell/lib/perf_json_output_lint.py
> index dafbde56cc76..36767905fcdb 100644
> --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> @@ -64,6 +64,7 @@ def check_json_output(expected_items):
>        'metric-threshold': lambda x: x in ['unknown', 'good', 'less good'=
, 'nearly bad', 'bad'],
>        'metricgroup': lambda x: True,
>        'node': lambda x: True,
> +      'pmu': lambda x: True,
>        'pcnt-running': lambda x: isfloat(x),
>        'socket': lambda x: True,
>        'thread': lambda x: True,
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index f94f1324d24a..61d634f8be2e 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -397,6 +397,8 @@ static void print_aggr_id_json(struct perf_stat_confi=
g *config, struct outstate
>                         json_out(os, "\"cpu\" : \"%d\"",
>                                 id.cpu.cpu);
>                 }
> +               if (evsel && evsel->pmu && (!evsel->pmu->is_core || evsel=
__is_hybrid(evsel)))
> +                       json_out(os, "\"pmu\" : \"%s\"", evsel->pmu->name=
);
>                 break;
>         case AGGR_THREAD:
>                 json_out(os, "\"thread\" : \"%s-%d\"",
> @@ -1009,11 +1011,12 @@ static void print_counter_aggrdata(struct perf_st=
at_config *config,
>
>  static void print_metric_begin(struct perf_stat_config *config,
>                                struct evlist *evlist,
> -                              struct outstate *os, int aggr_idx)
> +                              struct outstate *os, int aggr_idx,
> +                              struct evsel *counter)
>  {
>         struct perf_stat_aggr *aggr;
>         struct aggr_cpu_id id;
> -       struct evsel *evsel;
> +       struct evsel *evsel =3D counter ?: evlist__first(evlist);
>
>         os->first =3D true;
>         if (!config->metric_only)
> @@ -1028,7 +1031,6 @@ static void print_metric_begin(struct perf_stat_con=
fig *config,
>                 else
>                         fprintf(config->output, "%s", os->timestamp);
>         }
> -       evsel =3D evlist__first(evlist);
>         id =3D config->aggr_map->map[aggr_idx];
>         aggr =3D &evsel->stats->aggr[aggr_idx];
>         aggr_printout(config, os, evsel, id, aggr->nr);
> @@ -1066,7 +1068,7 @@ static void print_aggr(struct perf_stat_config *con=
fig,
>          * Without each counter has its own line.
>          */
>         cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
> -               print_metric_begin(config, evlist, os, aggr_idx);
> +               print_metric_begin(config, evlist, os, aggr_idx, NULL);
>
>                 evlist__for_each_entry(evlist, counter) {
>                         print_counter_aggrdata(config, counter, aggr_idx,=
 os);
> @@ -1092,7 +1094,7 @@ static void print_aggr_cgroup(struct perf_stat_conf=
ig *config,
>                 os->cgrp =3D evsel->cgrp;
>
>                 cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
> -                       print_metric_begin(config, evlist, os, aggr_idx);
> +                       print_metric_begin(config, evlist, os, aggr_idx, =
NULL);
>
>                         evlist__for_each_entry(evlist, counter) {
>                                 if (counter->cgrp !=3D os->cgrp)
> @@ -1128,7 +1130,8 @@ static void print_no_aggr_metric(struct perf_stat_c=
onfig *config,
>
>         perf_cpu_map__for_each_cpu(cpu, all_idx, evlist__core(evlist)->us=
er_requested_cpus) {
>                 struct evsel *counter;
> -               bool first =3D true;
> +               struct perf_pmu *last_pmu =3D NULL;
> +               bool line_open =3D false;
>
>                 evlist__for_each_entry(evlist, counter) {
>                         u64 ena, run, val;
> @@ -1143,13 +1146,34 @@ static void print_no_aggr_metric(struct perf_stat=
_config *config,
>                                 if (config->aggr_map->map[aggr_idx].cpu.c=
pu =3D=3D cpu.cpu)
>                                         break;
>                         }
> +                       if (aggr_idx >=3D config->aggr_map->nr)
> +                               continue;
>
>                         os->evsel =3D counter;
>                         os->id =3D aggr_cpu_id__cpu(cpu, /*data=3D*/NULL)=
;
> -                       if (first) {
> -                               print_metric_begin(config, evlist, os, ag=
gr_idx);
> -                               first =3D false;
> +
> +                       if (config->metric_only) {
> +                               struct perf_pmu *pmu =3D counter->pmu;
> +
> +                               if (!evsel__is_tool(counter)) {
> +                                       if (config->json_output && line_o=
pen &&
> +                                           (!last_pmu || pmu !=3D last_p=
mu)) {
> +                                               print_metric_end(config, =
os);
> +                                               line_open =3D false;
> +                                       }
> +                                       if (!line_open) {
> +                                               print_metric_begin(config=
, evlist, os,
> +                                                                  aggr_i=
dx, counter);
> +                                               line_open =3D true;
> +                                       }
> +                                       last_pmu =3D pmu;
> +                               } else if (!line_open) {
> +                                       print_metric_begin(config, evlist=
, os,
> +                                                          aggr_idx, coun=
ter);
> +                                       line_open =3D true;
> +                               }
>                         }
> +
>                         val =3D ps->aggr[aggr_idx].counts.val;
>                         ena =3D ps->aggr[aggr_idx].counts.ena;
>                         run =3D ps->aggr[aggr_idx].counts.run;
> @@ -1157,7 +1181,7 @@ static void print_no_aggr_metric(struct perf_stat_c=
onfig *config,
>                         uval =3D val * counter->scale;
>                         printout(config, os, uval, run, ena, 1.0, aggr_id=
x);
>                 }
> -               if (!first)
> +               if (line_open)
>                         print_metric_end(config, os);
>         }
>  }
> @@ -1520,7 +1544,7 @@ static void print_cgroup_counter(struct perf_stat_c=
onfig *config, struct evlist
>                                 print_metric_end(config, os);
>
>                         os->cgrp =3D counter->cgrp;
> -                       print_metric_begin(config, evlist, os, /*aggr_idx=
=3D*/0);
> +                       print_metric_begin(config, evlist, os, /*aggr_idx=
=3D*/0, NULL);
>                 }
>
>                 print_counter(config, counter, os);
> @@ -1570,7 +1594,7 @@ void evlist__print_counters(struct evlist *evlist, =
struct perf_stat_config *conf
>                 } else if (config->cgroup_list) {
>                         print_cgroup_counter(config, evlist, &os);
>                 } else {
> -                       print_metric_begin(config, evlist, &os, /*aggr_id=
x=3D*/0);
> +                       print_metric_begin(config, evlist, &os, /*aggr_id=
x=3D*/0, NULL);
>                         evlist__for_each_entry(evlist, counter) {
>                                 print_counter(config, counter, &os);
>                         }
> --
> 2.55.0.141.g00534a21ce-goog
>
