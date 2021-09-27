Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF43CC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 16:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD3C60F9B
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 16:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbhI0QLg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Sep 2021 12:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbhI0QLg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Sep 2021 12:11:36 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D12C061604
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Sep 2021 09:09:58 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p80so23410412iod.10
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Sep 2021 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2GQ/4yVo5M6uC3IK/BIrMcprTNmZ6x0QiXuUrYuvaGQ=;
        b=fvYVIROgMYloEMngAaoX++4PKLGL4I2Y6ORD7LIBRQ4TqPvpXEH02N1pz7M2Neokis
         3qmzHiem+1W3OryQkA9+ZA+YyOchpW5Rd5FMeYPXfOonp8QTbHG48R0EtbzjEhjZdw3j
         MStsGq02w6aP5HFKVSJXxwKxYK/xq38+M9t9LPxAftVQ1r0T4idsE3JDePie7/l0qYvl
         G3Jr1NO2CMKU2YYX9G70Xfa6MC16r+KxHX7tgEqb92HEOEpxuOAlDKxisFD8QgR5vRfo
         rNGHyFfm1gFba2uyuXeVBw4h/+4bjtNk5OyMmuPPq2coY1rc5V0svaB4X/fvyf2vZcjX
         9A8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2GQ/4yVo5M6uC3IK/BIrMcprTNmZ6x0QiXuUrYuvaGQ=;
        b=yBdmTHNsx5qVeb4to80Tex734mcaPiD6u2nUVbICWUQ/lec5O/6RubZHKnQ5kE9mlY
         bYVeco9dNfNo0zULNa1dyjQPqN46y8Wevw3w8rpBzJ/EYS+uiWAPC3GE7RIODJuIKV81
         vccF0xAZVAbYGHKfp06tMl1NfxA3YV8Dmop8Ow5cTU6UNF7L0bwPQAwX00+CTdgtzb63
         dkZ2zZusZl63xr+KzzoOidgrMyuCcEGXy9VMnOr6ij1CCxjyGm9WqbJ5Z5Vt7p1OY10N
         mTUzsVb9K21sfIJFVPqFxn1KYoujufvmhsWyAnZRnAOFn6zcqsavG3mk4CKyvxiyaXE1
         0NTg==
X-Gm-Message-State: AOAM530BiDXLAK3gxLm7xpsh300+1Bd9MnjEZYV/gfQu0xU9KAbHGZ3c
        5ujclJC0g7maBrMJY2owR6AWt7syQ2/6rxoJKA86Xg==
X-Google-Smtp-Source: ABdhPJwLXol1mbrw3uK9YsUwzKgrmzt2KzIExT1goYjNVKmnCt28a+gzwC3rgUPIRPogNnVM8mp8S7dTGtrExQw91JM=
X-Received: by 2002:a02:8790:: with SMTP id t16mr666255jai.14.1632758997457;
 Mon, 27 Sep 2021 09:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210922081959.390059-1-irogers@google.com> <YUumPj7Oa1HvVGW/@krava>
 <CAP-5=fVd8zU-uHMg1KjyNPDv-_y-Q562PvPpoWSi1rS-KD0ezw@mail.gmail.com> <YVDlL28JgxaRwMJs@krava>
In-Reply-To: <YVDlL28JgxaRwMJs@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 27 Sep 2021 09:09:43 -0700
Message-ID: <CAP-5=fXkfMW9jHYz8X9p==gsRRzRCsx5WrGdmzE5YWe+idBeQw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Start aligning perf test with kunit style
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Sep 26, 2021 at 2:25 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Sep 22, 2021 at 04:36:05PM -0700, Ian Rogers wrote:
> > On Wed, Sep 22, 2021 at 2:55 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Wed, Sep 22, 2021 at 01:19:53AM -0700, Ian Rogers wrote:
> > > > Perf test uses its own structs and code layout that differs from kunit
> > > > that was more recently introduced to the kernel. Besides consistency,
> > > > it is hoped that moving in the direction of kunit style will enable
> > > > reuse of infrastructure like test output formatting for continuous
> > > > testing systems. For example:
> > > > https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/
> > > >
> > > > The motivation for this restructuring comes from wanting to be able to
> > > > tag tests with a size:
> > > > https://lore.kernel.org/linux-perf-users/CAP-5=fWmGyuqFKc-EMP3rbmTkjZ3MS+YSajGZfeRMc38HS82gw@mail.gmail.com/
> > > > To have more exhaustive and slower running tests.  This isn't
> > > > something kunit currently supports, nor is the execution of python and
> > > > shell tests, but it seems sensible to work on an approach with kunit
> > > > rather to invent a new wheel inside of perf.
> > > >
> > > > These initial patches are just refactoring the main test suite
> > > > definitions to be in a more kunit style. Kunit isn't depended upon, it
> > > > is hoped that this can be done in later patches for the sake of
> > > > consistency.
> > >
> > > seems good.. how far away from kunit is the code now?
> >
> > Thanks Jiri, It is a ways away from complete. I was thinking to follow up with:
> > * Migrate the current sub-test approach to use kunit style test cases
> > within a suite.
> > * Combine what are currently independent test suites into one test
> > suite with different test cases, for example stat.c contains stat,
> > stat_config and stat_round tests.
> >
> > Once this is done then to unify with kunit we need to work out a
> > common pattern for skipping a test, etc. There's already a lot here
> > and so I wanted to get an opinion before pushing along further.
> >
> > > >
> > > > v1. Built/tested on x86.
> > > >
> > > > Ian Rogers (5):
> > > >   perf test: Use macro for "suite" declarations
> > > >   perf test: Use macro for "suite" definitions
> > > >   perf test: Make each test/suite its own struct.
> > > >   perf test: Move each test suite struct to its test
> > > >   perf test: Rename struct test to test_suite
> > > >
> > > >  tools/perf/arch/arm/include/arch-tests.h      |   2 +-
> > > >  tools/perf/arch/arm/tests/arch-tests.c        |  21 +-
> > > >  tools/perf/arch/arm/tests/vectors-page.c      |   2 +-
> > > >  tools/perf/arch/arm64/include/arch-tests.h    |   2 +-
> > > >  tools/perf/arch/arm64/tests/arch-tests.c      |  15 +-
> > > >  tools/perf/arch/powerpc/include/arch-tests.h  |   2 +-
> > > >  tools/perf/arch/powerpc/tests/arch-tests.c    |  15 +-
> > >
> > > I can run/test this on ppc/arm if you don't have any
> >
> > I have pretty easy access to ARM but lost access to PowerPC. If we're
> > happy with the direction then I can test ARM and ask for help on
> > PowerPC.
>
> it compiles fine on powerpc and failed tests seem reasonable,
> before/after perf test output is same apart from this:
>
> [root@ibm-p9z-06-lp7 perf]# diff -puw out.old out.new
> --- out.old     2021-09-26 17:15:57.947807813 -0400
> +++ out.new     2021-09-26 17:20:51.789918644 -0400
> @@ -81,7 +81,7 @@
>  69: PE file support                                                 : Ok
>  70: Event expansion for cgroups                                     : Ok
>  72: dlfilter C API                                                  : Ok
> -73: Test dwarf unwind                                               : Ok
> +73: DWARF unwind                                                    : Ok
>  74: build id cache operations                                       : Ok
>  75: daemon operations                                               : Ok
>  76: perf pipe recording and injection test                          : Ok
>
> not sure there's somebody out there parsing this output,
> maybe we can find out ;-)

Thanks, actually we have a parser on this output :-) I will correct the issue.

Ian

> jirka
>
> >
> > Thanks,
> > Ian
> >
> > > jirka
> > >
> > > >  tools/perf/arch/x86/include/arch-tests.h      |  14 +-
> > > >  tools/perf/arch/x86/tests/arch-tests.c        |  47 +-
> > > >  tools/perf/arch/x86/tests/bp-modify.c         |   2 +-
> > > >  tools/perf/arch/x86/tests/insn-x86.c          |   2 +-
> > > >  tools/perf/arch/x86/tests/intel-cqm.c         |   2 +-
> > > >  .../x86/tests/intel-pt-pkt-decoder-test.c     |   2 +-
> > > >  tools/perf/arch/x86/tests/rdpmc.c             |   2 +-
> > > >  tools/perf/arch/x86/tests/sample-parsing.c    |   2 +-
> > > >  tools/perf/tests/api-io.c                     |   6 +-
> > > >  tools/perf/tests/attr.c                       |   4 +-
> > > >  tools/perf/tests/backward-ring-buffer.c       |   4 +-
> > > >  tools/perf/tests/bitmap.c                     |   4 +-
> > > >  tools/perf/tests/bp_account.c                 |  10 +-
> > > >  tools/perf/tests/bp_signal.c                  |   8 +-
> > > >  tools/perf/tests/bp_signal_overflow.c         |   8 +-
> > > >  tools/perf/tests/bpf.c                        |  22 +-
> > > >  tools/perf/tests/builtin-test.c               | 441 ++++--------------
> > > >  tools/perf/tests/clang.c                      |  18 +-
> > > >  tools/perf/tests/code-reading.c               |   4 +-
> > > >  tools/perf/tests/cpumap.c                     |  10 +-
> > > >  tools/perf/tests/demangle-java-test.c         |   4 +-
> > > >  tools/perf/tests/demangle-ocaml-test.c        |   4 +-
> > > >  tools/perf/tests/dlfilter-test.c              |   4 +-
> > > >  tools/perf/tests/dso-data.c                   |  10 +-
> > > >  tools/perf/tests/dwarf-unwind.c               |   2 +-
> > > >  tools/perf/tests/event-times.c                |   4 +-
> > > >  tools/perf/tests/event_update.c               |   4 +-
> > > >  tools/perf/tests/evsel-roundtrip-name.c       |   4 +-
> > > >  tools/perf/tests/evsel-tp-sched.c             |   4 +-
> > > >  tools/perf/tests/expand-cgroup.c              |   6 +-
> > > >  tools/perf/tests/expr.c                       |   4 +-
> > > >  tools/perf/tests/fdarray.c                    |   7 +-
> > > >  tools/perf/tests/genelf.c                     |   6 +-
> > > >  tools/perf/tests/hists_cumulate.c             |   4 +-
> > > >  tools/perf/tests/hists_filter.c               |   4 +-
> > > >  tools/perf/tests/hists_link.c                 |   4 +-
> > > >  tools/perf/tests/hists_output.c               |   4 +-
> > > >  tools/perf/tests/is_printable_array.c         |   4 +-
> > > >  tools/perf/tests/keep-tracking.c              |   4 +-
> > > >  tools/perf/tests/kmod-path.c                  |   4 +-
> > > >  tools/perf/tests/llvm.c                       |  22 +-
> > > >  tools/perf/tests/maps.c                       |   4 +-
> > > >  tools/perf/tests/mem.c                        |   4 +-
> > > >  tools/perf/tests/mem2node.c                   |   4 +-
> > > >  tools/perf/tests/mmap-basic.c                 |   4 +-
> > > >  tools/perf/tests/mmap-thread-lookup.c         |   4 +-
> > > >  tools/perf/tests/openat-syscall-all-cpus.c    |   5 +-
> > > >  tools/perf/tests/openat-syscall-tp-fields.c   |   4 +-
> > > >  tools/perf/tests/openat-syscall.c             |   5 +-
> > > >  tools/perf/tests/parse-events.c               |   4 +-
> > > >  tools/perf/tests/parse-metric.c               |   4 +-
> > > >  tools/perf/tests/parse-no-sample-id-all.c     |   4 +-
> > > >  tools/perf/tests/pe-file-parsing.c            |   6 +-
> > > >  tools/perf/tests/perf-hooks.c                 |   4 +-
> > > >  tools/perf/tests/perf-record.c                |   4 +-
> > > >  tools/perf/tests/perf-time-to-tsc.c           |  10 +-
> > > >  tools/perf/tests/pfm.c                        |  16 +-
> > > >  tools/perf/tests/pmu-events.c                 |  19 +-
> > > >  tools/perf/tests/pmu.c                        |   4 +-
> > > >  tools/perf/tests/python-use.c                 |   4 +-
> > > >  tools/perf/tests/sample-parsing.c             |   4 +-
> > > >  tools/perf/tests/sdt.c                        |   6 +-
> > > >  tools/perf/tests/stat.c                       |  10 +-
> > > >  tools/perf/tests/sw-clock.c                   |   4 +-
> > > >  tools/perf/tests/switch-tracking.c            |   4 +-
> > > >  tools/perf/tests/task-exit.c                  |   4 +-
> > > >  tools/perf/tests/tests.h                      | 179 ++++---
> > > >  tools/perf/tests/thread-map.c                 |  10 +-
> > > >  tools/perf/tests/thread-maps-share.c          |   4 +-
> > > >  tools/perf/tests/time-utils-test.c            |   4 +-
> > > >  tools/perf/tests/topology.c                   |   4 +-
> > > >  tools/perf/tests/unit_number__scnprintf.c     |   4 +-
> > > >  tools/perf/tests/vmlinux-kallsyms.c           |   5 +-
> > > >  tools/perf/tests/wp.c                         |  22 +-
> > > >  81 files changed, 543 insertions(+), 618 deletions(-)
> > > >
> > > > --
> > > > 2.33.0.464.g1972c5931b-goog
> > > >
> > >
> >
>
