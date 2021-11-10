Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7CFC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 12:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF1C861264
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 12:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhKJMXP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Nov 2021 07:23:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231518AbhKJMXN (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Nov 2021 07:23:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19E5661251;
        Wed, 10 Nov 2021 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636546826;
        bh=9Mi7zBfFOFp45IKxZWRivyzhCkIw7ndVOzsvusYFmkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sf+YPTBzy4awnCs8d6Dvj+dzdmSYjxDf4Z9A2Z0NG0O8VminD7cva2FkeBTQWco5L
         JKN6CZoeovKchEy9cQ8nQaMKhzzyVnTMd0PjmFBLeS4OT7JBDEawUqjeHh4MNvyfwY
         Td/+QCYFSItslZ9zM8og2uZL0qV6HbpFgV4rBLdoRK561FoK7ntRM+x3jrTTaggP6h
         9TsX3v/lFQWiM79c3VzqgQ9DnkehgV8OPVhYYhEH2Uwq29ETf7x0iws7vo2Glfr93T
         JNvEQBbWkyPe0ULBLN4gmbnNRp3yrHsnvv7H3+IiXnpgChCyMgo81EqqbJsm4HERnR
         EvFq2GFP0g+0w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0EF29410A1; Wed, 10 Nov 2021 09:20:23 -0300 (-03)
Date:   Wed, 10 Nov 2021 09:20:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        David Gow <davidgow@google.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>, eranian@google.com
Subject: Re: [PATCH v3 00/22] Start aligning perf test with kunit style
Message-ID: <YYu5Bl7tJkDEdpce@kernel.org>
References: <20211104064208.3156807-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Nov 03, 2021 at 11:41:46PM -0700, Ian Rogers escreveu:
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
> v2. Gets to a point of the perf test test suite/case structs being
>     close facsimiles of the kunit ones. It also addresses feedback on
>     the v1 RFC, in particular from Jiri Olsa <jolsa@redhat.com>.
> 
> v1. Built/tested on x86.

  60     7.19 ubuntu:16.04-x-arm            : FAIL gcc version 5.4.0 20160609 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9)
    arch/arm/tests/vectors-page.c:12:5: error: no previous prototype for 'test__vectors_page' [-Werror=missing-prototypes]
     int test__vectors_page(struct test_suite *test __maybe_unused,
         ^
    cc1: all warnings being treated as errors
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'tests' failed
    make[5]: *** [tests] Error 2
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'arm' failed
    make[4]: *** [arm] Error 2
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'arch' failed
    make[3]: *** [arch] Error 2
  61    19.15 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  62    18.64 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  63    19.04 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  64    18.94 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  65     6.48 ubuntu:16.04-x-s390           : FAIL gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.9)
    tests/wp.c:24:12: error: 'wp_read' defined but not used [-Werror=unused-function]
     static int wp_read(int fd, long long *count, int size)
                ^
    tests/wp.c:51:12: error: '__event' defined but not used [-Werror=unused-function]
     static int __event(int wp_type, void *wp_addr, unsigned long wp_len)
                ^
    cc1: all warnings being treated as errors
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'tests' failed
    make[3]: *** [tests] Error 2
  66    75.42 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  67     7.70 ubuntu:18.04-x-arm            : FAIL gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04)
    arch/arm/tests/vectors-page.c:12:5: error: no previous prototype for 'test__vectors_page' [-Werror=missing-prototypes]
     int test__vectors_page(struct test_suite *test __maybe_unused,
         ^~~~~~~~~~~~~~~~~~
    cc1: all warnings being treated as errors
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'tests' failed
    make[5]: *** [tests] Error 2
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'arm' failed
    make[4]: *** [arm] Error 2
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'arch' failed
    make[3]: *** [arch] Error 2
  68    20.55 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
  69    22.45 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  70    19.94 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  71    21.36 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  72    21.75 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  73   102.45 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  74     6.90 ubuntu:18.04-x-s390           : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
    tests/wp.c:51:12: error: '__event' defined but not used [-Werror=unused-function]
     static int __event(int wp_type, void *wp_addr, unsigned long wp_len)
                ^~~~~~~
    tests/wp.c:24:12: error: 'wp_read' defined but not used [-Werror=unused-function]
     static int wp_read(int fd, long long *count, int size)
                ^~~~~~~
    cc1: all warnings being treated as errors
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'tests' failed
    make[3]: *** [tests] Error 2


I'm trying to fix those now.

- Arnaldo
 
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

-- 

- Arnaldo
