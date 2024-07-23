Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7A313D503
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721770368; cv=none; b=sqO2VyFXkYqFTCaVs3T26C+tfz9lZkMsrAiLozWwrREtVmhDsWskw0O6mTibE5eujrCVfJdjalhNyKo9hsUwcxVOrnbcaMZ1YDHiyVjfqX9qA0fPviCKPDorILtMzzIvgdZrSvKjx3yUlv4ArjE3V7zhBVt/bF+bRwSWo1F0z4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721770368; c=relaxed/simple;
	bh=QIveMcNay7q+0u41mO9RiIJ2/yA2MQ+wd4ptsBhBdGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=el2yMfOyLhRUzeKng5c744M6YLqIkkJU62VxvejPy/H7gVx56UHb5a3SHjvBMP+1wb9p217H/hlwy3xy8ECvde3T/AnEtxUOh7vgWp4It9qW3p7iSGYj64nbKQptsXyfq1WIbns7BVQ6JnQ4StBag7KNqHTlY7SW8jp4umBad/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lgkjbVHu; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lgkjbVHu"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-447df43324fso51321cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 14:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721770366; x=1722375166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ei+FAtI2RnZQIpiGeAOXZY2/EWuGpUeNTDCAqAstsm4=;
        b=lgkjbVHuYzY+PRtE6SVALtgIRE0rhK+mVeUlsJD5v9qoEHB9VXNMQ8qmQ6OUw3rCrg
         QNNJ6CZYpIDlfwlqh4vkylD1rKdG49nW+/1+SVg4tqrLpAmodyYBTpkxucxgPR1h6PZp
         FuaiVI/ssKgxQWwtJOACJ911uM6iWY2vj9Mw2beZjL5GjemUljSe0v9OiMO22dcAtoPH
         XtCZvp/cTDz2FcxrxH0DAgIRg5Xnb+TNBei8cjJh4R0E+0yuP3FNzsF/4H12GNyV63ef
         a5hUEAXcNqNPkq54pd8KotovRvTtUfiv6K+7ckKzE+cyPzJkDUWkU6QsYP3nE9LNMMFy
         i2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721770366; x=1722375166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ei+FAtI2RnZQIpiGeAOXZY2/EWuGpUeNTDCAqAstsm4=;
        b=tO0IRzxQ3Ba45QJax1cYhXh5vtF2TiJC1x+RUeknQXMz5wyiSpGLN7coeFuEjb0BoB
         +6S/Lh0l00Jae5X4QQH6MjcUlTCPlau/9OahJjdTqMxKwbNB9OPEaX3AWlgZXuTqpkAN
         aDVbVPeAUgQjF68x8St856DCjQ9akhuSFmHO9+MKCd7TTqN93romJ1WUY4Z7YHAw4aTI
         ho4bNhdUvfFNldIO3/fWuFauNU0g+UGomvuHE9+dcts3Z0i/Nxe2fLiM985ZBRxZwUu1
         XyEBrlg047OzpiG/5Xzl9cLDTUl39XAO+BZS1ejK69WWcy63c+DxG0Z44wOLTPElH5kR
         WZrw==
X-Gm-Message-State: AOJu0Yy99vqqUUmcbxOmgvcnTqfTDWMyl0i5L0XoCZEhHNhNvJErOtIi
	FDhoXKxmWuey/v26kt2f1kWZjcBe0cGcumZMBB2rIYkVZuOj4PyjqB0bY+Pdg8p5BWwwn09lAPg
	L3OsBmA7Ho1SNTrU9IwNjMw6ECg4Ogo6qoKLeCDpRHzpEJbfY5ZA/i6Q=
X-Google-Smtp-Source: AGHT+IExJLiOBvDO6NAQSQKes9ua1Bu4dXGrE0Bd5QTil+kSlj1WwQJL0RpqyaG455IQs5vB+Em/UM2jWdmfnvc3AB8=
X-Received: by 2002:ac8:7f49:0:b0:447:e423:a463 with SMTP id
 d75a77b69052e-44fd4a74d29mr1318511cf.3.1721770365575; Tue, 23 Jul 2024
 14:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723204834.3617647-1-ak@linux.intel.com> <20240723204834.3617647-3-ak@linux.intel.com>
In-Reply-To: <20240723204834.3617647-3-ak@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Jul 2024 14:32:33 -0700
Message-ID: <CAP-5=fU8=gTatcHkvN8jv72_dJvaAb3FE+pnWB2LSN=SM0dRxw@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] perf script: Fix perf script -F +metric
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 1:48=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
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

I don't follow this. Samples have CPUs but you're associating all
values with CPU0. Why not just use counts and aggregation properly?

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
> ---
>  tools/perf/builtin-script.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c16224b1fef3..1a4b9b3d240d 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2133,12 +2133,17 @@ static void perf_sample__fprint_metric(struct per=
f_script *script,
>         if (evsel_script(leader)->gnum++ =3D=3D 0)
>                 perf_stat__reset_shadow_stats();
>         val =3D sample->period * evsel->scale;
> +       /*
> +        * Always use CPU 0 storage because the groups are contiguous
> +        * and there's no need to handle multiple indexes for anything
> +        */
> +       evsel->stats->aggr[0].counts.val =3D val;

0 isn't necessary CPU0, it is what is the first aggregation
cpu_aggr_map which can be CPU1, it can be a thread map index. The
comment is confusing an index with a CPU number.

>         evsel_script(evsel)->val =3D val;

Why store val twice? Yes it is read below, but now you can also just
read it from the counts. Not that it matters in the cases that apply
but for json metrics all counts are unscaled.

>         if (evsel_script(leader)->gnum =3D=3D leader->core.nr_members) {
>                 for_each_group_member (ev2, leader) {
>                         perf_stat__print_shadow_stats(&stat_config, ev2,
>                                                       evsel_script(ev2)->=
val,
> -                                                     sample->cpu,
> +                                                     0,
>                                                       &ctx,
>                                                       NULL);
>                 }
> @@ -2325,6 +2330,20 @@ static void process_event(struct perf_script *scri=
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

No idea what this is doing. What's conflicting with what?

>  static struct scripting_ops    *scripting_ops;
>
>  static void __process_stat(struct evsel *counter, u64 tstamp)
> @@ -2334,6 +2353,8 @@ static void __process_stat(struct evsel *counter, u=
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
> @@ -3725,6 +3746,8 @@ static int process_stat_config_event(struct perf_se=
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
> @@ -3760,6 +3783,8 @@ int process_thread_map_event(struct perf_session *s=
ession,
>         struct perf_tool *tool =3D session->tool;
>         struct perf_script *script =3D container_of(tool, struct perf_scr=
ipt, tool);
>
> +       check_metric_conflict();
> +
>         if (dump_trace)
>                 perf_event__fprintf_thread_map(event, stdout);
>
> @@ -3785,6 +3810,8 @@ int process_cpu_map_event(struct perf_session *sess=
ion,
>         if (dump_trace)
>                 perf_event__fprintf_cpu_map(event, stdout);
>
> +       check_metric_conflict();
> +
>         if (script->cpus) {
>                 pr_warning("Extra cpu map event, ignoring.\n");
>                 return 0;
> @@ -4088,6 +4115,10 @@ int cmd_script(int argc, const char **argv)
>
>         argc =3D parse_options_subcommand(argc, argv, options, script_sub=
commands, script_usage,
>                              PARSE_OPT_STOP_AT_NON_OPTION);
> +       for (i =3D 0; i < OUTPUT_TYPE_MAX; i++) {
> +               if (output[i].fields & PERF_OUTPUT_METRIC)
> +                       stat_config.aggr_map =3D &(struct cpu_aggr_map){ =
.nr =3D 1 };

Assigning the address a temporary rval to a global variable seems
wrong to the point I'm surprised it compiles. Accessing
stat_config.aggr_map->map[0] will lead to reading beyond the end of
the value and presumably read uninitialized memory.  Compiling with
EXTRA_CFLAGS=3D"-fsanitize=3Daddress" should complain about all of this.

Thanks,
Ian

> +       }
>
>         if (symbol_conf.guestmount ||
>             symbol_conf.default_guest_vmlinux_name ||
> --
> 2.45.2
>
>
