Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEC2C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 23:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ECBE6115A
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 23:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbhIVXhu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 19:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhIVXhu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 19:37:50 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14571C061574
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 16:36:20 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id b8so4589685ilh.12
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 16:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pqt30ORAt5NIIu5Ce0uJ1yGi0D7yTHJUmzoEu1HIAiE=;
        b=gKWQdhsaqGb5vdiZUv6OWvX3KqOd9ZSgu8JRf3jvAdxlTcyiXRLXZ5W3/0mu9VxHlX
         RygN12KVwsSu7gWGfFWj2v67Q+6XqhUrx+UNl38/gPltqS+Dcs82a5KeudcriuUgOn1f
         fDPkcOsu0j0EJyrc0I/4kFD5yAaOK3AheX6B2q5PcJCYvek6PiNqxHz6md2Nqo+oHGVm
         W2dHK/oXa52fxpSxOV6MozpEukqXzTFGlQ7SYLx/OAj4CiCQ1aJlqOXejA8FAWghvmYo
         jo85j34T/UbMxAakKGUcyTTrFbanGumSqmVQN13oaSVRGnmPo5MC5Cdz9HvowjBC0hPu
         D/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pqt30ORAt5NIIu5Ce0uJ1yGi0D7yTHJUmzoEu1HIAiE=;
        b=axoTDz+ixLqefisUQP89JG6XVSAQEFbJiyG61c0/MG8kdDuJaTN692NguPkGhdSEZG
         OTzxToyQDv8Bf/Rg7gSKGRCUENoHJj1wDloiv52fioazqwGHWZm566hvrOXP+Z8oVRIZ
         +r0rz4Y60guKYFoUch2fLmvCHY4S+l/ZrctUkn25CPtwSLNMLiNbex+CmT0PkYLizcrA
         uLv7TFL/DhQcV6eG57nHaMYeUhTSgju6szt7eWhySDk+WWzGC66h4Q8xBpP6tzdpmgQx
         2Tr2wmkHYeMwd1NLK08f8V0t5bOiObhPoW8GUqXiHi6sg7JosmFzU9atjDfw0PzXNwrs
         DKIQ==
X-Gm-Message-State: AOAM533yVn3GBahSwMOhfLC3/gXNyq2ahqCcY9nCKJRbIbOqV42w+amS
        7r7U4WueYDOWo2HO9iI/l6sjP7cufJb4MynjMpN/FQ==
X-Google-Smtp-Source: ABdhPJxPF7fGb4Z5nv5+eYbvH1T7bbz/qFsNeAa+T0eHPkiBm7SP4vpDdar8usEG7cqHsCAPfndi1lKHXBC1PcLNT2I=
X-Received: by 2002:a92:440c:: with SMTP id r12mr1259497ila.174.1632353779271;
 Wed, 22 Sep 2021 16:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210922081959.390059-1-irogers@google.com> <YUumPj7Oa1HvVGW/@krava>
In-Reply-To: <YUumPj7Oa1HvVGW/@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Sep 2021 16:36:05 -0700
Message-ID: <CAP-5=fVd8zU-uHMg1KjyNPDv-_y-Q562PvPpoWSi1rS-KD0ezw@mail.gmail.com>
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

Thanks Jiri, It is a ways away from complete. I was thinking to follow up with:
* Migrate the current sub-test approach to use kunit style test cases
within a suite.
* Combine what are currently independent test suites into one test
suite with different test cases, for example stat.c contains stat,
stat_config and stat_round tests.

Once this is done then to unify with kunit we need to work out a
common pattern for skipping a test, etc. There's already a lot here
and so I wanted to get an opinion before pushing along further.

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

I have pretty easy access to ARM but lost access to PowerPC. If we're
happy with the direction then I can test ARM and ask for help on
PowerPC.

Thanks,
Ian

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
