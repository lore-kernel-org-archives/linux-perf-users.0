Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1A9C4321E
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Nov 2022 16:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiKAQbn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Nov 2022 12:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiKAQbc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Nov 2022 12:31:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57C01CB26
        for <linux-perf-users@vger.kernel.org>; Tue,  1 Nov 2022 09:31:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h9so20948771wrt.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Nov 2022 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GM5W8kdEVZTdrJaLxSP8hWg1gbfPZ58r3qozGiSOj2M=;
        b=SxPqmxfIyvPOuEndXUQFG+OUFf7gJowHMKLuR43rLJqZMJzPjxWJCbL8bE/XilZt6u
         6OcjOItYooR+Q2TvHWn8iOG0TOznhm5YwJKGEfJuGuWM92s+qjwmDdYep/0sR/01hARH
         k77ELga2o+iLBhcgPLz5FQDVv4DLsVvS+i04iHADLF7Fhna9/c0urtxzzElRtrN5atxI
         diKTnNlY174lxr1n0aCGRLhts1ZUoTTsgQ3KfDI/iVWLKesoS1sjrLg/wfNiINooyk2A
         EFvbRZPbQY+OETVwXNJ3MAbquUr6loK4yFJLVh+6ocClsDMRcQr+YHwhiTfwbrBKTJJQ
         L4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GM5W8kdEVZTdrJaLxSP8hWg1gbfPZ58r3qozGiSOj2M=;
        b=B9Z+ISF2qQVMEAotrN1uUehw0q8YQl+SyJ7Lh7j4Dxp680GxXJ0Nmk7X/nyVIb2ye2
         Gg4HgIBkteTbgwFK3TWEEBixWcrwqFENHzWnuOI8FY9/5iXNLoaYRV0giiq7FLnE9pqf
         BrY40/SBPzSOw+oapLIZWLEiyd+WNW4JP5c0C0nO7GNSn/u/sNwTsfXL2wGNXBuWHoCO
         NJ0xiWVsMdrRlmNVyikw6qgD0lZko6l+v14gaoF1n+5RQgNJ6zQqXRKFNuR5E6TvunBw
         eGc2W0Y7QTWe1VF24Z7K5Hd14DGYw8SJDOpXW1NY1fVtryzJm/9qWPduA4can7N7VwX3
         EABQ==
X-Gm-Message-State: ACrzQf0y8WsWF5Lme5sZN7NCK3f3QB9sZO7UJJHvJFWWttCf6nsSrFJf
        jV91iXoJlBeOdJ9OkJYIQd+tGg==
X-Google-Smtp-Source: AMsMyM52kTyY2RnZxPGxRTLot7eIkG3eHfeIhr7G9iQxfhQaC2JfM90ZbCC99T+2gAx1zv6joxmHVg==
X-Received: by 2002:a5d:484f:0:b0:236:9c97:6f85 with SMTP id n15-20020a5d484f000000b002369c976f85mr12476548wrs.636.1667320290279;
        Tue, 01 Nov 2022 09:31:30 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:e844:18b6:fc5:bbc9])
        by smtp.gmail.com with ESMTPSA id bu15-20020a056000078f00b0022ac1be009esm8339844wrb.16.2022.11.01.09.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:31:29 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 08/14] coresight: trace id: Remove legacy get trace ID function.
Date:   Tue,  1 Nov 2022 16:30:57 +0000
Message-Id: <20221101163103.17921-9-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221101163103.17921-1-mike.leach@linaro.org>
References: <20221101163103.17921-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Removes legacy coresight_get_trace_id() function now its use has been
removed from the ETM code.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 include/linux/coresight-pmu.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index ffff4e6277e5..624f4843453e 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -8,7 +8,6 @@
 #define _LINUX_CORESIGHT_PMU_H
 
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
-#define CORESIGHT_ETM_PMU_SEED  0x10
 
 /*
  * The legacy Trace ID system based on fixed calculation from the cpu
@@ -44,15 +43,4 @@
 #define ETM4_CFG_BIT_RETSTK	12
 #define ETM4_CFG_BIT_VMID_OPT	15
 
-static inline int coresight_get_trace_id(int cpu)
-{
-	/*
-	 * A trace ID of value 0 is invalid, so let's start at some
-	 * random value that fits in 7 bits and go from there.  Since
-	 * the common convention is to have data trace IDs be I(N) + 1,
-	 * set instruction trace IDs as a function of the CPU number.
-	 */
-	return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
-}
-
 #endif
-- 
2.17.1

