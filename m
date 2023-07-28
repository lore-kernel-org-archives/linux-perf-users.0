Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BF0C001DE
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Jul 2023 17:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjG1RmV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Jul 2023 13:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG1RmV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Jul 2023 13:42:21 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4132D4D
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jul 2023 10:42:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe07f0636bso4163257e87.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jul 2023 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690566137; x=1691170937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYLF84njYUu7JSVKHy5D6nCKlYMLp+3wofRRJeXEu7E=;
        b=iziTcra8O3kMOn7bPIAuiGktuKrjNiFuJrcytTPBjE9Z/F/6KagvBYqTFcSv0A2VD7
         fT0v2rYCw920LjFd2VW/H4+JnPKVEVA0k0pjKSQK/V7Fp+Pw95jdZ6RnXE+mirtB7RXX
         dVKIW5mX6DYU1TjRy+tJe62RfohmYOUgi9H0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566137; x=1691170937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYLF84njYUu7JSVKHy5D6nCKlYMLp+3wofRRJeXEu7E=;
        b=jaU2Tg0GqvGkxzvVPkMRUJxn2Zs+897BjD80t5zf94xgEXFAvOLu5AK5e4zhMGeh7K
         ewsHz3va2X7kd32P25ShwjmVSKXoL0qzZklJXKWlQ3ntAHTcBodJuYePvWo5+fAP7Z/7
         sUJqNE8PyvG5TZvZ1r/N428gr5KyEqh5cdSeEJ+7T8pDjlqrjbQIJt0pGs2GFjsZXX4i
         x1lQiBGH09sr+OlCtcY5CLljtew7VANG+Z+uxff3YmaaqUovYQMAlhiy+CN+aTYv6KD2
         oNc35/vgaAODPmVDWP8CzI0v6lvrifPo91vQn3f7ZpK9jo78BvgHqlTBXSO/pwKQ3ZxE
         l83g==
X-Gm-Message-State: ABy/qLZM5wBFCNWUpo0ZeD+IYnAbdNptNp3SKDbcErxeW5e4EOb/lAiO
        cEstdWtFDQV6oqNq4e5J2csE4qhW0Mk+St8l1txJFyDWkDg/lcYa
X-Google-Smtp-Source: APBJJlG+syxVWj31WyFpRDPU//DQTURjhEbh1wZ/zUchJicEJUyhjhyKV0VnmRkXLQh+8lqsZFetH31/oxxS+EeaRmM=
X-Received: by 2002:a19:9146:0:b0:4fb:7b4c:d38c with SMTP id
 y6-20020a199146000000b004fb7b4cd38cmr2103056lfj.60.1690566137512; Fri, 28 Jul
 2023 10:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230718000737.49077-1-ivan@cloudflare.com>
In-Reply-To: <20230718000737.49077-1-ivan@cloudflare.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 28 Jul 2023 10:42:06 -0700
Message-ID: <CABWYdi2E1XozvwsZwOA80X-YbqLejj_5sxzNAh7w6R93rD5sCw@mail.gmail.com>
Subject: Re: [PATCH] perf script: print cgroup on the same line as comm
To:     linux-perf-users@vger.kernel.org
Cc:     kernel-team@cloudflare.com, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 17, 2023 at 5:07=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com> w=
rote:
>
> Commit 3fd7a168bf51 ("perf script: Add 'cgroup' field for output")
> added support for printing cgroup path in perf script output.
>
> It was okay if you didn't want any stacks:
>
>     $ sudo perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,cgrou=
p
>     jpegtran:23f4bf 3321915 [013] 404718.587488:  /idle.slice/polish.serv=
ice
>     jpegtran:23f4bf 3321915 [031] 404718.592073:  /idle.slice/polish.serv=
ice
>
> With stacks it gets messier as cgroup is printed after the stack:
>
>     $ perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,cgroup,ip,=
sym
>     jpegtran:23f4bf 3321915 [013] 404718.587488:
>                     5c554 compress_output
>                     570d9 jpeg_finish_compress
>                     3476e jpegtran_main
>                     330ee jpegtran::main
>                     326e2 core::ops::function::FnOnce::call_once (inlined=
)
>                     326e2 std::sys_common::backtrace::__rust_begin_short_=
backtrace
>     /idle.slice/polish.service
>     jpegtran:23f4bf 3321915 [031] 404718.592073:
>                     8474d jsimd_encode_mcu_AC_first_prepare_sse2.PADDING
>                 55af68e62fff [unknown]
>     /idle.slice/polish.service
>
> Let's instead print cgroup on the same line as comm:
>
>     $ perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,cgroup,ip,=
sym
>     jpegtran:23f4bf 3321915 [013] 404718.587488:  /idle.slice/polish.serv=
ice
>                     5c554 compress_output
>                     570d9 jpeg_finish_compress
>                     3476e jpegtran_main
>                     330ee jpegtran::main
>                     326e2 core::ops::function::FnOnce::call_once (inlined=
)
>                     326e2 std::sys_common::backtrace::__rust_begin_short_=
backtrace
>
>     jpegtran:23f4bf 3321915 [031] 404718.592073:  /idle.slice/polish.serv=
ice
>                     8474d jsimd_encode_mcu_AC_first_prepare_sse2.PADDING
>                 55af68e62fff [unknown]
>
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> Fixes: 3fd7a168bf51 ("perf script: Add 'cgroup' field for output")
> ---
>  tools/perf/builtin-script.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 200b3e7ea8da..517bf25750c8 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2199,6 +2199,17 @@ static void process_event(struct perf_script *scri=
pt,
>         if (PRINT_FIELD(RETIRE_LAT))
>                 fprintf(fp, "%16" PRIu16, sample->retire_lat);
>
> +       if (PRINT_FIELD(CGROUP)) {
> +               const char *cgrp_name;
> +               struct cgroup *cgrp =3D cgroup__find(machine->env,
> +                                                  sample->cgroup);
> +               if (cgrp !=3D NULL)
> +                       cgrp_name =3D cgrp->name;
> +               else
> +                       cgrp_name =3D "unknown";
> +               fprintf(fp, " %s", cgrp_name);
> +       }
> +
>         if (PRINT_FIELD(IP)) {
>                 struct callchain_cursor *cursor =3D NULL;
>
> @@ -2243,17 +2254,6 @@ static void process_event(struct perf_script *scri=
pt,
>         if (PRINT_FIELD(CODE_PAGE_SIZE))
>                 fprintf(fp, " %s", get_page_size_name(sample->code_page_s=
ize, str));
>
> -       if (PRINT_FIELD(CGROUP)) {
> -               const char *cgrp_name;
> -               struct cgroup *cgrp =3D cgroup__find(machine->env,
> -                                                  sample->cgroup);
> -               if (cgrp !=3D NULL)
> -                       cgrp_name =3D cgrp->name;
> -               else
> -                       cgrp_name =3D "unknown";
> -               fprintf(fp, " %s", cgrp_name);
> -       }
> -
>         perf_sample__fprintf_ipc(sample, attr, fp);
>
>         fprintf(fp, "\n");
> --
> 2.41.0
>

A friendly bump in case this slipped through the cracks.
