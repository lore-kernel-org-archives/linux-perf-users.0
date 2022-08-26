Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E40ECAAA3
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Aug 2022 06:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244493AbiHZGGJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Aug 2022 02:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244950AbiHZGGG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Aug 2022 02:06:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E04F5C96D
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Aug 2022 23:06:05 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id r15-20020a17090a1bcf00b001fabf42a11cso588472pjr.3
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Aug 2022 23:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=VXo2//TDP+/ELV3UW1U6JUD/1LVXb50gfq3HIYQkvt4=;
        b=voAi8tuq7u9AyLAzIWKQVgyqkE9QFwN3FGESj+AUoBS+uAHIvayWoaN0StWADnMpwd
         PcWLGNdwCLV0VPf8/LkgE+1Oisc8mpYoERQKGGdRRPgYGlgkMBJqjs9vlgS7sCkrIHyl
         E6qpvqOgQb8if2AdsrtoKAYd5N3EHHW7Sq9YdVi0HFxETVPrQB/59G/6IDdfl+UM3IeA
         H9mrJqhH+ih3BchON1qn5+/FA1KtmtsE1v4HLlaXVaDukEXxpEdyjPJJ9KM7kGPW/dOs
         bU14CF9tm8pGSSksMcb0e0eDMZgYfy2btPU451mBxSNYXdNKEnWbr+xHWol8rHvnhEqd
         AnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=VXo2//TDP+/ELV3UW1U6JUD/1LVXb50gfq3HIYQkvt4=;
        b=CWqXkl3XzJ4vwLVSUlK6X3yV3x9rU486abnaDasVnbKiqstCYK+PtlWtj83+wonWnD
         a0SbIrfDyacY97M6Z0THCJm+vdQXKP2SBmLqpI/1N+eHvdBX/Ia6Qs/K5XMC4Jwcnsr+
         5PUmH/XbQ0UKvtmOqhgMrO9nxxZD+Ec/peNIrxosNYfl9foSeaJb+/KW9yFfGDExR2mH
         CnJyJdgLh+FmrlLOL2UytWFI3BL+Q9EYn2R/ErjUOVEgmVG6tEra/C4YOiWi0GLgQb3O
         xx0esF3vzPV/JUzmWAuTxWM4rxZ5EQk4V52PQgYybRVgpzKP2EtL9oHNkuH0d1/IgLLj
         +f5w==
X-Gm-Message-State: ACgBeo24gdOYfqAAs0DLwpXg/7VQ5BkAD8+kCEHgZCABdnpvxNosqtnD
        aQDBz59wbzsB5dKhdBE38x9gXg==
X-Google-Smtp-Source: AA6agR7ZKiL45YiejpzMG9FwieAWnnXLWMY1ju0WMQfyFJw1VO/w0kRRLN+eP5oDi1hffzpK1aReLQ==
X-Received: by 2002:a17:90b:4d8f:b0:1fc:314a:17e8 with SMTP id oj15-20020a17090b4d8f00b001fc314a17e8mr2855044pjb.152.1661493964469;
        Thu, 25 Aug 2022 23:06:04 -0700 (PDT)
Received: from localhost (n058152048222.netvigator.com. [58.152.48.222])
        by smtp.gmail.com with ESMTPSA id bb5-20020a170902bc8500b0016db7f49cc2sm625338plb.115.2022.08.25.23.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 23:06:03 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ali Saidi <alisaidi@amazon.com>, Leo Yan <leo.yan@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH v7] perf: Add SNOOP_PEER flag to perf mem data struct
Date:   Fri, 26 Aug 2022 14:05:56 +0800
Message-Id: <20220826060556.176681-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Ali Saidi <alisaidi@amazon.com>

Add a flag to the perf mem data struct to signal that a request caused a
cache-to-cache transfer of a line from a peer of the requestor and
wasn't sourced from a lower cache level.  The line being moved from one
peer cache to another has latency and performance implications. On Arm64
Neoverse systems the data source can indicate a cache-to-cache transfer
but not if the line is dirty or clean, so instead of overloading HITM
define a new flag that indicates this type of transfer.

Update notes:

This patch is to sync the headers between kernel and user space, commit
2e21bcf0514a ("perf tools: Sync addition of PERF_MEM_SNOOPX_PEER") for
updating kernel header has been merged in the mainline code.

Signed-off-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---

Changes from v6:
Added Leo's SoB.

 include/uapi/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 03b370062741..581ed4bdc062 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1313,7 +1313,7 @@ union perf_mem_data_src {
 #define PERF_MEM_SNOOP_SHIFT	19
 
 #define PERF_MEM_SNOOPX_FWD	0x01 /* forward */
-/* 1 free */
+#define PERF_MEM_SNOOPX_PEER	0x02 /* xfer from peer */
 #define PERF_MEM_SNOOPX_SHIFT  38
 
 /* locked instruction */
-- 
2.34.1

