Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F647339362
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464424; cv=none; b=pPX0/F3AOY4zlDv2KrI9XPk3ftI7yHHIMVXiqlqg6V1m8l7eTJ9AodNv8iV416BGKkuWGarrSu54pGXD/sa++HRCbLq4ffqzH2Wxigs4Gr+WSqYIMLK+5Wkob0q8+snGOi/Hf0pUPVUYGzP9UIpLO9Oicnrwl9foLU/AjqcxpFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464424; c=relaxed/simple;
	bh=s7zP/G+oeEaVi0BMhvkcbTExiUknMwFMVDCdVWZnBbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkrkGLkGMKovyOcwIWFcxv4zTTEHbDHTtE9TE1cJ6N9GShRixVmeCcbpBeIV79EEMUr66unE8TvvCOVE7evszNofRgB1DpLr8UDVympu0J3uJljjr/Hod8kchdYjasSUDIeWZu5ECBLviVrBz4NvTdAW/4bW43AYOjkcnJCD+Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=d3M67rtg; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="d3M67rtg"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbedf6a6fe8so305842a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 09:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1786464421; x=1787069221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7G7x9YFsXn4FS+MsawAPuBrlOk9V6aLvapXNJP5fUgU=;
        b=d3M67rtgs4AFv10xtjomxDkvwoWQDAvQ0qFtUxsD+I2P7yiWi2IdCYtqMUp0wVhOLz
         KM9oKDfA6IxjelvwQfBFD01nGpiNxVQE9imH0+pu/u2IB0VjSgPlrbiYI+xXOnMRj0fz
         Y1F6n1ZmwJ1lq2SQpz09C22x5FN7fOH4iX4VsvvUV+ce1DaWN5WddUbwTkMzb5Y3rx7T
         18V5K0Z+TG/FBkkFYzkgMuBzhHL0X7g8gH9bcn0EiUKdpPDDOAV26PeB2t6Aqu5uI5Qu
         TDonXmx/wss5KfXrr+7BjY3vsoOow+HmmX7OLI8+ujWYof5odloeqcG3KSO9RPJD41f4
         mSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786464421; x=1787069221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7G7x9YFsXn4FS+MsawAPuBrlOk9V6aLvapXNJP5fUgU=;
        b=hN9v6qz5FXxK6DoZcmL+8s1NalucMh75YLAmrnNg/byCPiuT4Ne/Ojy1AbcDfu8US+
         KusJjRJMvsEdQCGOqmbl5tHpOhZDfJ26nuxqtcA/OEYuzqVXM5h7EQ+xhjZfKCR8vzRj
         aIS8Lx4UhikqUkXNBx4DdocheEupVS+WqIXr9d7+CmgkHHAj872HNMxesXbsLif18YK4
         uS6+9phvdRgqDFtVw530n2uDzlJl5RoPOVRKNgXqt1tWE1qWgrhKkF46Tm+Gpw4KWOeK
         M2cerng19ml4S4A8pvuoLxrizZx4N9fggCiQYstyP9jnWdSnHDK57IG3BHltkNuYK5Jl
         qYDQ==
X-Forwarded-Encrypted: i=1; AHgh+RrjRAm6WevJ3tHuCHVzcdZZYJ3xybQWGzxlc/VpQhBb4X1D/NhtGiTKPLY/RfMXElOXvk7gVJE/t7mbb4GoNJwo@vger.kernel.org
X-Gm-Message-State: AOJu0YwzEnCo1UDQ/DzB1n6p2w0n8dQeRwVQO6CYzhacLBFgFpm1n0sQ
	9m3J5vy4uTZAxdWeqwAy7WPuLpwmyAYf2hCktJ2ZzodGqlLf51X1AJdBGyIViweEPcY=
X-Gm-Gg: AR+sD10CtRps5/I147UVU0udUc70/2IP+K8s3w3L4J0aCez7lfkW9a36W8P7KyG4rlC
	+rCbYoVdKRbPltoVsYR/eP57GrG72GNCzDHGjwAU/QFo3thZhcfzf4JAqqo8PrW1UoiOwho7ntn
	Ldv9w1tUNykUZIW85lhHqBLJzlw0cqFuZ8qOYJ7c701Ad4zhwYhAkcE/y5ggcpJmCs3z4Dz4OYs
	rK8l5sMF0naPcNJ1HMbaPXvEXXn5bMbHnUP9P+wDMYBg59125anbYlYrnyiUJw6d28p5Fabr4YU
	JJItCj5WWuLp4Td211wJcFQ6Wm/o7Zw7QkTTGdAz5kUKuEj3waQjwjw3rzz2ZXBhYIxQuZZsMfY
	4liZEbVdEJ5586rJaQdJZ5W1p/f5EYoV9EIkXKRVBrbvNkjIQZh1pAIV58WV6rqnyvGRryKMD2t
	+SYCOPzNiHDFTT4nMbvWT0NPtho+MqQAOrsABerzl5fU2o2H8xW6xhaF9tvgS9wPasliKlffBgZ
	XPfIco2B0p8gJMLxIQ=
X-Received: by 2002:a17:90b:2dca:b0:381:a766:efc9 with SMTP id 98e67ed59e1d1-392ec34642fmr5541878a91.7.1786464421415;
        Tue, 11 Aug 2026 09:07:01 -0700 (PDT)
Received: from FJ7FR2JRQ3 ([178.93.176.7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf7094c8dsm822008eec.31.2026.08.11.09.06.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 09:07:00 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>
Cc: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [PATCH v2 1/2] perf/dwc_pcie: Avoid nested bus notifier locking
Date: Wed, 12 Aug 2026 00:06:49 +0800
Message-ID: <20260811160649.28255-1-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260811131714.12779-1-zhangzhanpeng.jasper@bytedance.com>
References: <20260811131714.12779-1-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dwc_pcie_pmu_notifier() registers a synthetic platform device directly from
the BUS_NOTIFY_ADD_DEVICE callback. Bus notifier callbacks run with the
bus_notifier rwsem held, so platform_device_register_data() enters the
platform bus notifier chain before the PCI bus notifier returns. When PCI
host bridges are registered during late init, lockdep reports this as
possible recursive locking.

Move platform device reconciliation to a work item that runs after the PCI
notifier returns. Serialize it with PCI rescan and removal, and parent each
synthetic device to its Root Port so their lifetimes remain coupled.

During removal, unregister the perf PMU and its CPU hotplug instance before
PCI resources disappear, then defer only platform device destruction.
Disable manual bind controls to preserve that ordering.

Fixes: af9597adc2f1 ("drivers/perf: add DesignWare PCIe PMU driver")
Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
Tested on a RISC-V system with CONFIG_KASAN, CONFIG_PROVE_LOCKING,
CONFIG_DEBUG_LOCK_ALLOC and CONFIG_LOCKDEP enabled. Late-init PCI discovery
no longer triggers the nested bus notifier warning.

 drivers/perf/dwc_pcie_pmu.c | 149 +++++++++++++++++++++++++++---------
 1 file changed, 113 insertions(+), 36 deletions(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 5385401fa9cf..7b2e28aade73 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -13,6 +13,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/pcie-dwc.h>
 #include <linux/perf_event.h>
 #include <linux/pci.h>
@@ -20,6 +21,7 @@
 #include <linux/smp.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 #define DWC_PCIE_EVENT_CNT_CTL			0x8
 
@@ -103,12 +105,15 @@ struct dwc_pcie_pmu {
 static int dwc_pcie_pmu_hp_state;
 static struct list_head dwc_pcie_dev_info_head =
 				LIST_HEAD_INIT(dwc_pcie_dev_info_head);
+static DEFINE_MUTEX(dwc_pcie_dev_info_lock);
+static struct work_struct dwc_pcie_pmu_work;
 static bool notify;
 
 struct dwc_pcie_dev_info {
 	struct platform_device *plat_dev;
 	struct pci_dev *pdev;
 	struct list_head dev_node;
+	bool removed;
 };
 
 static ssize_t cpumask_show(struct device *dev,
@@ -593,6 +598,8 @@ static struct dwc_pcie_dev_info *dwc_pcie_find_dev_info(struct pci_dev *pdev)
 {
 	struct dwc_pcie_dev_info *dev_info;
 
+	lockdep_assert_held(&dwc_pcie_dev_info_lock);
+
 	list_for_each_entry(dev_info, &dwc_pcie_dev_info_head, dev_node)
 		if (dev_info->pdev == pdev)
 			return dev_info;
@@ -634,7 +641,6 @@ static u16 dwc_pcie_des_cap(struct pci_dev *pdev)
 static void dwc_pcie_unregister_dev(struct dwc_pcie_dev_info *dev_info)
 {
 	platform_device_unregister(dev_info->plat_dev);
-	list_del(&dev_info->dev_node);
 	kfree(dev_info);
 }
 
@@ -644,25 +650,92 @@ static int dwc_pcie_register_dev(struct pci_dev *pdev)
 	struct dwc_pcie_dev_info *dev_info;
 	u32 sbdf;
 
-	sbdf = (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bus->number, pdev->devfn);
-	plat_dev = platform_device_register_simple("dwc_pcie_pmu", sbdf, NULL, 0);
-	if (IS_ERR(plat_dev))
-		return PTR_ERR(plat_dev);
-
 	dev_info = kzalloc_obj(*dev_info);
-	if (!dev_info) {
-		platform_device_unregister(plat_dev);
+	if (!dev_info)
 		return -ENOMEM;
-	}
 
-	/* Cache platform device to handle pci device hotplug */
+	sbdf = (pci_domain_nr(pdev->bus) << 16) |
+	       PCI_DEVID(pdev->bus->number, pdev->devfn);
+	plat_dev = platform_device_register_data(&pdev->dev, "dwc_pcie_pmu",
+						 sbdf, NULL, 0);
+	if (IS_ERR(plat_dev)) {
+		kfree(dev_info);
+		return PTR_ERR(plat_dev);
+	}
 	dev_info->plat_dev = plat_dev;
 	dev_info->pdev = pdev;
-	list_add(&dev_info->dev_node, &dwc_pcie_dev_info_head);
+
+	mutex_lock(&dwc_pcie_dev_info_lock);
+	list_add_tail(&dev_info->dev_node, &dwc_pcie_dev_info_head);
+	mutex_unlock(&dwc_pcie_dev_info_lock);
 
 	return 0;
 }
 
+static void dwc_pcie_quiesce_dev(struct dwc_pcie_dev_info *dev_info)
+{
+	struct dwc_pcie_pmu *pcie_pmu;
+
+	pcie_pmu = platform_get_drvdata(dev_info->plat_dev);
+	if (!pcie_pmu)
+		return;
+
+	/* Stop config-space accesses before PCI host resources are released. */
+	platform_set_drvdata(dev_info->plat_dev, NULL);
+	devm_release_action(&dev_info->plat_dev->dev, dwc_pcie_unregister_pmu,
+			    pcie_pmu);
+	devm_release_action(&dev_info->plat_dev->dev,
+			    dwc_pcie_pmu_remove_cpuhp_instance,
+			    &pcie_pmu->cpuhp_node);
+}
+
+static int dwc_pcie_reconcile_devices(void)
+{
+	LIST_HEAD(removed_devices);
+	struct dwc_pcie_dev_info *dev_info, *tmp;
+	struct pci_dev *pdev = NULL;
+	int error = 0;
+	int ret;
+
+	pci_lock_rescan_remove();
+	mutex_lock(&dwc_pcie_dev_info_lock);
+	list_for_each_entry_safe(dev_info, tmp, &dwc_pcie_dev_info_head, dev_node)
+		if (dev_info->removed)
+			list_move_tail(&dev_info->dev_node, &removed_devices);
+	mutex_unlock(&dwc_pcie_dev_info_lock);
+
+	list_for_each_entry_safe(dev_info, tmp, &removed_devices, dev_node) {
+		list_del(&dev_info->dev_node);
+		dwc_pcie_unregister_dev(dev_info);
+	}
+
+	for_each_pci_dev(pdev) {
+		if (!dwc_pcie_des_cap(pdev))
+			continue;
+
+		mutex_lock(&dwc_pcie_dev_info_lock);
+		dev_info = dwc_pcie_find_dev_info(pdev);
+		mutex_unlock(&dwc_pcie_dev_info_lock);
+		if (dev_info)
+			continue;
+
+		ret = dwc_pcie_register_dev(pdev);
+		if (ret) {
+			pci_warn(pdev, "failed to register DWC PCIe PMU: %d\n", ret);
+			if (!error)
+				error = ret;
+		}
+	}
+	pci_unlock_rescan_remove();
+
+	return error;
+}
+
+static void dwc_pcie_update_devices(struct work_struct *work)
+{
+	dwc_pcie_reconcile_devices();
+}
+
 static int dwc_pcie_pmu_notifier(struct notifier_block *nb,
 				     unsigned long action, void *data)
 {
@@ -674,14 +747,19 @@ static int dwc_pcie_pmu_notifier(struct notifier_block *nb,
 	case BUS_NOTIFY_ADD_DEVICE:
 		if (!dwc_pcie_des_cap(pdev))
 			return NOTIFY_DONE;
-		if (dwc_pcie_register_dev(pdev))
-			return NOTIFY_BAD;
+		schedule_work(&dwc_pcie_pmu_work);
 		break;
 	case BUS_NOTIFY_DEL_DEVICE:
+		mutex_lock(&dwc_pcie_dev_info_lock);
 		dev_info = dwc_pcie_find_dev_info(pdev);
+		if (dev_info) {
+			dwc_pcie_quiesce_dev(dev_info);
+			dev_info->removed = true;
+		}
+		mutex_unlock(&dwc_pcie_dev_info_lock);
 		if (!dev_info)
 			return NOTIFY_DONE;
-		dwc_pcie_unregister_dev(dev_info);
+		schedule_work(&dwc_pcie_pmu_work);
 		break;
 	}
 
@@ -702,18 +780,14 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 	int ret;
 
 	sbdf = plat_dev->id;
-	pdev = pci_get_domain_bus_and_slot(sbdf >> 16, PCI_BUS_NUM(sbdf & 0xffff),
-					   sbdf & 0xff);
-	if (!pdev) {
-		pr_err("No pdev found for the sbdf 0x%x\n", sbdf);
+	if (!plat_dev->dev.parent || plat_dev->dev.parent->bus != &pci_bus_type)
 		return -ENODEV;
-	}
 
+	pdev = to_pci_dev(plat_dev->dev.parent);
 	vsec = dwc_pcie_des_cap(pdev);
 	if (!vsec)
 		return -ENODEV;
 
-	pci_dev_put(pdev);
 	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
 	if (!name)
 		return -ENOMEM;
@@ -766,6 +840,8 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 	if (ret)
 		return ret;
 
+	platform_set_drvdata(plat_dev, pcie_pmu);
+
 	return 0;
 }
 
@@ -815,7 +891,11 @@ static int dwc_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_n
 
 static struct platform_driver dwc_pcie_pmu_driver = {
 	.probe = dwc_pcie_pmu_probe,
-	.driver = {.name = "dwc_pcie_pmu",},
+	.driver = {
+		.name = "dwc_pcie_pmu",
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
+		.suppress_bind_attrs = true,
+	},
 };
 
 static void dwc_pcie_cleanup_devices(void)
@@ -823,32 +903,21 @@ static void dwc_pcie_cleanup_devices(void)
 	struct dwc_pcie_dev_info *dev_info, *tmp;
 
 	list_for_each_entry_safe(dev_info, tmp, &dwc_pcie_dev_info_head, dev_node) {
+		list_del(&dev_info->dev_node);
 		dwc_pcie_unregister_dev(dev_info);
 	}
 }
 
 static int __init dwc_pcie_pmu_init(void)
 {
-	struct pci_dev *pdev = NULL;
 	int ret;
 
-	for_each_pci_dev(pdev) {
-		if (!dwc_pcie_des_cap(pdev))
-			continue;
-
-		ret = dwc_pcie_register_dev(pdev);
-		if (ret) {
-			pci_dev_put(pdev);
-			goto err_cleanup;
-		}
-	}
-
 	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
 				      "perf/dwc_pcie_pmu:online",
 				      dwc_pcie_pmu_online_cpu,
 				      dwc_pcie_pmu_offline_cpu);
 	if (ret < 0)
-		goto err_cleanup;
+		return ret;
 
 	dwc_pcie_pmu_hp_state = ret;
 
@@ -856,19 +925,26 @@ static int __init dwc_pcie_pmu_init(void)
 	if (ret)
 		goto err_remove_cpuhp;
 
+	INIT_WORK(&dwc_pcie_pmu_work, dwc_pcie_update_devices);
 	ret = bus_register_notifier(&pci_bus_type, &dwc_pcie_pmu_nb);
 	if (ret)
 		goto err_unregister_driver;
 	notify = true;
+	ret = dwc_pcie_reconcile_devices();
+	if (ret)
+		goto err_unregister_notifier;
 
 	return 0;
 
+err_unregister_notifier:
+	bus_unregister_notifier(&pci_bus_type, &dwc_pcie_pmu_nb);
+	notify = false;
+	cancel_work_sync(&dwc_pcie_pmu_work);
+	dwc_pcie_cleanup_devices();
 err_unregister_driver:
 	platform_driver_unregister(&dwc_pcie_pmu_driver);
 err_remove_cpuhp:
 	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
-err_cleanup:
-	dwc_pcie_cleanup_devices();
 	return ret;
 }
 
@@ -876,6 +952,7 @@ static void __exit dwc_pcie_pmu_exit(void)
 {
 	if (notify)
 		bus_unregister_notifier(&pci_bus_type, &dwc_pcie_pmu_nb);
+	cancel_work_sync(&dwc_pcie_pmu_work);
 	dwc_pcie_cleanup_devices();
 	platform_driver_unregister(&dwc_pcie_pmu_driver);
 	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
-- 
2.50.1 (Apple Git-155)
