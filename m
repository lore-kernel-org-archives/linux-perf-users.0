Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A4CC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 08:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC78061050
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 08:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhIVIVe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 04:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbhIVIVe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 04:21:34 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFA9C061756
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 01:20:04 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id r11-20020ac86d2b000000b002a688ea1f4bso7387438qtu.5
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 01:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KhEOVDh5xBwdR6E0McNSkMxXx4DtQkSqGqlUPDV4Oz8=;
        b=ajtll/hE+SdlHmRQaIxAQ28nCxwVV1hOI1A/1IKZcGgcfUPcWAh7hoMvnaOf0hrGjF
         HJ2k9lbug/vVAKK5fIT/tDI0PJ0M5Z7kWIU9Lv6R0RH42PuzLWGhCPOEFuG+3dy+p0JE
         bV+BsNWoWcLqJLdzN5ObO1C0YbKZfKXugG37yUOrkzjW2ueOKGSzQjOnZAgw9kMg+IKk
         Fq83SlybD4SaoCI0mRZ3tx8qALO9rgc/O37jRnbHVPLnv0ecI3sZ2GVvimgrCOnZLh28
         4SyN/lfsjXbr2rRrKYtY3wjEQ8aJ8CTqB6NP7u87s94MKSyeArjPyK6H8mygfMLIJNLq
         KwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KhEOVDh5xBwdR6E0McNSkMxXx4DtQkSqGqlUPDV4Oz8=;
        b=GMf7OIPIoEWpEaWuvWyN8zMCED4/hSj4djkIvxY717jltUbz6IHTQmvwyPHBw8w6cc
         Pyi0E0b6yjuuDByvl4Fz1dcd47XVe7PecW/GT9SZfFtzdfUdIsFPNmlO4RH1V1PzWfAa
         1OFGTgOdj8FfA/4iaeOHTbgg2cEJ2Cmoo9qpVmke+iemhVyvDaUo1jfE5vZJCXWFeBuQ
         yTC+7kBe9AUoleK140R/gUhhdgJ1d31I50OMPTm2tJIpmAhnn06U+XWo9y3aNum9yIwF
         dzrMe0YIJtrslVi8IQZuHqAiqlFlxYmmetMxWT4iSdj5azevswE3IHQUWP/d20EwHgsA
         1Wyg==
X-Gm-Message-State: AOAM532JREOX/aZK5ktmyZoapg6aJvk6JU1xkAkKi+Ucp+yEey1ityJX
        Mm1MWlVcyQKc4Q2BgeForAfHzjKJOVhB
X-Google-Smtp-Source: ABdhPJwcd8CQaMde92mXnkx5x7+KSleayRkdFp32li3a/2Sm9cufhNS2kFs5KbkxeE0ojA8hDnduboWfr9Ju
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dffa:819a:f0e2:47e])
 (user=irogers job=sendgmr) by 2002:a25:7652:: with SMTP id
 r79mr45385167ybc.96.1632298803763; Wed, 22 Sep 2021 01:20:03 -0700 (PDT)
Date:   Wed, 22 Sep 2021 01:19:53 -0700
Message-Id: <20210922081959.390059-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [RFC PATCH 0/5] Start aligning perf test with kunit style
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

v1. Built/tested on x86.

Ian Rogers (5):
  perf test: Use macro for "suite" declarations
  perf test: Use macro for "suite" definitions
  perf test: Make each test/suite its own struct.
  perf test: Move each test suite struct to its test
  perf test: Rename struct test to test_suite

 tools/perf/arch/arm/include/arch-tests.h      |   2 +-
 tools/perf/arch/arm/tests/arch-tests.c        |  21 +-
 tools/perf/arch/arm/tests/vectors-page.c      |   2 +-
 tools/perf/arch/arm64/include/arch-tests.h    |   2 +-
 tools/perf/arch/arm64/tests/arch-tests.c      |  15 +-
 tools/perf/arch/powerpc/include/arch-tests.h  |   2 +-
 tools/perf/arch/powerpc/tests/arch-tests.c    |  15 +-
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
 tools/perf/tests/bp_account.c                 |  10 +-
 tools/perf/tests/bp_signal.c                  |   8 +-
 tools/perf/tests/bp_signal_overflow.c         |   8 +-
 tools/perf/tests/bpf.c                        |  22 +-
 tools/perf/tests/builtin-test.c               | 441 ++++--------------
 tools/perf/tests/clang.c                      |  18 +-
 tools/perf/tests/code-reading.c               |   4 +-
 tools/perf/tests/cpumap.c                     |  10 +-
 tools/perf/tests/demangle-java-test.c         |   4 +-
 tools/perf/tests/demangle-ocaml-test.c        |   4 +-
 tools/perf/tests/dlfilter-test.c              |   4 +-
 tools/perf/tests/dso-data.c                   |  10 +-
 tools/perf/tests/dwarf-unwind.c               |   2 +-
 tools/perf/tests/event-times.c                |   4 +-
 tools/perf/tests/event_update.c               |   4 +-
 tools/perf/tests/evsel-roundtrip-name.c       |   4 +-
 tools/perf/tests/evsel-tp-sched.c             |   4 +-
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
 tools/perf/tests/llvm.c                       |  22 +-
 tools/perf/tests/maps.c                       |   4 +-
 tools/perf/tests/mem.c                        |   4 +-
 tools/perf/tests/mem2node.c                   |   4 +-
 tools/perf/tests/mmap-basic.c                 |   4 +-
 tools/perf/tests/mmap-thread-lookup.c         |   4 +-
 tools/perf/tests/openat-syscall-all-cpus.c    |   5 +-
 tools/perf/tests/openat-syscall-tp-fields.c   |   4 +-
 tools/perf/tests/openat-syscall.c             |   5 +-
 tools/perf/tests/parse-events.c               |   4 +-
 tools/perf/tests/parse-metric.c               |   4 +-
 tools/perf/tests/parse-no-sample-id-all.c     |   4 +-
 tools/perf/tests/pe-file-parsing.c            |   6 +-
 tools/perf/tests/perf-hooks.c                 |   4 +-
 tools/perf/tests/perf-record.c                |   4 +-
 tools/perf/tests/perf-time-to-tsc.c           |  10 +-
 tools/perf/tests/pfm.c                        |  16 +-
 tools/perf/tests/pmu-events.c                 |  19 +-
 tools/perf/tests/pmu.c                        |   4 +-
 tools/perf/tests/python-use.c                 |   4 +-
 tools/perf/tests/sample-parsing.c             |   4 +-
 tools/perf/tests/sdt.c                        |   6 +-
 tools/perf/tests/stat.c                       |  10 +-
 tools/perf/tests/sw-clock.c                   |   4 +-
 tools/perf/tests/switch-tracking.c            |   4 +-
 tools/perf/tests/task-exit.c                  |   4 +-
 tools/perf/tests/tests.h                      | 179 ++++---
 tools/perf/tests/thread-map.c                 |  10 +-
 tools/perf/tests/thread-maps-share.c          |   4 +-
 tools/perf/tests/time-utils-test.c            |   4 +-
 tools/perf/tests/topology.c                   |   4 +-
 tools/perf/tests/unit_number__scnprintf.c     |   4 +-
 tools/perf/tests/vmlinux-kallsyms.c           |   5 +-
 tools/perf/tests/wp.c                         |  22 +-
 81 files changed, 543 insertions(+), 618 deletions(-)

-- 
2.33.0.464.g1972c5931b-goog

