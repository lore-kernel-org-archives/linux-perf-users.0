Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D0BC4332F
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Nov 2022 16:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiKAQbo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Nov 2022 12:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiKAQbf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Nov 2022 12:31:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D40A1CFDB
        for <linux-perf-users@vger.kernel.org>; Tue,  1 Nov 2022 09:31:35 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so10226676wmq.4
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Nov 2022 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/rZtCQJIH1tcdWsQUgVvKDosjDAE+Gq7OIwmjNOiDI=;
        b=obRRjsLUzj/9fSS9Ir2oWyllMpjsDNqARAhKoqpMrwQ6CoYPS++qDEkHEIMH8F7/xS
         f+QlD9OHiyvr3q2A+Kr1KlvLOe71vneqkDZ/6KksiuiXPuTWoPwfp0p4FTBdjbY9JK0z
         hCfj+zKEZ6qFNcilBOvhmSrun5HELIFnM2abmw+66O96lPuzMvJNyD82gDOuIsAp/T6C
         JkHqJ0tRh2Lc47sHosftOP2918io6TPIT3oueICQKzVU4h5peJ6BfVZOxM4yzavYfT6/
         omoJS7GFHRXhenMTNLp8bYgtxymMJYVSOlF9R7kc1Xb6FaZgyNl9OCZ7sD5UQWSaAaw3
         rT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/rZtCQJIH1tcdWsQUgVvKDosjDAE+Gq7OIwmjNOiDI=;
        b=YTF8dQgiTM6kptNDpBehLHhPm7pAh60gLimS4Dp2LBry3c2g52hW0SutKD7WOcimnH
         H9pEWxKy0EIAvIZlEHRWcmVAwTpozjA78UZfDQATntz5jeLRiToy+xEUUKkFfmdE9lOy
         Asf/1VOkhey12z9oAA8BbpNVbtA/7sbuNRFC8phh95JCzEyPLowPSvScAwotJwPRKOhG
         3FwN0B+ghh2SAt1GaGGqDty7uJo5ZiMfVn+g/hH2jWbaJcTLI2rMOckbqJPQ/tMFPn9k
         J6Qb7JsVJs6wRGD94eiWGMhM5Yhhd7Z9TAjnymbOGK3TDVROqoafKuewJqQ5u3ml/mK2
         wuzA==
X-Gm-Message-State: ACrzQf2u0UqJbz/u0nUQGSs/ERe3k7av0dCi/4SToHVqRnBGlCFDRMHt
        17v02cNCAOJJZWBl6nIbCpxJWw==
X-Google-Smtp-Source: AMsMyM6IU2ns6NLnyGvlHGiTa9VHUODxQoTiE+yXYHZwqyNMR484p4jVR+dqMo3bW7TOYVgWwkzPIg==
X-Received: by 2002:a1c:448b:0:b0:3cf:6fcd:e171 with SMTP id r133-20020a1c448b000000b003cf6fcde171mr8659097wma.163.1667320293696;
        Tue, 01 Nov 2022 09:31:33 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:e844:18b6:fc5:bbc9])
        by smtp.gmail.com with ESMTPSA id bu15-20020a056000078f00b0022ac1be009esm8339844wrb.16.2022.11.01.09.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:31:33 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 11/14] kernel: events: Export perf_report_aux_output_id()
Date:   Tue,  1 Nov 2022 16:31:00 +0000
Message-Id: <20221101163103.17921-12-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221101163103.17921-1-mike.leach@linaro.org>
References: <20221101163103.17921-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

CoreSight trace being updated to use the perf_report_aux_output_id()
in a similar way to intel-pt.

This function in needs export visibility to allow it to be called from
kernel loadable modules, which CoreSight may configured to be built as.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4ec3717003d5..ad388552f1d5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9231,6 +9231,7 @@ void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
 
 	perf_output_end(&handle);
 }
+EXPORT_SYMBOL_GPL(perf_report_aux_output_id);
 
 static int
 __perf_event_account_interrupt(struct perf_event *event, int throttle)
-- 
2.17.1

