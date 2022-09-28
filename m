Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF2EC32771
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Sep 2022 07:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbiI1HYA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Sep 2022 03:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiI1HWh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Sep 2022 03:22:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC74D74F4
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Sep 2022 00:22:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m131-20020a252689000000b006b2bf1dd88cso10695544ybm.19
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Sep 2022 00:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=+uljP0IZBjEa6liP5N6VFozdPRq+OISBI0t9P6nIUUs=;
        b=LLnH2QbvqYr/N0WnuyBjktiKaCnxyRBNo+CLSudb/qnwNtnvwYV7BdBbn4o77dTPGl
         genLbayfWUogTwUcdFKGTSvDUYRBQ+6dimv5mmv61jRaGTP/N/pJlIm6LpgGCG/57htZ
         z4JJndAW7WgN14TaflATNaVpA+XjXAwYLIT5GAetS1VenRcELnaMxP0whQQyRL2xWdyZ
         eDNUkmSkU0tL+uwBT5P7xYKenwboqJCpW+UXUH8vBtyguTrIBZyBIPLF8r5G6sM3pKla
         jd6K9iv/0kr5/otWKVDqlLornKruv8xnKZDvzGgNOv5YazUpWzunOD/MBpF5ibH1/ctP
         rXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=+uljP0IZBjEa6liP5N6VFozdPRq+OISBI0t9P6nIUUs=;
        b=DACBw6t1DXV6Ntwi9llWIBwL/IJ2CZoqTeVN7DG/jou5tWtONIgP267UWfPt9RNYhc
         VKXCPwUvNPHAWmqPSO4pvSbShxbmWvaSYLY0fvKquXHNtB4Zq1zuMAitiAEZFc8aXC71
         y1Dm9GBHWAyWohJNxrovFzi7agIPim+8+C+Kl642y4O662NEiZLRdH3cE6Ozpjd4qDrP
         uOWrljmA/jaHys/7Am2t2irkFd4HTIC/KVgsrQmu/2xfxG+/6Gdrppmx6iSFSrA41gIa
         A3uXF6QXdeM41bNXVHceXREh0uu9OKXU85FV+QvAeZU/G9elTmQZIs1Lk0iw0g0S53Th
         gkIg==
X-Gm-Message-State: ACrzQf1j5l+vShg9wIVKJ3AcXrQ858uxlGe1EqjyxmRqQGs0G5a1ReUW
        kADKhSkjb+ZZ/fy4z4axKqnO6cHiODcK
X-Google-Smtp-Source: AMsMyM5hap4jwoKcGPXXMuVVlOc8GWTYTyBREFQxWtYbxD2Mxz56HU7aNCiuuS3DoI+0x2mtIaMmvWFQ7enE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7099:1ccb:612a:5ad6])
 (user=irogers job=sendgmr) by 2002:a81:8103:0:b0:345:62dd:a9a7 with SMTP id
 r3-20020a818103000000b0034562dda9a7mr28435005ywf.330.1664349752544; Wed, 28
 Sep 2022 00:22:32 -0700 (PDT)
Date:   Wed, 28 Sep 2022 00:21:51 -0700
In-Reply-To: <20220928072204.1613330-1-irogers@google.com>
Message-Id: <20220928072204.1613330-10-irogers@google.com>
Mime-Version: 1.0
References: <20220928072204.1613330-1-irogers@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Subject: [PATCH v1 09/22] perf vendor events: Update elkhartlake cpuids
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add cpuid that was added to https://download.01.org/perfmon/mapfile.csv

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 594c6e96f0ce..6d0cd5030743 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -5,7 +5,7 @@ GenuineIntel-6-(3D|47),v26,broadwell,core
 GenuineIntel-6-56,v23,broadwellde,core
 GenuineIntel-6-4F,v19,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.16,cascadelakex,core
-GenuineIntel-6-96,v1.03,elkhartlake,core
+GenuineIntel-6-9[6C],v1.03,elkhartlake,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-(3C|45|46),v31,haswell,core
-- 
2.37.3.998.g577e59143f-goog

