Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0502B1B29A7
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Aug 2024 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723011873; cv=none; b=X20E03fvCAX4KAi5+TWzgl+qTK7n4K943uNUSzH+CHhHIf/3UtEFP8U3Zv2BbDZGE2mN9DodNM3LszFWXJMPV1QYbA8zP2OS4JpL7nKBTwTCWiWlwu5xcn94mLwcrJ/3CbBH6BnQMeTsRLxSu6s/MMRED2nHTj9RTSJi0Hrzkmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723011873; c=relaxed/simple;
	bh=cTIb25FogVTgKs8k3FaoK3KVIEj3c/08pOdpV4eQz5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxiKgy7mgHr43jUWmSYRAv//lkjdrYl2QKS4dfQgUN1FC14fvZL0LlxGb6VzJDFrRF5PzjNJIhj8+qXZ3R7ECwSYJaHP+VnoUtR7JUhwBYUE+3VwALOVlm/HT/RhQcM+s/w8h/463XZRfYl+1F10n0lZgDnLuHUYnVfejOYoryU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cf93dc11c6so1102663a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Aug 2024 23:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723011871; x=1723616671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mRLNrU4dNOfn30ta5TXCGehkVeCWm6XHcqer+evLf4=;
        b=Y1isIQnM1VxbszPWORbfkKpzOjgmkqEFaMVIB8tOpwNSnOqLAAMhe6ms4PlWDRnEEa
         YkZQhZip2xD2yiElE7/QjtpMs801Fv5C6Ub2a6ZNvAnfMgMmioKS1Na9mjSM1Opymkzl
         aa+1xT38F2d4X+BPGIzK2CNsZCtoB52r1X0cfBdtbu4VgSLbml6eI9BkQXPrkq6IDpxE
         MFeuyB5uebGGKiWkUEzGd+q280yG3nq/LUJtcFjihMlRtoNRwjkDZzSRus6okuuBJAZj
         1BOZHff0f3db8wZVLbn/jI8zxF1AhxnuomjY2bbwETdQaEPPbXC4PFHgmXLkxNdfXGGw
         aGSg==
X-Gm-Message-State: AOJu0YySZ8aEFvunWa46SA06HATyDF3vj+zFWrwix/B1qenTkZQHhBs9
	EAb7uLqbCFUhvF0g7OZVs/6lQZcUscwpSSrAUfwK9lwKlEQX0AP1qy4QZeJNvpuCcsZwzIV28nq
	tyZbxu/gWr+eeykoTdjriikjYv32fF01L
X-Google-Smtp-Source: AGHT+IHCm4i0+PMuuSfbzOAIL0xJ+ZyuREVxYXop8ba8vn/+RQxPH7MzmhsvwwzfE4c04zt+TnXM0a+IDWKTlElBIPk=
X-Received: by 2002:a17:90a:c696:b0:2c9:6d8:d823 with SMTP id
 98e67ed59e1d1-2cff93c4da3mr22288879a91.1.1723011870951; Tue, 06 Aug 2024
 23:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807033025.894167-1-ak@linux.intel.com> <20240807033025.894167-3-ak@linux.intel.com>
In-Reply-To: <20240807033025.894167-3-ak@linux.intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 6 Aug 2024 23:24:19 -0700
Message-ID: <CAM9d7ch131CJ0wh89XaaA6EDNriZ4G84GjrVr5-98UhXW-Tixg@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] perf script: Fix perf script -F +metric
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 8:30=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wrot=
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
> ---
>  tools/perf/builtin-script.c | 50 +++++++++++++++++++++++++++++++++----
>  1 file changed, 45 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c16224b1fef3..2e9f539ba4ce 100644
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
> @@ -2127,18 +2126,30 @@ static void perf_sample__fprint_metric(struct per=
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
> +       if (!(leader->core.attr.read_format & PERF_FORMAT_GROUP)) {

Oh, I meant checking both PERF_SAMPLE_READ and PERF_FORMAT_GROUP.
Sorry for the confusion, otherwise it looks good to me.

Thanks,
Namhyung


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
> @@ -2325,6 +2336,20 @@ static void process_event(struct perf_script *scri=
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
> @@ -2334,6 +2359,8 @@ static void __process_stat(struct evsel *counter, u=
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
> @@ -3725,6 +3752,8 @@ static int process_stat_config_event(struct perf_se=
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
> @@ -4088,6 +4117,17 @@ int cmd_script(int argc, const char **argv)
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
