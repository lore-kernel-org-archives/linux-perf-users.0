Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CE9C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 15:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5629E61186
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 15:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhKJPrI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Nov 2021 10:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhKJPrH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Nov 2021 10:47:07 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECC2C061764;
        Wed, 10 Nov 2021 07:44:20 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso2325360wmf.0;
        Wed, 10 Nov 2021 07:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rQqzmMPzFzq3afQK19UORovj6WjYsNPvthZJlG0OhFU=;
        b=LK41+a0DKhDQ8yuaRtMRMG3M1qldPTFG0cFC9QVtSMxoKEk7ITSEboHNbxDd9iN28C
         GOQZxo5yjyAwIVhf9xmexglb1VHRqLicXWgkcrK1db0QZRHdtK5PlO28s1jb2JMKYwya
         ui+nSDRAvec2GH/Qx5fQv4WxKopR4TMcgCUFCXGLxbtQwYhLwh/doEH4BXaeo7uMtpkU
         +WAXwuC8czidWztK8sMIu2nJFFTjQhhCNmRyz5Dh13f5qi2oh6LBL3JBas2YkJ75WS7g
         XyFJpM6NArZk1JAxcEW+m+IjGIK1qflrWMSHYDNWxaHcobyLLhXhtYDxy21HdBl4fQNJ
         Z3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rQqzmMPzFzq3afQK19UORovj6WjYsNPvthZJlG0OhFU=;
        b=KLSj5gD50tiCjmGTwQNBCb9Qfx4uoadY8so6lxlbm7YXt44F/lytyeQgtQ5Lx3y9Ll
         h8d/v66yeUyS+WbrA0ai+NqO8G47mXUMU6UvVKCGX+pLWVh7okwBapgv3mv1VJpU3gdR
         7aNnVdIRVr8T4gN/6PvLOeMA21uSyjLk4oJlznlilZDspGrUgSQUImBE/d9VLNGqAh+O
         SDvF2YW82Glr63Pu8bcM2baZh4PHpgrAlplYzSEqZBlmHQrasIYnkaTLkNW6kJTgtLZC
         SJMIKiUyTm7YxDfoC4F75EAVq2asg8qE/E5xUsXFb71FxmDBWzVmWTJ3ZMMp+F5ZxkL9
         7Dmw==
X-Gm-Message-State: AOAM531KWc84E/92uYnQ0IAI+NNz0DZZ/YJ3+R0jss69SDSonjWP8sH6
        8Ed5Thquci9vx86CgGt7r3U=
X-Google-Smtp-Source: ABdhPJzy/1XyGKXXviLUCmSYGIPNlk5mV72EKJ9Pn+ybxuwmp/ixPAzmlPO2XTthsUCZ1dsOmemHaQ==
X-Received: by 2002:a05:600c:5125:: with SMTP id o37mr88049wms.81.1636559058479;
        Wed, 10 Nov 2021 07:44:18 -0800 (PST)
Received: from pc ([197.49.136.152])
        by smtp.gmail.com with ESMTPSA id k8sm197950wrn.91.2021.11.10.07.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 07:44:17 -0800 (PST)
Date:   Wed, 10 Nov 2021 17:44:14 +0200
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v3 22/22] perf test: Remove skip_if_fail
Message-ID: <20211110154414.xu5jlt7sdgqneujs@pc>
References: <20211104064208.3156807-1-irogers@google.com>
 <20211104064208.3156807-23-irogers@google.com>
 <CAOz-JA7Wu07aE29K1LHZEPNojop59xTcQO+zjHR4gVB6YK+ykA@mail.gmail.com>
 <YYqGc9eIG8w+ep41@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYqGc9eIG8w+ep41@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Nov 09, 2021 at 11:32:19AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 04, 2021 at 03:51:07PM +0200, Sohaib Mohamed escreveu:
> > On Thu, Nov 4, 2021 at 8:43 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > Remove optionality, always run tests in a suite even if one fails. This
> > > brings perf's test more inline with kunit that lacks this notion.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > Tested-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
>
> Hi Sohaib,
>
> 	Have you tested all the 22 patches in this series or just the
> last one?
>
> 	I use 'b4' and it thinks you tested just the 22nd, if you tested
> all the patches, please next time reply with your
> Tested-by/Reviewed-by/Acked-by/etc to the cover letter, usually a 00/22
> message,
>

Yes, I tested them all, I'll do that. thanks for the note.

Sohaib

> Thanks!
>
> - Arnaldo
>
> > > ---
> > >  tools/perf/tests/bpf.c          |  1 -
> > >  tools/perf/tests/builtin-test.c | 24 ++++++++----------------
> > >  tools/perf/tests/clang.c        |  1 -
> > >  tools/perf/tests/llvm.c         |  1 -
> > >  tools/perf/tests/pfm.c          |  1 -
> > >  tools/perf/tests/tests.h        |  3 ---
> > >  6 files changed, 8 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> > > index e86a77ce93ef..c3d6eda8601e 100644
> > > --- a/tools/perf/tests/bpf.c
> > > +++ b/tools/perf/tests/bpf.c
> > > @@ -382,5 +382,4 @@ static struct test_case bpf_tests[] = {
> > >  struct test_suite suite__bpf = {
> > >         .desc = "BPF filter",
> > >         .test_cases = bpf_tests,
> > > -       .subtest = { .skip_if_fail = true, },
> > >  };
> > > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > > index 19b1228dbd5d..8cb5a1c3489e 100644
> > > --- a/tools/perf/tests/builtin-test.c
> > > +++ b/tools/perf/tests/builtin-test.c
> > > @@ -238,18 +238,13 @@ static int run_test(struct test_suite *test, int subtest)
> > >         for (j = 0; j < ARRAY_SIZE(tests); j++) \
> > >                 for (k = 0, t = tests[j][k]; tests[j][k]; k++, t = tests[j][k])
> > >
> > > -static int test_and_print(struct test_suite *t, bool force_skip, int subtest)
> > > +static int test_and_print(struct test_suite *t, int subtest)
> > >  {
> > >         int err;
> > >
> > > -       if (!force_skip) {
> > > -               pr_debug("\n--- start ---\n");
> > > -               err = run_test(t, subtest);
> > > -               pr_debug("---- end ----\n");
> > > -       } else {
> > > -               pr_debug("\n--- force skipped ---\n");
> > > -               err = TEST_SKIP;
> > > -       }
> > > +       pr_debug("\n--- start ---\n");
> > > +       err = run_test(t, subtest);
> > > +       pr_debug("---- end ----\n");
> > >
> > >         if (!has_subtests(t))
> > >                 pr_debug("%s:", t->desc);
> > > @@ -432,7 +427,7 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
> > >                         continue;
> > >                 }
> > >
> > > -               test_and_print(&test_suite, false, 0);
> > > +               test_and_print(&test_suite, 0);
> > >         }
> > >
> > >         for (e = 0; e < n_dirs; e++)
> > > @@ -456,7 +451,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
> > >         }
> > >
> > >         for_each_test(j, k, t) {
> > > -               int curr = i++, err;
> > > +               int curr = i++;
> > >                 int subi;
> > >
> > >                 if (!perf_test__matches(test_description(t, -1), curr, argc, argv)) {
> > > @@ -483,7 +478,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
> > >                 }
> > >
> > >                 if (!has_subtests(t)) {
> > > -                       test_and_print(t, false, -1);
> > > +                       test_and_print(t, -1);
> > >                 } else {
> > >                         int subn = num_subtests(t);
> > >                         /*
> > > @@ -495,7 +490,6 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
> > >                          * 35.1: Basic BPF llvm compiling test                          : Ok
> > >                          */
> > >                         int subw = width > 2 ? width - 2 : width;
> > > -                       bool skip = false;
> > >
> > >                         if (subn <= 0) {
> > >                                 color_fprintf(stderr, PERF_COLOR_YELLOW,
> > > @@ -518,9 +512,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
> > >
> > >                                 pr_info("%2d.%1d: %-*s:", i, subi + 1, subw,
> > >                                         test_description(t, subi));
> > > -                               err = test_and_print(t, skip, subi);
> > > -                               if (err != TEST_OK && t->subtest.skip_if_fail)
> > > -                                       skip = true;
> > > +                               test_and_print(t, subi);
> > >                         }
> > >                 }
> > >         }
> > > diff --git a/tools/perf/tests/clang.c b/tools/perf/tests/clang.c
> > > index ba06a2257574..a7111005d5b9 100644
> > > --- a/tools/perf/tests/clang.c
> > > +++ b/tools/perf/tests/clang.c
> > > @@ -29,5 +29,4 @@ static struct test_case clang_tests[] = {
> > >  struct test_suite suite__clang = {
> > >         .desc = "builtin clang support",
> > >         .test_cases = clang_tests,
> > > -       .subtest = { .skip_if_fail = true, },
> > >  };
> > > diff --git a/tools/perf/tests/llvm.c b/tools/perf/tests/llvm.c
> > > index f27ef00d65e9..8ac0a3a457ef 100644
> > > --- a/tools/perf/tests/llvm.c
> > > +++ b/tools/perf/tests/llvm.c
> > > @@ -216,5 +216,4 @@ static struct test_case llvm_tests[] = {
> > >  struct test_suite suite__llvm = {
> > >         .desc = "LLVM search and compile",
> > >         .test_cases = llvm_tests,
> > > -       .subtest = { .skip_if_fail = true, },
> > >  };
> > > diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
> > > index 651fee4ef819..71b76deb1f92 100644
> > > --- a/tools/perf/tests/pfm.c
> > > +++ b/tools/perf/tests/pfm.c
> > > @@ -191,5 +191,4 @@ static struct test_case pfm_tests[] = {
> > >  struct test_suite suite__pfm = {
> > >         .desc = "Test libpfm4 support",
> > >         .test_cases = pfm_tests,
> > > -       .subtest = { .skip_if_fail   = true }
> > >  };
> > > diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> > > index 15051801c790..8f65098110fc 100644
> > > --- a/tools/perf/tests/tests.h
> > > +++ b/tools/perf/tests/tests.h
> > > @@ -40,9 +40,6 @@ struct test_case {
> > >
> > >  struct test_suite {
> > >         const char *desc;
> > > -       struct {
> > > -               bool skip_if_fail;
> > > -       } subtest;
> > >         struct test_case *test_cases;
> > >         void *priv;
> > >  };
> > > --
> > > 2.33.1.1089.g2158813163f-goog
> > >
>
> --
>
> - Arnaldo
