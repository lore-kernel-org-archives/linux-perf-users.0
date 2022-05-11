Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1991C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 May 2022 07:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242446AbiEKHBt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 11 May 2022 03:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242428AbiEKHBq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 11 May 2022 03:01:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4256C0CB
        for <linux-perf-users@vger.kernel.org>; Wed, 11 May 2022 00:01:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f9299dfb81so10009587b3.6
        for <linux-perf-users@vger.kernel.org>; Wed, 11 May 2022 00:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3xLzWp+VN8d56IUKCn+oZgvctc6ILOg/P6G2GbPqdKc=;
        b=N8/Nldd50lgxa4UFpEziOLqimjwZJwjurqH31n9cYdBOi0RBAipty9Ako1bpqKqpEX
         3nmNb18S9Yvbq34OwG5EVj4isGDRt9nu75YwPVXb6E93b2xCV2jcGXqvojKpN/yDfW4l
         pyhnuj95b3Uy9b1rmrLuzFSNGLjx2PXdQGAY+YQCZ4pAVLCCAFaOns1U4IQ+lnfALzoy
         zltNPdjfV05fmlZV2Tv8Q8V4A5xGNr8tNXDi1NoMTLYG2sbBXe3nyRgTxdI9FOz4Mzup
         yq6Mq2rzn+6NrVKeJ/hJ8wRD9FFimIeUb39l3UgOke6JB8FMseM1/8VdxYv0gf2HIjvD
         ZuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3xLzWp+VN8d56IUKCn+oZgvctc6ILOg/P6G2GbPqdKc=;
        b=er9lDk/Ds4Ed9Ep7912aH1ItPCrYtUQoOiNxrleTN2/zh4xZ8CldQu1OFvb+olxy5X
         8irEj8n4FwcHA7ItNelSmpRld+YS8z1rVexmxgzXs2dbWg6ikyWgxGHSh9T1oMX39GJn
         34so2u3jO7lJLDiZrlxflGUxc+klotsaykekaMBnxp42sNMaojwX/ezJsdtRe2UeAvk6
         qFI0S53p1OdQpnhKeU9dilwbR3GDDockstuoJ3P0JnPeK95tyAmolVkR06JvdqyPM2/q
         /77rNeLLoWeIv6eZ5iY+sR7L3xQZ/PAMpIbDjBucaszMrXH/4/p4EOhn33N+tNnN0SEf
         1ltA==
X-Gm-Message-State: AOAM533xkwNfSGENk7R7JEv7eE6e2rc5psupw7cQc0TM6Jyiyco9Sa6e
        pJCikV61nXlI+gJWdx3XcbcT9GI87pYh
X-Google-Smtp-Source: ABdhPJyU0JGtkMiuWLcINboT3dByokO5rmHxkLIAGVtLVFu/F1k0AkML7xNFVmashRWlC6SkWWWwsV2ym4Mf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b6c9:16a6:f912:39d5])
 (user=irogers job=sendgmr) by 2002:a0d:df48:0:b0:2fb:3658:38b0 with SMTP id
 i69-20020a0ddf48000000b002fb365838b0mr22872026ywe.508.1652252504258; Wed, 11
 May 2022 00:01:44 -0700 (PDT)
Date:   Wed, 11 May 2022 00:01:29 -0700
In-Reply-To: <20220511070133.710721-1-irogers@google.com>
Message-Id: <20220511070133.710721-4-irogers@google.com>
Mime-Version: 1.0
References: <20220511070133.710721-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 3/7] perf vendor events: Fix Ivytown UNC_M_ACT_COUNT.RD umask
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The event had two umasks with the umask of 3 being correct.
Note: this change wasn't automatically generated as there is no CSV for
Ivytown uncore events at:
https://github.com/intel/event-converter-for-linux-perf

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json b/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
index df4b43294fa0..e8917cb59566 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
@@ -5,8 +5,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_M_ACT_COUNT.RD",
         "PerPkg": "1",
-        "UMask": "0x1",
-        "Umask": "0x3",
+        "UMask": "0x3",
         "Unit": "iMC"
     },
     {
-- 
2.36.0.512.ge40c2bad7a-goog

