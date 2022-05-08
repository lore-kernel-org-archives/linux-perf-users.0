Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E55C433EF
	for <linux-perf-users@archiver.kernel.org>; Sun,  8 May 2022 09:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiEHJ2x (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 8 May 2022 05:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiEHJ2b (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 8 May 2022 05:28:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11619E024
        for <linux-perf-users@vger.kernel.org>; Sun,  8 May 2022 02:24:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e24so10719839pjt.2
        for <linux-perf-users@vger.kernel.org>; Sun, 08 May 2022 02:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lPhdUw6/xRTj5eRnk/v+0C6+XGKs0gs1fQItGV05POc=;
        b=JHV7gnh3NYXiAdRA1WXm+zWhMZQYRMfuuvrBAALmzQyuAPV8GId/Hm7iFogCgfky21
         K99kFpaSwtoiI+yhw24x7mbWHUoX8FVN9/ZzlQKeqEyA7e3TrwSeZ8GVR612ZtSsrARn
         Ykdipe4E+U3hYvW+FbW0RkTrdrwv69GBQa7LLfVGCFoPHGq6ifTVsfrnCDGKbd/DDUrg
         fuBS3eC53OtHXTnyUIE0NpRFzB72NgISNo8hBf5oTAkp9yMjjil8fnYGkXV9ZddK+bDE
         D9L09XCVuVEVL2QFnClRTlRhwMtNqefnU52unoBcGvFgKR5zOfVdXkbVEOntbp6uoJuI
         f/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lPhdUw6/xRTj5eRnk/v+0C6+XGKs0gs1fQItGV05POc=;
        b=G0Bhl7REn4QBJjL1sHBpRhBoQqhNKEdQW9zkzXY78yiqUNvPqPjOUlNpQrBub6ujjB
         GSNt7JyxaX2DJ25o6Rkxmxv5CKTiEHjyUdkYBSiK5D4PUpTUQOHEIa1iedIncTuNt4kj
         O4DolFpTwR48iVT80pxDt42/r2mBBU2sVVJgEx6qjGdrKQvI+WMEd4tZf4wZMj1xRJ5C
         +BD5QyaeYw1Ij/nz14en9WU+PSaGlh5+mX3Hs+NOgbBERwOVs9LigcuT3WS1nyS8i3ZX
         pk04LNTHiVDYwlpzXH4/l2gFZWpDA/SzfcHiE1e5hr6h5hRFTD8R41+JJu15ZG1jMDGA
         MmWA==
X-Gm-Message-State: AOAM530UKwp0xG5hH5LPZmlixOw8nl0jXZahKcCdWsc9B503wsEbPx9T
        xQf3MqvLIosI7Y3olVC9LhLiLg==
X-Google-Smtp-Source: ABdhPJx8b1S7DP+l6TbHcjaDTxe+bP3mjVWrvxdRZjRpNA9ShTXWg/U5lWdyGp5WzpTFOapVuyHoYg==
X-Received: by 2002:a17:903:1111:b0:15f:7f0:bbf3 with SMTP id n17-20020a170903111100b0015f07f0bbf3mr2621799plh.12.1652001881479;
        Sun, 08 May 2022 02:24:41 -0700 (PDT)
Received: from localhost.localdomain (104-237-153-19.ip.linodeusercontent.com. [104.237.153.19])
        by smtp.gmail.com with ESMTPSA id t63-20020a638142000000b003c14af505f7sm6155088pgd.15.2022.05.08.02.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 02:24:41 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Like Xu <likexu@tencent.com>, Ian Rogers <irogers@google.com>,
        Alyssa Ross <hi@alyssa.is>, Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 03/11] perf c2c: Update documentation for store metric 'N/A'
Date:   Sun,  8 May 2022 17:23:38 +0800
Message-Id: <20220508092346.255826-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508092346.255826-1-leo.yan@linaro.org>
References: <20220508092346.255826-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The 'N/A' metric is added for store operations, update documentation to
reflect changes in the report table.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/Documentation/perf-c2c.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 3b6a2c84ea02..6f69173731aa 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -189,9 +189,10 @@ For each cacheline in the 1) list we display following data:
   Total stores
   - sum of all store accesses
 
-  Store Reference - L1Hit, L1Miss
+  Store Reference - L1Hit, L1Miss, N/A
     L1Hit - store accesses that hit L1
     L1Miss - store accesses that missed L1
+    N/A - store accesses with memory level is not available
 
   Core Load Hit - FB, L1, L2
   - count of load hits in FB (Fill Buffer), L1 and L2 cache
@@ -210,8 +211,9 @@ For each offset in the 2) list we display following data:
   HITM - Rmt, Lcl
   - % of Remote/Local HITM accesses for given offset within cacheline
 
-  Store Refs - L1 Hit, L1 Miss
-  - % of store accesses that hit/missed L1 for given offset within cacheline
+  Store Refs - L1 Hit, L1 Miss, N/A
+  - % of store accesses that hit L1, missed L1 and N/A (no available) memory
+    level for given offset within cacheline
 
   Data address - Offset
   - offset address
-- 
2.25.1

