Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49371C43334
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jul 2022 16:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiGRQnU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbiGRQnT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jul 2022 12:43:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03386F5BA
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 09:43:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j11-20020a05690212cb00b006454988d225so9152033ybu.10
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 09:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fYofINTij03DPcWKIxfbrAT4JPb3siK7exyNeIlcD5U=;
        b=N9uFsdwVL4V6pYvk4JsZwo6gVJAaVtZJfYKCVfqCJfXQFkY8VZVetp4CafnFw5m+wI
         USuc1jejc8950fmeG47w8DiTaJSwr67wd4asubiCo5lKObX4peLeAQXThc4q9fHZJNvy
         hSoRQF/ZkSlSJXiOaVb6PJKs0YkOX7I2KBcTTqzWZosQnTtu8rb94cO+T9SbAFDnclcZ
         qxip1nZk09WCKtqTNuPQkKQ6tWyiljVJHqEHYUfP2JWJSA20KUsx93M3+XqrX8L28ZAo
         R/nJJUN1hq3VoffKVxs0NXsHCW7bJTRugFvQ484nb9lJf6Z0Lhtu5kkznEIN/jlBGCuo
         QwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fYofINTij03DPcWKIxfbrAT4JPb3siK7exyNeIlcD5U=;
        b=kA4Iwh1Enx/IagjcVwfYvuDdYTAe8E+B35G7rKrZybxleDYRbYD4IYEsZeN7Nqr9r0
         TDc8R5FmDB0AZQLTEwmdEIJBARAj3SXN/rQfd8fQQ89odGIMqucFPE8IOoSRPayuhZaW
         Kln26oTbCMwmvGsRCkDJO92IToE1IIbPWJYeWpmNgUgZUdouthOskoceAltyGVmKU0oT
         WGmdNLkh9zBLiu1Cq6SHzZnyP1bq7xPZDUHYlRY6N8yS9LPL/YM0BVLTL6n9qIPHb1dk
         MBKBX0ojPPiE5yZtM4vFHcYuACsANRtKsw8Pt7e6Vf72xqR6dIGgyNphZgs+2w2QKmdM
         tUFg==
X-Gm-Message-State: AJIora/xuyraJTa2JLhqi4rtMIjjx/Qi+z1OgClzX4f1yui1UpjUZ6zY
        equBNsI7tBll1Kd2nB6iZfskhU+0vnn9
X-Google-Smtp-Source: AGRyM1sui6frsIcA/wQFW2UecSes/L71+RdmIY8GslmayyTv5uj7L8ODJtUI90YevaRH7Sf96QjfVgdmN8fV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:922:90e9:167f:1ccd])
 (user=irogers job=sendgmr) by 2002:a25:f06:0:b0:670:1685:d31d with SMTP id
 6-20020a250f06000000b006701685d31dmr10216544ybp.380.1658162597250; Mon, 18
 Jul 2022 09:43:17 -0700 (PDT)
Date:   Mon, 18 Jul 2022 09:43:09 -0700
Message-Id: <20220718164312.3994191-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 0/3] Add arch TSC frequency information
From:   Ian Rogers <irogers@google.com>
To:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The first patch adds the #system_tsc_freq literal to expr.c and
computes it via cpuid. The second patches adds support for "older"
processors by computing the value via /proc/cpuinfo. The third patch
adds a test then the computation looks somewhat sensible.

Such a literal is useful to calculate things like the average
frequency [1]. The TSC frequency isn't exposed by sysfs although some
experimental drivers look to add it [2].

[1] https://github.com/intel/perfmon-metrics/blob/5ad9ef7056f31075e8178b9f1fb732af183b2c8d/SKX/metrics/perf/skx_metric_perf.json#L11
[2] https://github.com/trailofbits/tsc_freq_khz

v4. Modified the patch order and separated out the test.
v3. Added the cpuid approach from Kan Liang.
v2. Adds warnings to make clear if things have changed/broken on future
    Intel platforms. It also adds caching and an Intel specific that a
    value is computed.

Ian Rogers (2):
  perf tsc: Add cpuinfo fall back for arch_get_tsc_freq
  perf test: Add test for #system_tsc_freq in metrics

Kan Liang (1):
  perf tsc: Add arch TSC frequency information

 tools/perf/arch/x86/util/cpuid.h  | 34 ++++++++++++++
 tools/perf/arch/x86/util/header.c | 27 +++++------
 tools/perf/arch/x86/util/tsc.c    | 77 +++++++++++++++++++++++++++++++
 tools/perf/tests/expr.c           | 13 ++++++
 tools/perf/util/expr.c            | 13 ++++++
 tools/perf/util/tsc.h             |  1 +
 6 files changed, 149 insertions(+), 16 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/cpuid.h

-- 
2.37.0.170.g444d1eabd0-goog

