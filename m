Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A951862A
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jul 2024 03:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721963647; cv=none; b=Fqd2mNScs32Pc1Njw/0zLuP8vsPIKOBml9GGZ3ZFf61VuBrxk79/a0Ri0TPyY44mImn3WClCiJxgclGy4Rcse1JprBaFR17JPKxAvToF26noHuJ44PovfDWUlwE+gqAtzfQbuAPcUkC5mxr/kPPP0sPVs3OESjA57zO6/BXPgFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721963647; c=relaxed/simple;
	bh=eKbnSvwEDfQU6G8ct4hvfKD85KBxnfqgg2udd3X/I5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ua2HN7u4kN/8l5aNvnki2TeWXIbNJXOGtnW84U1dTiG5uiVFmwRG7uD24fIOzyRIDi/LfF3SVyqlINwOLNw9u30/Vq1FVXm3wYpNVcy5IFjciq5wA16ASjpGDeH3taM1IdkMfPxRXLpNBp7JuNhwKkgLlhrnKGp/2+YGey2Fda4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pvx7+7wt; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pvx7+7wt"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39a16fab332so70015ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Jul 2024 20:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721963645; x=1722568445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccBUM3nU9z/5VZbq8AOh2LREUaZ7dLEC0x7/NzkD6ZU=;
        b=Pvx7+7wtcBOhVvRJpnmwD1bX1Z+xZMvD4Wwma5sRETY4HXjKVdgcM3zJJ9yZt8pzwP
         iyq/T1gZa2ATDiXqOHcZcUTWFOUqzYK8C3OBH6klDZWsXqUXNQCTyEk7/gMIE6B0c21B
         HNoDNO9VMZ86+h6zhKI558DXynbmWo+ETbx0T3GXVKZGfS/387cp9ESBPALb40Bf90I7
         DSBh9xf5x+5E7lmFkSfDaK727eJzwZjpAWwAT+Zub04QkmNbbbCUqJRfzgYLBPFc/Q99
         kzfE1tqjjwXho8uW4JdwikylHuZu5q7jpnqY9ed3l3wY2kBnkS4erzkgR1qsTy4knw1w
         J8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721963645; x=1722568445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccBUM3nU9z/5VZbq8AOh2LREUaZ7dLEC0x7/NzkD6ZU=;
        b=EiUrK0n1esq2hThFWVV4n92Nd0UdOZDsorqJ58Q4CUlJ0eyyAoQCNqjj3oWxGH/xIR
         Z6nSVzNor3oYqLy0OSQp0NX6F6pDTXW2x4fCEGxpOYLyHoILjnCdwWG73cHTfsFnk4x1
         BXo2hiunAWO4OMjNA228LPFNUqDgmizesD1HbLg9acxhwAnAVsPhpqNvlt7KuotDyrUN
         ju/P89BJKdJeYdjJRNYDTKup2fYvPbfKvLZZjTbXqmlZtYuVd6iq8WUlbnLRy3bA7olE
         ZG36OKR8GrgUP3C18jo4s5ImExqjouVtOZjdAQjCgVNW0dFLOqiLHluUiAcFjMJM6T/T
         Opvw==
X-Forwarded-Encrypted: i=1; AJvYcCWcAFNnCNyx14K9IcCsAeaDZbfL07+KC1EltJRYARBKFjC42KA2t2T+SXf7VrfkNOd1QqPF77S1vFOYcAPqmwUROw7LzRNh+RJCpylDEaeuKg==
X-Gm-Message-State: AOJu0YzC2VnrX2ZN/w9Hl7SOZwIyoW5Mzd+vSYZlC+XGAjOKXbSuRadR
	jSWhOQZR7ATe1SogktrqKJ88KBRyRPExbnO9C5oSfwdD+WmQg4K7Ixc00eS5BpRcKRPCKzrQNvV
	ygnwv50NqHcMRXS46Zjm3+0/I5FSr8VlIR98QjSGQllidkdWFcfUDhGg=
X-Google-Smtp-Source: AGHT+IFCrkW4iihq5MuHjIp7VtOVoGgpV/q/1P9LA2FlE/3qgEn59hIHs2HD0Vkq73dwSZgosUUQz0IyMalkXy9sYpU=
X-Received: by 2002:a05:6e02:1c85:b0:376:e6c5:1906 with SMTP id
 e9e14a558f8ab-39a2b254e7emr1747055ab.8.1721963644528; Thu, 25 Jul 2024
 20:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724190137.3810429-1-ak@linux.intel.com> <20240724190137.3810429-3-ak@linux.intel.com>
 <ZqLuWGKZjdUrkd0L@google.com>
In-Reply-To: <ZqLuWGKZjdUrkd0L@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 25 Jul 2024 20:13:53 -0700
Message-ID: <CAP-5=fU+Gjgs3RdExbsC641n_om6MRVGt=WtC0RYyqwWTdqoQw@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] perf script: Fix perf script -F +metric
To: Namhyung Kim <namhyung@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 5:31=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Jul 24, 2024 at 12:01:36PM -0700, Andi Kleen wrote:
> > This fixes a regression with perf script -F +metric originally caused b=
y :
> >
> > commit 37cc8ad77cf81f3ffd226856c367b0e15333a738
> > Author: Ian Rogers <irogers@google.com>
> > Date:   Sun Feb 19 01:28:46 2023 -0800
> >
> >     perf metric: Directly use counts rather than saved_value
> >
> > In the perf script environment the evsel wouldn't allocate an aggr
> > values array, which led to a -1 reference because the metric
> > evaluation would try to reference NULL - 1 (for aggr_idx)
> >
> > Give the perf script evsels a single CPU aggr setup. That's
> > enough because the groups are always contiguous, so no need
> > to store more than one CPU's worth of values.
> >
> > Before
> >
> > % perf record -e '{cycles,instructions}:S' perf bench  mem memcpy
> > % perf script -F +metric
> > Segmentation fault (core dumped)
> >
> > After:
> >
> > % perf record -e '{cycles,instructions}:S' perf bench  mem memcpy
> > ...
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.028 MB perf.data (90 samples) ]
> > % perf script -F +metric
> >        perf-exec 1847557 264658.180789:       3009       cycles:  fffff=
fff990a579a native_write_msr+0xa ([kernel.kallsyms])
> >        perf-exec 1847557 264658.180789:        382 instructions:  fffff=
fff990a579a native_write_msr+0xa ([kernel.kallsyms])
> >        perf-exec 1847557 264658.180789:         metric:    0.13  insn p=
er cycle
> > ...
> >
> > Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather ...")
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> >
> > ----
> >
> > v2: Reformat code
> > v3: Work around bogus warning
> > v4: Set up aggr map only for metrics case to keep perf stat record
> > working
> > v5: Broken version
> > v6: Only set up limited aggregation mode with -F +metric. Add conflict
> > checks with perf stat record files.
> > v7: Remove some unnecessary conflict checks. Fix buffer overflow. Minor=
 cleanups.
> > ---
> >  tools/perf/builtin-script.c | 42 ++++++++++++++++++++++++++++++++-----
> >  1 file changed, 37 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index c16224b1fef3..8058bb19a956 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -335,7 +335,6 @@ struct evsel_script {
> >         FILE *fp;
> >         u64  samples;
> >         /* For metric output */
> > -       u64  val;
> >         int  gnum;
> >  };
> >
> > @@ -2132,13 +2131,17 @@ static void perf_sample__fprint_metric(struct p=
erf_script *script,
> >               evlist__alloc_stats(&stat_config, script->session->evlist=
, /*alloc_raw=3D*/false);
> >       if (evsel_script(leader)->gnum++ =3D=3D 0)
> >               perf_stat__reset_shadow_stats();
> > -     val =3D sample->period * evsel->scale;
> > -     evsel_script(evsel)->val =3D val;
> > +     val =3D sample->period;
> > +     /*
> > +      * Always use the first storage because the groups are contiguous
>
> Without leader sampling we cannot guarantee groups events fire
> together, right?

It is theoretically possible that all groups, and not just leader
sampling, when the leader fires you create samples with the same stack
trace but with varying periods - this would seem redundant/wasteful
with leader sampling as an equivalent, and possibly a way to get more
lost samples. Perhaps Andi is assuming they fire together because of
frequency mode?

When we sched_in siblings in a group there is no difference to
scheduling in non-siblings except in the error path:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/kernel/events/core.c?h=3Dperf-tools-next#n2593

The PMU may do something special, but I don't see it looking at
drivers/perf and in the arch events directory. Perhaps there is some
common code with the logic Andi mentions. If the behavior is because
of frequency mode then stating that assumption in at least a comment
would be good.

Thanks,
Ian

>
> > +      * and there's no need to handle multiple indexes for anything
>
> Actually I think this is a behavior change that you changed the
> aggregation mode from NONE to GLOBAL.
>
> > +      */
> > +     evsel->stats->aggr[0].counts.val =3D val;
> >       if (evsel_script(leader)->gnum =3D=3D leader->core.nr_members) {
> >               for_each_group_member (ev2, leader) {
> >                       perf_stat__print_shadow_stats(&stat_config, ev2,
> > -                                                   evsel_script(ev2)->=
val,
> > -                                                   sample->cpu,
> > +                                                   evsel->stats->aggr[=
0].counts.val,
> > +                                                   0,
>
> Like I said to Ian, we should pass a proper aggr_idx here not just 0 to
> support correct aggregation.  For now I think only possible choice is
> AGGR_NONE (for cpu-wide record) or AGGR_THREAD (for per-task record).
> Then it should be an index to cpu or thread map.
>
> I think existing sample->cpu can be incorrect for cpu-wide records too
> in case of non-contiguous CPU list like `perf record -C 1,3,5 ...`.
>
> >                                                     &ctx,
> >                                                     NULL);
> >               }
> > @@ -2325,6 +2328,20 @@ static void process_event(struct perf_script *sc=
ript,
> >               fflush(fp);
> >  }
> >
> > +static void check_metric_conflict(void)
> > +{
> > +     int i;
> > +     /*
> > +      * Avoid conflict with the aggregation mode used for the metric p=
rinting.
> > +      */
> > +     for (i =3D 0; i < OUTPUT_TYPE_MAX; i++) {
> > +             if (output[i].fields & PERF_OUTPUT_METRIC) {
> > +                     fprintf(stderr, "perf stat record files are not s=
upported with -F metric\n");
> > +                     exit(1);
> > +             }
> > +     }
> > +}
> > +
> >  static struct scripting_ops  *scripting_ops;
> >
> >  static void __process_stat(struct evsel *counter, u64 tstamp)
> > @@ -2334,6 +2351,8 @@ static void __process_stat(struct evsel *counter,=
 u64 tstamp)
> >       struct perf_cpu cpu;
> >       static int header_printed;
> >
> > +     check_metric_conflict();
> > +
> >       if (!header_printed) {
> >               printf("%3s %8s %15s %15s %15s %15s %s\n",
> >                      "CPU", "THREAD", "VAL", "ENA", "RUN", "TIME", "EVE=
NT");
> > @@ -3725,6 +3744,8 @@ static int process_stat_config_event(struct perf_=
session *session __maybe_unused
> >  {
> >       perf_event__read_stat_config(&stat_config, &event->stat_config);
> >
> > +     check_metric_conflict();
> > +
> >       /*
> >        * Aggregation modes are not used since post-processing scripts a=
re
> >        * supposed to take care of such requirements
> > @@ -4088,6 +4109,17 @@ int cmd_script(int argc, const char **argv)
> >
> >       argc =3D parse_options_subcommand(argc, argv, options, script_sub=
commands, script_usage,
> >                            PARSE_OPT_STOP_AT_NON_OPTION);
> > +     for (i =3D 0; i < OUTPUT_TYPE_MAX; i++) {
> > +             if (output[i].fields & PERF_OUTPUT_METRIC) {
> > +                     stat_config.aggr_map =3D cpu_aggr_map__empty_new(=
1);
> > +                     err =3D -ENOMEM;
> > +                     if (!stat_config.aggr_map)
> > +                             goto out;
> > +                     err =3D 0;
> > +                     stat_config.aggr_map->nr =3D 1;
>
> It should be number of entries in the cpu map or thread map.
>
> Thanks,
> Namhyung
>
>
> > +                     break;
> > +             }
> > +     }
> >
> >       if (symbol_conf.guestmount ||
> >           symbol_conf.default_guest_vmlinux_name ||
> > --
> > 2.45.2
> >
>
