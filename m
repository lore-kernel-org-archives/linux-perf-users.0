Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366CBC83F18
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Aug 2023 18:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjH3Seo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344004AbjH3Rzz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Aug 2023 13:55:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2966B198
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Aug 2023 10:55:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c8f360a07a2so6731051276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Aug 2023 10:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693418152; x=1694022952; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nhUMR+Qhbp8y+nwD/HFpoTD9KE/+xTeRonW+Kynw6Ks=;
        b=fBo3tSleXwKoYKYS476vyY88xGz98rxpjgCzOOfW3o0GkW51U1RFsH5GqaF8XXKEjp
         awj2HNt2NSg9yH7S2a0CboFSlRHFjNyYeziSoHvIhJVoN0I6z4U+lX0IV3rXB76VEBfN
         Ur1WbtVM1vTIOK+6Q5iW1QmEidk1I6sQV3Hz//GPzHkxz4gUlIaU4OmisG8LhAe1PNwn
         I/r52Tmk4twPeLRXxNpMQbSqVXMfhisjGme7rhZ5fp/xH0b69XjEkrXUgr/H+CCQS8ho
         qjgZCYgzZvT9TiC7JUkUdKLNs7I4YQhuEk8xZMYUTxDYsHlH76Ki/GfptrDxHNmG362s
         4mXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693418152; x=1694022952;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nhUMR+Qhbp8y+nwD/HFpoTD9KE/+xTeRonW+Kynw6Ks=;
        b=bPKmjhnMTHfD3WDMoBgM/SSpYgchEoQUAkTuDz5p7TqIDZGePNseXshlrX/PAdIj3G
         i2JuqaYahbAYk9Ux3SvJ0u2kBYv2x2UhRF8SnscVL8ZujmTBKn9E/aIBiYLM9MRZF1am
         oBtI8eKM+GVhPLKxOIn2tYlz+g1KfLpgnVbKUkHxXWNPOgmNNMPYhYGMyDdDOFWB7jRP
         S9plxNfLD+Jup/Cdo9hatIO7M4M4aDRoFvL+MZvLQPqfkbJKygUxoQURZoTfC5A0YecS
         ow86UVCUNjC+tpZ2p96S4qG7vP68Hl+Mt+MdsK9kaw+nQ+MyP4WFbrg/uppS9EUnWDXB
         kG/w==
X-Gm-Message-State: AOJu0YyWM82UB66B8iQZXX2OGQzNo0p0QIDXZVh/CS7QdNndZ73BJeeb
        uWLNJTpz18mFJ3ULhd+8zskOTt26Baie
X-Google-Smtp-Source: AGHT+IGvBdJLMVXF/uFJxe50w5YPhsBZUhYxeG4/YnRgUHTI68Z8YR6f02uPs81VuhpenU633yiHhlN4Ozep
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:d623:3cd7:ecbc:8798])
 (user=irogers job=sendgmr) by 2002:a25:bc87:0:b0:d73:bcb7:7282 with SMTP id
 e7-20020a25bc87000000b00d73bcb77282mr85409ybk.8.1693418152443; Wed, 30 Aug
 2023 10:55:52 -0700 (PDT)
Date:   Wed, 30 Aug 2023 10:55:43 -0700
Message-Id: <20230830175543.1911892-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v1] perf vendor events intel: Fix modifier in tma_info_system_mem_parallel_reads
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The metric is using the wrong format encoding. This fix is in the
converter script PR: https://github.com/intel/perfmon/pull/101

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index 94cb38540b5a..2795a404bb58 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -923,7 +923,7 @@
     },
     {
         "BriefDescription": "Average number of parallel data read requests to external memory",
-        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.DATA_READ / UNC_ARB_TRK_OCCUPANCY.DATA_READ@thresh\\=1@",
+        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.DATA_READ / UNC_ARB_TRK_OCCUPANCY.DATA_READ@cmask\\=1@",
         "MetricGroup": "Mem;MemoryBW;SoC",
         "MetricName": "tma_info_system_mem_parallel_reads",
         "PublicDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches"
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

