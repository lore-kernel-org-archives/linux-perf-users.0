Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0EA1465A0
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Aug 2024 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723140565; cv=none; b=fWK/jPZS2EcV+2yXxSh5KeDN6PNh3ujnIyaiQr42o8Mp6/3FdmWt1SPd4tTYelb7dvZ9Dk0pgk+pUrUuEs2amfSojFL8172iEYQBoLWDWQp8WJW3gYWl99YHw2hKQgyLtdZB2ppzKkRXWLX2uwEjvuADss91mwdIGcVNTptZlM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723140565; c=relaxed/simple;
	bh=CPdkAjx8LITcWoIHNLvr2+Ws3EjcYxlxLFI/P7lqo1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lerj2plrRwIoA8EupmKZxhHq/TG5CUhsDPAFC+0A61q+bgE3t2P0bf0M+sdh/79BIOi4L5wEydk/fWKd6BQS/pN96KMMa3COIXmGN/YLMmXPZIJioZ4PeSLuMSrrwQbIF5qJDUvFIUwZJghspoLKaty8uFztK9vRpI/MvsbuJVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gwT4KknQ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gwT4KknQ"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-45029af1408so11531cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Aug 2024 11:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723140562; x=1723745362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4UPgj3Oh7A/Nbz7mZimRA+1DuQyIQXQNudOvMAF09A=;
        b=gwT4KknQ8gQNTGUtM7z+AH3RYtLqKAkNNjWiCnkq3MchMBOOpHdIrsU4JzU4rCh/qR
         MgCyStmsdFWQHnkyLU0DKmSx261GIaVVMPC5yq1Lm80eyyX+MUYN2KL1PZIgIcDxqGuP
         B5koahft53X0Gw4xlc4TjYgD1Jl+FlUlYq3u+74j7WS90GjXxrEkycbcY8UNIKHXdc4/
         oOtPkN4A45h4C8WATy9S+ogR4o+7sO3L4yMADhAXhyW68Y7AwtzBZDjaYvuAq2XEXGqa
         gGQdO2AdabluiHMLcqnB8eCcplHSCReWQTXsJHcynbfkaBmDxkcQvp1JvgCdJP8ZaLnJ
         jI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723140562; x=1723745362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4UPgj3Oh7A/Nbz7mZimRA+1DuQyIQXQNudOvMAF09A=;
        b=iCP+75+/z73h3T+2zDY0inW3Gm4GdH/TcF+zX/pHj8nzsD3tVdbaYa0+J+AMOowuQY
         w0db+S1NZCNKM8c+wjgUSuC358xYK2vOOdUDKTFLUkiUfVauCH+lPwk3xyXsK6yPXmw7
         IQeH1G8yZwoaUWyzFDs04HplWmkEVsuYfpkBFKC27r0FMYCvgdyQQx/Yaf4Q1upOXyEw
         T34eJ107zOMBphSW/aK1d9h/qPvPuKpfiV1XTAOEC/+jq7Gj7+dG2HzvHv57dZFllUuV
         v8+0iDQWwGyahEBb9t36PmfQ4MvkdvdVD/vpumvHZB4b7o2xyhoF294lShzxt3EVHttZ
         7S2g==
X-Forwarded-Encrypted: i=1; AJvYcCUH67oJfT2u6zR/0sN7rmmukd3yszX3uQ8qb27orFV/Zr4xc3pqXD6OGa9m/4CRzbLe/0asOxv4vBhHA8k1ov/vmABUps1TZ9vBcjDX6OcGPA==
X-Gm-Message-State: AOJu0Yy7MfvW1/1zxEfyAqXBby7dUBjWy/ht0In8jkC+loHH2TBWFTmB
	TRTXZTuFktVDCsXyhE3CLAiaCVn9QetDlIdsR98U7zO/zTX7YNXGKpUP92A6v1L6QdpjigsW9tb
	bTqkMl2v1uBF1I1NAGaAIWEET5pduH3fV621BCEZrtDkhiEbe4d2wuQQ=
X-Google-Smtp-Source: AGHT+IFAPQd4Idn9jeeMQ6j6GTs+VxYKlFoNHFLXZoY/GPuW1qu21rS53VfWIqQCpvvFbjCUv5DELRL72pCMtmm5bQQ=
X-Received: by 2002:ac8:5e4c:0:b0:447:f891:d41d with SMTP id
 d75a77b69052e-4530dd4db9cmr176171cf.18.1723140562168; Thu, 08 Aug 2024
 11:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807231823.898979-1-ak@linux.intel.com> <20240807231823.898979-3-ak@linux.intel.com>
 <CAM9d7ci40WcV=EtsNuNXkRAWc3XHDKzb9OACNUhD5WaqTu5vxg@mail.gmail.com>
In-Reply-To: <CAM9d7ci40WcV=EtsNuNXkRAWc3XHDKzb9OACNUhD5WaqTu5vxg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 8 Aug 2024 11:09:10 -0700
Message-ID: <CAP-5=fVZ0_orgpLcG492WtjW05QWu2Mbnuv=_NKweouVXq2icA@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] perf script: Fix perf script -F +metric
To: Namhyung Kim <namhyung@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 10:18=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Andi,
>
> On Wed, Aug 7, 2024 at 4:18=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wr=
ote:
> >
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
>
> Thanks for your work, for the series:
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Fwiw, not acked-by me. Repeating my comments below:

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
> > v8: Add check for leader sampling. Update some comments.
> > v9: Correct check for leader sampling (Namhyung)
> > v10: Check for PERF_FORMAT_GROUP and PERF_SAMPLE_READ (Namhyung)
> > ---
> >  tools/perf/builtin-script.c | 51 +++++++++++++++++++++++++++++++++----
> >  1 file changed, 46 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index c16224b1fef3..cb63507af839 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -335,7 +335,6 @@ struct evsel_script {
> >         FILE *fp;
> >         u64  samples;
> >         /* For metric output */
> > -       u64  val;
> >         int  gnum;

We're globally assuming properties of events assuming leader sampling.
gnum shouldn't exist. The assumptions will be invalid when leader
sampling isn't enabled.

> >  };
> >
> > @@ -2127,18 +2126,31 @@ static void perf_sample__fprint_metric(struct p=
erf_script *script,
> >         };
> >         struct evsel *ev2;
> >         u64 val;
> > +       static int printed;
> >
> >         if (!evsel->stats)
> >                 evlist__alloc_stats(&stat_config, script->session->evli=
st, /*alloc_raw=3D*/false);
> >         if (evsel_script(leader)->gnum++ =3D=3D 0)
> >                 perf_stat__reset_shadow_stats();
> > -       val =3D sample->period * evsel->scale;
> > -       evsel_script(evsel)->val =3D val;
> > +       val =3D sample->period;
> > +       if (!(leader->core.attr.read_format & PERF_FORMAT_GROUP) ||
> > +           !(leader->core.attr.sample_type & PERF_SAMPLE_READ)) {
> > +               if (!printed)
> > +                       fprintf(stderr, "perf script: -F metric require=
s {}:S for groups leader sampling\n");
> > +               printed =3D 1;
> > +               return;
> > +       }
> > +       /*
> > +        * Always use the first entry as storage because the leader sam=
pling
> > +        * groups are contiguous and there's no need to handle multiple=
 indexes
> > +        * for anything.
> > +        */
> > +       evsel->stats->aggr[0].counts.val =3D val;

Updating counts needs perf_stat_process_counter to update the
aggregation. How does sample->cpu given below relate to aggr[0] here?
This and the comment above are a hack liable to break in anything but
straightforward circumstances. See:
https://lore.kernel.org/lkml/20240720074552.1915993-2-irogers@google.com/
on how to handle this.

> >         if (evsel_script(leader)->gnum =3D=3D leader->core.nr_members) =
{
> >                 for_each_group_member (ev2, leader) {
> >                         perf_stat__print_shadow_stats(&stat_config, ev2=
,
> > -                                                     evsel_script(ev2)=
->val,
> > -                                                     sample->cpu,
> > +                                                     evsel->stats->agg=
r[0].counts.val,
> > +                                                     0,

Similarly this hard coded and unexplained constant.

> >                                                       &ctx,
> >                                                       NULL);
> >                 }
> > @@ -2325,6 +2337,20 @@ static void process_event(struct perf_script *sc=
ript,
> >                 fflush(fp);
> >  }
> >
> > +static void check_metric_conflict(void)
> > +{
> > +       int i;
> > +       /*
> > +        * Avoid conflict with the aggregation mode used for the metric=
 printing.
> > +        */

Why is it a conflict, why not support aggregation modes?

Thanks,
Ian

> > +       for (i =3D 0; i < OUTPUT_TYPE_MAX; i++) {
> > +               if (output[i].fields & PERF_OUTPUT_METRIC) {
> > +                       fprintf(stderr, "perf stat record files are not=
 supported with -F metric\n");
> > +                       exit(1);
> > +               }
> > +       }
> > +}
> > +
> >  static struct scripting_ops    *scripting_ops;
> >
> >  static void __process_stat(struct evsel *counter, u64 tstamp)
> > @@ -2334,6 +2360,8 @@ static void __process_stat(struct evsel *counter,=
 u64 tstamp)
> >         struct perf_cpu cpu;
> >         static int header_printed;
> >
> > +       check_metric_conflict();
> > +
> >         if (!header_printed) {
> >                 printf("%3s %8s %15s %15s %15s %15s %s\n",
> >                        "CPU", "THREAD", "VAL", "ENA", "RUN", "TIME", "E=
VENT");
> > @@ -3725,6 +3753,8 @@ static int process_stat_config_event(struct perf_=
session *session __maybe_unused
> >  {
> >         perf_event__read_stat_config(&stat_config, &event->stat_config)=
;
> >
> > +       check_metric_conflict();
> > +
> >         /*
> >          * Aggregation modes are not used since post-processing scripts=
 are
> >          * supposed to take care of such requirements
> > @@ -4088,6 +4118,17 @@ int cmd_script(int argc, const char **argv)
> >
> >         argc =3D parse_options_subcommand(argc, argv, options, script_s=
ubcommands, script_usage,
> >                              PARSE_OPT_STOP_AT_NON_OPTION);
> > +       for (i =3D 0; i < OUTPUT_TYPE_MAX; i++) {
> > +               if (output[i].fields & PERF_OUTPUT_METRIC) {
> > +                       stat_config.aggr_map =3D cpu_aggr_map__empty_ne=
w(1);
> > +                       err =3D -ENOMEM;
> > +                       if (!stat_config.aggr_map)
> > +                               goto out;
> > +                       err =3D 0;
> > +                       stat_config.aggr_map->nr =3D 1;
> > +                       break;
> > +               }
> > +       }
> >
> >         if (symbol_conf.guestmount ||
> >             symbol_conf.default_guest_vmlinux_name ||
> > --
> > 2.45.2
> >
>
