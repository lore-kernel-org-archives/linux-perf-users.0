Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5722AC43219
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Nov 2022 19:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbiKWTui (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Nov 2022 14:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236675AbiKWTu1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Nov 2022 14:50:27 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3726712D
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 11:50:26 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso2047085wms.4
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 11:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Msiba57uIoQyW0yBXGfGPLCUUWKUrx8bYCzahjs4eQE=;
        b=MXB1jGCmfUHw4ekjpgzWiJDLBOFelfcfIsTgcjt+m3SaajVC2QvoRCKxX+QxtleoDH
         iUc0VocvdnIItR0SvDD6Y7HCNSrAUXvSJNrcpmDv+kdtnHS54hwva8ggwr1FG6wntbyO
         99RrMd3c7uwAB3Gjs96z0cf/5Fv2OlVb7Zj4MzbeT/xl5T+glGPFVNMf9WpskFvxS8BW
         z/toUrSagHcirCf4wVIk179pROdutmJ5vFymDGo9o8TtpFeE2iY6fgHHqlQ3n2PV3IIZ
         GCNc5TXMZwNwffkiPAgVIbJovzoYHOsL2P2CDmGJZRMp7agRKvBF4T3D48JBM3MhQlnu
         ahPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Msiba57uIoQyW0yBXGfGPLCUUWKUrx8bYCzahjs4eQE=;
        b=ohiMHlxQTT0Y6c4elKZ4wz6TcQpTfTaAhIuqu5ekMixFhWg/ELZ4xyEHHEiJtDm2yF
         eiuAdVBF/SUgWUqEr/0RPlpiH/6xaJfnSTH6ST82+urbZHCmtup/B1r5ZjQ9swBAyT8k
         Yhqj40Nzd/sZkbcObcompeUCBAOsLDo6R1WuJjuj3IKXr7GM/RtYxzgc+GvrlYvu0JqU
         mgQoao6pK1i11qjqpzMnyI6d543UNxw9CpRNK2ooM9PZ4OeowQp2P473JgCyN1yfoh9P
         3YK2kXpFiJ2zGtOle25Hhlfexd1cIfGS/CoBFZ1lxGm89T6w2a8bItC5ktLx9/TMxMTy
         l/OQ==
X-Gm-Message-State: ANoB5pnnEO2Rh91ZfyCmwHR3Hs6zw2d2zOZeQOaXDsZWZtdtjif3w19P
        69nghQ4g66I5H6rSykge15h4Ug==
X-Google-Smtp-Source: AA0mqf4SxI1FHU824IE2lweG4VRy9wGzePSg/hnLe24uw62BkEOVr0cTBWjO5/zYcpzH+Cev4VTxQA==
X-Received: by 2002:a05:600c:a14:b0:3c7:a5:6113 with SMTP id z20-20020a05600c0a1400b003c700a56113mr11177850wmp.129.1669233025035;
        Wed, 23 Nov 2022 11:50:25 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:fcbc:7b5d:8d6c:43a4])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b002364c77bcacsm7267414wru.38.2022.11.23.11.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:50:24 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 04/14] coresight: stm: Update STM driver to use Trace ID API
Date:   Wed, 23 Nov 2022 19:50:00 +0000
Message-Id: <20221123195010.6859-5-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221123195010.6859-1-mike.leach@linaro.org>
References: <20221123195010.6859-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Updates the STM driver to use the trace ID allocation API.
This uses the _system_id calls to allocate an ID on device poll,
and release on device remove.

The sysfs access to the STMTRACEIDR register has been changed from RW
to RO. Having this value as writable is not appropriate for the new
Trace ID scheme - and had potential to cause errors in the previous
scheme if values clashed with other sources.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-stm.c | 41 +++++++--------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 463f449cfb79..6af1b996af6f 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -31,6 +31,7 @@
 #include <linux/stm.h>
 
 #include "coresight-priv.h"
+#include "coresight-trace-id.h"
 
 #define STMDMASTARTR			0xc04
 #define STMDMASTOPR			0xc08
@@ -615,24 +616,7 @@ static ssize_t traceid_show(struct device *dev,
 	val = drvdata->traceid;
 	return sprintf(buf, "%#lx\n", val);
 }
-
-static ssize_t traceid_store(struct device *dev,
-			     struct device_attribute *attr,
-			     const char *buf, size_t size)
-{
-	int ret;
-	unsigned long val;
-	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-
-	ret = kstrtoul(buf, 16, &val);
-	if (ret)
-		return ret;
-
-	/* traceid field is 7bit wide on STM32 */
-	drvdata->traceid = val & 0x7f;
-	return size;
-}
-static DEVICE_ATTR_RW(traceid);
+static DEVICE_ATTR_RO(traceid);
 
 static struct attribute *coresight_stm_attrs[] = {
 	&dev_attr_hwevent_enable.attr,
@@ -803,14 +787,6 @@ static void stm_init_default_data(struct stm_drvdata *drvdata)
 	 */
 	drvdata->stmsper = ~0x0;
 
-	/*
-	 * The trace ID value for *ETM* tracers start at CPU_ID * 2 + 0x10 and
-	 * anything equal to or higher than 0x70 is reserved.  Since 0x00 is
-	 * also reserved the STM trace ID needs to be higher than 0x00 and
-	 * lowner than 0x10.
-	 */
-	drvdata->traceid = 0x1;
-
 	/* Set invariant transaction timing on all channels */
 	bitmap_clear(drvdata->chs.guaranteed, 0, drvdata->numsp);
 }
@@ -838,7 +814,7 @@ static void stm_init_generic_data(struct stm_drvdata *drvdata,
 
 static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 {
-	int ret;
+	int ret, trace_id;
 	void __iomem *base;
 	struct device *dev = &adev->dev;
 	struct coresight_platform_data *pdata = NULL;
@@ -922,12 +898,22 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 		goto stm_unregister;
 	}
 
+	trace_id = coresight_trace_id_get_system_id();
+	if (trace_id < 0) {
+		ret = trace_id;
+		goto cs_unregister;
+	}
+	drvdata->traceid = (u8)trace_id;
+
 	pm_runtime_put(&adev->dev);
 
 	dev_info(&drvdata->csdev->dev, "%s initialized\n",
 		 (char *)coresight_get_uci_data(id));
 	return 0;
 
+cs_unregister:
+	coresight_unregister(drvdata->csdev);
+
 stm_unregister:
 	stm_unregister_device(&drvdata->stm);
 	return ret;
@@ -937,6 +923,7 @@ static void stm_remove(struct amba_device *adev)
 {
 	struct stm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
 
+	coresight_trace_id_put_system_id(drvdata->traceid);
 	coresight_unregister(drvdata->csdev);
 
 	stm_unregister_device(&drvdata->stm);
-- 
2.17.1

