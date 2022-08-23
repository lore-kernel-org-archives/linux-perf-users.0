Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC20C32792
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Aug 2022 10:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355641AbiHWKou (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356668AbiHWKmu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Aug 2022 06:42:50 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB757AA4F0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 02:10:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j26so6872330wms.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 02:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=pwmExfB0GU/JJ9bsvT+Z4EqrCVu9SNKAksEtRHBxI8c=;
        b=JrVszevmPoPRbfiTb8pNhNUMQ8h8MlWsdluTSJDr5PNDrh75e47+DkY8auefPEavd2
         s9msH0uwJ6ykCDBW6Ky9QIWXtl2Gne4XxfHXxiL1OAsPz+2ATtS43XYO+qeQXly1IXiY
         8LchZl/DvRDYTaAQkhI8kYm+JGNC9vTxaibR74ntM7a7IjaEgj3b+Zn5Dk3qSIfBTR/B
         nJDl89MomryEn0BrkLrlconJXlkq2J3kBgB/YaiSzm92HK3AcFYkshwt9tJNHMGvKE6v
         zukMAahTvSis5JeKxQINGyd77UWAXw9Uezpg8FmeTwv2HyE3XRBzq4CfUUHIKBIOZ32B
         siew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=pwmExfB0GU/JJ9bsvT+Z4EqrCVu9SNKAksEtRHBxI8c=;
        b=rZHjs2dywYM77B2LdWRjf405dR76WZVxv9+5WRR6mn16kbJyeVV6SzESFZyUgjYKA/
         qRgefWLNVQ/2QXptY40/UEwszGKoPPkazE84XZFs4quJI0y9XeKpdYN7gCVT8jALEpyt
         If31ckb4XuyFCMBzY0zWBsRXQtLG8ngDrbWpTWTNxSTjVqQdOxW55fCgBrbnr61a3NOd
         o0IB6a1IdLCn0Dgm+bNlFs1d+Z8u6bpjs9EftKuQJhPeIj1iz3mt2lhi867fbe8GEoN2
         mFk2hQpqIGeKvalVmn+v8L9VR6Fw2vuRXUscDOTqJBTqnr5drK8Dvv0yQVXiZad0cjUK
         q+lg==
X-Gm-Message-State: ACgBeo2ijacjPqhcGdXksEszOCTjRwt4sDUC9bD4W4L8zIbD2cQ0K7+P
        jkbeT0Hph+fbkXH87516cC6CrQ==
X-Google-Smtp-Source: AA6agR4rg6Y6twComjcMtlk5VkVPbVh3CjSnqC3K84LjaoswTCOevLdnZmNZgO2Buv+dzMChUqDRdg==
X-Received: by 2002:a05:600c:1d16:b0:3a6:1fa1:41f7 with SMTP id l22-20020a05600c1d1600b003a61fa141f7mr1456118wms.103.1661245816834;
        Tue, 23 Aug 2022 02:10:16 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:4553:cf11:6cff:b293])
        by smtp.gmail.com with ESMTPSA id w6-20020adfde86000000b002253d162491sm10760721wrl.52.2022.08.23.02.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 02:10:16 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 03/13] coresight: stm: Update STM driver to use Trace ID API
Date:   Tue, 23 Aug 2022 10:09:59 +0100
Message-Id: <20220823091009.14121-4-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220823091009.14121-1-mike.leach@linaro.org>
References: <20220823091009.14121-1-mike.leach@linaro.org>
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
index bb14a3a8a921..9ef3e923a930 100644
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
 
 #define coresight_stm_reg(name, offset)	\
 	coresight_simple_reg32(struct stm_drvdata, name, offset)
@@ -819,14 +803,6 @@ static void stm_init_default_data(struct stm_drvdata *drvdata)
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
@@ -854,7 +830,7 @@ static void stm_init_generic_data(struct stm_drvdata *drvdata,
 
 static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 {
-	int ret;
+	int ret, trace_id;
 	void __iomem *base;
 	struct device *dev = &adev->dev;
 	struct coresight_platform_data *pdata = NULL;
@@ -938,12 +914,22 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
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
@@ -953,6 +939,7 @@ static void stm_remove(struct amba_device *adev)
 {
 	struct stm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
 
+	coresight_trace_id_put_system_id(drvdata->traceid);
 	coresight_unregister(drvdata->csdev);
 
 	stm_unregister_device(&drvdata->stm);
-- 
2.17.1

