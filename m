Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948A6C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat,  4 Jun 2022 04:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350575AbiFDEaw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 4 Jun 2022 00:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350632AbiFDEab (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 4 Jun 2022 00:30:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEE837BF0
        for <linux-perf-users@vger.kernel.org>; Fri,  3 Jun 2022 21:30:19 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so8494826pjb.3
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Jun 2022 21:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GU0Fx5MqBypkPPR5oPl8FBqUWIca4qCm6hD5a1k+pSo=;
        b=P3hlmhZGSSe/tHysAx9pKosNOKX136mCts9rBAP73d+2oiAMeKZE9wH0jsJbQ//uaJ
         KRmJWP+8mXEchku3A3OmLMc11cxoBVuV+Zxkm1+JAYZhUmLggl9ivXBgStthiaLV1CLL
         n033U5o9vCrnszomBIFhKF9yS9c2m7Du041Y6vH3LMOn4ZJUtAY+G8oO/0Dm3ZJU0lha
         DhZDSyh7kDb4HDTxOVNuBmxcebvlLZJN5m1k6FISRwegrjJa4zqjQfQGm9hjXOR3pj2M
         mCc0rN5Oi6FfnhFlGCJq1GNc5HbmjB1q7e6z5zd8dmrXqtnQQOCXxARtaYQEmRDjYkES
         8Bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GU0Fx5MqBypkPPR5oPl8FBqUWIca4qCm6hD5a1k+pSo=;
        b=GUMnxQiQT2Ei1Cooubafi2o8SByFtK9xlwS66Ui4ayJboHqTEQWm80izc1JV3yMPTo
         /KYFWupx+wISU6pBhCIC0ypPExd3SoOUt+kNqyG2lwVQzFFMzA9gFEaUUoLrC9eRxBU3
         P0lbMMEPuVrHDxNfEcQ8qPe5PjzECv9s7t/HGy57y0Nyo4QyJsjbzEKC02Vt3pNDgI6c
         3+4qubYmDg1q32C2i1RDmgQ6tmqWpeunHMzdWl8Scs9kB4zFk/jo7+ByIOe9DNdcG/UW
         jrww0HZh8+6jEXNxIKPH1OeFFAGhuRDs7nhS/wzmUa5Zu4ZhRUnzPN1njQntb3OQtpx3
         xeGg==
X-Gm-Message-State: AOAM533pkKWilAX9eEwiWiJAVmFJp1VzTeb1xC6TrwHHYFmc6va2eVH3
        o7J0Opk/IqM1YhTAqYpAxKL6GA==
X-Google-Smtp-Source: ABdhPJwPsv7B/cB0f9lf7gE7960SfuDJQhoEcKlSR/LEXNV7lFeDLyxi95gda2GN0VeIwR6MFMcD2w==
X-Received: by 2002:a17:902:b703:b0:158:2667:7447 with SMTP id d3-20020a170902b70300b0015826677447mr12938801pls.92.1654317019242;
        Fri, 03 Jun 2022 21:30:19 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:30:18 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 17/17] perf c2c: Update documentation for new display option 'peer'
Date:   Sat,  4 Jun 2022 12:28:20 +0800
Message-Id: <20220604042820.2270916-18-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604042820.2270916-1-leo.yan@linaro.org>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since the new display option 'peer' is introduced, this patch is to
update the documentation to reflect it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/Documentation/perf-c2c.txt | 31 +++++++++++++++++++++------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 6f69173731aa..f1f7ae6b08d1 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -109,7 +109,9 @@ REPORT OPTIONS
 
 -d::
 --display::
-	Switch to HITM type (rmt, lcl) to display and sort on. Total HITMs as default.
+	Switch to HITM type (rmt, lcl) or peer snooping type (peer) to display
+	and sort on. Total HITMs (tot) as default, except Arm64 uses peer mode
+	as default.
 
 --stitch-lbr::
 	Show callgraph with stitched LBRs, which may have more complete
@@ -174,12 +176,18 @@ For each cacheline in the 1) list we display following data:
   Cacheline
   - cacheline address (hex number)
 
-  Rmt/Lcl Hitm
+  Rmt/Lcl Hitm (Display with HITM types)
   - cacheline percentage of all Remote/Local HITM accesses
 
-  LLC Load Hitm - Total, LclHitm, RmtHitm
+  Peer Snoop (Display with peer type)
+  - cacheline percentage of all peer accesses
+
+  LLC Load Hitm - Total, LclHitm, RmtHitm (For display with HITM types)
   - count of Total/Local/Remote load HITMs
 
+  Load Peer - Total, Local, Remote (For display with peer type)
+  - count of Total/Local/Remote load from peer cache or DRAM
+
   Total records
   - sum of all cachelines accesses
 
@@ -201,16 +209,21 @@ For each cacheline in the 1) list we display following data:
   - count of LLC load accesses, includes LLC hits and LLC HITMs
 
   RMT Load Hit - RmtHit, RmtHitm
-  - count of remote load accesses, includes remote hits and remote HITMs
+  - count of remote load accesses, includes remote hits and remote HITMs;
+    on Arm neoverse cores, RmtHit is used to account remote accesses,
+    includes remote DRAM or any upward cache level in remote node
 
   Load Dram - Lcl, Rmt
   - count of local and remote DRAM accesses
 
 For each offset in the 2) list we display following data:
 
-  HITM - Rmt, Lcl
+  HITM - Rmt, Lcl (Display with HITM types)
   - % of Remote/Local HITM accesses for given offset within cacheline
 
+  Peer Snoop - Rmt, Lcl (Display with peer type)
+  - % of Remote/Local peer accesses for given offset within cacheline
+
   Store Refs - L1 Hit, L1 Miss, N/A
   - % of store accesses that hit L1, missed L1 and N/A (no available) memory
     level for given offset within cacheline
@@ -227,9 +240,12 @@ For each offset in the 2) list we display following data:
   Code address
   - code address responsible for the accesses
 
-  cycles - rmt hitm, lcl hitm, load
+  cycles - rmt hitm, lcl hitm, load (Display with HITM types)
     - sum of cycles for given accesses - Remote/Local HITM and generic load
 
+  cycles - rmt peer, lcl peer, load (Display with peer type)
+    - sum of cycles for given accesses - Remote/Local peer load and generic load
+
   cpu cnt
     - number of cpus that participated on the access
 
@@ -251,7 +267,8 @@ The 'Node' field displays nodes that accesses given cacheline
 offset. Its output comes in 3 flavors:
   - node IDs separated by ','
   - node IDs with stats for each ID, in following format:
-      Node{cpus %hitms %stores}
+      Node{cpus %hitms %stores} (Display with HITM types)
+      Node{cpus %peers %stores} (Display with peer type)
   - node IDs with list of affected CPUs in following format:
       Node{cpu list}
 
-- 
2.25.1

