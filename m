Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C290AC433B4
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 07:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A0D61353
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 07:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbhESHVP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 May 2021 03:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239635AbhESHVN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 May 2021 03:21:13 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFBBC061760
        for <linux-perf-users@vger.kernel.org>; Wed, 19 May 2021 00:19:54 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 6so8810449pgk.5
        for <linux-perf-users@vger.kernel.org>; Wed, 19 May 2021 00:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VF7HOk9FnOo7p3niyuc/ZeydcOUyPtyVd5u7rDmQFT0=;
        b=EM5liwyzntU9Cj0R9VZ/vTntNwcOgx+IqSmnrR+4qu+Wk0p0ypqYuTODL2r5OW+9jq
         FiHKDrnpQ2Nv5WEbqX7D8qHVtUg7h0qQRT7ja4Or4opgEGILz6r1Ih1tSn12ORGd3tjP
         mNVBoF4yHFUcANpACuFQXyA6jafxUCIpMPrNXBr8+alRZymbhzvD9gzGswmajl7qDhwG
         dIXe5+nLkP5ej/gxj08Nnl+oEayMo/dg0ZCDrqQyTksVlb/RudCXIztuNU+SUcFe12uX
         D6dueLH6R+wV8lCI93Z0nxFTWM5UMYEdvR5NdW4bc4GdhmQqeuSmoWy75TnB25WsD+C2
         o/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VF7HOk9FnOo7p3niyuc/ZeydcOUyPtyVd5u7rDmQFT0=;
        b=Bh488q8kZ6bcwNBvs5j+qbnjqW5ocdJstcV6VVMl/sfKGgLhqQd/p/lkwHaXCg6UEO
         HAk2J4u65NfC2dR9Ef8ORhIiClYDXyFx1tHUod1HtZgUvxHizu4Wr7844PKfdZpXYfMJ
         pcghAMn4C7086QQmr7FjHesO5MzLsG6G49jK6hDMWcym29iVfHFKgrCxxnHliwaYT5XA
         Nns/Znxh5Rb4WWFtCWtZww4viHYBytG7ONVi9xna+ElyUgK2ashbaV17bP9xpAEAPvcA
         RXcceqc8gyNoo1GHJsd2v6kmi7nRFWEvLzveL2u18XKscH1aBeu+a3EsFuSRgBYy1Xu7
         7ccQ==
X-Gm-Message-State: AOAM533GMgIDrnIqjJ4t1SzIyg2AQ8+MbQpBf6wBrcmBBnSGrmA0kY86
        Wq2TwmxL+dxjmsnMeZO9jF8fDA==
X-Google-Smtp-Source: ABdhPJyWwwksCQZO2Hl+jN5SqYaQRszYdtaCccXCpevrwOSiRCdoiwIkINF5nLlC1dZqjTyS6nd9hQ==
X-Received: by 2002:a63:2218:: with SMTP id i24mr9373392pgi.335.1621408793596;
        Wed, 19 May 2021 00:19:53 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id 14sm13469638pfj.29.2021.05.19.00.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 00:19:53 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 2/5] perf arm-spe: Convert event kernel time to counter value
Date:   Wed, 19 May 2021 15:19:36 +0800
Message-Id: <20210519071939.1598923-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519071939.1598923-1-leo.yan@linaro.org>
References: <20210519071939.1598923-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When handle a perf event, Arm SPE decoder needs to decide if this perf
event is earlier or later than the samples from Arm SPE trace data; to
do comparision, it needs to use the same unit for the time.

This patch converts the event kernel time to arch timer's counter value,
thus it can be used to compare with counter value contained in Arm SPE
Timestamp packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index d2ae5a5c13ee..ff8b52e6d475 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -669,7 +669,7 @@ static int arm_spe_process_event(struct perf_session *session,
 	}
 
 	if (sample->time && (sample->time != (u64) -1))
-		timestamp = sample->time;
+		timestamp = perf_time_to_tsc(sample->time, &spe->tc);
 	else
 		timestamp = 0;
 
-- 
2.25.1

