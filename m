Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7DBC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 23:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4FA0611CA
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 23:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbhIVXeN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 19:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhIVXeM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 19:34:12 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A75C061574
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 16:32:42 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id m11so5735154ioo.6
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 16:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nCPXcJ9lWRs9vrBjB5bufM172W2+MCjzidAQ7eSmRuk=;
        b=O/1UBIFCiRhmfzDOcn8+4hp4nNkGWui2WPm1afV0XNBOAU77EfX915hpQV6iTX2/EE
         F015P696YZm8iI5nuBvoc2YDPq8p3Mqt52XZF4Nk+tBbmpwbTpS7QnOo+fXdeEz9I+Z8
         Zx1pCSJ1hPayi5vazQEVlQF7wex6vN9wOJzyDI38FbCO/5Dd1ncdx5K1PQ7pkqwSgcJ1
         uHcF3/K73cmnVoNAIkUTlTZu/GxdgbUJUV7M6kJY9tgaHlLHFY77FBBfId7Or4RaKGXs
         MDwRrK9PUbIZe/+3afwVZ3rejBRFn+46OmF0/0vJebaYiDEmQCK7UTJRfl+vSq/w3rs2
         D3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nCPXcJ9lWRs9vrBjB5bufM172W2+MCjzidAQ7eSmRuk=;
        b=fF7dM0vmxotxx5T2oq4/CQ+uTn/duH3zebTzz8TkGFQ0NoBJuiLolc+gF4vVYKuIho
         u6wu7wBNOAgXnBZ3W+XP9ibkIB4raEjHfJadmGXMjxVCDnLi/W3yrkYu0w1SGHKgI1YT
         xNnYMfEEW6xxkZajj73RN/PM8DhS/QXwBVo6bOIPfwGCfYw87Ob+MibpCN/1rydIMkcO
         WTEhDVIJ/f0EBO6V0+qggZAMY/3bBELTfxSjSjPzRBb9wIX716IrQl+8qmK1Igjq5f8o
         sFg8kQFTcob718Xgvkffnjzf7ipDbkUf8c6QAFzYaTgMVBQCJ7himTOEm+GSEB+Crp0a
         +FCA==
X-Gm-Message-State: AOAM532psC1sadFKbFepuViCNDFhZDhuDSJCfR+Tct/TKSp3zxNJbnUF
        DhFsYTWaSrwmKrtno0DJm4A80CO/uYa1cT69yVgwdQ==
X-Google-Smtp-Source: ABdhPJzacb4agqEwj6XORcaI3kTfQfB2iqThRIbFAS3jG9gWWqk8ek4w7Cho1nto8UrFxPH+mi/XFOJ9hAFBMY+O2do=
X-Received: by 2002:a5d:9051:: with SMTP id v17mr1364028ioq.134.1632353561445;
 Wed, 22 Sep 2021 16:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210922081959.390059-1-irogers@google.com> <YUumPj7Oa1HvVGW/@krava>
In-Reply-To: <YUumPj7Oa1HvVGW/@krava>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 22 Sep 2021 16:32:29 -0700
Message-ID: <CAGS_qxrrmnq-bwBwqseAZmKXKi7JuhapymWw=4PL4=CwD3RLdg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Start aligning perf test with kunit style
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 22, 2021 at 2:55 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Sep 22, 2021 at 01:19:53AM -0700, Ian Rogers wrote:
> > Perf test uses its own structs and code layout that differs from kunit
> > that was more recently introduced to the kernel. Besides consistency,
> > it is hoped that moving in the direction of kunit style will enable
> > reuse of infrastructure like test output formatting for continuous
> > testing systems. For example:
> > https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/
> >
> > The motivation for this restructuring comes from wanting to be able to
> > tag tests with a size:
> > https://lore.kernel.org/linux-perf-users/CAP-5=fWmGyuqFKc-EMP3rbmTkjZ3MS+YSajGZfeRMc38HS82gw@mail.gmail.com/
> > To have more exhaustive and slower running tests.  This isn't
> > something kunit currently supports, nor is the execution of python and
> > shell tests, but it seems sensible to work on an approach with kunit
> > rather to invent a new wheel inside of perf.
> >
> > These initial patches are just refactoring the main test suite
> > definitions to be in a more kunit style. Kunit isn't depended upon, it
> > is hoped that this can be done in later patches for the sake of
> > consistency.
>
> seems good.. how far away from kunit is the code now?

For context, here's what an example kunit test looks like:
https://elixir.bootlin.com/linux/latest/source/lib/kunit/kunit-example-test.c

So having the hierarchy of test_suite => list of tests is a big step
towards that.

A brief skim suggests we still have test funcs like `__test_bpf(int
idx)`, whereas normally KUnit has each test case as its own function.
In the case of bpf.c, it has a test table, so it'd probably use
https://www.kernel.org/doc/html/latest/dev-tools/kunit/usage.html#parameterized-testing

So overall there would probably be a pretty big delta if/when moving
to KUnit, but it should be quite a bit easier after these patches.


>
> >
> > v1. Built/tested on x86.
> >
> > Ian Rogers (5):
> >   perf test: Use macro for "suite" declarations
> >   perf test: Use macro for "suite" definitions
> >   perf test: Make each test/suite its own struct.
> >   perf test: Move each test suite struct to its test
> >   perf test: Rename struct test to test_suite
> >
> >  tools/perf/arch/arm/include/arch-tests.h      |   2 +-
> >  tools/perf/arch/arm/tests/arch-tests.c        |  21 +-
> >  tools/perf/arch/arm/tests/vectors-page.c      |   2 +-
> >  tools/perf/arch/arm64/include/arch-tests.h    |   2 +-
> >  tools/perf/arch/arm64/tests/arch-tests.c      |  15 +-
> >  tools/perf/arch/powerpc/include/arch-tests.h  |   2 +-
> >  tools/perf/arch/powerpc/tests/arch-tests.c    |  15 +-
>
> I can run/test this on ppc/arm if you don't have any
>
> jirka
>
> >  tools/perf/arch/x86/include/arch-tests.h      |  14 +-
> >  tools/perf/arch/x86/tests/arch-tests.c        |  47 +-
> >  tools/perf/arch/x86/tests/bp-modify.c         |   2 +-
> >  tools/perf/arch/x86/tests/insn-x86.c          |   2 +-
> >  tools/perf/arch/x86/tests/intel-cqm.c         |   2 +-
> >  .../x86/tests/intel-pt-pkt-decoder-test.c     |   2 +-
> >  tools/perf/arch/x86/tests/rdpmc.c             |   2 +-
> >  tools/perf/arch/x86/tests/sample-parsing.c    |   2 +-
> >  tools/perf/tests/api-io.c                     |   6 +-
> >  tools/perf/tests/attr.c                       |   4 +-
> >  tools/perf/tests/backward-ring-buffer.c       |   4 +-
> >  tools/perf/tests/bitmap.c                     |   4 +-
> >  tools/perf/tests/bp_account.c                 |  10 +-
> >  tools/perf/tests/bp_signal.c                  |   8 +-
> >  tools/perf/tests/bp_signal_overflow.c         |   8 +-
> >  tools/perf/tests/bpf.c                        |  22 +-
> >  tools/perf/tests/builtin-test.c               | 441 ++++--------------
> >  tools/perf/tests/clang.c                      |  18 +-
> >  tools/perf/tests/code-reading.c               |   4 +-
> >  tools/perf/tests/cpumap.c                     |  10 +-
> >  tools/perf/tests/demangle-java-test.c         |   4 +-
> >  tools/perf/tests/demangle-ocaml-test.c        |   4 +-
> >  tools/perf/tests/dlfilter-test.c              |   4 +-
> >  tools/perf/tests/dso-data.c                   |  10 +-
> >  tools/perf/tests/dwarf-unwind.c               |   2 +-
> >  tools/perf/tests/event-times.c                |   4 +-
> >  tools/perf/tests/event_update.c               |   4 +-
> >  tools/perf/tests/evsel-roundtrip-name.c       |   4 +-
> >  tools/perf/tests/evsel-tp-sched.c             |   4 +-
> >  tools/perf/tests/expand-cgroup.c              |   6 +-
> >  tools/perf/tests/expr.c                       |   4 +-
> >  tools/perf/tests/fdarray.c                    |   7 +-
> >  tools/perf/tests/genelf.c                     |   6 +-
> >  tools/perf/tests/hists_cumulate.c             |   4 +-
> >  tools/perf/tests/hists_filter.c               |   4 +-
> >  tools/perf/tests/hists_link.c                 |   4 +-
> >  tools/perf/tests/hists_output.c               |   4 +-
> >  tools/perf/tests/is_printable_array.c         |   4 +-
> >  tools/perf/tests/keep-tracking.c              |   4 +-
> >  tools/perf/tests/kmod-path.c                  |   4 +-
> >  tools/perf/tests/llvm.c                       |  22 +-
> >  tools/perf/tests/maps.c                       |   4 +-
> >  tools/perf/tests/mem.c                        |   4 +-
> >  tools/perf/tests/mem2node.c                   |   4 +-
> >  tools/perf/tests/mmap-basic.c                 |   4 +-
> >  tools/perf/tests/mmap-thread-lookup.c         |   4 +-
> >  tools/perf/tests/openat-syscall-all-cpus.c    |   5 +-
> >  tools/perf/tests/openat-syscall-tp-fields.c   |   4 +-
> >  tools/perf/tests/openat-syscall.c             |   5 +-
> >  tools/perf/tests/parse-events.c               |   4 +-
> >  tools/perf/tests/parse-metric.c               |   4 +-
> >  tools/perf/tests/parse-no-sample-id-all.c     |   4 +-
> >  tools/perf/tests/pe-file-parsing.c            |   6 +-
> >  tools/perf/tests/perf-hooks.c                 |   4 +-
> >  tools/perf/tests/perf-record.c                |   4 +-
> >  tools/perf/tests/perf-time-to-tsc.c           |  10 +-
> >  tools/perf/tests/pfm.c                        |  16 +-
> >  tools/perf/tests/pmu-events.c                 |  19 +-
> >  tools/perf/tests/pmu.c                        |   4 +-
> >  tools/perf/tests/python-use.c                 |   4 +-
> >  tools/perf/tests/sample-parsing.c             |   4 +-
> >  tools/perf/tests/sdt.c                        |   6 +-
> >  tools/perf/tests/stat.c                       |  10 +-
> >  tools/perf/tests/sw-clock.c                   |   4 +-
> >  tools/perf/tests/switch-tracking.c            |   4 +-
> >  tools/perf/tests/task-exit.c                  |   4 +-
> >  tools/perf/tests/tests.h                      | 179 ++++---
> >  tools/perf/tests/thread-map.c                 |  10 +-
> >  tools/perf/tests/thread-maps-share.c          |   4 +-
> >  tools/perf/tests/time-utils-test.c            |   4 +-
> >  tools/perf/tests/topology.c                   |   4 +-
> >  tools/perf/tests/unit_number__scnprintf.c     |   4 +-
> >  tools/perf/tests/vmlinux-kallsyms.c           |   5 +-
> >  tools/perf/tests/wp.c                         |  22 +-
> >  81 files changed, 543 insertions(+), 618 deletions(-)
> >
> > --
> > 2.33.0.464.g1972c5931b-goog
> >
>
