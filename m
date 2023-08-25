Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2752C7EE2C
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 05:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjHYFKj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 01:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjHYFK0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 01:10:26 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95081FC4
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 22:10:23 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40c72caec5cso183591cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 22:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692940223; x=1693545023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GM5LCWOrYHm+b9e2C3LWn/6EqDtDallIRoPwjyWLLgw=;
        b=cXZ+tmtzRjieSP5Xc82Ks7jFzMg8fiOaMkycJmhKKPkjljsOVkzyH/k4zp4wnJ78Mt
         +mxKPeG0+QxqQ9lfwag5nk8suLxcVA50s9HnNbTLWSmXo5XTuOCwbJ2j/9YMtolAxmcp
         MHE2wZbU6UIL1jrO8Id3wM0Nl5WQYFjnXPMa0hoLnJCf3ZgfIem/atsQUDOLOudLDVAp
         Jgc/mdtMFFOhma/WCYu6FklwtpgRalo9+AGt5a6c+MmwBxhG7EbiByqG8+f1BPKYv/my
         Rku4mW0E04xzUCHMVNOFO1BOcxpiwWyY+pywM8zzzil5k724DRdy/GGlN3oFnnpxe2gD
         0kXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692940223; x=1693545023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GM5LCWOrYHm+b9e2C3LWn/6EqDtDallIRoPwjyWLLgw=;
        b=lyWktt9OhflCYRKPP3EaUzZkmAJ3qIsyTi92C7enAYhuxQSWMTr8cwOQqyn0f8qmOL
         J8fScs+64oiDNlyJanaEV+yadnW8CUYx0o5+GNjDS6UAIsptpD/LDOBueYAO7uqAG6Mw
         novWcuETN4Y+EOWbovCHVlNoUp2GraP50xK0Rv93fjFjEsyN82cWCZyVwkfVbMtcWASk
         GmELjE+qPIizoqLMPW18FR+qsIy8CkhOQ6UiS49YlulSzd1y/ACLcQPjOFeWCOuAKtVU
         AtSQABjR9L8MhJ6HTvuGGPww051DPaWwd7WfDY+1ZDUzrm5ZB8UKMoPqB79Dm6zV7bLy
         2ApA==
X-Gm-Message-State: AOJu0YwpPm+t4oROtISTebXU6eYj565qyWKyKdM4sF8V29wnqplpXlby
        IK29IX+PrNfqss8KoJiTnvft3Yt5rD6hk2VdrXDq7Q==
X-Google-Smtp-Source: AGHT+IG0tyEVEUGxl0lrYufkgEyIAvw8yi4OGUx4DBfPxEbTqKQdXPhMUYiE/cswuweuW6BM+MOqktyYifRs7XltpYw=
X-Received: by 2002:a05:622a:1897:b0:403:affb:3c03 with SMTP id
 v23-20020a05622a189700b00403affb3c03mr163509qtc.10.1692940222719; Thu, 24 Aug
 2023 22:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230821012734.18241-1-yangjihong1@huawei.com> <20230821012734.18241-4-yangjihong1@huawei.com>
In-Reply-To: <20230821012734.18241-4-yangjihong1@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 22:10:11 -0700
Message-ID: <CAP-5=fW1zRmx4xxHLUySJ6jJ7NO5BTCcufN_=27gMak8bu6LMg@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] perf record: Move setting dummy tracking before record__init_thread_masks()
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@arm.com,
        tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Aug 20, 2023 at 6:30=E2=80=AFPM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> User space tasks can migrate between CPUs, so when tracing selected CPUs,
> sideband for all CPUs is needed. In this case set the cpu map of the evse=
l
> to all online CPUs. This may modify the original cpu map of the evlist.
> Therefore, need to check whether the preceding scenario exists before
> record__init_thread_masks().
> Dummy tracking has been set in record__open(), move it before
> record__init_thread_masks() and add a helper for unified processing.

I have a hard time understanding this commit message. Let me have a go:

In order to set cpu maps correctly on dummy events they need to set up
later. Factor out the dummy event initialization from record__open and
move it to its own function record__setup_dummy_event. Move the call
to the record__setup_dummy to before the call to
record__init_thread_masks in cmd_record.

> The sys_perf_event_open invoked is as follows:
>
>   # perf --debug verbose=3D3 record -e cpu-clock -D 100 true
>   <SNIP>
>   Opening: cpu-clock
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1 (PERF_TYPE_SOFTWARE)
>     size                             136
>     config                           0 (PERF_COUNT_SW_CPU_CLOCK)
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|PERIOD|IDENTIFIER
>     read_format                      ID|LOST
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 10318  cpu 0  group_fd -1  flags 0x8 =3D 5
>   sys_perf_event_open: pid 10318  cpu 1  group_fd -1  flags 0x8 =3D 6
>   sys_perf_event_open: pid 10318  cpu 2  group_fd -1  flags 0x8 =3D 7
>   sys_perf_event_open: pid 10318  cpu 3  group_fd -1  flags 0x8 =3D 9
>   sys_perf_event_open: pid 10318  cpu 4  group_fd -1  flags 0x8 =3D 10
>   sys_perf_event_open: pid 10318  cpu 5  group_fd -1  flags 0x8 =3D 11
>   sys_perf_event_open: pid 10318  cpu 6  group_fd -1  flags 0x8 =3D 12
>   sys_perf_event_open: pid 10318  cpu 7  group_fd -1  flags 0x8 =3D 13
>   Opening: dummy:u
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1 (PERF_TYPE_SOFTWARE)
>     size                             136
>     config                           0x9 (PERF_COUNT_SW_DUMMY)
>     { sample_period, sample_freq }   1
>     sample_type                      IP|TID|TIME|IDENTIFIER
>     read_format                      ID|LOST
>     disabled                         1
>     inherit                          1
>     exclude_kernel                   1
>     exclude_hv                       1
>     mmap                             1
>     comm                             1
>     enable_on_exec                   1
>     task                             1
>     sample_id_all                    1
>     exclude_guest                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>     bpf_event                        1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 10318  cpu 0  group_fd -1  flags 0x8 =3D 14
>   sys_perf_event_open: pid 10318  cpu 1  group_fd -1  flags 0x8 =3D 15
>   sys_perf_event_open: pid 10318  cpu 2  group_fd -1  flags 0x8 =3D 16
>   sys_perf_event_open: pid 10318  cpu 3  group_fd -1  flags 0x8 =3D 17
>   sys_perf_event_open: pid 10318  cpu 4  group_fd -1  flags 0x8 =3D 18
>   sys_perf_event_open: pid 10318  cpu 5  group_fd -1  flags 0x8 =3D 19
>   sys_perf_event_open: pid 10318  cpu 6  group_fd -1  flags 0x8 =3D 20
>   sys_perf_event_open: pid 10318  cpu 7  group_fd -1  flags 0x8 =3D 21
>   <SNIP>
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/builtin-record.c | 59 +++++++++++++++++++++++--------------
>  1 file changed, 37 insertions(+), 22 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 12edad8392cc..4ee94058028f 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -906,6 +906,37 @@ static int record__config_off_cpu(struct record *rec=
)
>         return off_cpu_prepare(rec->evlist, &rec->opts.target, &rec->opts=
);
>  }
>
> +static int record__config_tracking_events(struct record *rec)
> +{
> +       struct record_opts *opts =3D &rec->opts;
> +       struct evlist *evlist =3D rec->evlist;
> +       struct evsel *evsel;
> +
> +       /*
> +        * For initial_delay, system wide or a hybrid system, we need to =
add a
> +        * dummy event so that we can track PERF_RECORD_MMAP to cover the=
 delay

This code is explicitly talking about dummy events but the function is
now renamed to call it a tracking event. I think the code should be
consistent.

> +        * of waiting or event synthesis.
> +        */
> +       if (opts->target.initial_delay || target__has_cpu(&opts->target) =
||
> +           perf_pmus__num_core_pmus() > 1) {
> +               evsel =3D evlist__findnew_tracking_event(evlist, false);
> +               if (!evsel)
> +                       return -ENOMEM;
> +
> +               /*
> +                * Enable the dummy event when the process is forked for

Dummy again.

Thanks,
Ian

> +                * initial_delay, immediately for system wide.
> +                */
> +               if (opts->target.initial_delay && !evsel->immediate &&
> +                   !target__has_cpu(&opts->target))
> +                       evsel->core.attr.enable_on_exec =3D 1;
> +               else
> +                       evsel->immediate =3D 1;
> +       }
> +
> +       return 0;
> +}
> +
>  static bool record__kcore_readable(struct machine *machine)
>  {
>         char kcore[PATH_MAX];
> @@ -1286,28 +1317,6 @@ static int record__open(struct record *rec)
>         struct record_opts *opts =3D &rec->opts;
>         int rc =3D 0;
>
> -       /*
> -        * For initial_delay, system wide or a hybrid system, we need to =
add a
> -        * dummy event so that we can track PERF_RECORD_MMAP to cover the=
 delay
> -        * of waiting or event synthesis.
> -        */
> -       if (opts->target.initial_delay || target__has_cpu(&opts->target) =
||
> -           perf_pmus__num_core_pmus() > 1) {
> -               pos =3D evlist__findnew_tracking_event(evlist, false);
> -               if (!pos)
> -                       return -ENOMEM;
> -
> -               /*
> -                * Enable the dummy event when the process is forked for
> -                * initial_delay, immediately for system wide.
> -                */
> -               if (opts->target.initial_delay && !pos->immediate &&
> -                   !target__has_cpu(&opts->target))
> -                       pos->core.attr.enable_on_exec =3D 1;
> -               else
> -                       pos->immediate =3D 1;
> -       }
> -
>         evlist__config(evlist, opts, &callchain_param);
>
>         evlist__for_each_entry(evlist, pos) {
> @@ -4190,6 +4199,12 @@ int cmd_record(int argc, const char **argv)
>                 goto out;
>         }
>
> +       err =3D record__config_tracking_events(rec);
> +       if (err) {
> +               pr_err("record__config_tracking_events failed, error %d\n=
", err);
> +               goto out;
> +       }
> +
>         err =3D record__init_thread_masks(rec);
>         if (err) {
>                 pr_err("Failed to initialize parallel data streaming mask=
s\n");
> --
> 2.30.GIT
>
