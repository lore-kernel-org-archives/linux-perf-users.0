Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF30C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat,  7 May 2022 05:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445578AbiEGFiD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 7 May 2022 01:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445538AbiEGFiC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 7 May 2022 01:38:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6B6C7B
        for <linux-perf-users@vger.kernel.org>; Fri,  6 May 2022 22:34:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y26-20020a25ad1a000000b0064a54b86bbaso5035773ybi.6
        for <linux-perf-users@vger.kernel.org>; Fri, 06 May 2022 22:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4vU3lvK+Ux0QY/uX6Xb/Zo/8TNbKrXUBowbL674xebA=;
        b=EJfGPXf4V43SOAkVj7IEaHwyPoCqo8HnabnxDHTITOmrAJnUVkotxRGGvwuwm6a0kP
         2NTKScu8lx+m+vkE3E9kkXWbuNrroe4uRBLjrNmSQ3I3CuM+q85cB2To/mRvRGDNuYRd
         h7X5F5LLVmYxmZslAp+PLW/1fZRmoCw4fwpbaa9mOT0xV1gUdzrTrSiD0OTeTkXxhJw/
         LyGUbv4m6ZiUXhc4Sb9bkvDb2c8z6OhHyZgHVIpd1+gemgZ7paQ3H6zGSmQv7DPZt+CB
         6h9sqxMUjdscust4kMKqHTZHDJ1BCPpBqFmWpw0/P70QwhyHhi46GMQPl2GGMCDeAmND
         SZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4vU3lvK+Ux0QY/uX6Xb/Zo/8TNbKrXUBowbL674xebA=;
        b=Ghhhtp+lzDStNn7/H9lGKSmkCSB/lDCG7PRxMR6vwOVXxOO4kY5xKlo3miRTInJ/Ui
         WwA5ZFXBKU5+ktIUyuZawiONQKmYRgJJALd6qP5kneWCq7ANaNteFs5CpP6+54UHyoyt
         z+0nGFkayTdl3BckWHAuhRmiZHw9PnbCth6x8SsARVlcrSYYVDSs5GuKuJcSu+wWZty/
         eBQNpDSCCbEW66QHwA/LQBUDtmeAp1TOCTFkOhr7eVcj55c7e/F33vURO1vzM37sQenc
         5KMVY1k2GgWC2I2bFf5bCzoX3txSVdCoErzXFFbmHmtKKBbkdkQ1xfx2qRWmyK3zWdt4
         m7KQ==
X-Gm-Message-State: AOAM5302bprWGnb0peU0fcznUV3c0ippRtmu6DW3oJvULP3kLW2wiN79
        CT/8Xt2MQuDsc7M6Xhs/JmJYEbFDTu6s
X-Google-Smtp-Source: ABdhPJwlXvELF76l4UyZUOrNj/gJNZHeOGYaQ2tuGMaLKJ8K/78md0LxRjuwZ+v8RFNe3GV3QwzGrqG/EiAn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:bf2a:2f64:a273:3573])
 (user=irogers job=sendgmr) by 2002:a5b:f41:0:b0:64a:7639:3bab with SMTP id
 y1-20020a5b0f41000000b0064a76393babmr4424411ybr.138.1651901655099; Fri, 06
 May 2022 22:34:15 -0700 (PDT)
Date:   Fri,  6 May 2022 22:34:05 -0700
Message-Id: <20220507053410.3798748-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 0/5] Revert metric hybrid events, fix tools events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hybrid metrics place a PMU at the end of the parse string. This is
also where tool events are placed. The behavior of the parse string
isn't clear and so revert the change for now.

commit 75eafc970bd9 ("perf list: Print all available tool events") had
an off-by-1 error. Try to separate the tool event enum logic from
evsels. Also add a for loop helper to simplify working with a variety
of tool events.

Add support to metrics for more tool events than just
duration_time. Make the sharing logic only look to add for sharing
potentially used tool events, found by scanning the list of metrics.

Ian Rogers (5):
  Revert "perf stat: Support metrics with hybrid events"
  perf evsel: Constify a few arrays
  perf evsel: Add tool event helpers
  perf metrics: Support all tool events
  perf metrics: Don't add all tool events for sharing

 tools/perf/tests/evsel-roundtrip-name.c |   2 +-
 tools/perf/util/evsel.c                 |  53 +++-
 tools/perf/util/evsel.h                 |  22 +-
 tools/perf/util/metricgroup.c           | 373 +++++++-----------------
 tools/perf/util/parse-events.c          |   2 +-
 tools/perf/util/stat-display.c          |   8 +-
 tools/perf/util/stat-shadow.c           |  27 +-
 7 files changed, 180 insertions(+), 307 deletions(-)

-- 
2.36.0.512.ge40c2bad7a-goog

