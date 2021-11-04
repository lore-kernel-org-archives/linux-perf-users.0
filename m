Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA038C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 13:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CB260E98
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 13:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhKDNx7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 09:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhKDNx6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 09:53:58 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE35C061714;
        Thu,  4 Nov 2021 06:51:20 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id t11so9643975ljh.6;
        Thu, 04 Nov 2021 06:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=udxpWNmJvR3P/1fUceUMry5Vv92QsnKfxo9U4xtsz6s=;
        b=FP9RtWkvxgfM2JcjEXDocZ7rd58VHJTE3088VeIqyZeRtVsuIe9VV6VKPuoNEHpIWn
         BFrvJbbLnJm/h0CFLopCU0vX8zv/eJjLZmlMnmvKyPIx65ggsv0tCZWS3ZdlvShegUOI
         EBbIr6ju/6ZO9wvC/yzAlpq2srmkHKnnDS4jwBzWI5XEgmzTXTFCWviTvxBKRDeTfvEi
         JE3KuMCRxflymsrBIBdhVJ5WUf4iHZGc2hP5wspbA9LHG8Ac4VwuMl4Jj/sbO62b1ts4
         NS9fEvX5NrkJj3gbvElfVW/wNaFROYSRikl/xQuJ9PAGczu567Dr5+Zak8iBNxHZjaZC
         J5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=udxpWNmJvR3P/1fUceUMry5Vv92QsnKfxo9U4xtsz6s=;
        b=1JKxbEdznvxCAcRoMcPIK1al5a35JRcyq2eMRZ2IxGDrXg0DPznbW6IUV500QBK+bQ
         vPLFVbXiX85LY2iAyEy25yw5VPTLLqd4F9TBz+tbowNaYpMVzdUkYHI2hEKOhLA2v42/
         shjdQhifV4+5dnRZHN6o/sQRWLYJTQgYGyPaTVu8DiNeFG6LeMkhl9jBridloyruuXOw
         9ymTSoGo0kvh8YhVrweqHAADaGa6geixdCXrlSq8SVVxoBZDg6+OtBoHo0YxoUTQ+sYi
         odj3zEobouIGXSwV6/QG0SMFocrm9dOnSK8poq0mDXEt9fF9BKAnbZL5Fb90nh08uNou
         kXDA==
X-Gm-Message-State: AOAM532qDm6TFpycs7WWcuN/EIkxVW+whddnu1q6a+xH0Mi1Zp9lzRO4
        KOg2v1LVfzx1m3PuOyWWhqW4NK38gizKjeDTlC7FMf9hzHIJDw==
X-Google-Smtp-Source: ABdhPJzXhNnAIpv4JO6ximXMlfzmPOnttJ0oZdlcMERJ6TIMB9wXjXx04BKhXoxvQf/McwghoiarzUP075enBjIEIv0=
X-Received: by 2002:a2e:a885:: with SMTP id m5mr650331ljq.166.1636033878714;
 Thu, 04 Nov 2021 06:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com> <20211104064208.3156807-23-irogers@google.com>
In-Reply-To: <20211104064208.3156807-23-irogers@google.com>
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Date:   Thu, 4 Nov 2021 15:51:07 +0200
Message-ID: <CAOz-JA7Wu07aE29K1LHZEPNojop59xTcQO+zjHR4gVB6YK+ykA@mail.gmail.com>
Subject: Re: [PATCH v3 22/22] perf test: Remove skip_if_fail
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 4, 2021 at 8:43 AM Ian Rogers <irogers@google.com> wrote:
>
> Remove optionality, always run tests in a suite even if one fails. This
> brings perf's test more inline with kunit that lacks this notion.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
> ---
>  tools/perf/tests/bpf.c          |  1 -
>  tools/perf/tests/builtin-test.c | 24 ++++++++----------------
>  tools/perf/tests/clang.c        |  1 -
>  tools/perf/tests/llvm.c         |  1 -
>  tools/perf/tests/pfm.c          |  1 -
>  tools/perf/tests/tests.h        |  3 ---
>  6 files changed, 8 insertions(+), 23 deletions(-)
>
> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> index e86a77ce93ef..c3d6eda8601e 100644
> --- a/tools/perf/tests/bpf.c
> +++ b/tools/perf/tests/bpf.c
> @@ -382,5 +382,4 @@ static struct test_case bpf_tests[] = {
>  struct test_suite suite__bpf = {
>         .desc = "BPF filter",
>         .test_cases = bpf_tests,
> -       .subtest = { .skip_if_fail = true, },
>  };
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 19b1228dbd5d..8cb5a1c3489e 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -238,18 +238,13 @@ static int run_test(struct test_suite *test, int subtest)
>         for (j = 0; j < ARRAY_SIZE(tests); j++) \
>                 for (k = 0, t = tests[j][k]; tests[j][k]; k++, t = tests[j][k])
>
> -static int test_and_print(struct test_suite *t, bool force_skip, int subtest)
> +static int test_and_print(struct test_suite *t, int subtest)
>  {
>         int err;
>
> -       if (!force_skip) {
> -               pr_debug("\n--- start ---\n");
> -               err = run_test(t, subtest);
> -               pr_debug("---- end ----\n");
> -       } else {
> -               pr_debug("\n--- force skipped ---\n");
> -               err = TEST_SKIP;
> -       }
> +       pr_debug("\n--- start ---\n");
> +       err = run_test(t, subtest);
> +       pr_debug("---- end ----\n");
>
>         if (!has_subtests(t))
>                 pr_debug("%s:", t->desc);
> @@ -432,7 +427,7 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
>                         continue;
>                 }
>
> -               test_and_print(&test_suite, false, 0);
> +               test_and_print(&test_suite, 0);
>         }
>
>         for (e = 0; e < n_dirs; e++)
> @@ -456,7 +451,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>         }
>
>         for_each_test(j, k, t) {
> -               int curr = i++, err;
> +               int curr = i++;
>                 int subi;
>
>                 if (!perf_test__matches(test_description(t, -1), curr, argc, argv)) {
> @@ -483,7 +478,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>                 }
>
>                 if (!has_subtests(t)) {
> -                       test_and_print(t, false, -1);
> +                       test_and_print(t, -1);
>                 } else {
>                         int subn = num_subtests(t);
>                         /*
> @@ -495,7 +490,6 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>                          * 35.1: Basic BPF llvm compiling test                          : Ok
>                          */
>                         int subw = width > 2 ? width - 2 : width;
> -                       bool skip = false;
>
>                         if (subn <= 0) {
>                                 color_fprintf(stderr, PERF_COLOR_YELLOW,
> @@ -518,9 +512,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>
>                                 pr_info("%2d.%1d: %-*s:", i, subi + 1, subw,
>                                         test_description(t, subi));
> -                               err = test_and_print(t, skip, subi);
> -                               if (err != TEST_OK && t->subtest.skip_if_fail)
> -                                       skip = true;
> +                               test_and_print(t, subi);
>                         }
>                 }
>         }
> diff --git a/tools/perf/tests/clang.c b/tools/perf/tests/clang.c
> index ba06a2257574..a7111005d5b9 100644
> --- a/tools/perf/tests/clang.c
> +++ b/tools/perf/tests/clang.c
> @@ -29,5 +29,4 @@ static struct test_case clang_tests[] = {
>  struct test_suite suite__clang = {
>         .desc = "builtin clang support",
>         .test_cases = clang_tests,
> -       .subtest = { .skip_if_fail = true, },
>  };
> diff --git a/tools/perf/tests/llvm.c b/tools/perf/tests/llvm.c
> index f27ef00d65e9..8ac0a3a457ef 100644
> --- a/tools/perf/tests/llvm.c
> +++ b/tools/perf/tests/llvm.c
> @@ -216,5 +216,4 @@ static struct test_case llvm_tests[] = {
>  struct test_suite suite__llvm = {
>         .desc = "LLVM search and compile",
>         .test_cases = llvm_tests,
> -       .subtest = { .skip_if_fail = true, },
>  };
> diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
> index 651fee4ef819..71b76deb1f92 100644
> --- a/tools/perf/tests/pfm.c
> +++ b/tools/perf/tests/pfm.c
> @@ -191,5 +191,4 @@ static struct test_case pfm_tests[] = {
>  struct test_suite suite__pfm = {
>         .desc = "Test libpfm4 support",
>         .test_cases = pfm_tests,
> -       .subtest = { .skip_if_fail   = true }
>  };
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 15051801c790..8f65098110fc 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -40,9 +40,6 @@ struct test_case {
>
>  struct test_suite {
>         const char *desc;
> -       struct {
> -               bool skip_if_fail;
> -       } subtest;
>         struct test_case *test_cases;
>         void *priv;
>  };
> --
> 2.33.1.1089.g2158813163f-goog
>
