Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DCEC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Apr 2022 15:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240823AbiD0Pyw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Apr 2022 11:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240733AbiD0Pys (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Apr 2022 11:54:48 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7C4554A8
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Apr 2022 08:51:31 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id r9so1830274pjo.5
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Apr 2022 08:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88bbCk2ERYh6ocqftQtDENMk2Clg/XqHfHpE0jpLddU=;
        b=s83lkLksIUw8ngM7Tyq59eA4QD43e/DNUuirs4yzjdEUPGyJd9J1EPuqIZYpEm/E2a
         /35yDMvpNeOSfLpENywPsTdCITlb5EYJlaER73sUmG/2V63kr9N6OA1w7atZdNpgEIOG
         nPcP7Ui8oeioiaoqkPQuE1qBwXwluoQLP1WxPXG6vbkTMSErVqFHBYbRO+vK4KTWq7Ob
         SKnuMAJX+SsD2vj+uMk/ew2OTxkGItXFlzbXBOIu2RqrrJ8r9iECZHgDyMYsdLsBF49b
         f0ohV4mcDTiOIIrnlFkOHV+015HCNvPJXPIjrKOgrooM8hn9B0USG41fDXP2m0KpFvyq
         hsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88bbCk2ERYh6ocqftQtDENMk2Clg/XqHfHpE0jpLddU=;
        b=ag8Cdlo8JJtkKijBzXg/OB7CLdyemdVosvAqKDWU2wEQRjT+XfkepmwIfW8CF5rZQE
         8yC/GxtDVvm/XIipTirOWyo03VkA7N/8NVodw5HCFhsSa2JCus0BHXhRfz4fGbMBaX1B
         /u01jjYkZGLg/qbxYvdsRodwh8uc5+I8CNXX8TYEOF+JunW5eLcCf87E8BrJhl+TRAPk
         IKcsEcVBLnJw+DhOT16gz7XpzdsLEoJYME+sRdmlAmK+SBYiNR7Sd2u5UcQg8/wB9ur5
         +K4rLSfKzbcqK/TRL69w7iRP1k9E39JAeRqisEdUzKihAWBfDKVThc1RMAiEwx8Vl79r
         GINg==
X-Gm-Message-State: AOAM5323Tu4Q4kmUFoqTnVYjPE8jWCdZlRr0gvT/bexykwifbOxbKiTC
        kJB0mJvlyc1SbxXuSrvwVTSbyg==
X-Google-Smtp-Source: ABdhPJwYE1C1HRFhiAteWQw5NTe3sYOsMFFZ2w/7k6RfFUYNlXJpoH4zgI18iSg0W8q4Yw/eEx1ewA==
X-Received: by 2002:a17:90b:3145:b0:1d9:ab18:910e with SMTP id ip5-20020a17090b314500b001d9ab18910emr10949105pjb.57.1651074690736;
        Wed, 27 Apr 2022 08:51:30 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id v65-20020a626144000000b0050a839e490bsm19164127pfb.185.2022.04.27.08.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:51:30 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>, Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Ali Saidi <alisaidi@amazon.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 10/11] perf c2c: Update documentation for new display option 'peer'
Date:   Wed, 27 Apr 2022 23:50:12 +0800
Message-Id: <20220427155013.1833222-11-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427155013.1833222-1-leo.yan@linaro.org>
References: <20220427155013.1833222-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since the new display option 'peer' is introduced, this patch is to
update the documentation to reflect it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/Documentation/perf-c2c.txt | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index b39e3f3df272..aa560ce1a192 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -109,7 +109,8 @@ REPORT OPTIONS
 
 -d::
 --display::
-	Switch to HITM type (rmt, lcl) to display and sort on. Total HITMs as default.
+	Switch to HITM type (rmt, lcl) or peer snooping type (peer) to display
+	and sort on. Total HITMs (tot) as default.
 
 --stitch-lbr::
 	Show callgraph with stitched LBRs, which may have more complete
@@ -174,12 +175,18 @@ For each cacheline in the 1) list we display following data:
   Cacheline
   - cacheline address (hex number)
 
-  Rmt/Lcl Hitm
+  Rmt/Lcl Hitm (For display with HITM types)
   - cacheline percentage of all Remote/Local HITM accesses
 
+  Snoop Peer (For display with peer type)
+  - cacheline percentage of peer access
+
   LLC Load Hitm - Total, LclHitm, RmtHitm
   - count of Total/Local/Remote load HITMs
 
+  Snoop Peer
+  - count of peer access
+
   Total records
   - sum of all cachelines accesses
 
@@ -211,6 +218,9 @@ For each offset in the 2) list we display following data:
   HITM - Rmt, Lcl
   - % of Remote/Local HITM accesses for given offset within cacheline
 
+  Snoop Peer
+  - % of peer accesses for given offset within cacheline
+
   Store Refs - L1 Hit, L1 Miss, Any Lvl
   - % of store accesses that hit L1, missed L1 and any cache level for given
     offset within cacheline
@@ -227,8 +237,9 @@ For each offset in the 2) list we display following data:
   Code address
   - code address responsible for the accesses
 
-  cycles - rmt hitm, lcl hitm, load
-    - sum of cycles for given accesses - Remote/Local HITM and generic load
+  cycles - rmt hitm, lcl hitm, load, peer
+    - sum of cycles for given accesses - Remote/Local HITM, generic load and
+      peer access
 
   cpu cnt
     - number of cpus that participated on the access
@@ -251,7 +262,8 @@ The 'Node' field displays nodes that accesses given cacheline
 offset. Its output comes in 3 flavors:
   - node IDs separated by ','
   - node IDs with stats for each ID, in following format:
-      Node{cpus %hitms %stores}
+      Node{cpus %hitms %stores} (For display with HITM types)
+      Node{cpus %peers %stores} (For display with "peer" type)
   - node IDs with list of affected CPUs in following format:
       Node{cpu list}
 
-- 
2.25.1

