From: Ian Rogers <irogers@google.com>
Subject: Re: [RFC 1/3] perf jevents: Add support for parsing perchip/percore events
Date: Thu, 25 Jun 2020 07:08:04 -0700
Message-ID: <CAP-5=fWG9rxObKJ38dQ=VUf3_mQbNDCTzgU1kkyw=9uVfBa+qw@mail.gmail.com>
References: <20200625114718.229911-1-kjain@linux.ibm.com> <20200625114718.229911-2-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200625114718.229911-2-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Paul Clarke <pc@us.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, maddy@linux.ibm.com, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, "Liang, Kan" <kan.liang@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Jun 25, 2020 at 4:47 AM Kajol Jain <kjain@linux.ibm.com> wrote:
>
> Set up the "PerChip" field  so that perf knows they are
> per chip events.
>
> Set up the "PerCore" field  so that perf knows they are
> per core events and add these fields to pmu_event structure.
>
> Similar to the way we had "PerPkg field
> to specify perpkg events.
>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  tools/perf/pmu-events/jevents.c    | 34 ++++++++++++++++++++++++------
>  tools/perf/pmu-events/jevents.h    |  3 ++-
>  tools/perf/pmu-events/pmu-events.h |  2 ++
>  3 files changed, 32 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index fa86c5f997cc..21fd7990ded5 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -323,7 +323,8 @@ static int print_events_table_entry(void *data, char *name, char *event,
>                                     char *pmu, char *unit, char *perpkg,
>                                     char *metric_expr,
>                                     char *metric_name, char *metric_group,
> -                                   char *deprecated, char *metric_constraint)
> +                                   char *deprecated, char *perchip, char *percore,
> +                                   char *metric_constraint)
>  {
>         struct perf_entry_data *pd = data;
>         FILE *outfp = pd->outfp;
> @@ -357,6 +358,10 @@ static int print_events_table_entry(void *data, char *name, char *event,
>                 fprintf(outfp, "\t.metric_group = \"%s\",\n", metric_group);
>         if (deprecated)
>                 fprintf(outfp, "\t.deprecated = \"%s\",\n", deprecated);
> +       if (perchip)
> +               fprintf(outfp, "\t.perchip = \"%s\",\n", perchip);
> +       if (percore)
> +               fprintf(outfp, "\t.percore = \"%s\",\n", percore);
>         if (metric_constraint)
>                 fprintf(outfp, "\t.metric_constraint = \"%s\",\n", metric_constraint);
>         fprintf(outfp, "},\n");
> @@ -378,6 +383,8 @@ struct event_struct {
>         char *metric_group;
>         char *deprecated;
>         char *metric_constraint;
> +       char *perchip;
> +       char *percore;
>  };
>
>  #define ADD_EVENT_FIELD(field) do { if (field) {               \
> @@ -406,6 +413,8 @@ struct event_struct {
>         op(metric_name);                                        \
>         op(metric_group);                                       \
>         op(deprecated);                                         \
> +       op(perchip);                                            \
> +       op(percore);                                            \
>  } while (0)
>
>  static LIST_HEAD(arch_std_events);
> @@ -425,7 +434,8 @@ static int save_arch_std_events(void *data, char *name, char *event,
>                                 char *desc, char *long_desc, char *pmu,
>                                 char *unit, char *perpkg, char *metric_expr,
>                                 char *metric_name, char *metric_group,
> -                               char *deprecated, char *metric_constraint)
> +                               char *deprecated, char *perchip, char *percore,
> +                               char *metric_constraint)
>  {
>         struct event_struct *es;
>
> @@ -489,7 +499,8 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
>           char **name, char **long_desc, char **pmu, char **filter,
>           char **perpkg, char **unit, char **metric_expr, char **metric_name,
>           char **metric_group, unsigned long long eventcode,
> -         char **deprecated, char **metric_constraint)
> +         char **deprecated, char **perchip, char **percore,
> +         char **metric_constraint)
>  {
>         /* try to find matching event from arch standard values */
>         struct event_struct *es;
> @@ -518,7 +529,8 @@ int json_events(const char *fn,
>                       char *pmu, char *unit, char *perpkg,
>                       char *metric_expr,
>                       char *metric_name, char *metric_group,
> -                     char *deprecated, char *metric_constraint),
> +                     char *deprecated, char *perchip, char *percore,
> +                     char *metric_constraint),
>           void *data)
>  {
>         int err;
> @@ -548,6 +560,8 @@ int json_events(const char *fn,
>                 char *metric_name = NULL;
>                 char *metric_group = NULL;
>                 char *deprecated = NULL;
> +               char *perchip = NULL;
> +               char *percore = NULL;
>                 char *metric_constraint = NULL;
>                 char *arch_std = NULL;
>                 unsigned long long eventcode = 0;
> @@ -629,6 +643,10 @@ int json_events(const char *fn,
>                                 addfield(map, &perpkg, "", "", val);
>                         } else if (json_streq(map, field, "Deprecated")) {
>                                 addfield(map, &deprecated, "", "", val);
> +                       } else if (json_streq(map, field, "PerChip")) {
> +                               addfield(map, &perchip, "", "", val);
> +                       } else if (json_streq(map, field, "PerCore")) {
> +                               addfield(map, &percore, "", "", val);
>                         } else if (json_streq(map, field, "MetricName")) {
>                                 addfield(map, &metric_name, "", "", val);
>                         } else if (json_streq(map, field, "MetricGroup")) {
> @@ -676,13 +694,15 @@ int json_events(const char *fn,
>                                         &long_desc, &pmu, &filter, &perpkg,
>                                         &unit, &metric_expr, &metric_name,
>                                         &metric_group, eventcode,
> -                                       &deprecated, &metric_constraint);
> +                                       &deprecated, &perchip, &percore,
> +                                       &metric_constraint);
>                         if (err)
>                                 goto free_strings;
>                 }
>                 err = func(data, name, real_event(name, event), desc, long_desc,
>                            pmu, unit, perpkg, metric_expr, metric_name,
> -                          metric_group, deprecated, metric_constraint);
> +                          metric_group, deprecated, perchip, percore,
> +                          metric_constraint);
>  free_strings:
>                 free(event);
>                 free(desc);
> @@ -693,6 +713,8 @@ int json_events(const char *fn,
>                 free(filter);
>                 free(perpkg);
>                 free(deprecated);
> +               free(perchip);
> +               free(percore);
>                 free(unit);
>                 free(metric_expr);
>                 free(metric_name);
> diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
> index 2afc8304529e..3c439ecdac7c 100644
> --- a/tools/perf/pmu-events/jevents.h
> +++ b/tools/perf/pmu-events/jevents.h
> @@ -8,7 +8,8 @@ int json_events(const char *fn,
>                                 char *pmu,
>                                 char *unit, char *perpkg, char *metric_expr,
>                                 char *metric_name, char *metric_group,
> -                               char *deprecated, char *metric_constraint),
> +                               char *deprecated, char *perchip, char *percore,
> +                               char *metric_constraint),
>                 void *data);
>  char *get_cpu_str(void);
>
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
> index c8f306b572f4..13d96b732963 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -19,6 +19,8 @@ struct pmu_event {
>         const char *metric_group;
>         const char *deprecated;
>         const char *metric_constraint;
> +       const char *perchip;
> +       const char *percore;

(In general this looks good! Some nits)
Could we document perchip and percore? Agreed that the style here is
not to comment.
I'm a little confused as to why these need to be const char* and can't
just be a bool? Perhaps other variables shouldn't be const char* too.
Is there ever a case where both perchip and percore could be true?
Would something like an enum capture this better? I can imagine other
cases uncore and it seems a little strange to add a new "const char*"
each time.

I'm wondering if there needs to be a glossary of terms, so that the
use of terms like core, chip, thread, socket, cpu, package is kept
consistent. It's not trivially clear what the difference between a
chip and a socket is, for example. Mapping terms to other vendors
commonly used terms, such as "complex" would also be useful.

Thanks,
Ian

>  };
>
>  /*
> --
> 2.26.2
>
