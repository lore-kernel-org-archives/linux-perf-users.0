Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B51C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Nov 2022 19:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbiKWTul (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Nov 2022 14:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbiKWTuh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Nov 2022 14:50:37 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB31178D47
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 11:50:28 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id t1so13835661wmi.4
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 11:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WFf6QYJ93ZftLmaA8MnS6VvqDhL35ulHDB2UhDbwt2I=;
        b=pyS5yFvsMm3FIYrv9n58NHUYt1+uvfvxNAQxhjFudQ2AirGnszZEZKK+G6l9oHB3Le
         IaoTLiWuUutzQo/2SyPbWCDOAbselvc4DX3jOYvmnC4pLx38+ZFy78uWPlbTJxvOeWrz
         0IcLSacU0X/T1nljBYeFP52F2qkqySizFUp0rQ74bob//9w03Jg6q2RcYB7rVE1MLvdE
         pD3pjYX+JWL9dgTLuMWPPsVj1f4I15sxB237X9OVY61KtgJL7qlPpD0lqFOg83lR7BbW
         PUWzpf7N4QbIb0FcU4yF+kMIQUyEEk0XH7zfsyIbNV774PePT/T7b1TxzS/piMsnU3f6
         Dhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFf6QYJ93ZftLmaA8MnS6VvqDhL35ulHDB2UhDbwt2I=;
        b=LhIQ4rO8BFDgAe/tKZ97FSm88DDt8Qgb5XoHWec41Ozfd8T/SbfDMq1rzjysYyMyoC
         5RbaAKMJ85l33dJAWjL87OdyT5RMYE87UgQTSw/8iCLqLkOt/YFml3y8GwOJiL5fMxrh
         qz+Fyw6AzD/MY9A5Ah2qjpNehrMFLmm/eNXdzB1GdtHzkrDQkE6OAqf5MEOWSq8ar6Ug
         wXxF6hjpiNFNv2/fHZAwcpXar3z/xoiulx/4n3iI+E6cleUY2VV4DjCl8CSd7OJdkFQ1
         vDUrTHNlQN+PUHIeSsf4V3XPtW3pWp1/YhgkwhOaqXih9o+sLKc4/cwIlZopLs5fQ9AF
         EH+g==
X-Gm-Message-State: ANoB5pnM23+2IfMA7BaHl9X73BVW0XXdANaoubQVLsVLOuWFJdMoXGET
        rjalKC3BzU0o/+F/9wbdOTco8YHaXzKejA==
X-Google-Smtp-Source: AA0mqf56kaNvmVZf8Do72X4qnisRyjHyAIjPSAK2C1b8q+0rxJAm65cffsL1YtismD7GD9zwhzjbiA==
X-Received: by 2002:a1c:f006:0:b0:3cf:ecd8:330d with SMTP id a6-20020a1cf006000000b003cfecd8330dmr11310218wmb.130.1669233027296;
        Wed, 23 Nov 2022 11:50:27 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:fcbc:7b5d:8d6c:43a4])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b002364c77bcacsm7267414wru.38.2022.11.23.11.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:50:26 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 06/14] coresight: etm3x: Update ETM3 driver to use Trace ID API
Date:   Wed, 23 Nov 2022 19:50:02 +0000
Message-Id: <20221123195010.6859-7-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221123195010.6859-1-mike.leach@linaro.org>
References: <20221123195010.6859-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use the TraceID API to allocate ETM trace IDs dynamically.

As with the etm4x we allocate on enable / disable for perf,
allocate on enable / reset for sysfs.

Additionally we allocate on sysfs file read as both perf and sysfs
can read the ID before enabling the hardware.

Remove sysfs option to write trace ID - which is inconsistent with
both the dynamic allocation method and the fixed allocation method
previously used.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm.h   |  2 +
 .../coresight/coresight-etm3x-core.c          | 72 +++++++++++++++++--
 .../coresight/coresight-etm3x-sysfs.c         | 27 ++-----
 3 files changed, 75 insertions(+), 26 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index f3ab96eaf44e..3667428d38b6 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -287,4 +287,6 @@ int etm_get_trace_id(struct etm_drvdata *drvdata);
 void etm_set_default(struct etm_config *config);
 void etm_config_trace_mode(struct etm_config *config);
 struct etm_config *get_etm_config(struct etm_drvdata *drvdata);
+int etm_read_alloc_trace_id(struct etm_drvdata *drvdata);
+void etm_release_trace_id(struct etm_drvdata *drvdata);
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index d0ab9933472b..090b6fbf6305 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -32,6 +32,7 @@
 
 #include "coresight-etm.h"
 #include "coresight-etm-perf.h"
+#include "coresight-trace-id.h"
 
 /*
  * Not really modular but using module_param is the easiest way to
@@ -490,16 +491,59 @@ static int etm_trace_id(struct coresight_device *csdev)
 	return etm_get_trace_id(drvdata);
 }
 
+int etm_read_alloc_trace_id(struct etm_drvdata *drvdata)
+{
+	int trace_id;
+
+	/*
+	 * This will allocate a trace ID to the cpu,
+	 * or return the one currently allocated.
+	 *
+	 * trace id function has its own lock
+	 */
+	trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
+	if (IS_VALID_CS_TRACE_ID(trace_id))
+		drvdata->traceid = (u8)trace_id;
+	else
+		dev_err(&drvdata->csdev->dev,
+			"Failed to allocate trace ID for %s on CPU%d\n",
+			dev_name(&drvdata->csdev->dev), drvdata->cpu);
+	return trace_id;
+}
+
+void etm_release_trace_id(struct etm_drvdata *drvdata)
+{
+	coresight_trace_id_put_cpu_id(drvdata->cpu);
+}
+
 static int etm_enable_perf(struct coresight_device *csdev,
 			   struct perf_event *event)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	int trace_id;
 
 	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
 		return -EINVAL;
 
 	/* Configure the tracer based on the session's specifics */
 	etm_parse_event_config(drvdata, event);
+
+	/*
+	 * perf allocates cpu ids as part of _setup_aux() - device needs to use
+	 * the allocated ID. This reads the current version without allocation.
+	 *
+	 * This does not use the trace id lock to prevent lock_dep issues
+	 * with perf locks - we know the ID cannot change until perf shuts down
+	 * the session
+	 */
+	trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu);
+	if (!IS_VALID_CS_TRACE_ID(trace_id)) {
+		dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s on CPU%d\n",
+			dev_name(&drvdata->csdev->dev), drvdata->cpu);
+		return -EINVAL;
+	}
+	drvdata->traceid = (u8)trace_id;
+
 	/* And enable it */
 	return etm_enable_hw(drvdata);
 }
@@ -512,6 +556,11 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 
 	spin_lock(&drvdata->spinlock);
 
+	/* sysfs needs to allocate and set a trace ID */
+	ret = etm_read_alloc_trace_id(drvdata);
+	if (ret < 0)
+		goto unlock_enable_sysfs;
+
 	/*
 	 * Configure the ETM only if the CPU is online.  If it isn't online
 	 * hw configuration will take place on the local CPU during bring up.
@@ -528,6 +577,10 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 		ret = -ENODEV;
 	}
 
+	if (ret)
+		etm_release_trace_id(drvdata);
+
+unlock_enable_sysfs:
 	spin_unlock(&drvdata->spinlock);
 
 	if (!ret)
@@ -611,6 +664,12 @@ static void etm_disable_perf(struct coresight_device *csdev)
 	coresight_disclaim_device_unlocked(csdev);
 
 	CS_LOCK(drvdata->base);
+
+	/*
+	 * perf will release trace ids when _free_aux()
+	 * is called at the end of the session
+	 */
+
 }
 
 static void etm_disable_sysfs(struct coresight_device *csdev)
@@ -635,6 +694,13 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
 	spin_unlock(&drvdata->spinlock);
 	cpus_read_unlock();
 
+	/*
+	 * we only release trace IDs when resetting sysfs.
+	 * This permits sysfs users to read the trace ID after the trace
+	 * session has completed. This maintains operational behaviour with
+	 * prior trace id allocation method
+	 */
+
 	dev_dbg(&csdev->dev, "ETM tracing disabled\n");
 }
 
@@ -781,11 +847,6 @@ static void etm_init_arch_data(void *info)
 	CS_LOCK(drvdata->base);
 }
 
-static void etm_init_trace_id(struct etm_drvdata *drvdata)
-{
-	drvdata->traceid = coresight_get_trace_id(drvdata->cpu);
-}
-
 static int __init etm_hp_setup(void)
 {
 	int ret;
@@ -871,7 +932,6 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	if (etm_arch_supported(drvdata->arch) == false)
 		return -EINVAL;
 
-	etm_init_trace_id(drvdata);
 	etm_set_default(&drvdata->config);
 
 	pdata = coresight_get_platform_data(dev);
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index fd81eca3ec18..2f271b7fb048 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -85,6 +85,7 @@ static ssize_t reset_store(struct device *dev,
 		}
 
 		etm_set_default(config);
+		etm_release_trace_id(drvdata);
 		spin_unlock(&drvdata->spinlock);
 	}
 
@@ -1189,30 +1190,16 @@ static DEVICE_ATTR_RO(cpu);
 static ssize_t traceid_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	unsigned long val;
-	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-
-	val = etm_get_trace_id(drvdata);
-
-	return sprintf(buf, "%#lx\n", val);
-}
-
-static ssize_t traceid_store(struct device *dev,
-			     struct device_attribute *attr,
-			     const char *buf, size_t size)
-{
-	int ret;
-	unsigned long val;
+	int trace_id;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	ret = kstrtoul(buf, 16, &val);
-	if (ret)
-		return ret;
+	trace_id = etm_read_alloc_trace_id(drvdata);
+	if (trace_id < 0)
+		return trace_id;
 
-	drvdata->traceid = val & ETM_TRACEID_MASK;
-	return size;
+	return sysfs_emit(buf, "%#x\n", trace_id);
 }
-static DEVICE_ATTR_RW(traceid);
+static DEVICE_ATTR_RO(traceid);
 
 static struct attribute *coresight_etm_attrs[] = {
 	&dev_attr_nr_addr_cmp.attr,
-- 
2.17.1

