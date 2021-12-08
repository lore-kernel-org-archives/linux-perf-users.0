Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712F7C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Dec 2021 02:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243270AbhLHCtn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Dec 2021 21:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243240AbhLHCtn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Dec 2021 21:49:43 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F22C061746
        for <linux-perf-users@vger.kernel.org>; Tue,  7 Dec 2021 18:46:12 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id x5-20020a2584c5000000b005f89a35e57eso2009029ybm.19
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Dec 2021 18:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CLGxeFiW2EzzDmPWUFxAzqS7mvDeKkKaNxO2GyXM6mc=;
        b=NnKahnPPy6IIxBK1lzam+MEvU6PVxcY4VOuzxTahPQ/mzG54LSlqsjrEk8LyYS9xuL
         S1aPKOSYaUQg1a6CoLb1gJ+sSlBADMbjxUQ3h9qwaccGprL724gfe+6aK7stynb58Il4
         XSYlqgaMP6FzQBnyYkhog8OugVYKBTDHfG1CYstBcIEIJwOsb2VQkVlOgi2xs4xE1IrV
         7GoMT3i/OAQlUrjt85bgcwfpluRyAoBhd8gHPE9gMI0Vrt2iLj9A8HkBgbIwnlJDQSmu
         8wnufQTlRlrW+7UeAx80hf8Cqyy47+DueLbrn+q8rrNJ6M98iVbFEVL1njKAdN/IQtEL
         Z3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CLGxeFiW2EzzDmPWUFxAzqS7mvDeKkKaNxO2GyXM6mc=;
        b=3hDMs2k+niaQMT4kbakSpXwkTiGjEaSEyKsGOgD7xDNKtQDmL8hqT/3IAzKPCFFmoO
         lxYU5oavYOCpmVEfzeFE9SXbLfAftVyqnUUSDThi/01C5MIlHUKWb/Ndabn6iHrJ66cI
         p+aIJW1fkpg0tTXErZjhC0qz8xr61QAm7wU/f5ZlOj/JaLhHB/9o7crBinjL8gjH6n2q
         vhf0IfRhJ0Q7FORqzBKPq81YmgX/de2vgxY3ZYZGdvqTchFHjtGnTfGFCbPzaHw+j4NS
         e8UqQ11aGLGvnVfwtYzqexuaJlFFNVuKgqTrNltydFhVeremdDErYRub7ZgdhHsfEyhj
         yVvQ==
X-Gm-Message-State: AOAM5327SWH9QyQnXlItzjkRuYc9CphXwfoL2CJNTUzfrnxjlLtbMQEr
        LdGlhowRUsbvdAru/xDPbUHbaMdZcMSt
X-Google-Smtp-Source: ABdhPJx2u4yOo4d/+2DtTexBsEogDPpZDxD9U129h8ooJi1bFStxNrMahQBT4CJLt33fS1Sd0d2XNVgNy5ZF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a25:2391:: with SMTP id
 j139mr54854197ybj.382.1638931571551; Tue, 07 Dec 2021 18:46:11 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:45:45 -0800
Message-Id: <20211208024607.1784932-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 00/22] Refactor perf cpumap
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Perf cpu map has various functions where a cpumap and index are passed
in order to load the cpu. A problem with this is that the wrong index
may be passed for the cpumap, causing problems like aggregation on the
wrong CPU:
https://lore.kernel.org/lkml/20211204023409.969668-1-irogers@google.com/

This patch set refactors the cpu map API, greatly reducing it and
explicitly passing the cpu (rather than the pair) to functions that
need it. Comments are added at the same time.

Ian Rogers (22):
  libperf: Add comments to perf_cpu_map.
  perf stat: Add aggr creators that are passed a cpu.
  perf stat: Switch aggregation to use for_each loop
  perf stat: Switch to cpu version of cpu_map__get
  perf cpumap: Switch cpu_map__build_map to cpu function
  perf cpumap: Remove map+index get_socket
  perf cpumap: Remove map+index get_die
  perf cpumap: Remove map+index get_core
  perf cpumap: Remove map+index get_node
  perf cpumap: Add comments to aggr_cpu_id
  perf cpumap: Remove unused cpu_map__socket
  perf cpumap: Simplify equal function name.
  perf cpumap: Rename empty functions.
  perf cpumap: Document cpu__get_node and remove redundant function
  perf cpumap: Remove map from function names that don't use a map.
  perf cpumap: Remove cpu_map__cpu, use libperf function.
  perf cpumap: Refactor cpu_map__build_map
  perf cpumap: Rename cpu_map__get_X_aggr_by_cpu functions
  perf cpumap: Move 'has' function to libperf
  perf cpumap: Add some comments to cpu_aggr_map
  perf cpumap: Trim the cpu_aggr_map
  perf stat: Fix memory leak in check_per_pkg

 tools/lib/perf/cpumap.c                  |   7 +-
 tools/lib/perf/include/internal/cpumap.h |   9 +-
 tools/lib/perf/include/perf/cpumap.h     |   1 +
 tools/perf/arch/arm/util/cs-etm.c        |  16 +-
 tools/perf/builtin-ftrace.c              |   2 +-
 tools/perf/builtin-sched.c               |   6 +-
 tools/perf/builtin-stat.c                | 273 ++++++++++++-----------
 tools/perf/tests/topology.c              |  10 +-
 tools/perf/util/cpumap.c                 | 182 ++++++---------
 tools/perf/util/cpumap.h                 | 102 ++++++---
 tools/perf/util/cputopo.c                |   2 +-
 tools/perf/util/env.c                    |   6 +-
 tools/perf/util/stat-display.c           |  69 +++---
 tools/perf/util/stat.c                   |   9 +-
 tools/perf/util/stat.h                   |   3 +-
 15 files changed, 361 insertions(+), 336 deletions(-)

-- 
2.34.1.400.ga245620fadb-goog

