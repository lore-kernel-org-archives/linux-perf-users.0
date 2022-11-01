Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C2BC4321E
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Nov 2022 16:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiKAQbe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Nov 2022 12:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiKAQb2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Nov 2022 12:31:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3431CFE1
        for <linux-perf-users@vger.kernel.org>; Tue,  1 Nov 2022 09:31:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a14so20894816wru.5
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Nov 2022 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5MdleZXvt+JyHILxZIr8nt6Rc30u8pB2zD6TyZEOZ4E=;
        b=N0OHoOCfoadYHDve9A10mdduXwDqxckCMBXiPMJkrQLef+eysdKmGp4/vghZIe6ts5
         RlaYTAUndyvkgq6ziXZryvLpbUbZE0lyW/8Gj8n1sLV2ZKKVpSbFlR464jusNnUk+qsP
         U6Ig1UJvGX74Eq/KxUFdJO48PqCtqAGHkH7oQU9+5ocuFdkxGVTgWndwIS4fvh60r0vC
         mMQ7nFtRlksH0XF5JDnRlPJesa5boH7ytuNNYo7ugu4Qq7GIUjp/zAB48IU0B6G+VCIw
         yv5W6gOPpJKVMlBfo+uaBR5KA3j71cIO47kulqokHpqSqrA07kMTrDkOgb+cwcZPGDql
         SEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MdleZXvt+JyHILxZIr8nt6Rc30u8pB2zD6TyZEOZ4E=;
        b=YUu0bx6jAGklthK2OvUuv9FgC/dvk616g0vez32eigTQi0ay0Nuh2XFXnBAbeuZQ4P
         9oh5q+8V0BI0OaknJ9rc6OL8k98jqvTYatx+d77ea+Ia6MxHX8gaE0rLqitD5PF7RKsB
         9tFZFMmhIAXOF8IIrbUS8h2Ue9hY8D18dCtog0zDoAENt4BjnRmlX2Fv8F/95qxAVXeS
         WwiWlHp4ki2oRql5zeWRUMfbRwS9TobAydbkigA1mVNvZBEvz42z57vNjALoif2ahSEA
         jvY9vl3CDcDG0wrEMIbi9q5wYseaiKkuItVr1It66EX1BJwdKiVGRY1i85tNccn5UMbn
         /0Cg==
X-Gm-Message-State: ACrzQf30iPElhqXZoV1zZaXtLK1lpxjSI4jGBu9V1S+rm3m568BSTFoF
        FuV4CX9lmFK/zvgMn8V9b2w082nZ/s/gMQ==
X-Google-Smtp-Source: AMsMyM6rZBY+SRuvU6afB3H/N607It4scVT7TDau8qicMc11AO4dH+gwLsmVyLpvWDm+RkYOsw0I/g==
X-Received: by 2002:adf:f4c7:0:b0:236:c415:c707 with SMTP id h7-20020adff4c7000000b00236c415c707mr8974540wrp.24.1667320283203;
        Tue, 01 Nov 2022 09:31:23 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:e844:18b6:fc5:bbc9])
        by smtp.gmail.com with ESMTPSA id bu15-20020a056000078f00b0022ac1be009esm8339844wrb.16.2022.11.01.09.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:31:22 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 02/14] coresight: Remove obsolete Trace ID unniqueness checks
Date:   Tue,  1 Nov 2022 16:30:51 +0000
Message-Id: <20221101163103.17921-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221101163103.17921-1-mike.leach@linaro.org>
References: <20221101163103.17921-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The checks for sources to have unique IDs has been removed - this is now
guaranteed by the ID allocation mechanisms, and inappropriate where
multiple ID maps are in use in larger systems

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 45 --------------------
 1 file changed, 45 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 554a18039e10..45828564f0c8 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -113,45 +113,6 @@ struct coresight_device *coresight_get_percpu_sink(int cpu)
 }
 EXPORT_SYMBOL_GPL(coresight_get_percpu_sink);
 
-static int coresight_id_match(struct device *dev, void *data)
-{
-	int trace_id, i_trace_id;
-	struct coresight_device *csdev, *i_csdev;
-
-	csdev = data;
-	i_csdev = to_coresight_device(dev);
-
-	/*
-	 * No need to care about oneself and components that are not
-	 * sources or not enabled
-	 */
-	if (i_csdev == csdev || !i_csdev->enable ||
-	    i_csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
-		return 0;
-
-	/* Get the source ID for both components */
-	trace_id = source_ops(csdev)->trace_id(csdev);
-	i_trace_id = source_ops(i_csdev)->trace_id(i_csdev);
-
-	/* All you need is one */
-	if (trace_id == i_trace_id)
-		return 1;
-
-	return 0;
-}
-
-static int coresight_source_is_unique(struct coresight_device *csdev)
-{
-	int trace_id = source_ops(csdev)->trace_id(csdev);
-
-	/* this shouldn't happen */
-	if (trace_id < 0)
-		return 0;
-
-	return !bus_for_each_dev(&coresight_bustype, NULL,
-				 csdev, coresight_id_match);
-}
-
 static int coresight_find_link_inport(struct coresight_device *csdev,
 				      struct coresight_device *parent)
 {
@@ -460,12 +421,6 @@ static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
 {
 	int ret;
 
-	if (!coresight_source_is_unique(csdev)) {
-		dev_warn(&csdev->dev, "traceID %d not unique\n",
-			 source_ops(csdev)->trace_id(csdev));
-		return -EINVAL;
-	}
-
 	if (!csdev->enable) {
 		if (source_ops(csdev)->enable) {
 			ret = coresight_control_assoc_ectdev(csdev, true);
-- 
2.17.1

