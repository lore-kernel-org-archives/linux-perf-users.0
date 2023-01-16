Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFED5C678D8
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 Jan 2023 12:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjAPMtr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 Jan 2023 07:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjAPMto (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Jan 2023 07:49:44 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FA81E5CD
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jan 2023 04:49:40 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o15so19899564wmr.4
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jan 2023 04:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Msiba57uIoQyW0yBXGfGPLCUUWKUrx8bYCzahjs4eQE=;
        b=ULf73b4PZTSIvU+sVWArVsZHvItjOzh0GNp/PpJOHEEi45+pehABGahBQCZ3y56/Eh
         1oPwuCCm/wYSiG0a1hQ/9844+4hnI/UdOV6jWzg7wy7Fhc7e1EjWXJ8ZcqcOKibbl78/
         cVrfQbH9Y4nFOC7au/C1JO9SaA1joWMrmdwlOjv8y3t59PrRLDdigHyifs2by7Sebn7W
         XDMImkGSouEXgjucrxCA72WM+CcE0wVpq6gAS/0jz6woduY9vg3gIsPHDTm8vrI2qpLr
         Vh0fWxZTg3cwcHJIcnilRJNi8wswqPj7X2VHd9ttwgSeuZmPY5d15dU+FOqxZledl8cl
         sxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Msiba57uIoQyW0yBXGfGPLCUUWKUrx8bYCzahjs4eQE=;
        b=i0VP6a0/R9xIRGwXEyc4CGQZSdvDvWORu5IfJ5PhXTubeVOxfOFRwY/3P1iihMvOVc
         RzkYlZmFCJ8lFSXPNd9iYIsRj4i3UCrXD9C6q0yQ9wO3Zf29CGzyuX99tQIKh0YwRBRZ
         3rr4XQ7e5gMvfgM1OROVWP0+FEN+G05DoD4MN+T5b9VYao+ZU30wN/FhvE/sTIruDiXq
         F4X/nYf8/TsbAfDWY6tEYLfI504eH/rJ0IVrik0XthLgqWoYoL9RavpOmBP+//mXJuw3
         a0tznK021p99jYkGOvlP6Uj6XSfwX4IL8an07H2B0OsnzdCQCrsA01H0l8qIWu7tPIPM
         6Ovg==
X-Gm-Message-State: AFqh2kpHmGp0GSJymDsgR2jNbBKFcAJ2FQGhnXSh5kHmlCdvePucAUoC
        9aDHMS6IwV6zYWOZo2YC3+frBQ==
X-Google-Smtp-Source: AMrXdXsxxVfGf3gHw0mUCjrgel3qxJbvLg1EMMy4ZQ5RKo54Bpvm/njlgYYxAUYq6mj/Tk+dIBcLrA==
X-Received: by 2002:a7b:cc1a:0:b0:3da:fbcd:cdd2 with SMTP id f26-20020a7bcc1a000000b003dafbcdcdd2mr2978788wmh.9.1673873378751;
        Mon, 16 Jan 2023 04:49:38 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:6c91:710d:9433:e868])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b003dab40f9eafsm6896832wmb.35.2023.01.16.04.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:49:38 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 04/15] coresight: stm: Update STM driver to use Trace ID API
Date:   Mon, 16 Jan 2023 12:49:17 +0000
Message-Id: <20230116124928.5440-5-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230116124928.5440-1-mike.leach@linaro.org>
References: <20230116124928.5440-1-mike.leach@linaro.org>
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

