Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5B0C6379F
	for <linux-perf-users@archiver.kernel.org>; Sun, 19 Feb 2023 09:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjBSJq6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 19 Feb 2023 04:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjBSJq5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 19 Feb 2023 04:46:57 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B59583DA
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 01:46:16 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5368a9902d0so14348637b3.10
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 01:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ApboYwC5HDpqa4KgO9vE7lItPOtxh0INRVt9hDTELA=;
        b=eKrS9YbE5MvFZdViv4py+wujaC6AoA78JFYCdWX32lF9PoiXUgE3idq0OBKkFhvJ8L
         8iy6lGZX2pkmRRG5L9VoyF4JMYhESKqhxg1bQRw3cbXu9cp0CTVAsnfEx7iX0m8WcHmJ
         0khwL4pKRPFny0ZCfaK1RnTWEWhb3jRklhCcxexJ/lPXaF39kJkIOOWW9PvDQfhH3qw8
         i6SXakOmGvzYKxm+6U79/2sZgCBcFrdbqgmoGs3Zp43La0bVDCky0ubQmF3HRG8l/moZ
         Or4Qbi5jk1XP9gTTmxi3oHJe1J1/5t4dUvhGzSs/SXr7RmRzmHYiWa0KAaYnoxYzSygO
         fbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ApboYwC5HDpqa4KgO9vE7lItPOtxh0INRVt9hDTELA=;
        b=mJF21V3gir9K+9bfJRyeSFZSRZXsOGzWhZZAakhwoBeuzzTVGIQD04225yesprXEIO
         S2T+dAxnEyPGohtppVuA3Lbk02DOS6Irwt6K5W93a+2eBztCev+BpuvWGDnyJM8Dn9fQ
         pajOdY65+OWKr2XBOfgsoVfwK9OYl4WOhZ1HY9KcpQDOc8cAx9UDtXo79eulNUHc6RZZ
         VzdoKxFU0adrVQImnWGiVtATR972dBuhzN4T3Is3YAz+3eZgW8OQX3AdoMNsreof2G0C
         Wb+mNUaGqcrxTXUJO+eznLiI+Q9jNQmRMKoi3XNcmL7Hd49ZRjdvMcT/9V2EmG8WvoFI
         vUSA==
X-Gm-Message-State: AO0yUKX5jKxzpO1yO2xUF1O/kIBD3GJ5SgVdCt1RKjsHuegiAdNtK+uT
        vx2qfv8JSNH4FSwmWH2Wi2v7yvdD9WXY
X-Google-Smtp-Source: AK7set9l7EzTRgvXB15GxGWCICFKm8udU74GJTOUVF1jH0sNKtgIcL7PqS/JykUEiXuu54Ngmu99y9XTMRbT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a81:e94c:0:b0:507:68eb:1b20 with SMTP id
 e12-20020a81e94c000000b0050768eb1b20mr311210ywm.236.1676799327857; Sun, 19
 Feb 2023 01:35:27 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:43 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-47-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 46/51] perf stat: Move enums from header
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The enums are only used in stat-shadow.c, so narrow their scope by
moving to the C file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 25 +++++++++++++++++++++++++
 tools/perf/util/stat.h        | 27 ---------------------------
 2 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index d14fa531ee27..fc948a7e83b7 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -29,6 +29,31 @@ struct runtime_stat rt_stat;
 struct stats walltime_nsecs_stats;
 struct rusage_stats ru_stats;
 
+enum {
+	CTX_BIT_USER	= 1 << 0,
+	CTX_BIT_KERNEL	= 1 << 1,
+	CTX_BIT_HV	= 1 << 2,
+	CTX_BIT_HOST	= 1 << 3,
+	CTX_BIT_IDLE	= 1 << 4,
+	CTX_BIT_MAX	= 1 << 5,
+};
+
+enum stat_type {
+	STAT_NONE = 0,
+	STAT_NSECS,
+	STAT_CYCLES,
+	STAT_STALLED_CYCLES_FRONT,
+	STAT_STALLED_CYCLES_BACK,
+	STAT_BRANCHES,
+	STAT_CACHEREFS,
+	STAT_L1_DCACHE,
+	STAT_L1_ICACHE,
+	STAT_LL_CACHE,
+	STAT_ITLB_CACHE,
+	STAT_DTLB_CACHE,
+	STAT_MAX
+};
+
 struct saved_value {
 	struct rb_node rb_node;
 	struct evsel *evsel;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index df6068a3f7bb..215c0f5c4db7 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -55,33 +55,6 @@ enum aggr_mode {
 	AGGR_MAX
 };
 
-enum {
-	CTX_BIT_USER	= 1 << 0,
-	CTX_BIT_KERNEL	= 1 << 1,
-	CTX_BIT_HV	= 1 << 2,
-	CTX_BIT_HOST	= 1 << 3,
-	CTX_BIT_IDLE	= 1 << 4,
-	CTX_BIT_MAX	= 1 << 5,
-};
-
-#define NUM_CTX CTX_BIT_MAX
-
-enum stat_type {
-	STAT_NONE = 0,
-	STAT_NSECS,
-	STAT_CYCLES,
-	STAT_STALLED_CYCLES_FRONT,
-	STAT_STALLED_CYCLES_BACK,
-	STAT_BRANCHES,
-	STAT_CACHEREFS,
-	STAT_L1_DCACHE,
-	STAT_L1_ICACHE,
-	STAT_LL_CACHE,
-	STAT_ITLB_CACHE,
-	STAT_DTLB_CACHE,
-	STAT_MAX
-};
-
 struct runtime_stat {
 	struct rblist value_list;
 };
-- 
2.39.2.637.g21b0678d19-goog

