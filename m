Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E79C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Nov 2022 21:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbiKNVHk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Nov 2022 16:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiKNVHj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Nov 2022 16:07:39 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF749BDD
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 13:07:38 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id f19-20020a63f113000000b0046fde69a09dso6383486pgi.10
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 13:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bnk6QcACKDHfLaerzSC+1vUeLHtUQc78SZsram1d2Ns=;
        b=cYOIca+NENhdYACfSPVmKjGEQejr4Fzt4sx/bRNYYxGS7WA+7LWkliB7ofeINiW5Ms
         7Mo+vOvxe2sOljrDaJVzTAgD7JZsSDAoswQjxGt7VCm4y6AWk2H4cFa3TudXjUR/v4/n
         Bg5eaxBFhCgr8P/QYJY3wvJQLzAe0PWA57d+3m5El8CMl6WLjEsF27B2awPef3C6ogMM
         7BXVlXXWsdgrha+Z+1awDzFnC2NbxTvkvh6YuuH5+0wlq+r1PTBuurnIsrSoquELUbx/
         Zuxbpw9yOpCqDTyToLd/qn33k7H/fYB5M3mTBVPcxrsaHXvp1V2X28/NGzEUNMQwj3xk
         SZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bnk6QcACKDHfLaerzSC+1vUeLHtUQc78SZsram1d2Ns=;
        b=ihv5YLdggWSoFROitstjyK+zjBo74JBCcTPOwTvdQPao/HM2+eEh6LzqzHGOrPVvD1
         bgnuiKmo7yLTljlUUZPkbQibLMvzCXJ4yT6pXUj9yDdBBy4M/OZ/R0JMPqdDXetarIHX
         VFq3j+XgpV9QKA7eyI3V6sruib82wYlOlgbl+7qsPe+V1AlY/C/dhAoR+33ZSgEkvmsR
         SpzJyZVy8eVRnvSmkXk4OStI6pS4nzO9PaLW2MdXkQx89uhiOPLERTYdwTPmTVOxjvI1
         d7sLdrAu9mIXKbmGczuQLXITtLyDMlK7vpXb9yOdLZzEDNE543Im6t+9nHm2AGKHlhVB
         vxNQ==
X-Gm-Message-State: ANoB5plRd7kja4Y4qNNK5kMgcTZhwqA606VYWeM0E8NQdBB8rdlvuUSz
        Y1duLyjPscB75ILp7vgVanc+OCsyJvFi
X-Google-Smtp-Source: AA0mqf5XLHjklsrSGEkkJMrepVuOU97r0u2RyqqeVSUn4+rizrpjePhHSNj9GGDN3SSU11FFNjz6Oy0zOSu1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:553:438f:b86a:87f])
 (user=irogers job=sendgmr) by 2002:a63:4f54:0:b0:476:85ee:aee2 with SMTP id
 p20-20020a634f54000000b0047685eeaee2mr5230552pgl.582.1668460058138; Mon, 14
 Nov 2022 13:07:38 -0800 (PST)
Date:   Mon, 14 Nov 2022 13:07:13 -0800
Message-Id: <20221114210723.2749751-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v3 00/10] Restructure perf list and add json output
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Restructure perf list so that it uses callbacks to print events and
metrics. Use the callbacks to implement json output. In the process
add documentation to pmu.h, avoid some sorting of events, fix some
command line and output bugs.

v3. Removes is_hybrid from perf_pmu as suggested by Kan Liang.
    ScaleUnit is added to the json output as suggested by
    Weilin Wang. Some comments are also improved.
v2. Address feedback from Adrian Hunter and make kernel-doc work.

Ian Rogers (10):
  perf pmu: Remove is_hybrid member
  perf pmu: Add documentation
  tools lib api fs tracing_path: Add scandir alphasort
  perf tracepoint: Sort events in iterator
  perf list: Generalize limiting to a PMU name
  perf list: Simplify cache event printing
  perf list: Simplify symbol event printing
  perf pmu: Restructure print_pmu_events
  perf list: Reorganize to use callbacks
  perf list: Add json output option

 tools/lib/api/fs/tracing_path.c        |  16 +
 tools/lib/api/fs/tracing_path.h        |   1 +
 tools/perf/Documentation/perf-list.txt |  10 +-
 tools/perf/builtin-list.c              | 525 +++++++++++++++++---
 tools/perf/util/evsel.c                |   5 +-
 tools/perf/util/evsel.h                |   2 +-
 tools/perf/util/metricgroup.c          | 242 +++-------
 tools/perf/util/metricgroup.h          |   4 +-
 tools/perf/util/pmu.c                  | 288 ++++++-----
 tools/perf/util/pmu.h                  | 128 ++++-
 tools/perf/util/print-events.c         | 638 ++++++++++---------------
 tools/perf/util/print-events.h         |  42 +-
 tools/perf/util/stat.c                 |  11 +-
 13 files changed, 1102 insertions(+), 810 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

