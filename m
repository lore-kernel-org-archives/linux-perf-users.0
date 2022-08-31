Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07519ECAAD3
	for <linux-perf-users@archiver.kernel.org>; Wed, 31 Aug 2022 17:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiHaRt7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 31 Aug 2022 13:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiHaRtq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 31 Aug 2022 13:49:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176FBC990C
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Aug 2022 10:49:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-343a77f2129so11774467b3.15
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Aug 2022 10:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=MnsS8ncSlTAcFzP7xEc9prMO96AQWzO4o54UtGrQzJU=;
        b=gg3c8bDNGCr3x3JbayKQGif3lCtfSKsL+hD2/hH+DYLV89UjDLhUvnvGbL61aElRWU
         2puYuvgz7VcM3xmVRlZLm5MUlcL0302bbgotdLSWZB3kCFMEFCmkIsrNihw9EY//796o
         AAqYjlYpOqSJBqaqkMZIT73K4HqWEXsxQGcGT0+ZMS32tow3pzhz+Qi6LKIQnM19rB2a
         kmDenz81aGiF0UOtl1MFu5lH3kDlBHKRPKm89KQx7TFJa50EwaM0uPu2dqbIAnwPo+zt
         re7McxUZFeN2zcFd0Qk4kqefnJ39aGDKPmfc1TCcX6D07pHhnUG7jxk5rVjgctm7ct/5
         uatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=MnsS8ncSlTAcFzP7xEc9prMO96AQWzO4o54UtGrQzJU=;
        b=SmEWIHBOfuJa5tf0HNaLD9fcD6I9B8fKAn5gijQzCmCk2t+PRIxpa2LsdN7hWIJ2mX
         BNOi3zYJWuy2uXAeG4zebBlGuPG4wszW/6T2OX9LF5KK0H4UdKwKk1nyHhahbNsY/CUY
         2jccNB/xn1ojD0br7Vp414U63vq8FjH6YdqivAD8xDL4OiY+fq9+3U7jZdUm2RCGvt92
         nogww5kX6Fn7fFWdzcmsaY8tgeKmPYhdDcyFRfNrwRi5+LkJH3AS/uHStMtr8MqHKVb9
         vzuwkropEcx3VvYN5/rXJMxAvNJiorzw+PqIGjN14tfbAWcoxDvstEzNJ80YSBuLyaqB
         Lmrw==
X-Gm-Message-State: ACgBeo3lux4/nuC+2K4D0tWsx9Myy2qORaP0Nc9NK1A344cSAheWwFcH
        dIamlLRtnNBz0Ts4lEK7abrPLJEoGreJ
X-Google-Smtp-Source: AA6agR5at5t1TXd5WijHlgK6tmOOJUVw9stHldpjmciTFBm7Fn21LINgH9dd6oZLnP4AdhNoGG63TfQE5sNg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8e4:a3e5:9d09:d3d4])
 (user=irogers job=sendgmr) by 2002:a25:4c83:0:b0:699:5f97:cf2 with SMTP id
 z125-20020a254c83000000b006995f970cf2mr17491716yba.198.1661968177909; Wed, 31
 Aug 2022 10:49:37 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:49:19 -0700
Message-Id: <20220831174926.579643-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v2 0/7] Add core wide metric literal
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
        kshipra.bopardikar@intel.com, ahmad.yasin@intel.com
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

v2. Add error handling for ENOMEM to more strdup cases as suggested by
    Arnaldo. Init the shadow stats if running "perf stat report",
    issue caught by the stat shell test.

Ian Rogers (7):
  perf metric: Return early if no CPU PMU table exists
  perf expr: Move the scanner_ctx into the parse_ctx
  perf smt: Compute SMT from topology
  perf topology: Add core_wide
  perf stat: Delay metric parsing
  perf metrics: Wire up core_wide
  perf test: Add basic core_wide expression test

 tools/perf/builtin-stat.c     |  66 +++++++++++++----
 tools/perf/tests/expr.c       |  37 +++++++---
 tools/perf/util/cputopo.c     |  61 +++++++++++++++
 tools/perf/util/cputopo.h     |   5 ++
 tools/perf/util/expr.c        |  29 +++++---
 tools/perf/util/expr.h        |  14 ++--
 tools/perf/util/expr.l        |   6 +-
 tools/perf/util/metricgroup.c | 135 ++++++++++++++++++++++++----------
 tools/perf/util/metricgroup.h |   4 +-
 tools/perf/util/smt.c         | 109 ++++++---------------------
 tools/perf/util/smt.h         |  12 ++-
 tools/perf/util/stat-shadow.c |  13 +++-
 tools/perf/util/stat.h        |   2 +
 13 files changed, 318 insertions(+), 175 deletions(-)

-- 
2.37.2.672.g94769d06f0-goog

