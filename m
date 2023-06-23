Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B35EB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 23:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjFWXWk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 19:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjFWXWj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 19:22:39 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583D11A4
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 16:22:38 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40079620a83so103631cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 16:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687562557; x=1690154557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVCy/Qbk9kNtXs7TzOYDCjZWn+6FmeL5t8WtYyr2TL4=;
        b=aTzYN8jTYt6CPp98Tr2lZT8/Z+UJtI536y4LxWMavVgTlAudUdrjF+V9DAT4ilaiNR
         ef03exKNjcoxF0gxn42dDDdajxmbpNajLAhkvZRnnDUowThceFeh6RWhDUR8uxzZVJgS
         yDkSwkxwK/ZAKwdDhGiu912ZsLXQFcBvWYu1oOgNq4BgXqsA91q3w+Vr63ZeLotXlHNV
         g8eoWiORai84PuWIOWrMDpZCJb6dBcytLwrhvizLideXlfNB+j8AaUQVw5IcmvC/H67/
         nlmPvepeEALmBLySxBM7fv0CIMOP2/sZK3q5sDrPcmTc6uXyJKJ2B2eQQoLoCD6+xap1
         jeeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687562557; x=1690154557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVCy/Qbk9kNtXs7TzOYDCjZWn+6FmeL5t8WtYyr2TL4=;
        b=e0aTxEgYawIY7BrBGaI+8u1mYg+qW7xET469KaOyXBZi5xWTe7SR9PtQRZU0ZlT+Uo
         1RQb6Q/JDt2an0UKxHm5610HwUqnaCF7ZxQw+H6HHh+K8pZT+bvFttBqT0d46yINaJVk
         xz702KtMR2HK/u4D2H4L+zfuZVwhdrA8O4Tyq/46L52WQxWD1bzp9B1s9rHRB0IjixPW
         dAxDCBBZUSXcsci1h/kOz7yupYanMMd37CuNThM9AXAiJ6pt42PMhXRj4tNwIP+zd0oj
         AQ+l58SpTMhuNUJdWgzBhpKiJU5nbrOIovRuLG7vHUcCdkmDRvce6+36XHrAOLcFEAS5
         PiBw==
X-Gm-Message-State: AC+VfDytzXT6zj7Oelwt/AVVQJZY8nvdTjhMP+xOk5JvGBn1YaoS9NTX
        SvL9/44SOsCeat2GDs01rl6Uy86pvA7tqxDomsrnFLblu5/x4ll0dcE=
X-Google-Smtp-Source: ACHHUZ4p5kBDh9CVuIEQ6H2HfBbKX547s0FEjTSlecEFitznDyDkatRfqP63wMtH84Gy5QkTpBpLtkLclehdmCUSd+Q=
X-Received: by 2002:a05:622a:1743:b0:3ef:404a:b291 with SMTP id
 l3-20020a05622a174300b003ef404ab291mr49619qtk.7.1687562557389; Fri, 23 Jun
 2023 16:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230623230139.985594-1-namhyung@kernel.org>
In-Reply-To: <20230623230139.985594-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Jun 2023 16:22:25 -0700
Message-ID: <CAP-5=fX6Of3pKjZGLEaNL58opn2veXxOhrY_sQqgY6hgUJeaBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf test: Reorder event name checks in stat STD
 output linter
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 23, 2023 at 4:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On AMD machines, the perf stat STD output test failed like below:
>
>   $ sudo ./perf test -v 98
>    98: perf stat STD output linter                                     :
>   --- start ---
>   test child forked, pid 1841901
>   Checking STD output: no argswrong event metric.
>     expected 'GHz' in 108,121 stalled-cycles-frontend  # 10.88% frontend =
cycles idle
>   test child finished with -1
>   ---- end ----
>   perf stat STD output linter: FAILED!
>
> This is because there are stalled-cycles-{frontend,backend} events are
> used by default.  The current logic checks the event_name array to find
> which event it's running.  But 'cycles' event comes before those stalled
> cycles event and it matches first.  So it tries to find 'GHz' metric
> in the output (which is for the 'cycles') and fails.
>
> Move the stalled-cycles-{frontend,backend} events before 'cycles' so
> that it can find the stalled cycles events first.
>
> Also add a space after 'no args' test name for consistency.
>
> Fixes: 99a04a48f225 ("perf test: Add test case for the standard 'perf sta=
t' output")
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/lib/stat_output.sh | 2 +-
>  tools/perf/tests/shell/stat+std_output.sh | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests=
/shell/lib/stat_output.sh
> index 363979b1123d..698343f0ecf9 100644
> --- a/tools/perf/tests/shell/lib/stat_output.sh
> +++ b/tools/perf/tests/shell/lib/stat_output.sh
> @@ -9,7 +9,7 @@ function ParanoidAndNotRoot()
>  # $1 name $2 extra_opt
>  check_no_args()
>  {
> -        echo -n "Checking $1 output: no args"
> +        echo -n "Checking $1 output: no args "
>          perf stat $2 true
>          commachecker --no-args
>          echo "[Success]"
> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests=
/shell/stat+std_output.sh
> index 98cc3356a04a..1f70aab45184 100755
> --- a/tools/perf/tests/shell/stat+std_output.sh
> +++ b/tools/perf/tests/shell/stat+std_output.sh
> @@ -10,8 +10,8 @@ set -e
>
>  stat_output=3D$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
>
> -event_name=3D(cpu-clock task-clock context-switches cpu-migrations page-=
faults cycles instructions branches branch-misses stalled-cycles-frontend s=
talled-cycles-backend)
> -event_metric=3D("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "GH=
z" "insn per cycle" "/sec" "of all branches" "frontend cycles idle" "backen=
d cycles idle")
> +event_name=3D(cpu-clock task-clock context-switches cpu-migrations page-=
faults stalled-cycles-frontend stalled-cycles-backend cycles instructions b=
ranches branch-misses)
> +event_metric=3D("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "fr=
ontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of=
 all branches")
>
>  metricgroup_name=3D(TopdownL1 TopdownL2)
>
> --
> 2.41.0.162.gfafddb0af9-goog
>
