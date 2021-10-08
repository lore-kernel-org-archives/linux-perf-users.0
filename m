Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442BEC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 20:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15278610E5
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 20:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242160AbhJHUGM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 16:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhJHUGM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Oct 2021 16:06:12 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EA7C061755
        for <linux-perf-users@vger.kernel.org>; Fri,  8 Oct 2021 13:04:16 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id h11so3371186ila.10
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Oct 2021 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=54hDmXr2Paoz2+LC6oFG+5e8/5S5X4cUXnpR6jROIYo=;
        b=JCuT9KD3X2OdvW/J8323cUFXQdxMlqp0ouiVFnLruk2BlDgYqmOU+dW4c4vYUAlL9e
         nGWfP+D0xA9hTXsLwKsToOLcDjorXFdAJo00/60KbBh3zFFYndCCTIEXZqXhjxzbrzcu
         1IUdj5tIqWopSGuQIQkEWX0aHdd08bzbHqk6f/n14hK7aDGErpYPE8ivQDWEZ1iOIx9Q
         7V7QKhN8DgsRa3Jj0PhsAOgFwuJq/6J38VTG0X/jUXFRPVPwAF8iweFLnTElJV97zuvs
         FPbOHvpYgXUQ6lSbeXT11U+5Hl8FSU4RdECE1nLsonmhtcMJRB+Wrc5h9hXsg1joUnFp
         Jmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=54hDmXr2Paoz2+LC6oFG+5e8/5S5X4cUXnpR6jROIYo=;
        b=nMiAMnBr3Y57BVcNp3mQJ6VK2yVkWqufv9LL8ZebTGtFFerP7RptoVyzBajFlD8mgR
         gP+08CsZzi3sjjtStTMEhIH85ZQ8TzTuKv9iWKiq5uSH/SWL+gyzqJZQckv1Hx3oxlPU
         ersKQyaNdxeWjBr7VVx9IiaiJDZtZ/m9OW65fMyGG9CosXtU9h8KwWMmJG0L+vSw9/G4
         gbCn+HwaPodpUbQdbEMmtA/LompSu+r356zdwINo67qF7azWaru/yeDQRU98NOJV+F2t
         VR9PZ7LkLGEx7PtuR0i8SQeGl9hrfPMA5kbXJj2jhsAt7YHPmpXennDZoRtsG9C4U5U0
         Aznw==
X-Gm-Message-State: AOAM530/L0+Dacz5jpSLr8aTiZrYoXGSh1DvdEi5seA79GQFU3f5gx0A
        8WRwr1qTSZKjZFiVhlrzNol8fXoHXyd8qlOMbNg4Zw==
X-Google-Smtp-Source: ABdhPJw2HwIPjY0od+gfnx4+b+NRQhOvduZSvDe9coOckBS+/XtEZOWPxK/JUuCAZ0brvVoExmt7CLjtR9BBjGTmZTY=
X-Received: by 2002:a05:6e02:190a:: with SMTP id w10mr8831798ilu.2.1633723455648;
 Fri, 08 Oct 2021 13:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210922081959.390059-1-irogers@google.com> <YUumPj7Oa1HvVGW/@krava>
 <CAP-5=fVd8zU-uHMg1KjyNPDv-_y-Q562PvPpoWSi1rS-KD0ezw@mail.gmail.com>
 <YVDlL28JgxaRwMJs@krava> <CAP-5=fXkfMW9jHYz8X9p==gsRRzRCsx5WrGdmzE5YWe+idBeQw@mail.gmail.com>
 <YWCXQ5xw3Nc2NGIt@kernel.org>
In-Reply-To: <YWCXQ5xw3Nc2NGIt@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 8 Oct 2021 13:04:02 -0700
Message-ID: <CAP-5=fUy4Qe4dqBjcRwBV0U4q9QgVUw4swxi7iE65sfOrJ17xw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Start aligning perf test with kunit style
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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

On Fri, Oct 8, 2021 at 12:08 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Sep 27, 2021 at 09:09:43AM -0700, Ian Rogers escreveu:
> > On Sun, Sep 26, 2021 at 2:25 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Wed, Sep 22, 2021 at 04:36:05PM -0700, Ian Rogers wrote:
> > > > On Wed, Sep 22, 2021 at 2:55 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > >
> > > > > On Wed, Sep 22, 2021 at 01:19:53AM -0700, Ian Rogers wrote:
> > > > > > Perf test uses its own structs and code layout that differs from kunit
> > > > > > that was more recently introduced to the kernel. Besides consistency,
> > > > > > it is hoped that moving in the direction of kunit style will enable
> > > > > > reuse of infrastructure like test output formatting for continuous
> > > > > > testing systems. For example:
> > > > > > https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/
> > > > > >
> > > > > > The motivation for this restructuring comes from wanting to be able to
> > > > > > tag tests with a size:
> > > > > > https://lore.kernel.org/linux-perf-users/CAP-5=fWmGyuqFKc-EMP3rbmTkjZ3MS+YSajGZfeRMc38HS82gw@mail.gmail.com/
> > > > > > To have more exhaustive and slower running tests.  This isn't
> > > > > > something kunit currently supports, nor is the execution of python and
> > > > > > shell tests, but it seems sensible to work on an approach with kunit
> > > > > > rather to invent a new wheel inside of perf.
> > > > > >
> > > > > > These initial patches are just refactoring the main test suite
> > > > > > definitions to be in a more kunit style. Kunit isn't depended upon, it
> > > > > > is hoped that this can be done in later patches for the sake of
> > > > > > consistency.
> > > > >
> > > > > seems good.. how far away from kunit is the code now?
> > > >
> > > > Thanks Jiri, It is a ways away from complete. I was thinking to follow up with:
> > > > * Migrate the current sub-test approach to use kunit style test cases
> > > > within a suite.
> > > > * Combine what are currently independent test suites into one test
> > > > suite with different test cases, for example stat.c contains stat,
> > > > stat_config and stat_round tests.
> > > >
> > > > Once this is done then to unify with kunit we need to work out a
> > > > common pattern for skipping a test, etc. There's already a lot here
> > > > and so I wanted to get an opinion before pushing along further.
> > > >
> > > > > >
> > > > > > v1. Built/tested on x86.
> > > > > >
> > > > > > Ian Rogers (5):
> > > > > >   perf test: Use macro for "suite" declarations
> > > > > >   perf test: Use macro for "suite" definitions
> > > > > >   perf test: Make each test/suite its own struct.
> > > > > >   perf test: Move each test suite struct to its test
> > > > > >   perf test: Rename struct test to test_suite
> > > > > >
> > > > > >  tools/perf/arch/arm/include/arch-tests.h      |   2 +-
> > > > > >  tools/perf/arch/arm/tests/arch-tests.c        |  21 +-
> > > > > >  tools/perf/arch/arm/tests/vectors-page.c      |   2 +-
> > > > > >  tools/perf/arch/arm64/include/arch-tests.h    |   2 +-
> > > > > >  tools/perf/arch/arm64/tests/arch-tests.c      |  15 +-
> > > > > >  tools/perf/arch/powerpc/include/arch-tests.h  |   2 +-
> > > > > >  tools/perf/arch/powerpc/tests/arch-tests.c    |  15 +-
> > > > >
> > > > > I can run/test this on ppc/arm if you don't have any
> > > >
> > > > I have pretty easy access to ARM but lost access to PowerPC. If we're
> > > > happy with the direction then I can test ARM and ask for help on
> > > > PowerPC.
> > >
> > > it compiles fine on powerpc and failed tests seem reasonable,
> > > before/after perf test output is same apart from this:
> > >
> > > [root@ibm-p9z-06-lp7 perf]# diff -puw out.old out.new
> > > --- out.old     2021-09-26 17:15:57.947807813 -0400
> > > +++ out.new     2021-09-26 17:20:51.789918644 -0400
> > > @@ -81,7 +81,7 @@
> > >  69: PE file support                                                 : Ok
> > >  70: Event expansion for cgroups                                     : Ok
> > >  72: dlfilter C API                                                  : Ok
> > > -73: Test dwarf unwind                                               : Ok
> > > +73: DWARF unwind                                                    : Ok
> > >  74: build id cache operations                                       : Ok
> > >  75: daemon operations                                               : Ok
> > >  76: perf pipe recording and injection test                          : Ok
> > >
> > > not sure there's somebody out there parsing this output,
> > > maybe we can find out ;-)
> >
> > Thanks, actually we have a parser on this output :-) I will correct the issue.
>
> Seems like the right direction, people are ok with it, v2 time?

Thanks! I'm working on v2, I've fixed up wrt Jiri's comments and I'm
working on using the test_case style for subtests. I hope to send it
out soon-ish.

Thanks,
Ian

> - Arnaldo
>
> > Ian
> >
> > > jirka
> > >
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > > jirka
> > > > >
> > > > > >  tools/perf/arch/x86/include/arch-tests.h      |  14 +-
> > > > > >  tools/perf/arch/x86/tests/arch-tests.c        |  47 +-
> > > > > >  tools/perf/arch/x86/tests/bp-modify.c         |   2 +-
> > > > > >  tools/perf/arch/x86/tests/insn-x86.c          |   2 +-
> > > > > >  tools/perf/arch/x86/tests/intel-cqm.c         |   2 +-
> > > > > >  .../x86/tests/intel-pt-pkt-decoder-test.c     |   2 +-
> > > > > >  tools/perf/arch/x86/tests/rdpmc.c             |   2 +-
> > > > > >  tools/perf/arch/x86/tests/sample-parsing.c    |   2 +-
> > > > > >  tools/perf/tests/api-io.c                     |   6 +-
> > > > > >  tools/perf/tests/attr.c                       |   4 +-
> > > > > >  tools/perf/tests/backward-ring-buffer.c       |   4 +-
> > > > > >  tools/perf/tests/bitmap.c                     |   4 +-
> > > > > >  tools/perf/tests/bp_account.c                 |  10 +-
> > > > > >  tools/perf/tests/bp_signal.c                  |   8 +-
> > > > > >  tools/perf/tests/bp_signal_overflow.c         |   8 +-
> > > > > >  tools/perf/tests/bpf.c                        |  22 +-
> > > > > >  tools/perf/tests/builtin-test.c               | 441 ++++--------------
> > > > > >  tools/perf/tests/clang.c                      |  18 +-
> > > > > >  tools/perf/tests/code-reading.c               |   4 +-
> > > > > >  tools/perf/tests/cpumap.c                     |  10 +-
> > > > > >  tools/perf/tests/demangle-java-test.c         |   4 +-
> > > > > >  tools/perf/tests/demangle-ocaml-test.c        |   4 +-
> > > > > >  tools/perf/tests/dlfilter-test.c              |   4 +-
> > > > > >  tools/perf/tests/dso-data.c                   |  10 +-
> > > > > >  tools/perf/tests/dwarf-unwind.c               |   2 +-
> > > > > >  tools/perf/tests/event-times.c                |   4 +-
> > > > > >  tools/perf/tests/event_update.c               |   4 +-
> > > > > >  tools/perf/tests/evsel-roundtrip-name.c       |   4 +-
> > > > > >  tools/perf/tests/evsel-tp-sched.c             |   4 +-
> > > > > >  tools/perf/tests/expand-cgroup.c              |   6 +-
> > > > > >  tools/perf/tests/expr.c                       |   4 +-
> > > > > >  tools/perf/tests/fdarray.c                    |   7 +-
> > > > > >  tools/perf/tests/genelf.c                     |   6 +-
> > > > > >  tools/perf/tests/hists_cumulate.c             |   4 +-
> > > > > >  tools/perf/tests/hists_filter.c               |   4 +-
> > > > > >  tools/perf/tests/hists_link.c                 |   4 +-
> > > > > >  tools/perf/tests/hists_output.c               |   4 +-
> > > > > >  tools/perf/tests/is_printable_array.c         |   4 +-
> > > > > >  tools/perf/tests/keep-tracking.c              |   4 +-
> > > > > >  tools/perf/tests/kmod-path.c                  |   4 +-
> > > > > >  tools/perf/tests/llvm.c                       |  22 +-
> > > > > >  tools/perf/tests/maps.c                       |   4 +-
> > > > > >  tools/perf/tests/mem.c                        |   4 +-
> > > > > >  tools/perf/tests/mem2node.c                   |   4 +-
> > > > > >  tools/perf/tests/mmap-basic.c                 |   4 +-
> > > > > >  tools/perf/tests/mmap-thread-lookup.c         |   4 +-
> > > > > >  tools/perf/tests/openat-syscall-all-cpus.c    |   5 +-
> > > > > >  tools/perf/tests/openat-syscall-tp-fields.c   |   4 +-
> > > > > >  tools/perf/tests/openat-syscall.c             |   5 +-
> > > > > >  tools/perf/tests/parse-events.c               |   4 +-
> > > > > >  tools/perf/tests/parse-metric.c               |   4 +-
> > > > > >  tools/perf/tests/parse-no-sample-id-all.c     |   4 +-
> > > > > >  tools/perf/tests/pe-file-parsing.c            |   6 +-
> > > > > >  tools/perf/tests/perf-hooks.c                 |   4 +-
> > > > > >  tools/perf/tests/perf-record.c                |   4 +-
> > > > > >  tools/perf/tests/perf-time-to-tsc.c           |  10 +-
> > > > > >  tools/perf/tests/pfm.c                        |  16 +-
> > > > > >  tools/perf/tests/pmu-events.c                 |  19 +-
> > > > > >  tools/perf/tests/pmu.c                        |   4 +-
> > > > > >  tools/perf/tests/python-use.c                 |   4 +-
> > > > > >  tools/perf/tests/sample-parsing.c             |   4 +-
> > > > > >  tools/perf/tests/sdt.c                        |   6 +-
> > > > > >  tools/perf/tests/stat.c                       |  10 +-
> > > > > >  tools/perf/tests/sw-clock.c                   |   4 +-
> > > > > >  tools/perf/tests/switch-tracking.c            |   4 +-
> > > > > >  tools/perf/tests/task-exit.c                  |   4 +-
> > > > > >  tools/perf/tests/tests.h                      | 179 ++++---
> > > > > >  tools/perf/tests/thread-map.c                 |  10 +-
> > > > > >  tools/perf/tests/thread-maps-share.c          |   4 +-
> > > > > >  tools/perf/tests/time-utils-test.c            |   4 +-
> > > > > >  tools/perf/tests/topology.c                   |   4 +-
> > > > > >  tools/perf/tests/unit_number__scnprintf.c     |   4 +-
> > > > > >  tools/perf/tests/vmlinux-kallsyms.c           |   5 +-
> > > > > >  tools/perf/tests/wp.c                         |  22 +-
> > > > > >  81 files changed, 543 insertions(+), 618 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 2.33.0.464.g1972c5931b-goog
> > > > > >
> > > > >
> > > >
> > >
>
> --
>
> - Arnaldo
