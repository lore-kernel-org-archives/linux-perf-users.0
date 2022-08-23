Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59E5C32796
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Aug 2022 10:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355788AbiHWKoZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356660AbiHWKmt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Aug 2022 06:42:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32AEAA4E1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 02:10:17 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r83-20020a1c4456000000b003a5cb389944so9174280wma.4
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 02:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=DeGX8nF0J+NtV1pTcJJ/EmsZLaXqQa78Qzzsccc5Pfw=;
        b=TkCnT5TT/j1+VD+ja7Ce6+jps9TFVDUcjUPFgi3QD5qNTd4UtGD7kx5dQMNalf8H7Z
         HcKh9q8cerh1KGRJEUIugPs3/+rnZXiJPfFPiaEBqoGYUfGZWtd3q1D/Sa1Urr7coyXn
         7ptKIPuQMAqPxfH6dNNWaFvFmOXj6SmqxlsVZv9vOBZ8nSiZVGlRxitu8k1wfbbd7Cc9
         pbcOl4PyxZxLfCxj858Zf2bO5hPE5yHul438XbuiqQ6ue+mGGVEUmEnm9PrKuo5jM1h6
         Iz193k+0UpI4TRCP29J5JEUS5yUN0LIfpJvF1kCmgaMnVNvjYQ0/GZMvsOLj1DUypnqQ
         XOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=DeGX8nF0J+NtV1pTcJJ/EmsZLaXqQa78Qzzsccc5Pfw=;
        b=ozjJWLyB6T77gf3ZvV6nRcBxvjSebk6bWvRMw8YUdZNpR6yWdH6W4r2XECNZ1YNl0y
         SbutKN3WmvMvkI/AIO+TEMmZJfjHyYfJf/Ft9b5AFkWgNeGndYbb+laJ4BLR+ce04V3T
         zGwvYjpylWuTd3IWENWxAmWKob5Ude9C6fY1P1qNDV+4tlUc03MV0chRac+2Ysjt6gak
         L0/aZtK6+tjAE0P69Vmo2UahULrFWS8W/dEu+rmuR+1Sc9BUqnQCxE7A6ARz/JmOn9lK
         RF9KfA8mpk8xYduGevwtD+np+V+qs7ePi7vml04grcYUxaax4qzm5cjzURducOAJn4+G
         m5sQ==
X-Gm-Message-State: ACgBeo1Y5uwTQr4yKUKI8ectwDPDbRrfPpMoBY/bEzknlah69Ero2+YY
        FCw8F6zqvj2GEOJqOPVJcJv9yw==
X-Google-Smtp-Source: AA6agR6Y5XJoqHuf1SW5JDiawMpiIHPzX/sjuPfTe/y8hUpqflUeXG2hO8snD1W2tHdoOOM7kcbiLg==
X-Received: by 2002:a05:600c:3b9f:b0:3a5:45d9:8a69 with SMTP id n31-20020a05600c3b9f00b003a545d98a69mr1506230wms.186.1661245815809;
        Tue, 23 Aug 2022 02:10:15 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:4553:cf11:6cff:b293])
        by smtp.gmail.com with ESMTPSA id w6-20020adfde86000000b002253d162491sm10760721wrl.52.2022.08.23.02.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 02:10:15 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 02/13] coresight: Remove obsolete Trace ID unniqueness checks
Date:   Tue, 23 Aug 2022 10:09:58 +0100
Message-Id: <20220823091009.14121-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220823091009.14121-1-mike.leach@linaro.org>
References: <20220823091009.14121-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The checks for sources to have unique IDs has been removed - this is now
guaranteed by the ID allocation mechanisms, and inappropriate where
multiple ID maps are in use in larger systems

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 45 --------------------
 1 file changed, 45 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index c7b7c518a0a3..cde1b4704727 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -85,45 +85,6 @@ struct coresight_device *coresight_get_percpu_sink(int cpu)
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
@@ -432,12 +393,6 @@ static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
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

