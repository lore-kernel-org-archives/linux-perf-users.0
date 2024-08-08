Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DB3208DA
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Aug 2024 05:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723094310; cv=none; b=NZez3ZmeiJnON1kzA5x7Mze+jSU5WMMb4LV1DEiU1TC7nGNj1fGOB986CBXD14flSWH/RC0afILv+ZflRT5ofme4ojfboywIAo6ObBhv4Wfs3cTzDN2p0keoQa6QBZE8MIhPBUyfDCzCOXD4UDdOS9O95l545ZGJYnhfYgwcPlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723094310; c=relaxed/simple;
	bh=+pve8w5OmDuhEfKAZ0v4QgDzAlDSeolETGcLJaL6EVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISWYIIBETXKJ9dplJ1DbHPKbBMVgkxt9kE7iZxN069OnL9RpciQCm1A+F+Z0IFuROZ0ZAAtHX/aK8pj2gfKEeapGY0yEye5YOsu+c+m6Dg7l8xJIlK1nNGyBbgFew4b82ZLWSzL+mROjEa2o8xBYaGHW09GcvLHIt5OHIC0yiKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso547376b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Aug 2024 22:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723094308; x=1723699108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlD9KilVP/+UaWYaZ7K9co9pYkczzJbUbakDSn5gvig=;
        b=ZAqXWI/5sdidcerV3kzb9+6Jy3NZp4wRvjMpN4JTYCQQL7AivDUr8wxqskENIVB3rF
         sPKiGkJmcbr8Mul3eO/WOtXh018qCUpov44UaF22kScoPHFqxdttfFGBdwg0OtkiZRtF
         I7gpxRdkPq3kcEJjxZPOTiKe4SWbS62cisGZueu1JsqhiNtMyl3G+6sxyXuMgeNLUHFb
         XU5NP6qfXPH/5Cmz+VsCWe63uwijpPbougQwUhzjIari30CDbSSpqQqrOkLWhIkE2N/Y
         NiVQ2V76dnLu0VQNyD4I9i1aUkHf0LN7QG6pOsoDPEHiczb2Fxshlue5QWLwqxg6HwHZ
         dkaA==
X-Gm-Message-State: AOJu0YzqVm4ND2O28m7diIo9gcvw88uj5NjLtQ+wcrg4QJ1hXAS8MilJ
	wIrEftpdDuM/bmUheSHa9EPr4Bjy2jlzdvp3R8V7RKwYpJEQlrajOrTvSBOX1foxoVxTtZJsvvg
	0YH7NihVj1ZjmGgY5O4+keawKazk=
X-Google-Smtp-Source: AGHT+IHNVo2ZaWOQJqjUDzMFydzGL/1p8wMp46arW2418YC6XYhkJy+4gJa4bvSB1FxQt15rIMyM7BCguwf/7aU6+uk=
X-Received: by 2002:a05:6a20:8419:b0:1c4:818c:299d with SMTP id
 adf61e73a8af0-1c6fce3dc3bmr886845637.11.1723094308198; Wed, 07 Aug 2024
 22:18:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807231823.898979-1-ak@linux.intel.com> <20240807231823.898979-3-ak@linux.intel.com>
In-Reply-To: <20240807231823.898979-3-ak@linux.intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 7 Aug 2024 22:18:17 -0700
Message-ID: <CAM9d7ci40WcV=EtsNuNXkRAWc3XHDKzb9OACNUhD5WaqTu5vxg@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] perf script: Fix perf script -F +metric
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andi,

On Wed, Aug 7, 2024 at 4:18=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wrot=
e:
>
> This fixes a regression with perf script -F +metric originally caused by =
:
>
> commit 37cc8ad77cf81f3ffd226856c367b0e15333a738
> Author: Ian Rogers <irogers@google.com>
> Date:   Sun Feb 19 01:28:46 2023 -0800
>
>     perf metric: Directly use counts rather than saved_value
>
> In the perf script environment the evsel wouldn't allocate an aggr
> values array, which led to a -1 reference because the metric
> evaluation would try to reference NULL - 1 (for aggr_idx)
>
> Give the perf script evsels a single CPU aggr setup. That's
> enough because the groups are always contiguous, so no need
> to store more than one CPU's worth of values.
>
> Before
>
> % perf record -e '{cycles,instructions}:S' perf bench  mem memcpy
> % perf script -F +metric
> Segmentation fault (core dumped)
>
> After:
>
> % perf record -e '{cycles,instructions}:S' perf bench  mem memcpy
> ...
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.028 MB perf.data (90 samples) ]
> % perf script -F +metric
>        perf-exec 1847557 264658.180789:       3009       cycles:  fffffff=
f990a579a native_write_msr+0xa ([kernel.kallsyms])
>        perf-exec 1847557 264658.180789:        382 instructions:  fffffff=
f990a579a native_write_msr+0xa ([kernel.kallsyms])
>        perf-exec 1847557 264658.180789:         metric:    0.13  insn per=
 cycle
> ...
>
> Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather ...")
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Thanks for your work, for the series:

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
> ----
>
> v2: Reformat code
> v3: Work around bogus warning
> v4: Set up aggr map only for metrics case to keep perf stat record
> working
> v5: Broken version
> v6: Only set up limited aggregation mode with -F +metric. Add conflict
> checks with perf stat record files.
> v7: Remove some unnecessary conflict checks. Fix buffer overflow. Minor c=
leanups.
> v8: Add check for leader sampling. Update some comments.
> v9: Correct check for leader sampling (Namhyung)
> v10: Check for PERF_FORMAT_GROUP and PERF_SAMPLE_READ (Namhyung)
> ---
>  tools/perf/builtin-script.c | 51 +++++++++++++++++++++++++++++++++----
>  1 file changed, 46 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c16224b1fef3..cb63507af839 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -335,7 +335,6 @@ struct evsel_script {
>         FILE *fp;
>         u64  samples;
>         /* For metric output */
> -       u64  val;
>         int  gnum;
>  };
>
> @@ -2127,18 +2126,31 @@ static void perf_sample__fprint_metric(struct per=
f_script *script,
>         };
>         struct evsel *ev2;
>         u64 val;
> +       static int printed;
>
>         if (!evsel->stats)
>                 evlist__alloc_stats(&stat_config, script->session->evlist=
, /*alloc_raw=3D*/false);
>         if (evsel_script(leader)->gnum++ =3D=3D 0)
>                 perf_stat__reset_shadow_stats();
> -       val =3D sample->period * evsel->scale;
> -       evsel_script(evsel)->val =3D val;
> +       val =3D sample->period;
> +       if (!(leader->core.attr.read_format & PERF_FORMAT_GROUP) ||
> +           !(leader->core.attr.sample_type & PERF_SAMPLE_READ)) {
> +               if (!printed)
> +                       fprintf(stderr, "perf script: -F metric requires =
{}:S for groups leader sampling\n");
> +               printed =3D 1;
> +               return;
> +       }
> +       /*
> +        * Always use the first entry as storage because the leader sampl=
ing
> +        * groups are contiguous and there's no need to handle multiple i=
ndexes
> +        * for anything.
> +        */
> +       evsel->stats->aggr[0].counts.val =3D val;
>         if (evsel_script(leader)->gnum =3D=3D leader->core.nr_members) {
>                 for_each_group_member (ev2, leader) {
>                         perf_stat__print_shadow_stats(&stat_config, ev2,
> -                                                     evsel_script(ev2)->=
val,
> -                                                     sample->cpu,
> +                                                     evsel->stats->aggr[=
0].counts.val,
> +                                                     0,
>                                                       &ctx,
>                                                       NULL);
>                 }
> @@ -2325,6 +2337,20 @@ static void process_event(struct perf_script *scri=
pt,
>                 fflush(fp);
>  }
>
> +static void check_metric_conflict(void)
> +{
> +       int i;
> +       /*
> +        * Avoid conflict with the aggregation mode used for the metric p=
rinting.
> +        */
> +       for (i =3D 0; i < OUTPUT_TYPE_MAX; i++) {
> +               if (output[i].fields & PERF_OUTPUT_METRIC) {
> +                       fprintf(stderr, "perf stat record files are not s=
upported with -F metric\n");
> +                       exit(1);
> +               }
> +       }
> +}
> +
>  static struct scripting_ops    *scripting_ops;
>
>  static void __process_stat(struct evsel *counter, u64 tstamp)
> @@ -2334,6 +2360,8 @@ static void __process_stat(struct evsel *counter, u=
64 tstamp)
>         struct perf_cpu cpu;
>         static int header_printed;
>
> +       check_metric_conflict();
> +
>         if (!header_printed) {
>                 printf("%3s %8s %15s %15s %15s %15s %s\n",
>                        "CPU", "THREAD", "VAL", "ENA", "RUN", "TIME", "EVE=
NT");
> @@ -3725,6 +3753,8 @@ static int process_stat_config_event(struct perf_se=
ssion *session __maybe_unused
>  {
>         perf_event__read_stat_config(&stat_config, &event->stat_config);
>
> +       check_metric_conflict();
> +
>         /*
>          * Aggregation modes are not used since post-processing scripts a=
re
>          * supposed to take care of such requirements
> @@ -4088,6 +4118,17 @@ int cmd_script(int argc, const char **argv)
>
>         argc =3D parse_options_subcommand(argc, argv, options, script_sub=
commands, script_usage,
>                              PARSE_OPT_STOP_AT_NON_OPTION);
> +       for (i =3D 0; i < OUTPUT_TYPE_MAX; i++) {
> +               if (output[i].fields & PERF_OUTPUT_METRIC) {
> +                       stat_config.aggr_map =3D cpu_aggr_map__empty_new(=
1);
> +                       err =3D -ENOMEM;
> +                       if (!stat_config.aggr_map)
> +                               goto out;
> +                       err =3D 0;
> +                       stat_config.aggr_map->nr =3D 1;
> +                       break;
> +               }
> +       }
>
>         if (symbol_conf.guestmount ||
>             symbol_conf.default_guest_vmlinux_name ||
> --
> 2.45.2
>
