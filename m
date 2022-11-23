Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8A4C43219
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Nov 2022 19:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbiKWTve (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Nov 2022 14:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239178AbiKWTuv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Nov 2022 14:50:51 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F47A314F
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 11:50:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id x17so17558853wrn.6
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 11:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/rZtCQJIH1tcdWsQUgVvKDosjDAE+Gq7OIwmjNOiDI=;
        b=Y0wzeg/9IEcrSrRDjm7ewn/WmRVLl9UfqDflyrgJ9IvuIAkyBU71uuBK++bvGEkdBS
         cBKsQM9HBAjhqCRA05xgQhQfmSaQ32g/6tLlrugADv7VQQ1B46VcGwY1VGRZ+0XePHqo
         tUU2qNaUxoTJVRD3r3y7Kx+lb35dMY7UBYvUrG6J+YOzEomA//1xxqz6gdk2bxBUkihB
         RgRMCwsDeT8HCDqK0TuLt5kJTl9bI0/b/eG5k+FzAfSz5IyYKGZU3qDb8UP/0FcAa1aS
         stE219YI2e8ekdnspHR7Xns+ih/fw88y9ATSKPvblGnWdf405TqixObxDC4Fs9o7Ywv1
         nY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/rZtCQJIH1tcdWsQUgVvKDosjDAE+Gq7OIwmjNOiDI=;
        b=7ekNAzj25CBJohAwaq7ukENKBf3o/p8WmMBNTfEcurHAFFGx/iWbWSiQR3KXm1JzI4
         6W2cSSNCEb9QETfTkGWKndOSCrl0fnOJ9HjEsZqPLGJg6sqLnnE79vZ/mjcfyaCBkHDL
         2C8fADHmm62/KDnIvS/uYQpEHr550OtpZPMMUOY9rlSaNMHP5ELzNzK6fa3SjH0in7w6
         HfRTrSKHvFhnhNLrS+FfhUWAaOJHeHGBrsAk+CV+lawv+v2kNS77q3MWmaQ/BFQyrd6B
         Q5nUVAY3CdPiHml2UVkQZ3LoxCToE48k2MJQWRc1Q7ashRse0BzU5PyOjEfhwdLex2RC
         j7KA==
X-Gm-Message-State: ANoB5pmj/CiBACnIZcLZA3/dyg3gUeNJUe4d7f95wUwLDDt5kw9r6xnK
        Ldu1IJWi6Jaz8yg0Dzh2m7j3Eg==
X-Google-Smtp-Source: AA0mqf5Ymr48oHJexOSABWqRTfaBxwQ6JYV5duyinhabrT6UzI2CSiqCwawpQ+QIa/NWw32+bwWSJg==
X-Received: by 2002:adf:f805:0:b0:236:ef0b:68c5 with SMTP id s5-20020adff805000000b00236ef0b68c5mr18911996wrp.373.1669233032908;
        Wed, 23 Nov 2022 11:50:32 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:fcbc:7b5d:8d6c:43a4])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b002364c77bcacsm7267414wru.38.2022.11.23.11.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:50:32 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 11/14] kernel: events: Export perf_report_aux_output_id()
Date:   Wed, 23 Nov 2022 19:50:07 +0000
Message-Id: <20221123195010.6859-12-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221123195010.6859-1-mike.leach@linaro.org>
References: <20221123195010.6859-1-mike.leach@linaro.org>
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

