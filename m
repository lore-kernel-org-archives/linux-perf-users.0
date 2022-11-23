Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9094FC4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Nov 2022 19:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbiKWTux (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Nov 2022 14:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238764AbiKWTuj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Nov 2022 14:50:39 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC45A93CDD
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 11:50:30 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id n3so14458360wrp.5
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 11:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UhRbA3Bqp5wzwk6l8nkMnlzM8NPWC0TqClYGwAsB7GE=;
        b=cZryXwPDfXWRdMGvqWJnGJRO7WwwLZ6mD2mcnPZr4X+qr6c/03itTmlsif+1sMK+0K
         +ymWQPWywcwdB2f0aGlNCRz3Vusw4tGDHnDQQlsqeziN0XCQSGVQ+T8yVSmRMbav/zYH
         jQp+Qc76B6SMBtg0oIFWcjRcaXNmKnQgif7N4Bhlg0aHUqo68nX7JLJK11PLJff4iHob
         x25BYSba4DwDQzRv0agSGZJcTa4PLQSxIpkUO3wznX5VBLf6oInRPJFsr7woJuPA3ags
         2/JR8mD11FabTwv8yMheCmZlrfgEKZGpPL5EroRGf0e89KxRaK9tQw7D844ieOO7Bcza
         A70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhRbA3Bqp5wzwk6l8nkMnlzM8NPWC0TqClYGwAsB7GE=;
        b=BpIjSvyNfbIJoRcbiPgpff5H++O/G46MmUbyVVEEjvsz4/NMJNnC5C7QKlFMKwAnwY
         pA++t+rG8Yn/mXqHN6BRUoKLBJsc1EsdhUpsGVJTr2HpssbCtZiiRthySH7T3QFDgjzQ
         UlQEXoqQqxcpNcxp081WUvW4ugBVhpyS8acVzlxN+UCsbYszsnLYKhJQXqMgUFedhKFR
         EWFCnexy3QWdRdy/DkFejerOzWlRThLVF0ByjVwRj+beP/cN3frLY9lAa6FtZbDm/DtD
         69wJmc4IgMMdRaxFnKXiE0mk+Aa3p095aKZyT99KQ1GwU7FR8JoWGUsgd/Lqsuku06Ok
         VKkw==
X-Gm-Message-State: ANoB5plSquUKaBjRMZLmtpBDnO9aHVSkamhKOv5zUyTDx6DW3M1Czxdh
        vEJEMrTmTh4OLDYaiElvNmLE0A==
X-Google-Smtp-Source: AA0mqf6KKEFVkffTxpaEdfZ0VXAsXtwCJbKntviKH0lMQ0dqFVgelLlQ7xjR+ByXKNG3AkjD+j1JnQ==
X-Received: by 2002:a05:6000:691:b0:241:b92b:d086 with SMTP id bo17-20020a056000069100b00241b92bd086mr18360854wrb.259.1669233029527;
        Wed, 23 Nov 2022 11:50:29 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:fcbc:7b5d:8d6c:43a4])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b002364c77bcacsm7267414wru.38.2022.11.23.11.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:50:29 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 08/14] coresight: trace id: Remove legacy get trace ID function.
Date:   Wed, 23 Nov 2022 19:50:04 +0000
Message-Id: <20221123195010.6859-9-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221123195010.6859-1-mike.leach@linaro.org>
References: <20221123195010.6859-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Removes legacy coresight_get_trace_id() function now its use has been
removed from the ETM code.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
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

