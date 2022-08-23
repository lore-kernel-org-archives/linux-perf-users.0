Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3A4C32772
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Aug 2022 10:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355853AbiHWKo6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350891AbiHWKmx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Aug 2022 06:42:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3892AA4F5
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 02:10:19 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id bs25so16205301wrb.2
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 02:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=wxLiAf3ETI1pUKkDvOtNy10A8Mz8Sbg3o01abH5defc=;
        b=TBPegJDeqkI5otajI0ul/pcNsyTLe6h3eEoUWhxcNoVts8FfWqAGuuetZMQObiGBK4
         flvNHT+vsqG0W1wYTOyClu+Fg1SNukjuJva0txStbc+A9O7YMFkJcwn8d3gwVfJf4Ymd
         t5ayKQFBdCwmaWvUBPvCITgZb8e3PoCgFesB4Nt7GXTnhTL7j84Y4hLmhzlm+1ujpMD8
         iU3PnoVzTiphwdVaJI0sxcPqJmAnczBXFAzc1G+XmXt5Oki+lhdhzi5W+OLW1uj+ZvNv
         USavLc8nyj1HonEH2JSlvWTxGSW00B7Vms7DNOmb1pXgKBHVMh6/ZDwbsRW9ybBgvRSq
         J06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=wxLiAf3ETI1pUKkDvOtNy10A8Mz8Sbg3o01abH5defc=;
        b=6TNP7tndbW7erxCbCupq001yxbo9sEzW6yh6rLICRmGmYb9Ej8Ao8TzCx3MqpiqB/V
         ZiKu0rdXokkXox2ETPi6u3I7qYLdpViUecThbzaoj3LcLL7xLwvAoGsr9izqm7OMYZEm
         Wq2Zh8geHzloEjp7wIIqgiLR3oAIn8E3EZBuxnihNB5KHaUQS+vlt7b8p/QzH6FMGxfq
         DvpBePy3JmVAz7XV8u/sPdKgkplV74DyJJoyYayuGB8HX3vxWOSbOA2DPF0sdCw17iI5
         TzDILZI1MX0iE7lETkfCPpq3HMM2EE7sUiySwr207SHCblMyRNCm+oe3E87hj9KB0Nci
         G+pw==
X-Gm-Message-State: ACgBeo13fyJGoE1BVTPTiM8j6hH/ExAJzNUmP7uFSqywb0SDmXVcIb/g
        dIpcdwi+tAvEdSPGnLHkEwOEhQ==
X-Google-Smtp-Source: AA6agR6tbwGykBDWsX6a11rgumzRljeOWJvX+j0iZ/l9KOi9qIipEdOmG8Wq9EpwnQ7t8xThaDjgtw==
X-Received: by 2002:adf:f68a:0:b0:225:3fed:76f with SMTP id v10-20020adff68a000000b002253fed076fmr9083953wrp.249.1661245817763;
        Tue, 23 Aug 2022 02:10:17 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:4553:cf11:6cff:b293])
        by smtp.gmail.com with ESMTPSA id w6-20020adfde86000000b002253d162491sm10760721wrl.52.2022.08.23.02.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 02:10:17 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 04/13] coresight: etm4x: Update ETM4 driver to use Trace ID API
Date:   Tue, 23 Aug 2022 10:10:00 +0100
Message-Id: <20220823091009.14121-5-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220823091009.14121-1-mike.leach@linaro.org>
References: <20220823091009.14121-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The trace ID API is now used to allocate trace IDs for ETM4.x / ETE
devices.

For perf sessions, these will be allocated on enable, and released on
disable.

For sysfs sessions, these will be allocated on enable, but only released
on reset. This allows the sysfs session to interrogate the Trace ID used
after the session is over - maintaining functional consistency with the
previous allocation scheme.

The trace ID will also be allocated on read of the mgmt/trctraceid file.
This ensures that if perf or sysfs read this before enabling trace, the
value will be the one used for the trace session.

Trace ID initialisation is removed from the _probe() function.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../coresight/coresight-etm4x-core.c          | 79 +++++++++++++++++--
 .../coresight/coresight-etm4x-sysfs.c         | 27 ++++++-
 drivers/hwtracing/coresight/coresight-etm4x.h |  3 +
 3 files changed, 100 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index cf249ecad5a5..b4fb28ce89fd 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -42,6 +42,7 @@
 #include "coresight-etm4x-cfg.h"
 #include "coresight-self-hosted-trace.h"
 #include "coresight-syscfg.h"
+#include "coresight-trace-id.h"
 
 static int boot_enable;
 module_param(boot_enable, int, 0444);
@@ -234,6 +235,50 @@ static int etm4_trace_id(struct coresight_device *csdev)
 	return drvdata->trcid;
 }
 
+int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata)
+{
+	int trace_id;
+
+	/*
+	 * This will allocate a trace ID to the cpu,
+	 * or return the one currently allocated.
+	 */
+	/* trace id function has its own lock */
+	trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
+	if (IS_VALID_ID(trace_id))
+		drvdata->trcid = (u8)trace_id;
+	else
+		dev_err(&drvdata->csdev->dev,
+			"Failed to allocate trace ID for %s on CPU%d\n",
+			dev_name(&drvdata->csdev->dev), drvdata->cpu);
+	return trace_id;
+}
+
+static int etm4_set_current_trace_id(struct etmv4_drvdata *drvdata)
+{
+	int trace_id;
+
+	/*
+	 * Set the currently allocated trace ID - perf allocates IDs
+	 * as part of setup_aux for all CPUs it may use.
+	 */
+	trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu);
+	if (IS_VALID_ID(trace_id)) {
+		drvdata->trcid = (u8)trace_id;
+		return 0;
+	}
+
+	dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s on CPU%d\n",
+		dev_name(&drvdata->csdev->dev), drvdata->cpu);
+
+	return -EINVAL;
+}
+
+void etm4_release_trace_id(struct etmv4_drvdata *drvdata)
+{
+	coresight_trace_id_put_cpu_id(drvdata->cpu);
+}
+
 struct etm4_enable_arg {
 	struct etmv4_drvdata *drvdata;
 	int rc;
@@ -729,6 +774,15 @@ static int etm4_enable_perf(struct coresight_device *csdev,
 	ret = etm4_parse_event_config(csdev, event);
 	if (ret)
 		goto out;
+
+	/*
+	 * perf allocates cpu ids as part of setup - device needs to use
+	 * the allocated ID.
+	 */
+	ret = etm4_set_current_trace_id(drvdata);
+	if (ret < 0)
+		goto out;
+
 	/* And enable it */
 	ret = etm4_enable_hw(drvdata);
 
@@ -753,6 +807,11 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 
 	spin_lock(&drvdata->spinlock);
 
+	/* sysfs needs to read and allocate a trace ID */
+	ret = etm4_read_alloc_trace_id(drvdata);
+	if (ret < 0)
+		goto unlock_sysfs_enable;
+
 	/*
 	 * Executing etm4_enable_hw on the cpu whose ETM is being enabled
 	 * ensures that register writes occur when cpu is powered.
@@ -764,6 +823,11 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 		ret = arg.rc;
 	if (!ret)
 		drvdata->sticky_enable = true;
+
+	if (ret)
+		etm4_release_trace_id(drvdata);
+
+unlock_sysfs_enable:
 	spin_unlock(&drvdata->spinlock);
 
 	if (!ret)
@@ -895,6 +959,8 @@ static int etm4_disable_perf(struct coresight_device *csdev,
 	/* TRCVICTLR::SSSTATUS, bit[9] */
 	filters->ssstatus = (control & BIT(9));
 
+	/* The perf event will release trace ids when it is destroyed */
+
 	return 0;
 }
 
@@ -920,6 +986,13 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
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
 
@@ -1562,11 +1635,6 @@ static int etm4_dying_cpu(unsigned int cpu)
 	return 0;
 }
 
-static void etm4_init_trace_id(struct etmv4_drvdata *drvdata)
-{
-	drvdata->trcid = coresight_get_trace_id(drvdata->cpu);
-}
-
 static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
 {
 	int i, ret = 0;
@@ -1971,7 +2039,6 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 	if (!desc.name)
 		return -ENOMEM;
 
-	etm4_init_trace_id(drvdata);
 	etm4_set_default(&drvdata->config);
 
 	pdata = coresight_get_platform_data(dev);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 6ea8181816fc..d3c27c521d43 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -266,10 +266,11 @@ static ssize_t reset_store(struct device *dev,
 	config->vmid_mask0 = 0x0;
 	config->vmid_mask1 = 0x0;
 
-	drvdata->trcid = drvdata->cpu + 1;
-
 	spin_unlock(&drvdata->spinlock);
 
+	/* for sysfs - only release trace id when resetting */
+	etm4_release_trace_id(drvdata);
+
 	cscfg_csdev_reset_feats(to_coresight_device(dev));
 
 	return size;
@@ -2363,6 +2364,26 @@ static struct attribute *coresight_etmv4_attrs[] = {
 	NULL,
 };
 
+/*
+ * Trace ID allocated dynamically on enable - but also allocate on read
+ * in case sysfs or perf read before enable to ensure consistent metadata
+ * information for trace decode
+ */
+static ssize_t trctraceid_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	int trace_id;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	trace_id = etm4_read_alloc_trace_id(drvdata);
+	if (trace_id < 0)
+		return trace_id;
+
+	return sysfs_emit(buf, "0x%x\n", trace_id);
+}
+static DEVICE_ATTR_RO(trctraceid);
+
 struct etmv4_reg {
 	struct coresight_device *csdev;
 	u32 offset;
@@ -2499,7 +2520,7 @@ static struct attribute *coresight_etmv4_mgmt_attrs[] = {
 	coresight_etm4x_reg(trcpidr3, TRCPIDR3),
 	coresight_etm4x_reg(trcoslsr, TRCOSLSR),
 	coresight_etm4x_reg(trcconfig, TRCCONFIGR),
-	coresight_etm4x_reg(trctraceid, TRCTRACEIDR),
+	&dev_attr_trctraceid.attr,
 	coresight_etm4x_reg(trcdevarch, TRCDEVARCH),
 	NULL,
 };
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index a7bfea31f7d8..793c361841d4 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -1095,4 +1095,7 @@ static inline bool etm4x_is_ete(struct etmv4_drvdata *drvdata)
 {
 	return drvdata->arch >= ETM_ARCH_ETE;
 }
+
+int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata);
+void etm4_release_trace_id(struct etmv4_drvdata *drvdata);
 #endif
-- 
2.17.1

