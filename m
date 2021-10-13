Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3F8C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7191961151
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbhJMRs3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238182AbhJMRs1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Oct 2021 13:48:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF5AC06174E
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:46:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v70-20020a256149000000b005ba4d61ea0fso3914432ybb.22
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Zi5HmM/Iu6/fkSGLhyqm/tkYmOiHV4iGSD0CDddNH0Q=;
        b=VGGWiTy5s9uZj6oVqPMRlagfGE5LIaoUFUuRzCfilBPRS+fJWlHbnEXUD/nhWoMqFg
         AGTHRbNNbNBF0kefvoq76q8Fozlqx28Z9UYaANCJ/vhJBY7AhvfQ4IScC19jEXSqCATL
         YBfMLGJnKGss4DP8nbrrliZuGBMYEk+nOhkwnfw9QJUIz1tQYcqSuBYfKinKmifEFKQX
         X8WqAl/dXscFcX+s3sHdhfNteTM83UZjlADZMm/wurOtz30Wf8niHLzPd8r00mFQ74Lo
         Wl8GQ91hzqVLzbemu3So9NfbjDzCuU3F5gMMJyO6EqU2V237ni/XLA79fcOLFagw3IMG
         JQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Zi5HmM/Iu6/fkSGLhyqm/tkYmOiHV4iGSD0CDddNH0Q=;
        b=f+in25vwzO/WpLy59rMjg4UoUJ1D6fok2KkOsPizJbKQox3AcPYgPRld4lnhAO/b+Z
         ocCIH3E/JYWR+MCWxdTSpVSeKzB8DOgHzgj7eZAlaw5SJUtyYBRbTHdM6gYli+wrlETP
         ATdQpRNCB+kSMmb3rKWW92/kJoGrrx9sF801LvPxniJ6ujH/hRYbS4130p8aYz0V6B4S
         7m2Fe9T/x6hl0ie6pUovCpC7m8zl+LuWhqGsg8fBpCdk10OE9g3VP1YAiqagBp5V7ijC
         c6zTTT9IG6YqqfzdRlQJ6GLeCEZ9tisuE1Lynt92Gzj1YnwsnNZMrPK2Csycs69UIn/y
         7hTg==
X-Gm-Message-State: AOAM530Hfh7/oCry+ZKuebUt1yDt8YPt345TpS/ir343YJLiOEBtlHyg
        epEDUL/lHlnsixfiIaOkYd+aJ382l2rJ
X-Google-Smtp-Source: ABdhPJwzOqfZ1PiPr3V1eCTuH0ImAWtQ6SJ7/slvZ79fWK8rMMpQaHA0e/a6liIK03GeDlqSAlIkSrHWmK7Z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:a25:4146:: with SMTP id
 o67mr836334yba.113.1634147181878; Wed, 13 Oct 2021 10:46:21 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:45:42 -0700
Message-Id: <20211013174604.747276-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 00/22] Start aligning perf test with kunit style
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
        David Gow <davidgow@google.com>
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
 tools/perf/arch/x86/tests/arch-tests.c        |  46 +-
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
 83 files changed, 811 insertions(+), 966 deletions(-)

-- 
2.33.0.882.g93a45727a2-goog

