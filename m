Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B04C11F66
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7226E610D1
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 12:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbhGMMOZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 08:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbhGMMOY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 08:14:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6C4C0613DD;
        Tue, 13 Jul 2021 05:11:33 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b14-20020a1c1b0e0000b02901fc3a62af78so1462528wmb.3;
        Tue, 13 Jul 2021 05:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0k9i4ryQ9bJFDsrRO38Wd8DYLKsoLjmKBJR+v0YQjxs=;
        b=nqnYzTcu4Et3R8OrU+dlYoeVA3GpRaLFiomzAkbfuc3beAXI2HptS+mLpO17WTkbCu
         DrnktVrVaNiftWwLNMLBDLJhGa3CW6Zsa+B53G5Jvm6AxsMvuKtwKvZ+/aRso6+JXUy6
         7TVkn7/7DMqI+fbUlMAfF4L7sqG9kgM/9EGnQyxI72C0Vl3j5UlxDxPnwiAoPo20nnXd
         HFg6DtAQjzpWVG8BF3tI2ugq9esCS1Ze3+mBggZv26BO3mW9DDcNMCbw+al+EDPyDHnM
         6sDI3j6GTUWZjejh2RhzHR0GNaDYksenuBUsp1wtNh/gxWTxCfKbZACmzkNbGiS1YjrK
         tWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0k9i4ryQ9bJFDsrRO38Wd8DYLKsoLjmKBJR+v0YQjxs=;
        b=E+m5alwu80QDkU7t4bF5+8Q55quU37DVEBctVed/anwM+s5R0OukSXKVZhQ8RA6PRA
         XxxIEaMzSYvcbrZ6VBfZlymXJHuWb4BhaazF9nZ/XKL7jqbFvs3qO7/TDacgMh+nwOcH
         TgJwfMCtHsNYseDQiFbUWxN0GjPg6F7gpAPBYR+oad/yCfPVetOiFwLLtJ4gn7N1NjEI
         ZEwn3dHl/h7fsuEx69PlEPTbESyt02jS5DfMEhNkl9fKGGbWoQviQhqISeq7yR6IbamQ
         luUUuHImvpLj+Wxn9CHB66cD+HwxpKTJZWD4UpsGcokAOaq647XaMQdAH1ssM0MhjOZB
         g6Hg==
X-Gm-Message-State: AOAM5333uhU1WjZv+kBMurilJU0w/tJA047oUdxfOGdg8Q1dWcnZ8BMk
        9/fgYJZOqtAVOLQubJ61gdg=
X-Google-Smtp-Source: ABdhPJxB611LBG3S9GKodAtf+TuKLj9cr4bT5ebwWlleKL8jl1cOUH4mIdaml73zsi2Q+KlS7+UJEw==
X-Received: by 2002:a7b:c1c2:: with SMTP id a2mr4573948wmj.15.1626178291200;
        Tue, 13 Jul 2021 05:11:31 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id o3sm17551425wrw.56.2021.07.13.05.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 05:11:30 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH 00/10] perf: add workqueue library and use it in synthetic-events
Date:   Tue, 13 Jul 2021 14:11:11 +0200
Message-Id: <cover.1626177381.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

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
workqueue has a higher overhead compared to manual creation of threads, 
but is able to more effectively partition work among threads, yielding 
a better result with more threads.
Furthermore, the overhead could be configured by changing the
`work_size` (currently 1), aka the number of dirents that are 
processed by a thread before grabbing a lock to get the new work item.
I experimented with different sizes but, while bigger sizes reduce overhead
as expected, they do not scale as well to more threads.

I tried to keep the patchset as simple as possible, deferring possible
improvements and features to future work.
Naming a few:
 - in order to achieve a better performance, we could consider using 
   work-stealing instead of a common queue.
 - affinities in the thread pool, as in Alexey prototype for
   perf-record. Doing so would enable reusing the same threadpool for
   different purposes (evlist open, threaded trace, synthetic threads),
   avoiding having to spin up threads multiple times.
 - resizable threadpool, e.g. for lazy spawining of threads.

@Arnaldo
Since I wanted the workqueue to provide a similar API to the Kernel's
workqueue, I followed the naming style I found there, instead of the
usual object__method style that is typically found in perf. 
Let me know if you'd like me to follow perf style instead.

Thanks,
Riccardo

Riccardo Mancini (10):
  perf workqueue: threadpool creation and destruction
  perf tests: add test for workqueue
  perf workqueue: add threadpool start and stop functions
  perf workqueue: add threadpool execute and wait functions
  perf workqueue: add sparse annotation header
  perf workqueue: introduce workqueue struct
  perf workqueue: implement worker thread and management
  perf workqueue: add queue_work and flush_workqueue functions
  perf workqueue: add utility to execute a for loop in parallel
  perf synthetic-events: use workqueue parallel_for

 tools/perf/tests/Build                 |   1 +
 tools/perf/tests/builtin-test.c        |   9 +
 tools/perf/tests/tests.h               |   3 +
 tools/perf/tests/workqueue.c           | 453 +++++++++++++++++
 tools/perf/util/Build                  |   1 +
 tools/perf/util/synthetic-events.c     | 131 +++--
 tools/perf/util/workqueue/Build        |   2 +
 tools/perf/util/workqueue/sparse.h     |  21 +
 tools/perf/util/workqueue/threadpool.c | 516 ++++++++++++++++++++
 tools/perf/util/workqueue/threadpool.h |  29 ++
 tools/perf/util/workqueue/workqueue.c  | 642 +++++++++++++++++++++++++
 tools/perf/util/workqueue/workqueue.h  |  38 ++
 12 files changed, 1771 insertions(+), 75 deletions(-)
 create mode 100644 tools/perf/tests/workqueue.c
 create mode 100644 tools/perf/util/workqueue/Build
 create mode 100644 tools/perf/util/workqueue/sparse.h
 create mode 100644 tools/perf/util/workqueue/threadpool.c
 create mode 100644 tools/perf/util/workqueue/threadpool.h
 create mode 100644 tools/perf/util/workqueue/workqueue.c
 create mode 100644 tools/perf/util/workqueue/workqueue.h

-- 
2.31.1

