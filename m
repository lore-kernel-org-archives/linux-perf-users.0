Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81701C677F1
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 Jan 2023 12:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjAPMtq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 Jan 2023 07:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjAPMto (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Jan 2023 07:49:44 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D866A1E5E9
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jan 2023 04:49:37 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bk16so27352580wrb.11
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jan 2023 04:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PCemn0i95mwoh/MU/VK1Wd9F6OgWQRZUEuH/awNPIM8=;
        b=Qxg0NcQqzwZhKCq1V/1nm71+DlVXBOIijj4vE97t6DY9t3fp3H8kMI9Z1nR8snKwyA
         ZN+mpvWayCFJq9mSPeg3txSeB2hkBOeZJGX9DA+XvofbyKp65MZxV4wTrLeOzi6E0ID1
         q5fZ9k1j5Q8N+pP8v2ExKmxRhdgSW+A3LWaJKWwjE4WdCKo8J+MQotIankgRl8vDdx06
         pbv2VRRJ4vIaVyoWwFaYUOwPwnxsUdwNycTjzHP0ZJT1UDFThf0tubQA/WMVIwDOCLTb
         1lr1qulz624xfILIJwQpMF10lbQWnsBWlSz0Ht7vVARnSqlJCVmGha6VuQ0vY9FxPSsJ
         erqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCemn0i95mwoh/MU/VK1Wd9F6OgWQRZUEuH/awNPIM8=;
        b=2BWDsHZGTxnKdUfd7+1lbIQ+G9AqD9OEqo8xEgg14BYzGgMOzVfXFjCm5pfD5JXTis
         PH/V5WWlkm2zCxyqBfycDYHk92VduLjWR19AowZEAND5ZABPplkSjRiDddTiZJweLRxa
         o9GTWDV9auq3Mng4a0ObFl8Kb+E2qi7N1ILvfUTz74b5qfjrP0DkU4Abg8syrqaY7v2G
         Hwx1+aMCKxL+uTsbUsdOy3XClvNlyXAVAJ+9+9w49ND539PBf3g0TTTqjYhEZmhXbtne
         8od1dCR84/vFJCu27rq58YfsAVaw+cLtUG6ebJ9Dw9hvlvjEq+9W6IT46fuDn9u8a4L5
         uzZQ==
X-Gm-Message-State: AFqh2kor1B3CS+6kf/wEuqDIGyIZRwoAXGs8JpEACF2KF+fX/mcgkGx3
        ms2XYttsfPiebSEQ2NErXMbC3A==
X-Google-Smtp-Source: AMrXdXtX6u5D7OWA9FMGFgCq4+u+kHbx8Vp3c75YOf1j5mcStXb/qUYsmuRsX5N9P//OIcLvus4++g==
X-Received: by 2002:a05:6000:1250:b0:2bd:c581:293d with SMTP id j16-20020a056000125000b002bdc581293dmr6984405wrx.15.1673873376462;
        Mon, 16 Jan 2023 04:49:36 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:6c91:710d:9433:e868])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b003dab40f9eafsm6896832wmb.35.2023.01.16.04.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:49:35 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 02/15] coresight: Remove obsolete Trace ID unniqueness checks
Date:   Mon, 16 Jan 2023 12:49:15 +0000
Message-Id: <20230116124928.5440-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230116124928.5440-1-mike.leach@linaro.org>
References: <20230116124928.5440-1-mike.leach@linaro.org>
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
index f3068175ca9d..ce3aa845ecc2 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -112,45 +112,6 @@ struct coresight_device *coresight_get_percpu_sink(int cpu)
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
@@ -459,12 +420,6 @@ static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
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

