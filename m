Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF997C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 18:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F17061055
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 18:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbhKHSf6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 13:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbhKHSf5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 13:35:57 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304F3C061570
        for <linux-perf-users@vger.kernel.org>; Mon,  8 Nov 2021 10:33:13 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id l8so17975843ilv.3
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 10:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QIVfKaHwJtR526+2LMpHnZAbFDnNe63R3JsZeT3APHQ=;
        b=qKnNuMB2Yysr+YHoLtECOqBtd6RqCsxpkRe4i8GBps3dnBnyDJXRNQPDe/Bq/+OROk
         8HObSeh0X0wJ6M8xg8Qk8x0ONCUdEpIp0P9U/zYGUh7Dmw8rQ3b7gzaxf2Ywoa8Z+Vpt
         wkiyv7Gep4/KVSQ4MTdfYkTpjUEPvRYELtkRzQolT5iH/SljwcwX/4k41FsjFGfyGzT7
         p2YB8tn/+f9BcyWe1r/vneK9Va05uMSfwtpvPkop7AsZxNA4wZaW0r+//yMUZPnQKp/a
         oS1Z61TXOgT58LZJxPxnmb5h9Su7VQ66x2TWqjKFelEpUtn9CjI2msUWg5iod+2Cc5Hc
         ZEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIVfKaHwJtR526+2LMpHnZAbFDnNe63R3JsZeT3APHQ=;
        b=6MD7E49zmZMokdZOBtwb5VWjyh4cJCTJdqeRnzJlRaEhh5AxNjofsVM2S28ctKIMBn
         k85I9MA2vQMkYHRVpZymkBevHyJTg31eZQw3JUAUMseT050fPPHOTZExY0Q1UALVO5yl
         loK6nUESkqVCgzxLWbgG6BAdngnYe8Ljo5cTdUYYPdkGo+tnOjE2nCTTA6Fxhtbdh5X+
         JOg4DD/WuEPEDVoDjcQPAXaKT0dHb1fV0ngdMW88kJypngPLNjJSSvr7mOuAWlh3RVyv
         2T+1iuCf1yZ+D/5bjZzxRvFitUe6Yqqej/yClvwyuvYkYXoNHJC0gcKJLEX8MVKKSS2r
         Rybg==
X-Gm-Message-State: AOAM533R8RP4oMpT6jMeqePgTAegP97am1FvM/RyQVK7u+dHuhjy2qEG
        8YYS52bjEsk6s3e8RdmEYwfzBKk6enQptmz53Vk6yw==
X-Google-Smtp-Source: ABdhPJw+1BehD8hqC9/bKWsUR1ZuyKUNpsDdVbwKUyo/A5hfrglGQdb4rGHZdmYt/Fr6WbKruKcV62Q1/1AyCXHkgso=
X-Received: by 2002:a05:6e02:174e:: with SMTP id y14mr832768ill.89.1636396392424;
 Mon, 08 Nov 2021 10:33:12 -0800 (PST)
MIME-Version: 1.0
References: <20211108133710.1352822-1-jolsa@kernel.org> <20211108133710.1352822-60-jolsa@kernel.org>
In-Reply-To: <20211108133710.1352822-60-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 8 Nov 2021 10:32:57 -0800
Message-ID: <CAP-5=fXgNKGwiF-HnSrC6S6LKm1qQw66wjEx=0pGELLCcDcfrQ@mail.gmail.com>
Subject: Re: [PATCH 59/59] libperf: Add parse-events test
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 8, 2021 at 5:43 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> Adding parse-events test.

Fwiw, we fuzz test this code but filter out strings containing .bpf.,
.o or .c to avoid the fuzzer turning into an LLVM fuzzer. This
refactoring will solve some linking issues we have. Perhaps we can set
up fuzz testing here?

Thanks,
Ian

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/perf/tests/Build               |  1 +
>  tools/lib/perf/tests/main.c              |  1 +
>  tools/lib/perf/tests/test-evlist.c       |  2 ++
>  tools/lib/perf/tests/test-parse-events.c | 41 ++++++++++++++++++++++++
>  tools/lib/perf/tests/tests.h             |  1 +
>  5 files changed, 46 insertions(+)
>  create mode 100644 tools/lib/perf/tests/test-parse-events.c
>
> diff --git a/tools/lib/perf/tests/Build b/tools/lib/perf/tests/Build
> index 56e81378d443..f1d1133d8dae 100644
> --- a/tools/lib/perf/tests/Build
> +++ b/tools/lib/perf/tests/Build
> @@ -3,3 +3,4 @@ tests-y += test-evsel.o
>  tests-y += test-evlist.o
>  tests-y += test-cpumap.o
>  tests-y += test-threadmap.o
> +tests-y += test-parse-events.o
> diff --git a/tools/lib/perf/tests/main.c b/tools/lib/perf/tests/main.c
> index 56423fd4db19..bfa8ba05c422 100644
> --- a/tools/lib/perf/tests/main.c
> +++ b/tools/lib/perf/tests/main.c
> @@ -7,6 +7,7 @@ int tests_verbose;
>
>  int main(int argc, char **argv)
>  {
> +       __T("test parse_events", !test_parse_events(argc, argv));
>         __T("test cpumap", !test_cpumap(argc, argv));
>         __T("test threadmap", !test_threadmap(argc, argv));
>         __T("test evlist", !test_evlist(argc, argv));
> diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
> index ce91a582f0e4..199451a605a1 100644
> --- a/tools/lib/perf/tests/test-evlist.c
> +++ b/tools/lib/perf/tests/test-evlist.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#ifndef _GNU_SOURCE
>  #define _GNU_SOURCE // needed for sched.h to get sched_[gs]etaffinity and CPU_(ZERO,SET)
> +#endif
>  #include <sched.h>
>  #include <stdio.h>
>  #include <stdarg.h>
> diff --git a/tools/lib/perf/tests/test-parse-events.c b/tools/lib/perf/tests/test-parse-events.c
> new file mode 100644
> index 000000000000..5f913f82de7f
> --- /dev/null
> +++ b/tools/lib/perf/tests/test-parse-events.c
> @@ -0,0 +1,41 @@
> +#include <stdio.h>
> +#include <linux/perf_event.h>
> +#include <linux/hw_breakpoint.h>
> +#include <perf/evlist.h>
> +#include <perf/evsel.h>
> +#include <internal/evlist.h>
> +#include <internal/tests.h>
> +#include "tests.h"
> +
> +static int libperf_print(enum libperf_print_level level,
> +                        const char *fmt, va_list ap)
> +{
> +       return vfprintf(stderr, fmt, ap);
> +}
> +
> +int test_parse_events(int argc, char **argv)
> +{
> +       struct perf_evlist *evlist;
> +       struct perf_evsel *evsel;
> +       int err;
> +
> +       __T_START;
> +
> +       libperf_init(libperf_print);
> +
> +       evlist = perf_evlist__new();
> +       __T("failed to create evlist", evlist);
> +
> +       err = libperf_parse_events(evlist, "mem:0:rw");
> +       __T("failed to parse events", !err);
> +
> +       evsel = perf_evlist__first(evlist);
> +
> +       __T("wrong type", PERF_TYPE_BREAKPOINT == evsel->attr.type);
> +       __T("wrong config", 0 == evsel->attr.config);
> +       __T("wrong bp_type", (HW_BREAKPOINT_R|HW_BREAKPOINT_W) == evsel->attr.bp_type);
> +       __T("wrong bp_len", HW_BREAKPOINT_LEN_4 == evsel->attr.bp_len);
> +
> +       __T_END;
> +       return tests_failed == 0 ? 0 : -1;
> +}
> diff --git a/tools/lib/perf/tests/tests.h b/tools/lib/perf/tests/tests.h
> index 604838f21b2b..b4f27fc9c46d 100644
> --- a/tools/lib/perf/tests/tests.h
> +++ b/tools/lib/perf/tests/tests.h
> @@ -6,5 +6,6 @@ int test_cpumap(int argc, char **argv);
>  int test_threadmap(int argc, char **argv);
>  int test_evlist(int argc, char **argv);
>  int test_evsel(int argc, char **argv);
> +int test_parse_events(int argc, char **argv);
>
>  #endif /* TESTS_H */
> --
> 2.31.1
>
