Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6860C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A4E60ED5
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhKDGox (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhKDGow (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 02:44:52 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB0AC061714
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Nov 2021 23:42:15 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id v14-20020a05620a0f0e00b0043355ed67d1so4073382qkl.7
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Nov 2021 23:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=w0kh89to1zhehI/CVL9rXrp6S32A9ztok2TsK5d0jl4=;
        b=K0j5TQiJ6mELfax+1pIz2ky8yPZblthyvqyptP5LCw70hjq2BkupSQmP98YvHVn+5g
         shCYA46RatgJes4b1LhHCaRNj1VdSvdBYgmH8H1uU0jA3V4WheMUNVXYqhZ0GU4GRDDC
         vaNT+BGFfG0o0RaTNtB3AaoujBHD/iNo/3NIpHMk1ZoEYMo/+j/5FWA/35C87HVZNX49
         ngpnU461xagBf3wpjjHu5p4oJiKEisHHMPicFjfwb8Bes3MO6dVFH5vXVKGHTWGOJGgI
         kWwpAY2jBbOEfIUTAJz3hK4Tj/cDSuW8wOyuZwoPuOi1opL5CILzRWQTlD+8axNB5z2o
         V6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=w0kh89to1zhehI/CVL9rXrp6S32A9ztok2TsK5d0jl4=;
        b=1UBVV66eep54+9H0zgu83YNCJ1rgXaWkW/l9/0HPuuoxPlW6DQly/E9aw6G07S8Qo+
         35XkQhEO8B1ngnzm7vgGNUxFMcYvvr6s9OhmS8dbmAUL2qFmAYiTWaxQhEVICXrSKFU5
         sx17qiQCwYp4Z8hTfBMBhAq98EMs1RQ0F//WIcsM6BDmiCLhkguoZ+QrCYlPmTRYtdIH
         KEo+qbi/KOk8TXZBKm8stpnreqORy57vrEADui79dgOD5A7DIpFrMHBIIcK6F1xQc/Hy
         gybbKNtkuSTH8uuvG2Q4xUhFmSeWeaTwtDpHQ69tjLEA2TE2vWoep+2fRYIzDR2w19Q6
         J0yQ==
X-Gm-Message-State: AOAM532llP8VswqkFsXyyrBJeLz4OpvGWUDzXJxuE1Py7VCnOXur8swm
        zv8RQ+7xcCB+7toKwbUoLhgPETkqZ5It
X-Google-Smtp-Source: ABdhPJyBmcCVHuL9KNPhYR9KHBXUsQw9fvQ1TU7+6+MAkz7tPJC8ADAeAsnDnZQmP2GZl9Flm2Is6mpdqcui
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a05:622a:1885:: with SMTP id
 v5mr34190755qtc.176.1636008134362; Wed, 03 Nov 2021 23:42:14 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:41:46 -0700
Message-Id: <20211104064208.3156807-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 00/22] Start aligning perf test with kunit style
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
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
        David Gow <davidgow@google.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Perf test uses its own structs and code layout that differs from kunit
that was more recently introduced to the kernel. Besides consistency,
it is hoped that moving in the direction of kunit style will enable
reuse of infrastructure like test output formatting for continuous
testing systems. For example:
https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/

The motivation for this restructuring comes from wanting to be able to
tag tests with a size:
https://lore.kernel.org/linux-perf-users/CAP-5=fWmGyuqFKc-EMP3rbmTkjZ3MS+YSajGZfeRMc38HS82gw@mail.gmail.com/
To have more exhaustive and slower running tests.  This isn't
something kunit currently supports, nor is the execution of python and
shell tests, but it seems sensible to work on an approach with kunit
rather to invent a new wheel inside of perf.

These initial patches are just refactoring the main test suite
definitions to be in a more kunit style. Kunit isn't depended upon, it
is hoped that this can be done in later patches for the sake of
consistency.

v3. Fixes a missing null and out of bound skip reason load detected by
    address sanitizer. This issue was reported by Jiri Olsa
    <jolsa@redhat.com> with an address sanitizer reproduction provided
    by Sohaib Mohamed <sohaib.amhmd@gmail.com>.

v2. Gets to a point of the perf test test suite/case structs being
    close facsimiles of the kunit ones. It also addresses feedback on
    the v1 RFC, in particular from Jiri Olsa <jolsa@redhat.com>.

v1. Built/tested on x86.

Ian Rogers (22):
  perf test: Use macro for "suite" declarations
  perf test: Use macro for "suite" definitions
  perf test: Make each test/suite its own struct.
  perf test: Move each test suite struct to its test
  perf test: Rename struct test to test_suite
  perf test: Add helper functions for abstraction.
  perf test: Add test case struct.
  perf test: Add skip reason to test case.
  perf test: Convert pfm tests to use test cases.
  perf test: Convert pmu event tests to test cases.
  perf test: Convert watch point tests to test cases.
  perf test: Convert clang tests to test cases.
  perf test: Convert bpf tests to test cases.
  perf test: Convert llvm tests to test cases.
  perf test: Remove now unused subtest helpers
  perf test: bp tests use test case
  perf test: Convert time to tsc test to test case.
  perf test: Remove non test case style support.
  perf test: BP tests, remove is_supported use
  perf test: TSC test, remove is_supported use
  perf test: Remove is_supported function
  perf test: Remove skip_if_fail

 tools/perf/arch/arm/include/arch-tests.h      |   2 +-
 tools/perf/arch/arm/tests/arch-tests.c        |  18 +-
 tools/perf/arch/arm/tests/vectors-page.c      |   2 +-
 tools/perf/arch/arm64/include/arch-tests.h    |   2 +-
 tools/perf/arch/arm64/tests/arch-tests.c      |  11 +-
 tools/perf/arch/powerpc/include/arch-tests.h  |   2 +-
 tools/perf/arch/powerpc/tests/arch-tests.c    |  12 +-
 tools/perf/arch/x86/include/arch-tests.h      |  14 +-
 tools/perf/arch/x86/tests/arch-tests.c        |  47 +-
 tools/perf/arch/x86/tests/bp-modify.c         |   2 +-
 tools/perf/arch/x86/tests/insn-x86.c          |   2 +-
 tools/perf/arch/x86/tests/intel-cqm.c         |   2 +-
 .../x86/tests/intel-pt-pkt-decoder-test.c     |   2 +-
 tools/perf/arch/x86/tests/rdpmc.c             |   2 +-
 tools/perf/arch/x86/tests/sample-parsing.c    |   2 +-
 tools/perf/tests/api-io.c                     |   6 +-
 tools/perf/tests/attr.c                       |   4 +-
 tools/perf/tests/backward-ring-buffer.c       |   4 +-
 tools/perf/tests/bitmap.c                     |   4 +-
 tools/perf/tests/bp_account.c                 |  36 +-
 tools/perf/tests/bp_signal.c                  |  34 +-
 tools/perf/tests/bp_signal_overflow.c         |   9 +-
 tools/perf/tests/bpf.c                        |  69 ++-
 tools/perf/tests/builtin-test.c               | 578 ++++++------------
 tools/perf/tests/clang.c                      |  54 +-
 tools/perf/tests/code-reading.c               |   4 +-
 tools/perf/tests/cpumap.c                     |  10 +-
 tools/perf/tests/demangle-java-test.c         |   4 +-
 tools/perf/tests/demangle-ocaml-test.c        |   4 +-
 tools/perf/tests/dlfilter-test.c              |   4 +-
 tools/perf/tests/dso-data.c                   |  10 +-
 tools/perf/tests/dwarf-unwind.c               |   5 +-
 tools/perf/tests/event-times.c                |   4 +-
 tools/perf/tests/event_update.c               |   4 +-
 tools/perf/tests/evsel-roundtrip-name.c       |   5 +-
 tools/perf/tests/evsel-tp-sched.c             |   5 +-
 tools/perf/tests/expand-cgroup.c              |   6 +-
 tools/perf/tests/expr.c                       |   4 +-
 tools/perf/tests/fdarray.c                    |   7 +-
 tools/perf/tests/genelf.c                     |   6 +-
 tools/perf/tests/hists_cumulate.c             |   4 +-
 tools/perf/tests/hists_filter.c               |   4 +-
 tools/perf/tests/hists_link.c                 |   4 +-
 tools/perf/tests/hists_output.c               |   4 +-
 tools/perf/tests/is_printable_array.c         |   4 +-
 tools/perf/tests/keep-tracking.c              |   4 +-
 tools/perf/tests/kmod-path.c                  |   4 +-
 tools/perf/tests/llvm.c                       |  74 ++-
 tools/perf/tests/maps.c                       |   4 +-
 tools/perf/tests/mem.c                        |   4 +-
 tools/perf/tests/mem2node.c                   |   4 +-
 tools/perf/tests/mmap-basic.c                 |   4 +-
 tools/perf/tests/mmap-thread-lookup.c         |   4 +-
 tools/perf/tests/openat-syscall-all-cpus.c    |   5 +-
 tools/perf/tests/openat-syscall-tp-fields.c   |   5 +-
 tools/perf/tests/openat-syscall.c             |   5 +-
 tools/perf/tests/parse-events.c               |   4 +-
 tools/perf/tests/parse-metric.c               |   4 +-
 tools/perf/tests/parse-no-sample-id-all.c     |   5 +-
 tools/perf/tests/pe-file-parsing.c            |   6 +-
 tools/perf/tests/perf-hooks.c                 |   4 +-
 tools/perf/tests/perf-record.c                |   4 +-
 tools/perf/tests/perf-time-to-tsc.c           |  30 +-
 tools/perf/tests/pfm.c                        |  63 +-
 tools/perf/tests/pmu-events.c                 |  73 +--
 tools/perf/tests/pmu.c                        |   4 +-
 tools/perf/tests/python-use.c                 |   4 +-
 tools/perf/tests/sample-parsing.c             |   4 +-
 tools/perf/tests/sdt.c                        |   6 +-
 tools/perf/tests/stat.c                       |  11 +-
 tools/perf/tests/sw-clock.c                   |   4 +-
 tools/perf/tests/switch-tracking.c            |   4 +-
 tools/perf/tests/task-exit.c                  |   4 +-
 tools/perf/tests/tests.h                      | 238 ++++----
 tools/perf/tests/thread-map.c                 |  10 +-
 tools/perf/tests/thread-maps-share.c          |   4 +-
 tools/perf/tests/time-utils-test.c            |   4 +-
 tools/perf/tests/topology.c                   |   4 +-
 tools/perf/tests/unit_number__scnprintf.c     |   4 +-
 tools/perf/tests/vmlinux-kallsyms.c           |   5 +-
 tools/perf/tests/wp.c                         | 122 +---
 tools/perf/util/c++/clang-c.h                 |   8 +-
 tools/perf/util/c++/clang-test.cpp            |   6 +-
 83 files changed, 812 insertions(+), 966 deletions(-)

-- 
2.33.1.1089.g2158813163f-goog

