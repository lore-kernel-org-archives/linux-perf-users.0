Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77326C4338F
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 06:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D65A61054
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 06:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbhG2GZB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 02:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbhG2GZA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 02:25:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29B6C061757
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Jul 2021 23:24:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v71-20020a252f4a0000b029055b51419c7dso5712013ybv.23
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Jul 2021 23:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ig9yW7AlFooz6SNIp+N282gcWud42g+mhGkhzdDB7tI=;
        b=lrIJ/pv4DloBVMTY1khfGSy/+pq02J6sjkcOee8earL4Fik5brTIEk2vKuoaWhoIqm
         shXrxpP0h/A+s/3pyhyp91mOhsM5OWizb4oTAA+4tBlMyVafLaHHRQ+WtPBd0+8fZfqs
         mBixU04IXw36jyLCcJKwRu9eMoGl5FOQEahwLfwOKfP1j8L+PbGG6BT4htpfL7q8CRV9
         uEzUIB1sliUANlzleZdqOOB4TAKmbKUGsCv9qmE/b61aQbuito49UYIqkWplS+AAcRgL
         pi64F+2F+LB5l8VmEF5IKh8VYXxfqLO/1EYch/WKJ2YqAc/lhwpH6BDko+bTAiIj8gTL
         AyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ig9yW7AlFooz6SNIp+N282gcWud42g+mhGkhzdDB7tI=;
        b=M5X1IEP45y0kmmkrVaZ4elSHGSZPQ/AxwD5yziaghgzARVXY2R6GMMuBazYlle8cJf
         +00/Nd5018HhuN3YL9HW5EJsB8v0UaMFLDaJum2ll9ZbX0imhgdx/peJ6AXpavWPga78
         3+Vtg2UjIBm7j0R4WcDh2ug5zhdko8Xj1Vp+BNkOXcnmPgZBgfQrhTcy7lr457ddGdLw
         1EaHkEA4wlzyXQ4eAs+3B6nX/72ulXMBTa6AUNXH+LgYiCrBjX+nmrmSDhN/XIyRerNh
         5WVxDMpKW4MskpQPh0HnZdFSgP8zdQDofM1+bNWBYWkgx6DKluYB0PrCP9MvGj/2YQnW
         R1XQ==
X-Gm-Message-State: AOAM532DS0vrDDGz64vgMR3KZYOnLR6cT7BIaprQqOSqUpn2F8tQMKeO
        wdsRDvtuvH2MS2g6cCYXCmKWUM6p3WTW
X-Google-Smtp-Source: ABdhPJz9DrxxrrXYPmbwWmgcXIRMX6CXL6KQNcCisIOTudiMM4HcG37hQKNEYs8qCG/Gf15tSh5yf/PNVNNo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8f98:bc28:73a6:e8c9])
 (user=irogers job=sendgmr) by 2002:a25:b810:: with SMTP id
 v16mr4917039ybj.357.1627539897036; Wed, 28 Jul 2021 23:24:57 -0700 (PDT)
Date:   Wed, 28 Jul 2021 23:24:48 -0700
Message-Id: <20210729062451.1349566-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH 0/3] Some exit code tidying
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

I'm interested in varying error codes for things like parse event
failures. This is some cleanup to use more intention revealing names
in the existing exit/test cases.

Ian Rogers (3):
  libperf: Prefer exit(EXIT_SUCCESS) over exit(0)
  tools perf: Prefer exit(EXIT_*) over exit(0|1)
  perf test: Be more consistent in use of TEST_*

 tools/lib/perf/tests/test-evlist.c          |   2 +-
 tools/perf/arch/x86/tests/bp-modify.c       |   4 +-
 tools/perf/arch/x86/tests/rdpmc.c           |   8 +-
 tools/perf/bench/inject-buildid.c           |   8 +-
 tools/perf/bench/numa.c                     |   2 +-
 tools/perf/bench/sched-messaging.c          |   6 +-
 tools/perf/bench/sched-pipe.c               |   4 +-
 tools/perf/bench/syscall.c                  |   2 +-
 tools/perf/builtin-c2c.c                    |   2 +-
 tools/perf/builtin-ftrace.c                 |   2 +-
 tools/perf/builtin-mem.c                    |   2 +-
 tools/perf/builtin-script.c                 |   4 +-
 tools/perf/perf.c                           |   8 +-
 tools/perf/tests/attr.c                     |   2 +-
 tools/perf/tests/bitmap.c                   |   2 +-
 tools/perf/tests/bp_account.c               |   4 +-
 tools/perf/tests/bp_signal.c                |  51 +++++++--
 tools/perf/tests/code-reading.c             |  12 +-
 tools/perf/tests/cpumap.c                   |  10 +-
 tools/perf/tests/dso-data.c                 |   8 +-
 tools/perf/tests/dwarf-unwind.c             |  14 ++-
 tools/perf/tests/event-times.c              |   2 +-
 tools/perf/tests/evsel-roundtrip-name.c     |  14 +--
 tools/perf/tests/evsel-tp-sched.c           |  28 ++---
 tools/perf/tests/expr.c                     |   4 +-
 tools/perf/tests/fdarray.c                  |   4 +-
 tools/perf/tests/genelf.c                   |   2 +-
 tools/perf/tests/hists_cumulate.c           |   2 +-
 tools/perf/tests/hists_filter.c             |  12 +-
 tools/perf/tests/hists_link.c               |  33 +++---
 tools/perf/tests/keep-tracking.c            |   4 +-
 tools/perf/tests/kmod-path.c                |   6 +-
 tools/perf/tests/mem.c                      |   4 +-
 tools/perf/tests/mem2node.c                 |   2 +-
 tools/perf/tests/mmap-basic.c               |  10 +-
 tools/perf/tests/mmap-thread-lookup.c       |   2 +-
 tools/perf/tests/openat-syscall-all-cpus.c  |   4 +-
 tools/perf/tests/openat-syscall-tp-fields.c |   4 +-
 tools/perf/tests/openat-syscall.c           |   6 +-
 tools/perf/tests/parse-events.c             | 118 ++++++++++----------
 tools/perf/tests/parse-metric.c             |  16 +--
 tools/perf/tests/parse-no-sample-id-all.c   |   4 +-
 tools/perf/tests/perf-hooks.c               |   2 +-
 tools/perf/tests/perf-record.c              |   2 +-
 tools/perf/tests/perf-time-to-tsc.c         |   4 +-
 tools/perf/tests/pfm.c                      |   4 +-
 tools/perf/tests/pmu-events.c               |  36 +++---
 tools/perf/tests/pmu.c                      |  16 +--
 tools/perf/tests/python-use.c               |   2 +-
 tools/perf/tests/sample-parsing.c           |  10 +-
 tools/perf/tests/stat.c                     |  12 +-
 tools/perf/tests/sw-clock.c                 |   8 +-
 tools/perf/tests/switch-tracking.c          |   9 +-
 tools/perf/tests/task-exit.c                |  12 +-
 tools/perf/tests/tests.h                    |   4 +-
 tools/perf/tests/thread-map.c               |   8 +-
 tools/perf/tests/thread-maps-share.c        |   2 +-
 tools/perf/tests/time-utils-test.c          |   2 +-
 tools/perf/tests/topology.c                 |   2 +-
 tools/perf/tests/vmlinux-kallsyms.c         |   6 +-
 tools/perf/tests/wp.c                       |  10 +-
 tools/perf/ui/tui/setup.c                   |   4 +-
 tools/perf/util/dlfilter.c                  |   2 +-
 tools/perf/util/help-unknown-cmd.c          |   2 +-
 64 files changed, 319 insertions(+), 278 deletions(-)

-- 
2.32.0.432.gabb21c7263-goog

