Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A973EECAAA1
	for <linux-perf-users@archiver.kernel.org>; Tue, 30 Aug 2022 16:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiH3Qs6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 30 Aug 2022 12:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiH3Qs5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 Aug 2022 12:48:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3B8B8F16
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Aug 2022 09:48:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p12-20020a259e8c000000b006958480b858so170592ybq.12
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Aug 2022 09:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=bqWWElpifsVIcRBtLS4h3nAno3DuqAdm5MwVPcG6g2U=;
        b=ohH04+bmBKg6/u4gjhGe4ql6BSMCMzp43mE/vQ1+o8MMfyn3LexUr+otcCJbGXxt5B
         zA73E2gOIwAro0XcudubwXtWJQ1gxhBUgP9JjDi1EPaaK6hwxynzIh4VAsPdb8NmnwLk
         YabXxaYmQb5CeozvGL/q3XcX7nXBzmeY2HPERul/OKs/ikAffbgglH2fGF+HbIkAbhYM
         4F5Cs4d0d/v7fiWbf3yKGY+ER5IDJ8jxf0E6R3oK+Qoo9tghgwwY2E2PrxOnqaEc4Axg
         ITTNacw061mfcumS7EsJDub8SCVYbVvwpbYkKgtSlJLu2B0FGKZUJEYHwD9Nian/1xgv
         ZdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=bqWWElpifsVIcRBtLS4h3nAno3DuqAdm5MwVPcG6g2U=;
        b=iTssAncv6aGkg+EP8Zopth0ENGM5MNdeVgaAIA07KaOR6bg6iZbS6TOlidqHgHBdll
         PbJtcqn4IQwAglUsC5R8GuODslPhWvoLBFY6irwd8wJ6Baaj3VXc6oqsuwOHW7slClQf
         AKqIwIaF4k1mPSdkH/9SSQOEp+dBMeg69JJiwZy+sxgv16D5nfixs72ftLQVT95lLmVG
         EHqJ6e3SxNvsM/L4Wy7AkciRcQRYTSl6ovSFyMAEfdQNGdzgchGiIquvqqDnETIHVraQ
         6N4850miqDHQANW9R4f90GADwgbsUoXOUAVoU3+PmrbdFIUQoP+2fIEvmZnKQI9kijAU
         0BIA==
X-Gm-Message-State: ACgBeo2SSSUPTdMP6RIpRYRxkeXciuYCz5yBY2DMhajwcebYiS6GZsLK
        QCoAJHyfP1Iluv0qSLZI7JemC2hs+lr7
X-Google-Smtp-Source: AA6agR5HYPGdfJCmFz6kSepJum8lO1auKcPBMGIAOUdWwb2wB+i9kNM7DUBx1cmoh+TCIyRIFxNSFW2DxAmz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:902c:b0fa:dec9:8767])
 (user=irogers job=sendgmr) by 2002:a25:db48:0:b0:696:4274:477b with SMTP id
 g69-20020a25db48000000b006964274477bmr12234993ybf.146.1661878135792; Tue, 30
 Aug 2022 09:48:55 -0700 (PDT)
Date:   Tue, 30 Aug 2022 09:48:38 -0700
Message-Id: <20220830164846.401143-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v1 0/8] Add core wide metric literal
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

It is possible to optimize metrics when all SMT threads (CPUs) on a
core are measuring events in system wide mode. For example, TMA
metrics [1] defines CORE_CLKS for Sandybrdige as:
    
if SMT is disabled:
  CPU_CLK_UNHALTED.THREAD
if SMT is enabled and recording on all SMT threads (for all processes):
  CPU_CLK_UNHALTED.THREAD_ANY / 2
if SMT is enabled and not recording on all SMT threads:
  (CPU_CLK_UNHALTED.THREAD/2)*
  (1+CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE/CPU_CLK_UNHALTED.REF_XCLK )
    
That is two more events are necessary when not gathering counts on all
SMT threads. To distinguish all SMT threads on a core vs system wide
(all CPUs) call the new property core wide.

As this literal requires the user requested CPUs and system wide to be
present, the parsing of metrics is delayed until after command line
option processing. As events are used to compute the evlist maps, and
metrics create events, the data for core wide must come from the target.

This patch series doesn't correct the Intel metrics to use #core_wide,
which will be done in follow up work. To see the two behaviors
currently you need an Intel CPU between Sandybridge and before
Icelake, then compare the events for tma_backend_bound_percent and
Backend_Bound_SMT where the former assumes recording on all SMT
threads and the latter assumes not recording on all SMT threads. The
future work will just have a single backend bound metric for both
cases determined using #core_wide.

[1] https://download.01.org/perfmon/TMA_Metrics.xlsx Note, #EBS_Mode
is false when recording on all SMT threads and all processes which is
 #core_wide true in this change.

Ian Rogers (8):
  perf smt: Tidy header guard add SPDX
  perf metric: Return early if no CPU PMU table exists
  perf expr: Move the scanner_ctx into the parse_ctx
  perf smt: Compute SMT from topology
  perf topology: Add core_wide
  perf stat: Delay metric parsing
  perf metrics: Wire up core_wide
  perf test: Add basic core_wide expression test

 tools/perf/builtin-stat.c     |  57 +++++++++++++-----
 tools/perf/tests/expr.c       |  37 +++++++++---
 tools/perf/util/cputopo.c     |  61 +++++++++++++++++++
 tools/perf/util/cputopo.h     |   5 ++
 tools/perf/util/expr.c        |  26 ++++----
 tools/perf/util/expr.h        |  14 +++--
 tools/perf/util/expr.l        |   6 +-
 tools/perf/util/metricgroup.c |  92 +++++++++++++++++++++-------
 tools/perf/util/metricgroup.h |   4 +-
 tools/perf/util/smt.c         | 110 ++++++++--------------------------
 tools/perf/util/smt.h         |  19 ++++--
 tools/perf/util/stat-shadow.c |  13 ++--
 tools/perf/util/stat.h        |   2 +
 13 files changed, 286 insertions(+), 160 deletions(-)

-- 
2.37.2.672.g94769d06f0-goog

