Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182CE15D1
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Oct 2024 04:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730348245; cv=none; b=sAQq1wMIOdgHqdEiN/6mEXkf3Txacxo1iRhDCagKwB4oBgtLi3Y5G0zZriSWdEpOuj+Yv5M1+XxUdBdJ1HG2DGz9/KPzGJ/1YFBnE+RjiBKCxDM9oB0uwC4O9BBTUP3W3v82X8t/of4beIOYjI8OhFJfZQ+ZN+pobVxxLfGgS9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730348245; c=relaxed/simple;
	bh=+hpS2ciU+y8EDFuvViT6OavWLMHdBDGyk3DgAN9sito=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOL7rUh+U1cRe6y5hTV4xo2DyqB4kasQ9YT95ysSdv18TqzvuwRbaWXVkWlUJGvLiBYOtOCQaN+cq7MdY8uEteWmcJaZjQmoF83s4uXvIgSZoE0yMAoCQU27p+h7hge9MCHdIlwYSfo+Oiou8c4bVGdHqLA2YK1QPvHR55Ff1T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xZCxUkCC; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xZCxUkCC"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso42525ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 21:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730348241; x=1730953041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DZw8EShtkLTIgbzQZ9BmyyhQD/lNcXcVUcbnp+v/4A=;
        b=xZCxUkCCudXoNQzSzrXA3nXBmPcN6QXR6rAKTz9UhzlcJx3XSMe+LKUvm35bFnsR3O
         B6GWoxFCwQddoF+shX8UPql5eaf4EG+SdRxkiZMuEZ1BJAjuVkvLHYvn2PIzIfYTOX2Q
         8yYB1TlXjrCOGH/9F0b9cENWyZCD5gt1YPUiTGagA+JtBpIol+cOwNLncBYpS5yja8fP
         VkDF+aNJuEZI6x9+dQrKiGZGq9m469HOCszctF6MPzyiTNqx39Te83cnzHlBAjFfnr3p
         S5pfa8Y8g/o8xSO376Ma/yC2BNg+fdVSTV4SI/m/fGwEjePrAB9kUdWJDikxm15jerRI
         e/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730348241; x=1730953041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DZw8EShtkLTIgbzQZ9BmyyhQD/lNcXcVUcbnp+v/4A=;
        b=uEYTDDpQFW5mPuM21dtw5HQbPgGaYa4zBctMfSrwoaRh6KaZT3rCJr4BQt7DYCl0QO
         fUgjwgw2eTY4ZpldUfQRaDi77lMRZNsMhGSndN9vHv49ImAzFnNvrku277S32pXyJ41a
         sYl6d4yw7jb4Pas8/soSaVslllk1r5MvC7nlKdmpkOr+lmugDB97J+J7EHF6huIHJKxJ
         axF/Z0jqN0ktaXciMVQ04OuOGyDbVapWlpWLh6FkFH+sJia5RkLaPLhnj8/+ZKit1aMM
         NCPyMmDEPmPWNztS4/qh3IpMLV4vbMDJW4cYhR75CLa3k1EzMpIReRyXJ1E6Dlg8Vv4v
         yL/A==
X-Gm-Message-State: AOJu0YwcA2T8EfXZ6ung6XsT3dkP6BMxj4DsZZpcYtnJ2ie2zLNGTgh+
	YE8I9+Elub8C3PWgu/sNPgGVPQbsj1w4ygi4LOrTYdXeiWOKveEI6vvytldBMz2zShDSF0gCH/Q
	E3kVListBdFG19Lavz1r/tABjWhS2EqyuHVMp
X-Gm-Gg: ASbGnct/wR2oV67UuIrwH9u9Frpp83rT6TSXAjZGQ6NmZ1XzFFPghJVNxFnXU4+J2wn
	xByp/9XEtLDmPgGiVaFoblR/6CBgfAK86
X-Google-Smtp-Source: AGHT+IEWjOT2Gvp4Gr1jJa+qgvvjc4f92eMW4ft/FhoLdOBKTytjaSq5lFH0HPqNRUKqxdLZ/Bqaw47VaIaEdlkJS0c=
X-Received: by 2002:a05:6e02:144f:b0:39b:b1f:5be1 with SMTP id
 e9e14a558f8ab-3a6a93596a8mr1455695ab.1.1730348240759; Wed, 30 Oct 2024
 21:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030113946.229361-1-james.clark@linaro.org> <20241030113946.229361-2-james.clark@linaro.org>
In-Reply-To: <20241030113946.229361-2-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 30 Oct 2024 21:17:06 -0700
Message-ID: <CAP-5=fXbh3i0i1Bwh9c3reZLZyXU6QShcyjwKaRsMp9YR0CMsQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf stat: Fix trailing comma when there is no
 metric unit
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	tim.c.chen@linux.intel.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:40=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> Now that printing metric-value and metric-unit is optional,
> print_running_json() shouldn't add the comma in case it becomes
> trailing.
>
> Replace all manual json comma stuff with a json_out() function that uses
> the existing os->first tracking and auto inserts a comma if it's needed.
> Update the test to handle that two of the fields can be missing.

Thanks for the larger clean up!

> This fixes the following test failure on Cortex A57 where the branch
> misses metric is missing a required event:
>
>  $ perf test -vvv "json output"
>
>  106: perf stat JSON output linter:
>  --- start ---
>  test child forked, pid 665682
>  Checking json output: no args Test failed for input:
>  ...
>  {"counter-value" : "3112.000000", "unit" : "",
>   "event" : "armv8_pmuv3_1/branch-misses/",
>   "event-runtime" : 20699340, "pcnt-running" : 100.00, }
>  ...
>  json.decoder.JSONDecodeError: Expecting property name enclosed in
>  double quotes: line 12 column 144 (char 2109)
>  ---- end(-1) ----
>  106: perf stat JSON output linter                 : FAILED!
>
> Fixes: e1cc918b6cfd ("perf stat: Drop metric-unit if unit is NULL")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  .../tests/shell/lib/perf_json_output_lint.py  |  14 +-
>  tools/perf/util/stat-display.c                | 177 ++++++++++--------
>  2 files changed, 104 insertions(+), 87 deletions(-)
>
> diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/=
perf/tests/shell/lib/perf_json_output_lint.py
> index 8ddb85586131..b066d721f897 100644
> --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> @@ -69,16 +69,16 @@ def check_json_output(expected_items):
>    for item in json.loads(input):
>      if expected_items !=3D -1:
>        count =3D len(item)
> -      if count !=3D expected_items and count >=3D 1 and count <=3D 7 and=
 'metric-value' in item:
> +      if count not in expected_items and count >=3D 1 and count <=3D 7 a=
nd 'metric-value' in item:
>          # Events that generate >1 metric may have isolated metric
>          # values and possibly other prefixes like interval, core,
>          # aggregate-number, or event-runtime/pcnt-running from multiplex=
ing.
>          pass
> -      elif count !=3D expected_items and count >=3D 1 and count <=3D 5 a=
nd 'metricgroup' in item:
> +      elif count not in expected_items and count >=3D 1 and count <=3D 5=
 and 'metricgroup' in item:
>          pass
> -      elif count =3D=3D expected_items + 1 and 'metric-threshold' in ite=
m:
> +      elif count - 1 in expected_items and 'metric-threshold' in item:
>            pass
> -      elif count !=3D expected_items:
> +      elif count not in expected_items:
>          raise RuntimeError(f'wrong number of fields. counted {count} exp=
ected {expected_items}'
>                             f' in \'{item}\'')
>      for key, value in item.items():
> @@ -90,11 +90,11 @@ def check_json_output(expected_items):
>
>  try:
>    if args.no_args or args.system_wide or args.event:
> -    expected_items =3D 7
> +    expected_items =3D [5, 7]
>    elif args.interval or args.per_thread or args.system_wide_no_aggr:
> -    expected_items =3D 8
> +    expected_items =3D [6, 8]
>    elif args.per_core or args.per_socket or args.per_node or args.per_die=
 or args.per_cluster or args.per_cache:
> -    expected_items =3D 9
> +    expected_items =3D [7, 9]
>    else:
>      # If no option is specified, don't check the number of items.
>      expected_items =3D -1
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 53dcdf07f5a2..a5d72f4a515c 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -114,23 +114,44 @@ static void print_running_csv(struct perf_stat_conf=
ig *config, u64 run, u64 ena)
>         fprintf(config->output, "%s%" PRIu64 "%s%.2f",
>                 config->csv_sep, run, config->csv_sep, enabled_percent);
>  }
> +struct outstate {
> +       FILE *fh;
> +       bool newline;
> +       bool first;

It'd be nice to have kernel-doc capturing the meaning of these
variables. newline and first, why would something be a newline but not
first? I know the lack of documentation is a pre-existing condition.
Pretty much every variable in the struct below confuses me and I need
to read the code to try to figure it out.

> +       const char *prefix;

Prefix of what?

> +       int  nfields;

Is this the number of columns in CSV format? Why not a name like
csv_columns then? What is a field here?

> +       int  aggr_nr;
> +       struct aggr_cpu_id id;

Something to do with aggregation, presumably for the current CSV line.
Why two of them?

> +       struct evsel *evsel;
> +       struct cgroup *cgrp;

Maybe the counter and cgroup being printed, but we usually pass those
as extra arguments. This loses me.

I was hoping the code here could be more like the perf list json:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/builtin-list.c?h=3Dperf-tools-next#n357
which avoids the comma problem by printing everything in one go.
There's so much spaghetti code in stat-display and before we had tests
there were frequent breakages. Anyway, I don't expect a larger clean
up, just venting. If you could do the comments and clear up the
newline vs first it'd be great.

Thanks,
Ian

> +};
>
> -static void print_running_json(struct perf_stat_config *config, u64 run,=
 u64 ena)
> +static const char *json_sep(struct outstate *os)
> +{
> +       const char *sep =3D os->first ? "" : ", ";
> +
> +       os->first =3D false;
> +       return sep;
> +}
> +
> +#define json_out(os, format, ...) fprintf((os)->fh, "%s" format, json_se=
p(os), ##__VA_ARGS__)
> +
> +static void print_running_json(struct outstate *os, u64 run, u64 ena)
>  {
>         double enabled_percent =3D 100;
>
>         if (run !=3D ena)
>                 enabled_percent =3D 100 * run / ena;
> -       fprintf(config->output, "\"event-runtime\" : %" PRIu64 ", \"pcnt-=
running\" : %.2f, ",
> -               run, enabled_percent);
> +       json_out(os, "\"event-runtime\" : %" PRIu64 ", \"pcnt-running\" :=
 %.2f",
> +                run, enabled_percent);
>  }
>
> -static void print_running(struct perf_stat_config *config,
> +static void print_running(struct perf_stat_config *config, struct outsta=
te *os,
>                           u64 run, u64 ena, bool before_metric)
>  {
>         if (config->json_output) {
>                 if (before_metric)
> -                       print_running_json(config, run, ena);
> +                       print_running_json(os, run, ena);
>         } else if (config->csv_output) {
>                 if (before_metric)
>                         print_running_csv(config, run, ena);
> @@ -153,20 +174,20 @@ static void print_noise_pct_csv(struct perf_stat_co=
nfig *config,
>         fprintf(config->output, "%s%.2f%%", config->csv_sep, pct);
>  }
>
> -static void print_noise_pct_json(struct perf_stat_config *config,
> +static void print_noise_pct_json(struct outstate *os,
>                                  double pct)
>  {
> -       fprintf(config->output, "\"variance\" : %.2f, ", pct);
> +       json_out(os, "\"variance\" : %.2f", pct);
>  }
>
> -static void print_noise_pct(struct perf_stat_config *config,
> +static void print_noise_pct(struct perf_stat_config *config, struct outs=
tate *os,
>                             double total, double avg, bool before_metric)
>  {
>         double pct =3D rel_stddev_stats(total, avg);
>
>         if (config->json_output) {
>                 if (before_metric)
> -                       print_noise_pct_json(config, pct);
> +                       print_noise_pct_json(os, pct);
>         } else if (config->csv_output) {
>                 if (before_metric)
>                         print_noise_pct_csv(config, pct);
> @@ -176,7 +197,7 @@ static void print_noise_pct(struct perf_stat_config *=
config,
>         }
>  }
>
> -static void print_noise(struct perf_stat_config *config,
> +static void print_noise(struct perf_stat_config *config, struct outstate=
 *os,
>                         struct evsel *evsel, double avg, bool before_metr=
ic)
>  {
>         struct perf_stat_evsel *ps;
> @@ -185,7 +206,7 @@ static void print_noise(struct perf_stat_config *conf=
ig,
>                 return;
>
>         ps =3D evsel->stats;
> -       print_noise_pct(config, stddev_stats(&ps->res_stats), avg, before=
_metric);
> +       print_noise_pct(config, os, stddev_stats(&ps->res_stats), avg, be=
fore_metric);
>  }
>
>  static void print_cgroup_std(struct perf_stat_config *config, const char=
 *cgrp_name)
> @@ -198,18 +219,19 @@ static void print_cgroup_csv(struct perf_stat_confi=
g *config, const char *cgrp_n
>         fprintf(config->output, "%s%s", config->csv_sep, cgrp_name);
>  }
>
> -static void print_cgroup_json(struct perf_stat_config *config, const cha=
r *cgrp_name)
> +static void print_cgroup_json(struct outstate *os, const char *cgrp_name=
)
>  {
> -       fprintf(config->output, "\"cgroup\" : \"%s\", ", cgrp_name);
> +       json_out(os, "\"cgroup\" : \"%s\"", cgrp_name);
>  }
>
> -static void print_cgroup(struct perf_stat_config *config, struct cgroup =
*cgrp)
> +static void print_cgroup(struct perf_stat_config *config, struct outstat=
e *os,
> +                        struct cgroup *cgrp)
>  {
>         if (nr_cgroups || config->cgroup_list) {
>                 const char *cgrp_name =3D cgrp ? cgrp->name  : "";
>
>                 if (config->json_output)
> -                       print_cgroup_json(config, cgrp_name);
> +                       print_cgroup_json(os, cgrp_name);
>                 else if (config->csv_output)
>                         print_cgroup_csv(config, cgrp_name);
>                 else
> @@ -324,47 +346,45 @@ static void print_aggr_id_csv(struct perf_stat_conf=
ig *config,
>         }
>  }
>
> -static void print_aggr_id_json(struct perf_stat_config *config,
> +static void print_aggr_id_json(struct perf_stat_config *config, struct o=
utstate *os,
>                                struct evsel *evsel, struct aggr_cpu_id id=
, int aggr_nr)
>  {
> -       FILE *output =3D config->output;
> -
>         switch (config->aggr_mode) {
>         case AGGR_CORE:
> -               fprintf(output, "\"core\" : \"S%d-D%d-C%d\", \"aggregate-=
number\" : %d, ",
> +               json_out(os, "\"core\" : \"S%d-D%d-C%d\", \"aggregate-num=
ber\" : %d",
>                         id.socket, id.die, id.core, aggr_nr);
>                 break;
>         case AGGR_CACHE:
> -               fprintf(output, "\"cache\" : \"S%d-D%d-L%d-ID%d\", \"aggr=
egate-number\" : %d, ",
> +               json_out(os, "\"cache\" : \"S%d-D%d-L%d-ID%d\", \"aggrega=
te-number\" : %d",
>                         id.socket, id.die, id.cache_lvl, id.cache, aggr_n=
r);
>                 break;
>         case AGGR_CLUSTER:
> -               fprintf(output, "\"cluster\" : \"S%d-D%d-CLS%d\", \"aggre=
gate-number\" : %d, ",
> +               json_out(os, "\"cluster\" : \"S%d-D%d-CLS%d\", \"aggregat=
e-number\" : %d",
>                         id.socket, id.die, id.cluster, aggr_nr);
>                 break;
>         case AGGR_DIE:
> -               fprintf(output, "\"die\" : \"S%d-D%d\", \"aggregate-numbe=
r\" : %d, ",
> +               json_out(os, "\"die\" : \"S%d-D%d\", \"aggregate-number\"=
 : %d",
>                         id.socket, id.die, aggr_nr);
>                 break;
>         case AGGR_SOCKET:
> -               fprintf(output, "\"socket\" : \"S%d\", \"aggregate-number=
\" : %d, ",
> +               json_out(os, "\"socket\" : \"S%d\", \"aggregate-number\" =
: %d",
>                         id.socket, aggr_nr);
>                 break;
>         case AGGR_NODE:
> -               fprintf(output, "\"node\" : \"N%d\", \"aggregate-number\"=
 : %d, ",
> +               json_out(os, "\"node\" : \"N%d\", \"aggregate-number\" : =
%d",
>                         id.node, aggr_nr);
>                 break;
>         case AGGR_NONE:
>                 if (evsel->percore && !config->percore_show_thread) {
> -                       fprintf(output, "\"core\" : \"S%d-D%d-C%d\"",
> +                       json_out(os, "\"core\" : \"S%d-D%d-C%d\"",
>                                 id.socket, id.die, id.core);
>                 } else if (id.cpu.cpu > -1) {
> -                       fprintf(output, "\"cpu\" : \"%d\", ",
> +                       json_out(os, "\"cpu\" : \"%d\"",
>                                 id.cpu.cpu);
>                 }
>                 break;
>         case AGGR_THREAD:
> -               fprintf(output, "\"thread\" : \"%s-%d\", ",
> +               json_out(os, "\"thread\" : \"%s-%d\"",
>                         perf_thread_map__comm(evsel->core.threads, id.thr=
ead_idx),
>                         perf_thread_map__pid(evsel->core.threads, id.thre=
ad_idx));
>                 break;
> @@ -376,29 +396,17 @@ static void print_aggr_id_json(struct perf_stat_con=
fig *config,
>         }
>  }
>
> -static void aggr_printout(struct perf_stat_config *config,
> +static void aggr_printout(struct perf_stat_config *config, struct outsta=
te *os,
>                           struct evsel *evsel, struct aggr_cpu_id id, int=
 aggr_nr)
>  {
>         if (config->json_output)
> -               print_aggr_id_json(config, evsel, id, aggr_nr);
> +               print_aggr_id_json(config, os, evsel, id, aggr_nr);
>         else if (config->csv_output)
>                 print_aggr_id_csv(config, evsel, id, aggr_nr);
>         else
>                 print_aggr_id_std(config, evsel, id, aggr_nr);
>  }
>
> -struct outstate {
> -       FILE *fh;
> -       bool newline;
> -       bool first;
> -       const char *prefix;
> -       int  nfields;
> -       int  aggr_nr;
> -       struct aggr_cpu_id id;
> -       struct evsel *evsel;
> -       struct cgroup *cgrp;
> -};
> -
>  static void new_line_std(struct perf_stat_config *config __maybe_unused,
>                          void *ctx)
>  {
> @@ -413,7 +421,7 @@ static inline void __new_line_std_csv(struct perf_sta=
t_config *config,
>         fputc('\n', os->fh);
>         if (os->prefix)
>                 fputs(os->prefix, os->fh);
> -       aggr_printout(config, os->evsel, os->id, os->aggr_nr);
> +       aggr_printout(config, os, os->evsel, os->id, os->aggr_nr);
>  }
>
>  static inline void __new_line_std(struct outstate *os)
> @@ -499,9 +507,9 @@ static void print_metric_json(struct perf_stat_config=
 *config __maybe_unused,
>         FILE *out =3D os->fh;
>
>         if (unit) {
> -               fprintf(out, "\"metric-value\" : \"%f\", \"metric-unit\" =
: \"%s\"", val, unit);
> +               json_out(os, "\"metric-value\" : \"%f\", \"metric-unit\" =
: \"%s\"", val, unit);
>                 if (thresh !=3D METRIC_THRESHOLD_UNKNOWN) {
> -                       fprintf(out, ", \"metric-threshold\" : \"%s\"",
> +                       json_out(os, "\"metric-threshold\" : \"%s\"",
>                                 metric_threshold_classify__str(thresh));
>                 }
>         }
> @@ -514,9 +522,11 @@ static void new_line_json(struct perf_stat_config *c=
onfig, void *ctx)
>         struct outstate *os =3D ctx;
>
>         fputs("\n{", os->fh);
> +       os->first =3D true;
>         if (os->prefix)
> -               fprintf(os->fh, "%s", os->prefix);
> -       aggr_printout(config, os->evsel, os->id, os->aggr_nr);
> +               json_out(os, "%s", os->prefix);
> +
> +       aggr_printout(config, os, os->evsel, os->id, os->aggr_nr);
>  }
>
>  static void print_metricgroup_header_json(struct perf_stat_config *confi=
g,
> @@ -526,7 +536,7 @@ static void print_metricgroup_header_json(struct perf=
_stat_config *config,
>         if (!metricgroup_name)
>                 return;
>
> -       fprintf(config->output, "\"metricgroup\" : \"%s\"}", metricgroup_=
name);
> +       json_out((struct outstate *) ctx, "\"metricgroup\" : \"%s\"}", me=
tricgroup_name);
>         new_line_json(config, ctx);
>  }
>
> @@ -644,7 +654,6 @@ static void print_metric_only_json(struct perf_stat_c=
onfig *config __maybe_unuse
>                                   const char *unit, double val)
>  {
>         struct outstate *os =3D ctx;
> -       FILE *out =3D os->fh;
>         char buf[64], *ends;
>         char tbuf[1024];
>         const char *vals;
> @@ -661,8 +670,7 @@ static void print_metric_only_json(struct perf_stat_c=
onfig *config __maybe_unuse
>         *ends =3D 0;
>         if (!vals[0])
>                 vals =3D "none";
> -       fprintf(out, "%s\"%s\" : \"%s\"", os->first ? "" : ", ", unit, va=
ls);
> -       os->first =3D false;
> +       json_out(os, "\"%s\" : \"%s\"", unit, vals);
>  }
>
>  static void new_line_metric(struct perf_stat_config *config __maybe_unus=
ed,
> @@ -743,28 +751,27 @@ static void print_counter_value_csv(struct perf_sta=
t_config *config,
>         fprintf(output, "%s", evsel__name(evsel));
>  }
>
> -static void print_counter_value_json(struct perf_stat_config *config,
> +static void print_counter_value_json(struct outstate *os,
>                                      struct evsel *evsel, double avg, boo=
l ok)
>  {
> -       FILE *output =3D config->output;
>         const char *bad_count =3D evsel->supported ? CNTR_NOT_COUNTED : C=
NTR_NOT_SUPPORTED;
>
>         if (ok)
> -               fprintf(output, "\"counter-value\" : \"%f\", ", avg);
> +               json_out(os, "\"counter-value\" : \"%f\"", avg);
>         else
> -               fprintf(output, "\"counter-value\" : \"%s\", ", bad_count=
);
> +               json_out(os, "\"counter-value\" : \"%s\"", bad_count);
>
>         if (evsel->unit)
> -               fprintf(output, "\"unit\" : \"%s\", ", evsel->unit);
> +               json_out(os, "\"unit\" : \"%s\"", evsel->unit);
>
> -       fprintf(output, "\"event\" : \"%s\", ", evsel__name(evsel));
> +       json_out(os, "\"event\" : \"%s\"", evsel__name(evsel));
>  }
>
> -static void print_counter_value(struct perf_stat_config *config,
> +static void print_counter_value(struct perf_stat_config *config, struct =
outstate *os,
>                                 struct evsel *evsel, double avg, bool ok)
>  {
>         if (config->json_output)
> -               print_counter_value_json(config, evsel, avg, ok);
> +               print_counter_value_json(os, evsel, avg, ok);
>         else if (config->csv_output)
>                 print_counter_value_csv(config, evsel, avg, ok);
>         else
> @@ -772,12 +779,13 @@ static void print_counter_value(struct perf_stat_co=
nfig *config,
>  }
>
>  static void abs_printout(struct perf_stat_config *config,
> +                        struct outstate *os,
>                          struct aggr_cpu_id id, int aggr_nr,
>                          struct evsel *evsel, double avg, bool ok)
>  {
> -       aggr_printout(config, evsel, id, aggr_nr);
> -       print_counter_value(config, evsel, avg, ok);
> -       print_cgroup(config, evsel->cgrp);
> +       aggr_printout(config, os, evsel, id, aggr_nr);
> +       print_counter_value(config, os, evsel, avg, ok);
> +       print_cgroup(config, os, evsel->cgrp);
>  }
>
>  static bool is_mixed_hw_group(struct evsel *counter)
> @@ -868,17 +876,17 @@ static void printout(struct perf_stat_config *confi=
g, struct outstate *os,
>         out.force_header =3D false;
>
>         if (!config->metric_only && !counter->default_metricgroup) {
> -               abs_printout(config, os->id, os->aggr_nr, counter, uval, =
ok);
> +               abs_printout(config, os, os->id, os->aggr_nr, counter, uv=
al, ok);
>
> -               print_noise(config, counter, noise, /*before_metric=3D*/t=
rue);
> -               print_running(config, run, ena, /*before_metric=3D*/true)=
;
> +               print_noise(config, os, counter, noise, /*before_metric=
=3D*/true);
> +               print_running(config, os, run, ena, /*before_metric=3D*/t=
rue);
>         }
>
>         if (ok) {
>                 if (!config->metric_only && counter->default_metricgroup)=
 {
>                         void *from =3D NULL;
>
> -                       aggr_printout(config, os->evsel, os->id, os->aggr=
_nr);
> +                       aggr_printout(config, os, os->evsel, os->id, os->=
aggr_nr);
>                         /* Print out all the metricgroup with the same me=
tric event. */
>                         do {
>                                 int num =3D 0;
> @@ -891,8 +899,8 @@ static void printout(struct perf_stat_config *config,=
 struct outstate *os,
>                                                 __new_line_std_csv(config=
, os);
>                                 }
>
> -                               print_noise(config, counter, noise, /*bef=
ore_metric=3D*/true);
> -                               print_running(config, run, ena, /*before_=
metric=3D*/true);
> +                               print_noise(config, os, counter, noise, /=
*before_metric=3D*/true);
> +                               print_running(config, os, run, ena, /*bef=
ore_metric=3D*/true);
>                                 from =3D perf_stat__print_shadow_stats_me=
tricgroup(config, counter, aggr_idx,
>                                                                          =
        &num, from, &out,
>                                                                          =
        &config->metric_events);
> @@ -905,8 +913,8 @@ static void printout(struct perf_stat_config *config,=
 struct outstate *os,
>         }
>
>         if (!config->metric_only) {
> -               print_noise(config, counter, noise, /*before_metric=3D*/f=
alse);
> -               print_running(config, run, ena, /*before_metric=3D*/false=
);
> +               print_noise(config, os, counter, noise, /*before_metric=
=3D*/false);
> +               print_running(config, os, run, ena, /*before_metric=3D*/f=
alse);
>         }
>  }
>
> @@ -1083,12 +1091,17 @@ static void print_counter_aggrdata(struct perf_st=
at_config *config,
>                 return;
>
>         if (!metric_only) {
> -               if (config->json_output)
> +               if (config->json_output) {
> +                       os->first =3D true;
>                         fputc('{', output);
> -               if (os->prefix)
> -                       fprintf(output, "%s", os->prefix);
> -               else if (config->summary && config->csv_output &&
> -                        !config->no_csv_summary && !config->interval)
> +               }
> +               if (os->prefix) {
> +                       if (config->json_output)
> +                               json_out(os, "%s", os->prefix);
> +                       else
> +                               fprintf(output, "%s", os->prefix);
> +               } else if (config->summary && config->csv_output &&
> +                          !config->no_csv_summary && !config->interval)
>                         fprintf(output, "%s%s", "summary", config->csv_se=
p);
>         }
>
> @@ -1114,15 +1127,19 @@ static void print_metric_begin(struct perf_stat_c=
onfig *config,
>
>         if (config->json_output)
>                 fputc('{', config->output);
> -       if (os->prefix)
> -               fprintf(config->output, "%s", os->prefix);
>
> +       if (os->prefix) {
> +               if (config->json_output)
> +                       json_out(os, "%s", os->prefix);
> +               else
> +                       fprintf(config->output, "%s", os->prefix);
> +       }
>         evsel =3D evlist__first(evlist);
>         id =3D config->aggr_map->map[aggr_idx];
>         aggr =3D &evsel->stats->aggr[aggr_idx];
> -       aggr_printout(config, evsel, id, aggr->nr);
> +       aggr_printout(config, os, evsel, id, aggr->nr);
>
> -       print_cgroup(config, os->cgrp ? : evsel->cgrp);
> +       print_cgroup(config, os, os->cgrp ? : evsel->cgrp);
>  }
>
>  static void print_metric_end(struct perf_stat_config *config, struct out=
state *os)
> @@ -1343,7 +1360,7 @@ static void prepare_interval(struct perf_stat_confi=
g *config,
>                 return;
>
>         if (config->json_output)
> -               scnprintf(prefix, len, "\"interval\" : %lu.%09lu, ",
> +               scnprintf(prefix, len, "\"interval\" : %lu.%09lu",
>                           (unsigned long) ts->tv_sec, ts->tv_nsec);
>         else if (config->csv_output)
>                 scnprintf(prefix, len, "%lu.%09lu%s",
> @@ -1557,7 +1574,7 @@ static void print_footer(struct perf_stat_config *c=
onfig)
>                 fprintf(output, " %17.*f +- %.*f seconds time elapsed",
>                         precision, avg, precision, sd);
>
> -               print_noise_pct(config, sd, avg, /*before_metric=3D*/fals=
e);
> +               print_noise_pct(config, NULL, sd, avg, /*before_metric=3D=
*/false);
>         }
>         fprintf(output, "\n\n");
>
> --
> 2.34.1
>
