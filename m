Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060A5C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 16:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC16560FD8
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 16:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhKJQPq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Nov 2021 11:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhKJQPq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Nov 2021 11:15:46 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2F7C061764;
        Wed, 10 Nov 2021 08:12:58 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so2378569wmd.1;
        Wed, 10 Nov 2021 08:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nkx/hxjCvKYSYux0Hp241xP789Vv0S9tzt4mlR46qnQ=;
        b=fC4lSPi2ngo1Z3RtNg9b3XkbbX3YFnBhhtl0sgJTOFHsbM5vTf2Qk6LJwAiamYO3q/
         G21oGpWJVeX6IIhO6UDC8MmTYjYSl32YZosQkI8GwJnaIwszZuydqAeFgzQxq2e6zvwv
         ZITn2lKUKmBSrdx+Ecvq17lVItdx0CiBSn29s2qrPruJ1IwojSDO1uP0RSj+PUgxIQC7
         q1Sh0JPQp88+bjEkpNKaChBVQ6t1wh+C8ML5JEmZ2EKdNuiDxc4g9etddRLGPBl08w4s
         hrri5jguf3JfMiOplPsguLAZY6FaC4pAXr0mtiwzQyd6S70UAy6vaNTt5jn55eaP1uHI
         mg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nkx/hxjCvKYSYux0Hp241xP789Vv0S9tzt4mlR46qnQ=;
        b=drh0DTj3q4DZRkZcIFOsApyW53aYUGSK33lcg7EXdCjOmNLuugNOYeHNJJV8dUMcor
         nvdPs1RwXb01QOAAw4Had7DRY79jZhFbByHPUiLyuSMJoe/5iCED0QvdDFszBfWPWAve
         vZmMzSUIVbK5BVp8f66EESLsTa1XoybBb8OJaKP9shzBUABQyYQxoDL4W0BjZKKFl9U9
         xFGus0Q1doL/S6VJ50DUJtN8dqAmi0lB2xZoxKYGSj2Jj8ONgg3EvGnIY5vRleHGrjzS
         ko0xViKADmyj5nGLEnmzuZiTPtkDmGXfnzuOyjvlg70gxateAl0YThp95Bckef1YW2Hv
         I4xg==
X-Gm-Message-State: AOAM531TEqHJlH4Fme5Jc12+PBr6s46rbuC7lqwtVEnIholt5I8B2znU
        RbVGOW8doEXKoGGe9wlixyU=
X-Google-Smtp-Source: ABdhPJzj6dv3JtmN6axu4D1QBvrBXprNS0ipJaY3NZFD+fEbQYUvOnqEcJg848M6CkYsiFT3j9fdqA==
X-Received: by 2002:a05:600c:4fcc:: with SMTP id o12mr18296320wmq.110.1636560777071;
        Wed, 10 Nov 2021 08:12:57 -0800 (PST)
Received: from pc ([197.49.136.152])
        by smtp.gmail.com with ESMTPSA id r8sm417626wrz.43.2021.11.10.08.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 08:12:56 -0800 (PST)
Date:   Wed, 10 Nov 2021 18:12:52 +0200
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>, eranian@google.com
Subject: Re: [PATCH v3 00/22] Start aligning perf test with kunit style
Message-ID: <20211110161252.s4yb3ayw2tqgfugj@pc>
References: <20211104064208.3156807-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 03, 2021 at 11:41:46PM -0700, Ian Rogers wrote:
> Perf test uses its own structs and code layout that differs from kunit
> that was more recently introduced to the kernel. Besides consistency,
> it is hoped that moving in the direction of kunit style will enable
> reuse of infrastructure like test output formatting for continuous
> testing systems. For example:
> https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/
>
> The motivation for this restructuring comes from wanting to be able to
> tag tests with a size:
> https://lore.kernel.org/linux-perf-users/CAP-5=fWmGyuqFKc-EMP3rbmTkjZ3MS+YSajGZfeRMc38HS82gw@mail.gmail.com/
> To have more exhaustive and slower running tests.  This isn't
> something kunit currently supports, nor is the execution of python and
> shell tests, but it seems sensible to work on an approach with kunit
> rather to invent a new wheel inside of perf.
>
> These initial patches are just refactoring the main test suite
> definitions to be in a more kunit style. Kunit isn't depended upon, it
> is hoped that this can be done in later patches for the sake of
> consistency.
>
> v3. Fixes a missing null and out of bound skip reason load detected by
>     address sanitizer. This issue was reported by Jiri Olsa
>     <jolsa@redhat.com> with an address sanitizer reproduction provided
>     by Sohaib Mohamed <sohaib.amhmd@gmail.com>.
>

Tested-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>

Thanks,
Sohaib

> v2. Gets to a point of the perf test test suite/case structs being
>     close facsimiles of the kunit ones. It also addresses feedback on
>     the v1 RFC, in particular from Jiri Olsa <jolsa@redhat.com>.
>
> v1. Built/tested on x86.
>
> Ian Rogers (22):
>   perf test: Use macro for "suite" declarations
>   perf test: Use macro for "suite" definitions
>   perf test: Make each test/suite its own struct.
>   perf test: Move each test suite struct to its test
>   perf test: Rename struct test to test_suite
>   perf test: Add helper functions for abstraction.
>   perf test: Add test case struct.
>   perf test: Add skip reason to test case.
>   perf test: Convert pfm tests to use test cases.
>   perf test: Convert pmu event tests to test cases.
>   perf test: Convert watch point tests to test cases.
>   perf test: Convert clang tests to test cases.
>   perf test: Convert bpf tests to test cases.
>   perf test: Convert llvm tests to test cases.
>   perf test: Remove now unused subtest helpers
>   perf test: bp tests use test case
>   perf test: Convert time to tsc test to test case.
>   perf test: Remove non test case style support.
>   perf test: BP tests, remove is_supported use
>   perf test: TSC test, remove is_supported use
>   perf test: Remove is_supported function
>   perf test: Remove skip_if_fail
>
>  tools/perf/arch/arm/include/arch-tests.h      |   2 +-
>  tools/perf/arch/arm/tests/arch-tests.c        |  18 +-
>  tools/perf/arch/arm/tests/vectors-page.c      |   2 +-
>  tools/perf/arch/arm64/include/arch-tests.h    |   2 +-
>  tools/perf/arch/arm64/tests/arch-tests.c      |  11 +-
>  tools/perf/arch/powerpc/include/arch-tests.h  |   2 +-
>  tools/perf/arch/powerpc/tests/arch-tests.c    |  12 +-
>  tools/perf/arch/x86/include/arch-tests.h      |  14 +-
>  tools/perf/arch/x86/tests/arch-tests.c        |  47 +-
>  tools/perf/arch/x86/tests/bp-modify.c         |   2 +-
>  tools/perf/arch/x86/tests/insn-x86.c          |   2 +-
>  tools/perf/arch/x86/tests/intel-cqm.c         |   2 +-
>  .../x86/tests/intel-pt-pkt-decoder-test.c     |   2 +-
>  tools/perf/arch/x86/tests/rdpmc.c             |   2 +-
>  tools/perf/arch/x86/tests/sample-parsing.c    |   2 +-
>  tools/perf/tests/api-io.c                     |   6 +-
>  tools/perf/tests/attr.c                       |   4 +-
>  tools/perf/tests/backward-ring-buffer.c       |   4 +-
>  tools/perf/tests/bitmap.c                     |   4 +-
>  tools/perf/tests/bp_account.c                 |  36 +-
>  tools/perf/tests/bp_signal.c                  |  34 +-
>  tools/perf/tests/bp_signal_overflow.c         |   9 +-
>  tools/perf/tests/bpf.c                        |  69 ++-
>  tools/perf/tests/builtin-test.c               | 578 ++++++------------
>  tools/perf/tests/clang.c                      |  54 +-
>  tools/perf/tests/code-reading.c               |   4 +-
>  tools/perf/tests/cpumap.c                     |  10 +-
>  tools/perf/tests/demangle-java-test.c         |   4 +-
>  tools/perf/tests/demangle-ocaml-test.c        |   4 +-
>  tools/perf/tests/dlfilter-test.c              |   4 +-
>  tools/perf/tests/dso-data.c                   |  10 +-
>  tools/perf/tests/dwarf-unwind.c               |   5 +-
>  tools/perf/tests/event-times.c                |   4 +-
>  tools/perf/tests/event_update.c               |   4 +-
>  tools/perf/tests/evsel-roundtrip-name.c       |   5 +-
>  tools/perf/tests/evsel-tp-sched.c             |   5 +-
>  tools/perf/tests/expand-cgroup.c              |   6 +-
>  tools/perf/tests/expr.c                       |   4 +-
>  tools/perf/tests/fdarray.c                    |   7 +-
>  tools/perf/tests/genelf.c                     |   6 +-
>  tools/perf/tests/hists_cumulate.c             |   4 +-
>  tools/perf/tests/hists_filter.c               |   4 +-
>  tools/perf/tests/hists_link.c                 |   4 +-
>  tools/perf/tests/hists_output.c               |   4 +-
>  tools/perf/tests/is_printable_array.c         |   4 +-
>  tools/perf/tests/keep-tracking.c              |   4 +-
>  tools/perf/tests/kmod-path.c                  |   4 +-
>  tools/perf/tests/llvm.c                       |  74 ++-
>  tools/perf/tests/maps.c                       |   4 +-
>  tools/perf/tests/mem.c                        |   4 +-
>  tools/perf/tests/mem2node.c                   |   4 +-
>  tools/perf/tests/mmap-basic.c                 |   4 +-
>  tools/perf/tests/mmap-thread-lookup.c         |   4 +-
>  tools/perf/tests/openat-syscall-all-cpus.c    |   5 +-
>  tools/perf/tests/openat-syscall-tp-fields.c   |   5 +-
>  tools/perf/tests/openat-syscall.c             |   5 +-
>  tools/perf/tests/parse-events.c               |   4 +-
>  tools/perf/tests/parse-metric.c               |   4 +-
>  tools/perf/tests/parse-no-sample-id-all.c     |   5 +-
>  tools/perf/tests/pe-file-parsing.c            |   6 +-
>  tools/perf/tests/perf-hooks.c                 |   4 +-
>  tools/perf/tests/perf-record.c                |   4 +-
>  tools/perf/tests/perf-time-to-tsc.c           |  30 +-
>  tools/perf/tests/pfm.c                        |  63 +-
>  tools/perf/tests/pmu-events.c                 |  73 +--
>  tools/perf/tests/pmu.c                        |   4 +-
>  tools/perf/tests/python-use.c                 |   4 +-
>  tools/perf/tests/sample-parsing.c             |   4 +-
>  tools/perf/tests/sdt.c                        |   6 +-
>  tools/perf/tests/stat.c                       |  11 +-
>  tools/perf/tests/sw-clock.c                   |   4 +-
>  tools/perf/tests/switch-tracking.c            |   4 +-
>  tools/perf/tests/task-exit.c                  |   4 +-
>  tools/perf/tests/tests.h                      | 238 ++++----
>  tools/perf/tests/thread-map.c                 |  10 +-
>  tools/perf/tests/thread-maps-share.c          |   4 +-
>  tools/perf/tests/time-utils-test.c            |   4 +-
>  tools/perf/tests/topology.c                   |   4 +-
>  tools/perf/tests/unit_number__scnprintf.c     |   4 +-
>  tools/perf/tests/vmlinux-kallsyms.c           |   5 +-
>  tools/perf/tests/wp.c                         | 122 +---
>  tools/perf/util/c++/clang-c.h                 |   8 +-
>  tools/perf/util/c++/clang-test.cpp            |   6 +-
>  83 files changed, 812 insertions(+), 966 deletions(-)
>
> --
> 2.33.1.1089.g2158813163f-goog
>
