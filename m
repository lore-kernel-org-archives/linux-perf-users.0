Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8A6C432BE
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE62060FDA
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbhHTKys (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbhHTKyq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 06:54:46 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CE4C061575;
        Fri, 20 Aug 2021 03:54:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id cn28so13392090edb.6;
        Fri, 20 Aug 2021 03:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ETu4NqrlKbYuKVe85dJqo/CXxe7GJ1QkR/R9WQ9e6Os=;
        b=PjvsG5uerhNkQyZ0H4LuT+PGLt5INRIfG+H/JWJ6e84yJW/WIyOz2GbnBjEVDyyUmk
         CsrBM/CDRNhSZ39EMU6OjC3vMJZGODerwqf0mVNRxiDUmP0nM42meS1cm+tsO8Cz6chk
         5DMitrsr3/yLdzRCDtR/KtXgAEmpVg1ezk9jbWj1Ul/QFhN8ohpCvwIVhUeDxdYQFr2G
         HEXRb6Md41L5nWvyCThbcCODBKy5xAQ68mt9rNN8ad3lyOX9yfnXmJEcBiRy1Ygt8Jb0
         n2dTpMJRKtEjcViMV9tq1bAIS86gRyb9erm+oOip6gX8lsXJa2/hdaJwCvfQMwX6JA92
         imKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ETu4NqrlKbYuKVe85dJqo/CXxe7GJ1QkR/R9WQ9e6Os=;
        b=a1hNWzJ9dIfCxKgCOof/31boxjk0WvAOk0pR4zuAFY1q/9CzTqN+l0V4c215iEjnGF
         sN1HSXjmDD2FwrWDGYY64Ipp6zjBxKVvqHvyfGNJIwNMGjk9Y7BOTUTd0ObczmcTSLOq
         vQJJPp526kMq6wIyVvCcxUZYMt5XWprT7CnFNStUXB1TN3QqqLGKSvPrUpvhAbsWfrhL
         RCri+kOD8BY7Elu95NLhsD6TYpZE2/hGcRVnKoc5BWIPdtnK9lipledu5NlamEx2hmEN
         w3REnXIA39Mrtk18jaNBgdqtOPxa1X68u1VEbsDH9P5dKNdlvsrPPfoy58tTgu3n3F//
         oR9g==
X-Gm-Message-State: AOAM533cGLn3banmKpv9AM5KQdZHcUing4ffX0godIeZGoRB6DTmbwV6
        CxupLy5GoWiWgIguYhmmuYo=
X-Google-Smtp-Source: ABdhPJzh62+i5EZxM+JgCHSHiDSmApNtQPY9ihvx2y5tEe/HTS76PaHsmXkSbE5AKwQp3kfh3SRiLg==
X-Received: by 2002:aa7:dd48:: with SMTP id o8mr18244697edw.44.1629456846758;
        Fri, 20 Aug 2021 03:54:06 -0700 (PDT)
Received: from honeypot.epfl.ch (mob-176-243-199-7.net.vodafone.it. [176.243.199.7])
        by smtp.googlemail.com with ESMTPSA id g29sm3451459edf.31.2021.08.20.03.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 03:54:05 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v3 00/15] perf: add workqueue library and use it in synthetic-events
Date:   Fri, 20 Aug 2021 12:53:46 +0200
Message-Id: <cover.1629454773.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Changes in v3:
 - improved separation of threadpool and threadpool_entry method
 - replaced shared workqueue with per-thread workqueue. This should
   improve the performance on big machines (Jiri noticed in his
   experiments a significant performance degradation after 15 threads
   with the shared queue).
 - improved error reporting in both threadpool and workqueue
 - added lazy spinup of threads in workqueue [9/15]
 - added global workqueue [10/15]
 - setup global workqueue in perf record, top and synthesize bench
   [12-14/15] and used in in synthetic events

v2: https://lore.kernel.org/lkml/cover.1627643744.git.rickyman7@gmail.com/
    https://lore.kernel.org/lkml/4f0cd6c8e77c0b4f4d4b8d553a7032757b976e61.1627657061.git.rickyman7@gmail.com/
(something went wrong when sending it and the cover letter has a wrong
Message-Id)

Changes in v2:
 - rename threadpool_struct and its functions to adhere to naming style
 - use ERR_PTR instead of returning NULL
 - add *__strerror functions, removing pr_err from library code
 - wait for threads after creation of all threads, instead of waiting
   after each creation
 - use intention-revealing macros in test code instead of 0 and -1
 - use readn/writen functions

v1: https://lkml.kernel.org/lkml/cover.1626177381.git.rickyman7@gmail.com/

This patchset introduces a new utility library inside perf/util, which
provides a work queue abstraction, which follows the Kernel workqueue API.

The workqueue abstraction is made up by two components:
 - threadpool: which takes care of managing a pool of threads. It is
   inspired by the prototype for threaded trace in perf-record from Alexey:
   https://lore.kernel.org/lkml/cover.1625227739.git.alexey.v.bayduraev@linux.intel.com/
 - workqueue: manages the workers in the threadpool and assigns the work 
   items to the thread-local queues.

On top of the workqueue, a simple parallel-for utility is implemented
which is then showcased in synthetic-events.c, replacing the previous
manual pthread-created threads.

Through some experiments with perf bench, I can see how the new 
workqueue has a slightly higher overhead compared to manual creation of 
threads, but is able to more effectively partition work among threads, 
yielding better results overall (see the last patch for benchmark
detaisl on my machine). 
Since I'm not able to test it on bigger machine, it would be helpful if
someone could also test it and report back his results (thanks to Jiri
and Arnaldo who have already helped me by doing some tests).

Furthermore, the overhead could be reduced by changing the
`work_size` (currently 1), aka the number of dirents that are
processed by a thread before grabbing a lock to get the new work item.
I experimented with different sizes but, while bigger sizes reduce overhead
as expected, they do not scale as well to more threads.

Soon I will also send another patchset applying the workqueue to evlist
operations (open, enable, disable, close).

Thanks,
Riccardo

Riccardo Mancini (15):
  perf workqueue: threadpool creation and destruction
  perf tests: add test for workqueue
  perf workqueue: add threadpool start and stop functions
  perf workqueue: add threadpool execute and wait functions
  tools: add sparse context/locking annotations in compiler-types.h
  perf workqueue: introduce workqueue struct
  perf workqueue: implement worker thread and management
  perf workqueue: add queue_work and flush_workqueue functions
  perf workqueue: spinup threads when needed
  perf workqueue: create global workqueue
  perf workqueue: add utility to execute a for loop in parallel
  perf record: setup global workqueue
  perf top: setup global workqueue
  perf test/synthesis: setup global workqueue
  perf synthetic-events: use workqueue parallel_for

 tools/include/linux/compiler_types.h   |  18 +
 tools/perf/bench/synthesize.c          |  28 +-
 tools/perf/builtin-kvm.c               |   2 +-
 tools/perf/builtin-record.c            |  18 +-
 tools/perf/builtin-top.c               |  19 +-
 tools/perf/builtin-trace.c             |   3 +-
 tools/perf/tests/Build                 |   1 +
 tools/perf/tests/builtin-test.c        |   9 +
 tools/perf/tests/mmap-thread-lookup.c  |   2 +-
 tools/perf/tests/tests.h               |   3 +
 tools/perf/tests/workqueue.c           | 453 +++++++++++++
 tools/perf/util/Build                  |   1 +
 tools/perf/util/synthetic-events.c     | 135 ++--
 tools/perf/util/synthetic-events.h     |   8 +-
 tools/perf/util/workqueue/Build        |   2 +
 tools/perf/util/workqueue/threadpool.c | 619 +++++++++++++++++
 tools/perf/util/workqueue/threadpool.h |  41 ++
 tools/perf/util/workqueue/workqueue.c  | 901 +++++++++++++++++++++++++
 tools/perf/util/workqueue/workqueue.h  | 104 +++
 19 files changed, 2253 insertions(+), 114 deletions(-)
 create mode 100644 tools/perf/tests/workqueue.c
 create mode 100644 tools/perf/util/workqueue/Build
 create mode 100644 tools/perf/util/workqueue/threadpool.c
 create mode 100644 tools/perf/util/workqueue/threadpool.h
 create mode 100644 tools/perf/util/workqueue/workqueue.c
 create mode 100644 tools/perf/util/workqueue/workqueue.h

-- 
2.31.1

