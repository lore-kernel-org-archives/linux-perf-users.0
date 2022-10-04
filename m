Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306F7C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Oct 2022 02:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiJDCSB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Oct 2022 22:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJDCRN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Oct 2022 22:17:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0403DF28
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Oct 2022 19:16:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-358a4ea26a2so60136647b3.16
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Oct 2022 19:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=1Fr2K5+nGwAaJU7O66cM9z/u4Ic+WMsu462XEdN8mXE=;
        b=eDuZOFLXZOAhkECusE5OKfNo+zlrq1YLat4R0rqtq9h+aJDtLYv7z/NCYzE0BEeocb
         QSkoih/iMjTqIY+XlZdCQnfbsXmEcG4kiz68Dt/Cq3qN43RvMByvx9u5nCyaseXiMhGL
         wva1iD2Go+PLfFrov5/Fx8AiMTNkl0VjV2NXMcAvQCOrGHrfuHhSI95xZeE31+4vYLEr
         rwJee+Ifi2PHRQKHclnAs3JyENIjUGfQXplVu+CQQOJbe5U4vrElK17aaqUVv/G6IwXz
         rU4/LEP6zgoGQx5PEbTisLULcJRFUfMVZHdPW1xcPD+ARCElroTvP83ETs6tz6wR3Rw6
         x1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=1Fr2K5+nGwAaJU7O66cM9z/u4Ic+WMsu462XEdN8mXE=;
        b=pgIO22HvHvCg6vO0I0QOlgsPxQSoIfiX11msBZAE1yQzHTy2qyG4s9djympQqcNSya
         t9ax5mL0KViXvzzTZ95Yo3LPOJNOdFZktRHmKd0YbvBdq9A4yMJPRmzM6CjwuQk+d2s+
         xIthVNX3RMCDixK4PBw45mCeoJjz1FD6dh3wpCrlpuHdg5xWfEHh3irq5sHuwiYPlZ+5
         4jrHicMxxbfJKNdjz0L6BYBqdNy+anmj6o5LvQYK8dlw/mPwqw5lbmoe1Ezsf2B1sFtW
         ti4aBdyTgZvxZad+nNXo39gLpGn2jOxI1URS1tYbjUqGAOM6q49P9PAKX+BXXjpvUIvj
         hzQg==
X-Gm-Message-State: ACrzQf36IxgDFiTgEVVYE+mt5/BJVYuLz6BEuvCEwMSvNumvQrH++GFC
        a6NVTYNLAz7DzAPWMxXeOk5iYTsf3ZSj
X-Google-Smtp-Source: AMsMyM69JWLeqb8fvC27sn/8K64yRaH1g/N4YiGgljL/mdexMvfSnxvcZeR8/uTHfWBdTk7Lp/wcXbLH6HX8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a86d:8afd:70b1:9b0c])
 (user=irogers job=sendgmr) by 2002:a25:f304:0:b0:6be:e3c:9724 with SMTP id
 c4-20020a25f304000000b006be0e3c9724mr3475463ybs.145.1664849805040; Mon, 03
 Oct 2022 19:16:45 -0700 (PDT)
Date:   Mon,  3 Oct 2022 19:15:59 -0700
In-Reply-To: <20221004021612.325521-1-irogers@google.com>
Message-Id: <20221004021612.325521-11-irogers@google.com>
Mime-Version: 1.0
References: <20221004021612.325521-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v3 10/23] perf vendor events: Update elkhartlake cpuids
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
index bc873a1e84e1..6c8188404db8 100644
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
2.38.0.rc1.362.ged0d419d3c-goog

