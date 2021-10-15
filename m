Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A901C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B88E61164
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242130AbhJORXp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242113AbhJORXo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Oct 2021 13:23:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE7EC061570
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Oct 2021 10:21:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h185-20020a256cc2000000b005bdce4db0easo11905827ybc.12
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Oct 2021 10:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/nDYakaYxbaZyFecc8yKJArWXyue+4iCPN+vHLxVtm8=;
        b=XmoWQqvtNFAnC5n3qHx2qxnIzT/lAJ3vqMh2+Y5AFYiZuFEXjIUIYEonLUunixL318
         H0ee/WTxT/JZghvOXvp4P8ievcQt7y+xZhIpgseQrLnNpRwzwGKCM6eOETch3oNK1YMn
         qPZnax1FHsNdoSx2irt8F79E0yUWGTyz4CuQHMk+f5vRc3N2Rv10sk0EjRvsyreUr0TR
         ugItKRl9iCkmtx8ipyHS+YCt38w6cin9bnFTLvzlrzVTTLmdqfhsBOOuADQUrkR/851e
         sWhNZFvjyhglxz7DZ+dPBaSilVsOAKALFDmVUokE2bbcxmvLqN8rWPMuwQavZ6oUOIt2
         hZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/nDYakaYxbaZyFecc8yKJArWXyue+4iCPN+vHLxVtm8=;
        b=zULCZXelWgC7SMLwV0sIn62XsAEkca8k3Md0jdFcabXJ/ciTkvWwyGbDkHldavvG/E
         gXxNGBz0T6RxESJ/P/6yc8OlMtlWNBfzP5Boszh/qGZAAhpeiwjasGXOC8VT8jLMNh6J
         lZzKj9ATB2CmkuQBc0phyKORP6fTwpN0pD3r/yfses/u/7r58a55FVlPwBBFGXpqOrOj
         2FMv/jqqhjALVAX4D9VFB0YjZUj7ljPeuJwGRgqkbCjUlDtoVJNUVGSW5B0FPjGIin/F
         xYFcLK7h0ulCW9snAtgA+HEsk16DJC7hFVQnHah95MKWbRbo1zihTYm1RCaa0NWKY0Hd
         t/Xg==
X-Gm-Message-State: AOAM533HVAEn0J77+TqBKv15cGcTvP1Al+9g32CgM8GXwYM7EDTXa9FP
        lZ3pZ+olUjIZkE5PKe79ua5sJx4STTKM
X-Google-Smtp-Source: ABdhPJxWkEEYlmaq0lw+6VBwNltVyHcRE1ud7zxTCiWiOQbO8QnBrhf6vxsDI5Q29gM5R6kaQp8KAFegi3m+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:69bc:7451:58ad:6585])
 (user=irogers job=sendgmr) by 2002:a25:6e06:: with SMTP id
 j6mr14669326ybc.311.1634318497453; Fri, 15 Oct 2021 10:21:37 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:21:11 -0700
Message-Id: <20211015172132.1162559-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 00/21] perf metric: Fixes and allow modifiers
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

There are 4 main changes in this patch set:
 - perf metric: Modify resolution and recursion check.
 - perf parse-events: Add new "metric-id" term.
 - perf metrics: Modify setup and deduplication
 - perf metric: Allow modifiers on metrics.

In overview the changes start by trying to simplify the metric code,
then it fixes various bugs and finally it builds a new feature of
allowing metrics like:

$ perf stat -M IPC:u,IPC:k -a sleep 1

 Performance counter stats for 'system wide':

        93,269,988      inst_retired.any:k        #     0.26 IPC:k                  
       352,037,460      cpu_clk_unhalted.thread:k                                   
        70,317,865      inst_retired.any:u        #     0.76 IPC:u                  
        92,762,220      cpu_clk_unhalted.thread:u                                   

       1.003754577 seconds time elapsed

Previous complexity came from using the evsel->name as the identifier
for events in metrics, however, this name isn't stable and has issues
around wildcard expansion. These changes fix this by adding a
dedicated metric_id to evsels, performing deduplication on IDs before
event parsing and not handling all evsels on a single evlist.

The recursion and metric_ref logic is simplified, the first by moving
data from the heap to the stack, the latter by building in an array
rather than a linked list. This logic is integral to metric set up and
simplification makes the effects of the changes easier to follow, in
particular as there are fewer structs being maintained.

Event parsing is modified to allow qualifiers on kernel PMU events,
this is necessary to allow the metric-id to be added, but allows
qualifiers in other cases like specifying callgraph or a name.

There is a certain amount of comment adding and const-ification, this
is with a view to making the code more intention revealing and to aid
following its logic. For example, the pmu event tables should never
change and it'd be a bug if they ever did, it's therefore strange to
access it using non-const pointers.

The kernel list_sort.c/h are added for use sorting metrics in order to
deduplicate/reuse events from a larger group in a smaller one. This
was previously done by inserting in size order, but that only worked
within a metric group.

Some of the commit messages show the TopDownL1 metrics being used on a
SkylakeX machine. These metrics were removed by
c4ad8fabd03f76ed3a2a4c8aef6baf6cd4f24542 ("perf vendor events: Update
metrics for SkyLake Server") and the data was gathered with this patch
reverted.

v2. Add METADATA fixes to 'Add list_sort' suggested by
    Arnaldo Carvalho de Melo <acme@kernel.org>.
    Fix arm64 function declaration in 'Add const to pmu_events_map' found by
    Andrew Kilroy <andrew.kilroy@arm.com>.
    Add a static in 'Make pmu_event tables const' suggested by
    John Garry <john.garry@huawei.com>.
    Add acked-by: Andi Kleen <ak@linux.intel.com>.
    Fix/handle 0 events case in 'Modify setup and deduplication'.
    Fix a missed strdup that resulted in a double free in 'Allow modifiers on
    metrics.'

Ian Rogers (21):
  tools lib: Add list_sort.
  perf pmu: Add const to pmu_events_map.
  perf pmu: Make pmu_sys_event_tables const.
  perf pmu: Make pmu_event tables const.
  perf metric: Move runtime value to the expr context
  perf metric: Add documentation and rename a variable.
  perf metric: Add metric new and free
  perf metric: Only add a referenced metric once
  perf metric: Modify resolution and recursion check.
  perf metric: Comment data structures.
  perf metric: Document the internal 'struct metric'
  perf metric: Simplify metric_refs calculation.
  perf parse-events: Add const to evsel name
  perf parse-events: Add new "metric-id" term.
  perf parse-events: Allow config on kernel PMU events
  perf metric: Encode and use metric-id as qualifier
  perf expr: Add subset utility.
  perf metrics: Modify setup and deduplication
  perf metric: Switch fprintf to pr_err.
  perf parse-events: Identify broken modifiers.
  perf metric: Allow modifiers on metrics.

 tools/include/linux/list_sort.h       |   14 +
 tools/lib/list_sort.c                 |  252 +++++
 tools/perf/MANIFEST                   |    1 +
 tools/perf/arch/arm64/util/pmu.c      |    2 +-
 tools/perf/arch/powerpc/util/header.c |    2 +-
 tools/perf/check-headers.sh           |    2 +
 tools/perf/pmu-events/jevents.c       |    6 +-
 tools/perf/pmu-events/pmu-events.h    |    8 +-
 tools/perf/tests/expand-cgroup.c      |    2 +-
 tools/perf/tests/expr.c               |   29 +-
 tools/perf/tests/parse-metric.c       |    2 +-
 tools/perf/tests/pmu-events.c         |   59 +-
 tools/perf/util/Build                 |    5 +
 tools/perf/util/evsel.c               |   17 +
 tools/perf/util/evsel.h               |    2 +
 tools/perf/util/expr.c                |   56 +-
 tools/perf/util/expr.h                |   16 +-
 tools/perf/util/expr.l                |    6 +-
 tools/perf/util/expr.y                |    2 +-
 tools/perf/util/metricgroup.c         | 1461 ++++++++++++++-----------
 tools/perf/util/metricgroup.h         |   35 +-
 tools/perf/util/parse-events-hybrid.c |   34 +-
 tools/perf/util/parse-events-hybrid.h |    6 +-
 tools/perf/util/parse-events.c        |  166 +--
 tools/perf/util/parse-events.h        |   11 +-
 tools/perf/util/parse-events.l        |   18 +-
 tools/perf/util/parse-events.y        |   27 +-
 tools/perf/util/pfm.c                 |    3 +-
 tools/perf/util/pmu.c                 |   22 +-
 tools/perf/util/pmu.h                 |   10 +-
 tools/perf/util/python-ext-sources    |    1 +
 tools/perf/util/s390-sample-raw.c     |    6 +-
 tools/perf/util/stat-shadow.c         |   27 +-
 33 files changed, 1470 insertions(+), 840 deletions(-)
 create mode 100644 tools/include/linux/list_sort.h
 create mode 100644 tools/lib/list_sort.c

-- 
2.33.0.1079.g6e70778dc9-goog

