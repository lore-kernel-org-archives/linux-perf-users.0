Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14A4C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 May 2022 03:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiERDhq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 May 2022 23:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiERDho (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 May 2022 23:37:44 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307A354199
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 20:37:42 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s28so681297wrb.7
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 20:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Da3hainkRf/xpoiBomkjcTniTf/eBgQLq0JEOX63v/I=;
        b=SFvDNgen2hnckHJeu/GACnvb4YONMZPzE3SSGQEYBBtPFClxLLeSbK95l32Msh2cMv
         hzC8ve31LMp3XoXJ5i6ZVjDVqLU39AqcGIQCtWI01CizEXPZ3LCkqoElHKCGwj+Cx9L9
         Ro9gg1qbsmPkGSuFyu9GVS/yHklk1ogYvF3I9FU0LGbqdm/GsXGGmBiMZMQX4v57usI6
         IH6G6heMV5wEtUoxGS9MJYn3yvjMqivg+DuJRy+ctGQ4uWrRzmDHdwy+kNC9rTLcDzIi
         fdsiiJ6EJaDF0A0+c1swUxGUc55H6XFDSBdCOpB1QCZhU7yQ/MrVI71tCwz7V8xMK1Xa
         IPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Da3hainkRf/xpoiBomkjcTniTf/eBgQLq0JEOX63v/I=;
        b=RqoGQZfSX9Ck6SJ6jGjVr9xHYrFZ31uHSzHNZ4QNqIKo8XfX1n1oaVXeYbzLkv+Fpu
         dtk2jfArw0TdOb+bs6vvuo0OhZdeZEtZRKPEkf9CpLdyfXOD1RAPXLNekIVW6eG9MQAa
         o2uWJsJBrMiVUoJxN7bemPO3X3r0pnW90Takufg7dvmg7jM2PC5V6mtNHngQRjOovz6r
         NCTNMs/hP0NSx+tWn5kM+kcWu35SH1o6cztfCULzhA8mwBUGvIOfHcjhU5Edq72RcL8T
         3FTXMVeA19LhMC40YVm4gs+2oc10Y3fI6kXP9xbhQYPtmLujFgLSfCkaEdXcTXhMM0QT
         UiYg==
X-Gm-Message-State: AOAM530EeKBH1nzfUGd3uEPrDxsMNaGYomHCG5yMin9OZuEKuTqxGRvV
        gRPdTqbez5Cd+adg3IZdH6o30hFFuVSIgsr6ZJMAxg==
X-Google-Smtp-Source: ABdhPJyXZxjWc6xEUE9d3UXe9p7BzGlZAXskf8rWlSKWJeTZApYQRlb6szH6b9S23DVL0eDDLvfvzVPbS2QRIQv/xQY=
X-Received: by 2002:a5d:598f:0:b0:20c:83c9:b05b with SMTP id
 n15-20020a5d598f000000b0020c83c9b05bmr21065065wri.343.1652845060916; Tue, 17
 May 2022 20:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220513040519.1499333-1-irogers@google.com> <20220513040519.1499333-3-irogers@google.com>
 <CAM9d7ch6Xg+gGLsuJ_=X7=wSMRpo324YfRtfHG1=+YD8oG+7vQ@mail.gmail.com>
In-Reply-To: <CAM9d7ch6Xg+gGLsuJ_=X7=wSMRpo324YfRtfHG1=+YD8oG+7vQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 17 May 2022 20:37:28 -0700
Message-ID: <CAP-5=fXUM-dSBB7DD9dQsRkuoXD6cwXkvHQ5B4ydJqoG44fj9g@mail.gmail.com>
Subject: Re: [PATCH 2/7] perf test: Use skip in vmlinux kallsyms
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 16, 2022 at 8:22 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Thu, May 12, 2022 at 9:05 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Currently failures in reading vmlinux or kallsyms result in a test
> > failure. However, the failure is typically permission related. Prefer to
> > flag these failures as skip.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/vmlinux-kallsyms.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
> > index 93dee542a177..983f32964749 100644
> > --- a/tools/perf/tests/vmlinux-kallsyms.c
> > +++ b/tools/perf/tests/vmlinux-kallsyms.c
> > @@ -114,7 +114,7 @@ static bool is_ignored_symbol(const char *name, char type)
> >  static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused,
> >                                         int subtest __maybe_unused)
> >  {
> > -       int err = -1;
> > +       int err = TEST_FAIL;
> >         struct rb_node *nd;
> >         struct symbol *sym;
> >         struct map *kallsyms_map, *vmlinux_map, *map;
> > @@ -142,7 +142,8 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
> >          * and find the .ko files that match them in /lib/modules/`uname -r`/.
> >          */
> >         if (machine__create_kernel_maps(&kallsyms) < 0) {
> > -               pr_debug("machine__create_kernel_maps ");
> > +               pr_info("machine__create_kernel_maps failed");
> > +               err = TEST_SKIP;
> >                 goto out;
> >         }
> >
> > @@ -158,7 +159,8 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
> >          * code and with the one got from /proc/modules from the "kallsyms" code.
> >          */
> >         if (machine__load_kallsyms(&kallsyms, "/proc/kallsyms") <= 0) {
> > -               pr_debug("dso__load_kallsyms ");
> > +               pr_debug("machine__load_kallsyms failed");
>
> For consistency, you might want to use pr_info() here.

Point taken, I think pr_debug is more consistent with other tests and
so I changed the above back in v2.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +               err = TEST_SKIP;
> >                 goto out;
> >         }
> >
> > @@ -178,7 +180,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
> >          * Now repeat step 2, this time for the vmlinux file we'll auto-locate.
> >          */
> >         if (machine__create_kernel_maps(&vmlinux) < 0) {
> > -               pr_debug("machine__create_kernel_maps ");
> > +               pr_info("machine__create_kernel_maps failed");
> >                 goto out;
> >         }
> >
> > @@ -196,7 +198,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
> >          * to fixup the symbols.
> >          */
> >         if (machine__load_vmlinux_path(&vmlinux) <= 0) {
> > -               pr_debug("Couldn't find a vmlinux that matches the kernel running on this machine, skipping test\n");
> > +               pr_info("Couldn't find a vmlinux that matches the kernel running on this machine, skipping test\n");
> >                 err = TEST_SKIP;
> >                 goto out;
> >         }
> > --
> > 2.36.0.550.gb090851708-goog
> >
