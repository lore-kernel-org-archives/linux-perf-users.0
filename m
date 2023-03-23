Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28828C74A5B
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Mar 2023 19:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjCWTWN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Mar 2023 15:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjCWTVq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Mar 2023 15:21:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7650D9000
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Mar 2023 12:21:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b124-20020a253482000000b00b72947f6a54so5816439yba.14
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Mar 2023 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679599287;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ICoBRC5p7C47vzNPhCu4TQTxzhqKflbzynhlXLr/MKk=;
        b=NTv4v6z3Ry7/x16aUR6VsSc2k8sA9zVbyAhVQTlCenK4TKyrTtLzcVCpKnXXpMYMvz
         mnCi5FW6Ux9aGdiAkPcCiBPO4+hnZ4FncMdfsiCKN/qpAFzVrkRDXdsL2DgYYoOvBTJ+
         5d+Yacn36i26RyuFzNCVISlOJXf4MCzBjg/H95LHGb5HfwiQplhxgCzA+3YAKjzwTVcC
         KxdILpoPITXk1FkOALG7PUQAKKiH8bCcArW2Et3dbd/CtwpnZrnPDgURtyQng8zxIHWp
         ktEMzP1HbudPxSO69jZzUQC+v2yrGNGQsS2uBYTaXmsD6t/brrNCuwsbHF3SBl9CwKMm
         0izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679599287;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICoBRC5p7C47vzNPhCu4TQTxzhqKflbzynhlXLr/MKk=;
        b=wguJEdfeXYX/9Pqe2LcpRqZJt7ekFuAybJvkJ2KkXQ86KAE4eiHM1yfVsGiSi8brRv
         PH2dQ/CCanko4DGmUVCH9Zo0eDZG5xplmR+oWnGGVROFuhUh5MOxmmD3fCjiw7wE8vQU
         XjRBpLJPiU8cBVyati+UnHzr5Dd7I2+wp0PAvu581nbCSqGIMr+MZco/LcSoTN5s0oFH
         kLx9Qd62GKMahDBJ7PfeBXGWcBKeJJV9JDPOulOrps57h5D3gMt/rheZCPAaIFV3t+65
         98FM6EdNySIiTmuDOFTAR/QwAOTEgrpjdNCUsm4CdygJmz2MMXdHXRdta7+/XlksvBor
         TSvw==
X-Gm-Message-State: AAQBX9djGj61hEflx+gEdigstciANr6Y8be4y54+6khd1Py3bMy1lndy
        kGAMRNeFhjovINz4tpObwJxyAVWMtv6a
X-Google-Smtp-Source: AKy350aykOl/2HKkfyrVxLlykwiNwGTV+2qSc99jTYQOFCt6cgGio9japBskZHWTdyIz90vOL8VmY1WwhukS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e705:3a3d:46e5:fb50])
 (user=irogers job=sendgmr) by 2002:a05:6902:70a:b0:b21:5fb4:c6e6 with SMTP id
 k10-20020a056902070a00b00b215fb4c6e6mr2790224ybt.11.1679599287786; Thu, 23
 Mar 2023 12:21:27 -0700 (PDT)
Date:   Thu, 23 Mar 2023 12:20:25 -0700
In-Reply-To: <20230323192028.135759-1-irogers@google.com>
Message-Id: <20230323192028.135759-7-irogers@google.com>
Mime-Version: 1.0
References: <20230323192028.135759-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v2 6/9] perf vendor events: Jaketown v23 events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        samantha.alt@intel.com, weilin.wang@intel.com
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adds BR_MISP_EXEC.INDIRECT event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/jaketown/pipeline.json | 8 ++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv            | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
index 85c04fe7632a..d0edfdec9f01 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
@@ -202,6 +202,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0xc4"
     },
+    {
+        "BriefDescription": "Speculative mispredicted indirect branches",
+        "EventCode": "0x89",
+        "EventName": "BR_MISP_EXEC.INDIRECT",
+        "PublicDescription": "Counts speculatively miss-predicted indirect branches at execution time. Counts for indirect near CALL or JMP instructions (RET excluded).",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe4"
+    },
     {
         "BriefDescription": "Not taken speculative and retired mispredicted macro conditional branches.",
         "EventCode": "0x89",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index e1a609401fff..e41c289fa427 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -16,7 +16,7 @@ GenuineIntel-6-(7D|7E|A7),v1.17,icelake,core
 GenuineIntel-6-6[AC],v1.19,icelakex,core
 GenuineIntel-6-3A,v23,ivybridge,core
 GenuineIntel-6-3E,v22,ivytown,core
-GenuineIntel-6-2D,v22,jaketown,core
+GenuineIntel-6-2D,v23,jaketown,core
 GenuineIntel-6-(57|85),v10,knightslanding,core
 GenuineIntel-6-A[AC],v1.01,meteorlake,core
 GenuineIntel-6-1[AEF],v3,nehalemep,core
-- 
2.40.0.348.gf938b09366-goog

