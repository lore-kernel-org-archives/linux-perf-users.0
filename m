Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1668C3F6B0
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Aug 2022 22:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiHWWJd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Aug 2022 18:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiHWWJc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Aug 2022 18:09:32 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC6F4F1BD
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 15:09:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-334370e5ab9so262765957b3.22
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 15:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=HRWWuMUYy36/5xb+aAKJxi6xKWERSTh637ioc2nz1MM=;
        b=TbODgJmMNwImOPQ+3Wbs2Ur4gZuBVrcmswRIWZUOLMqrxcpOOf9/WcRW8qfV2F+JL5
         oEx6uYt2Vf5L3Lb1O3vlf748jkHyGUegaloQb1NGL9pYPhHoQUE+L1wF6g/zK7b11XOz
         B/QV3ganfLkN/NW0VtbOz2Fxpi5W56ZfXXst2Q8dHz6sRIO8xos24vVAvg0NoSCRFYH7
         E+vXoe78S2TNJCSATNR6+iKUxdkzs1IyD1/X16H7Z6pqQmfy74twnJ7Ott/AWdefE+Vu
         nKf9wXn5ElZCAGevccTwWPx2DPi7X9EhkUyFbvzdD6/WqgAsH1Hd0SNrlsQovajT8QaW
         Y7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=HRWWuMUYy36/5xb+aAKJxi6xKWERSTh637ioc2nz1MM=;
        b=UEC7lS8gucfL+NkR9BZlWlJitOgIk/eLXEbTDNCbl9rqRT18Toy3Qg4tXhjGG6/+Ac
         ZrOsnTN/vguHgd7CsSYfPiFvG3InrDxQ14htQ216FzwPLGtxEdKPxeh/cHfNehBaddMf
         FzYDA/vOgGfuzRc+uDJewKU3/VtLnYwhvVDpLP9P20wNRKy42cJDTfMw2sGHQsDdxL7F
         MczRE96MsYFzsi7nRU/ZoKxhNiHlPyHQQ1+p8/JqKhhJnS6Bq6pX+beaigubT/ea5yb2
         /ENdh84Gu/OkMQ4nIPsIXD32BMcpGZkXGmM0h0s+WYxICrbiXTBHgIdkUZxRjP0xxiu/
         IYzQ==
X-Gm-Message-State: ACgBeo0c3jMSSfVIWnkUIFVGPezkEksxyYomwOC/d7oW9RhQ5FGc3AXz
        yoXbfrBLkIhjq+SkHMRkQNEQwdJawhB6
X-Google-Smtp-Source: AA6agR7wyeS4bKT9fcGk1VO3ihu1bw0SXHxTcOJXjKtyu/7pvii/KcWvhbTN3WU5iC4VPBLRHzbOGicZwyXy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7dbd:c08f:de81:c2a3])
 (user=irogers job=sendgmr) by 2002:a05:6902:702:b0:695:526d:7957 with SMTP id
 k2-20020a056902070200b00695526d7957mr21957631ybt.256.1661292569676; Tue, 23
 Aug 2022 15:09:29 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:09:04 -0700
Message-Id: <20220823220922.256001-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v2 00/18] Mutex wrapper, locking and memory leak fixes
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When fixing a locking race and memory leak in:
https://lore.kernel.org/linux-perf-users/20211118193714.2293728-1-irogers@google.com/

It was requested that debug mutex code be separated out into its own
files. This was, in part, done by Pavithra Gurushankar in:
https://lore.kernel.org/lkml/20220727111954.105118-1-gpavithrasha@gmail.com/

These patches fix issues with the previous patches, add in the
original dso->nsinfo fix and then build on our mutex wrapper with
clang's -Wthread-safety analysis. The analysis found missing unlocks
in builtin-sched.c which are fixed and -Wthread-safety is enabled by
default when building with clang.

v2. Breaks apart changes that s/pthread_mutex/mutex/g and the lock
    annotations as requested by Arnaldo and Namhyung. A boolean is
    added to builtin-sched.c to terminate thread funcs rather than
    leaving them blocked on delted mutexes.

Ian Rogers (17):
  perf bench: Update use of pthread mutex/cond
  perf tests: Avoid pthread.h inclusion
  perf hist: Update use of pthread mutex
  perf bpf: Remove unused pthread.h include
  perf lock: Remove unused pthread.h include
  perf record: Update use of pthread mutex
  perf sched: Update use of pthread mutex
  perf ui: Update use of pthread mutex
  perf mmap: Remove unnecessary pthread.h include
  perf dso: Update use of pthread mutex
  perf annotate: Update use of pthread mutex
  perf top: Update use of pthread mutex
  perf dso: Hold lock when accessing nsinfo
  perf mutex: Add thread safety annotations
  perf sched: Fixes for thread safety analysis
  perf top: Fixes for thread safety analysis
  perf build: Enable -Wthread-safety with clang

Pavithra Gurushankar (1):
  perf mutex: Wrapped usage of mutex and cond

 tools/perf/Makefile.config                 |   5 +
 tools/perf/bench/epoll-ctl.c               |  33 +++----
 tools/perf/bench/epoll-wait.c              |  33 +++----
 tools/perf/bench/futex-hash.c              |  33 +++----
 tools/perf/bench/futex-lock-pi.c           |  33 +++----
 tools/perf/bench/futex-requeue.c           |  33 +++----
 tools/perf/bench/futex-wake-parallel.c     |  33 +++----
 tools/perf/bench/futex-wake.c              |  33 +++----
 tools/perf/bench/numa.c                    |  93 +++++++-----------
 tools/perf/builtin-inject.c                |   4 +
 tools/perf/builtin-lock.c                  |   1 -
 tools/perf/builtin-record.c                |  13 ++-
 tools/perf/builtin-sched.c                 | 105 +++++++++++----------
 tools/perf/builtin-top.c                   |  45 ++++-----
 tools/perf/tests/mmap-basic.c              |   2 -
 tools/perf/tests/openat-syscall-all-cpus.c |   2 +-
 tools/perf/tests/perf-record.c             |   2 -
 tools/perf/ui/browser.c                    |  20 ++--
 tools/perf/ui/browsers/annotate.c          |  12 +--
 tools/perf/ui/setup.c                      |   5 +-
 tools/perf/ui/tui/helpline.c               |   5 +-
 tools/perf/ui/tui/progress.c               |   8 +-
 tools/perf/ui/tui/setup.c                  |   8 +-
 tools/perf/ui/tui/util.c                   |  18 ++--
 tools/perf/ui/ui.h                         |   4 +-
 tools/perf/util/Build                      |   1 +
 tools/perf/util/annotate.c                 |  15 +--
 tools/perf/util/annotate.h                 |   4 +-
 tools/perf/util/bpf-event.h                |   1 -
 tools/perf/util/build-id.c                 |  12 ++-
 tools/perf/util/dso.c                      |  19 ++--
 tools/perf/util/dso.h                      |   4 +-
 tools/perf/util/hist.c                     |   6 +-
 tools/perf/util/hist.h                     |   4 +-
 tools/perf/util/map.c                      |   3 +
 tools/perf/util/mmap.h                     |   1 -
 tools/perf/util/mutex.c                    |  99 +++++++++++++++++++
 tools/perf/util/mutex.h                    | 105 +++++++++++++++++++++
 tools/perf/util/probe-event.c              |   3 +
 tools/perf/util/symbol.c                   |   4 +-
 tools/perf/util/top.h                      |   5 +-
 41 files changed, 546 insertions(+), 323 deletions(-)
 create mode 100644 tools/perf/util/mutex.c
 create mode 100644 tools/perf/util/mutex.h

-- 
2.37.2.609.g9ff673ca1a-goog

