Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEDAC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D2ED60F26
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbhG3Pgl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 11:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbhG3Per (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jul 2021 11:34:47 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1B6C061765;
        Fri, 30 Jul 2021 08:34:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f14-20020a05600c154eb02902519e4abe10so9433614wmg.4;
        Fri, 30 Jul 2021 08:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yXVPRJ1bxZJUL/ue/BthOJ9EM++tRcJBnBje0eCPUjk=;
        b=g/mOvvMdoMMIpIMRuqib+1s5P7mjityOnJ9AcHuCTpnp8gHr4lYFUX8m63IhpMyX+V
         dKQZjZ6VQc9cmgFZ82TP/Hp7BC2XQxWc6Y7xt74cWI/pDQRQPpoVDFPeC6xJMjkNOFSE
         56bTFwH6Is+2GPDnHpqjhh2DcbZh46hXkfJDEh4R6KrwyHJoVkCTGY6IPyPwSRd/As+1
         LlckILzoxC5InZ7zR6hUPBmSvVdBwy83rHpFTMGE3k1BPgcqXs8n3ms3cmm8M5Eph2UM
         G05Hvx6nmx99dnjuUdpLom9EpbWWuu5yoOXaT5QO7OQZeZA1OGUdmJY4gtaQ1ZQY/Acn
         dndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yXVPRJ1bxZJUL/ue/BthOJ9EM++tRcJBnBje0eCPUjk=;
        b=Ak8CtydfYqjQW8zcAqleoZvmJHGAOcmIAjaR71MxMFm6NnQGqXeu2q6Bzpp+ngjw82
         ppmGqdQx1calgXBN8xRpIMcLf422nqR1IZdbsULjKjmnw03xV4FGyUR5ZCIiyFIzwNjQ
         qEFWizZDTS+NA3SRagvtMm0L6aXlc1mRZjTCgAV0iAbMVV8udc2J0UpsfYN4h6plf90+
         GgluuxwzGr5xtOl0bGXDg93ApBCykXk55mgwrE37zkZwiRA52zSklSNrHspdRImEcyml
         bQCrgmBKIvfj1gXeFK4woTnxlTkkedNVQQlDWYUeS6Eccdg/b2oeOAGHLhZMncrlY2Vs
         OT+A==
X-Gm-Message-State: AOAM531M/7xIktRWyhoCuVcS060VHxohzI6Qeqc5+Z0+cEv/xp7rZts/
        uPdUobLVUNkpXAZVVz4n6aY=
X-Google-Smtp-Source: ABdhPJyZd9c2c5dgq39mAgctHgGwwS7RhQSHntOqQ0T9AhL8N6Lg8CatOpb1LvcvPykXrus2TkMNyg==
X-Received: by 2002:a1c:7c17:: with SMTP id x23mr3574515wmc.43.1627659262490;
        Fri, 30 Jul 2021 08:34:22 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id v15sm2354727wmj.39.2021.07.30.08.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:34:22 -0700 (PDT)
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
Subject: [RFC PATCH v2 00/10] perf: add workqueue library and use it in synthetic-events
Date:   Fri, 30 Jul 2021 17:34:07 +0200
Message-Id: <cover.1627643744.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

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
provides a work queue abstraction, which loosely follows the Kernel
workqueue API.

The workqueue abstraction is made up by two components:
 - threadpool: which takes care of managing a pool of threads. It is
   inspired by the prototype for threaded trace in perf-record from Alexey:
   https://lore.kernel.org/lkml/cover.1625227739.git.alexey.v.bayduraev@linux.intel.com/
 - workqueue: manages a shared queue and provides the workers implementation.

On top of the workqueue, a simple parallel-for utility is implemented
which is then showcased in synthetic-events.c, replacing the previous
manual pthread-created threads.

Through some experiments with perf bench, I can see how the new 
workqueue has a slightly higher overhead compared to manual creation of 
threads, but is able to more effectively partition work among threads, 
yielding better results overall.
Furthermore, the overhead could be reduced by changing the
`work_size` (currently 1), aka the number of dirents that are
processed by a thread before grabbing a lock to get the new work item.
I experimented with different sizes but, while bigger sizes reduce overhead
as expected, they do not scale as well to more threads.

I believe the next steps are, in order:
 - add support to specifying affinities to threads.
 - add worker queues with round robin assignment (replacing the current
   shared queue).
 - optionally add work stealing among the worker queues. I'd keep it a
   future work for the moment since we do not have a specific use case
   for it at the moment (the synthetic threads would not benefit too
   much from it imo).
 - add support to executing jobs on a specific worker (which will have
   its own affinity). This is useful for Alexey's usecase and for the
   following evlist open usecase.
 - make workqueue directly manage the threadpool (as Arnaldo already 
   suggested). We could also make the workqueue global but that requires
   an autogrow feature so that threads are created on demand and not all
   at the beginning. I'd keep it a future work.
 - apply workqueue to the evlist open (the idea is to pin each thread to
   a GPU and submit a work_struct for each evsel/cpu to the matching cpu).

Any comment or idea is highly appreciated.

Thanks,
Riccardo

Riccardo Mancini (10):
  perf workqueue: threadpool creation and destruction
  perf tests: add test for workqueue
  perf workqueue: add threadpool start and stop functions
  perf workqueue: add threadpool execute and wait functions
  tools: add sparse context/locking annotations in compiler-types.h
  perf workqueue: introduce workqueue struct
  perf workqueue: implement worker thread and management
  perf workqueue: add queue_work and flush_workqueue functions
  perf workqueue: add utility to execute a for loop in parallel
  perf synthetic-events: use workqueue parallel_for

 tools/include/linux/compiler_types.h   |  18 +
 tools/perf/tests/Build                 |   1 +
 tools/perf/tests/builtin-test.c        |   9 +
 tools/perf/tests/tests.h               |   3 +
 tools/perf/tests/workqueue.c           | 450 +++++++++++++++
 tools/perf/util/Build                  |   1 +
 tools/perf/util/synthetic-events.c     | 155 ++---
 tools/perf/util/workqueue/Build        |   2 +
 tools/perf/util/workqueue/threadpool.c | 674 ++++++++++++++++++++++
 tools/perf/util/workqueue/threadpool.h |  40 ++
 tools/perf/util/workqueue/workqueue.c  | 750 +++++++++++++++++++++++++
 tools/perf/util/workqueue/workqueue.h  |  51 ++
 12 files changed, 2080 insertions(+), 74 deletions(-)
 create mode 100644 tools/perf/tests/workqueue.c
 create mode 100644 tools/perf/util/workqueue/Build
 create mode 100644 tools/perf/util/workqueue/threadpool.c
 create mode 100644 tools/perf/util/workqueue/threadpool.h
 create mode 100644 tools/perf/util/workqueue/workqueue.c
 create mode 100644 tools/perf/util/workqueue/workqueue.h

-- 
2.31.1

