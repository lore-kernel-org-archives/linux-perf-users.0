Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E578240F8EB
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244082; cv=none; b=ZSF1t+isOSYAKXcl7b5dn5HuoHANTOYO8qdJRVFRhQytxFJuKim26+pNxOcxuWgAx3bAkwh4InkRfikrNWkZIZYzLllYoA2M0vMLkiyrqvAQilB/BoTA0t5MHONotztZjBqNbXlT/bPin8LRclt7Ig5zhkQP7U96YzsKwtiKdJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244082; c=relaxed/simple;
	bh=yYqekLJ/G1t+rbxU0H1jBCLzz7cJv7e+IWYJeGIMiGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxbQGbMby+itLMDEHmEiK4pYijprfQH2hXFxV6IHJzJN+oUyaPWpfHrwvXou5scQ+O9q7ONh/R5N97PY1I7EELEXsbTDarpdwrAZGV2VwbNd2GVXnXFHcnayWEG1U82RhBmd0xe44LZvVNmzYgT+vowSeSibqvdhAzumrOgxRMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CFcCb0y7; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CFcCb0y7"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f089b1e3so1652540c88.2
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1790244075; x=1790848875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QtF+hEd4zxaSXZ54y5RlnY99ygpvKaq026DcmobuPXU=;
        b=CFcCb0y7ooap2tqp5BBs19zpWMvSojKrHIRKWbygnnYLnuooQhbH4TCbFKuLANB1k/
         xCzxG07eYBFJHylubiGFkm7duIyQx7UDYRW2zOQDUrFp04GVZTLj7C24GyVGcg6K+7zd
         u+oozwPLWgVHHnTgVh8VK8xIxzFG27yplCN7k332fRmpApTcrEK/7wN5ExQ5FgF0ECho
         NTXhwLDUM/qwBWMozMZfUaK3PPaEGYvrgTguri2fDpPs30AQQaQr+MD95dl9VSdS82Jr
         vwRzxRLT1vGKsj7Sjj64HucBWTqZ80V4+1rI+hoFTqPAZ6RN7JwxEfCvwihsN3lsYPXP
         2JcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790244075; x=1790848875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QtF+hEd4zxaSXZ54y5RlnY99ygpvKaq026DcmobuPXU=;
        b=QFE/g5CQz6tyu8geYyNLuiIJEzQ1nT6kTqrj1H8JFqk3gqRlHaaVqqA+yzHWa9+4XR
         kwZsYVR5DV6lX4MdnYh/nv/GbPH6HphAbrY6stHajU6pFD16qQeyOa+KHr5Dg6GJasun
         bsMzhKnAp1LObFLauqQexIlMknLkjuw2QB/cFU4xHnIPn3VW1rueTOSuRVOdAnj4pcPn
         2nM2IF33zrrir5kEm8R9e66fAXFgwMpPUwcY042PDTkyuwwHIlcrKUdEbX9pqOBIofAn
         x559J+vBF/J8PKC33eJo4bVHQkja9/ZjJBNkWx5teo21ssktP0YZcQICNTUCcUGaE5x4
         l1Nw==
X-Forwarded-Encrypted: i=1; AKwUvBwGiXZCTbvHonQBMF1MHTaHkKx1xk4klserJZYOAbiM1gTdEQPjY5TBvIorlCkHnLdKyMWifrmgPdssZ56oExH/@vger.kernel.org
X-Gm-Message-State: AFuF++lTxTmIxfC10mnQsrsCCffNz5xnNADXjGIAfFW/kU/3i+hxr9C5
	bEIZCn/mJ3Gmt/pSitoYr5HyISfIB9WbBDyDTfiLtU0radc924rsZwNOvEX4Uzq3aGk=
X-Gm-Gg: AYBFou2qFh0bsYmYRRvJXkokKZq8ggD2C0JrKBnppnjn4pzXXLi7X3TM+9Fi8ckm1ou
	Y47s7YEXHEbrnen9MMvLvPyFPSOOYjlInLZiIoAS+7COG8b9WFjPFN+q+CtfG0E7IjEWlVIJuUt
	y5DsuIxZUmMsxFNYQ2fhKGlGsx6bL+55lO1oIIj4gs1O9qpn+qs1cptJWkJQ5aooEbuodkywLZ0
	r3BDpShM4IJguJVXLTJmTXxyiZhubdM7TgEUAfczvSnANIy0RCJDhYL5n3akjh1U6UWygl630gJ
	+RlfTGOzaOuChLeAN36oe79WfSTXNFdaSz/qquJDjt97Wl0IoFOhUEUDBHDP0tc4ZmgJz4V2MNm
	+Obc+6sbrtrZEHIW8R0b+bUPDCvAVQGNibd7mZpiu91mzniycMLGRmetV2rDhb6lW1oCbnVoI9J
	2wJcqjWT9zokgx9M0YlfvNsPWhUv7ApS1OTNlne/6+0uI+cD0ubzVK0q4tQwF/GwnPtzexgfL6l
	+9apJtY5FTJ9LjkpipNsQ==
X-Received: by 2002:a05:7300:561e:b0:333:b6d8:c2fe with SMTP id 5a478bee46e88-3400439cfbcmr1465583eec.3.1790244075027;
        Thu, 24 Sep 2026 03:01:15 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96e498f0sm11649975eec.27.2026.09.24.03.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:01:14 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	mark.rutland@arm.com,
	andrew.jones@oss.qualcomm.com,
	guoren@kernel.org,
	david.laight.linux@gmail.com,
	zhangzhanpeng.jasper@bytedance.com,
	yang.yicong@picoheart.com,
	nutty.liu@hotmail.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v14 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Thu, 24 Sep 2026 03:01:05 -0700
Message-ID: <20260924100106.2054127-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260924100106.2054127-1-zong.li@sifive.com>
References: <20260924100106.2054127-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create an auxiliary device for HPM when the IOMMU supports a
hardware performance monitor.

Tested-by: Chen Pei <cp0613@linux.alibaba.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>
Suggested-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/Kconfig |  1 +
 drivers/iommu/riscv/iommu.c | 48 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.h |  4 ++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
index b86e5ab94183..8025bf0fb67f 100644
--- a/drivers/iommu/riscv/Kconfig
+++ b/drivers/iommu/riscv/Kconfig
@@ -10,6 +10,7 @@ config RISCV_IOMMU
 	select GENERIC_PT
 	select IOMMU_PT
 	select IOMMU_PT_RISCV64
+	select AUXILIARY_BUS
 	help
 	  Support for implementations of the RISC-V IOMMU architecture that
 	  complements the RISC-V MMU capabilities, providing similar address
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index fe8e6d0f8a23..3c8f8adba647 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -14,6 +14,7 @@
 
 #include <linux/acpi.h>
 #include <linux/acpi_rimt.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/compiler.h>
 #include <linux/crash_dump.h>
 #include <linux/init.h>
@@ -48,6 +49,9 @@
 static DEFINE_IDA(riscv_iommu_pscids);
 #define RISCV_IOMMU_MAX_PSCID		(BIT(20) - 1)
 
+/* IOMMU PMU auxiliary device id allocation namespace. */
+static DEFINE_IDA(riscv_iommu_pmu_ida);
+
 /* Device resource-managed allocations */
 struct riscv_iommu_devres {
 	void *addr;
@@ -587,6 +591,46 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/*
+ * IOMMU Hardware performance monitor
+ */
+static void riscv_iommu_pmu_id_free(void *data)
+{
+	ida_free(&riscv_iommu_pmu_ida, (unsigned long)data);
+}
+
+static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
+{
+	struct auxiliary_device *auxdev;
+	int id, ret;
+
+	id = ida_alloc(&riscv_iommu_pmu_ida, GFP_KERNEL);
+	if (id < 0)
+		return id;
+
+	ret = devm_add_action_or_reset(iommu->dev, riscv_iommu_pmu_id_free,
+				       (void *)(unsigned long)id);
+	if (ret)
+		return ret;
+
+	auxdev = auxiliary_device_create(iommu->dev, "riscv-iommu",
+					 "pmu", iommu, id);
+	if (!auxdev)
+		return -ENODEV;
+
+	iommu->pmu_dev = auxdev;
+	return 0;
+}
+
+static void riscv_iommu_hpm_disable(struct riscv_iommu_device *iommu)
+{
+	if (!iommu->pmu_dev)
+		return;
+
+	auxiliary_device_destroy(iommu->pmu_dev);
+	iommu->pmu_dev = NULL;
+}
+
 /* Lookup and initialize device context info structure. */
 static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
 						 unsigned int devid)
@@ -1570,6 +1614,7 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 
 void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 {
+	riscv_iommu_hpm_disable(iommu);
 	iommu_device_unregister(&iommu->iommu);
 	iommu_device_sysfs_remove(&iommu->iommu);
 	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF);
@@ -1636,6 +1681,9 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_remove_sysfs;
 	}
 
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
+		riscv_iommu_hpm_enable(iommu);
+
 	return 0;
 
 err_remove_sysfs:
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 5676001548cc..7fcd79fa47c8 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -19,6 +19,7 @@
 #include "iommu-bits.h"
 
 struct riscv_iommu_device;
+struct auxiliary_device;
 
 struct riscv_iommu_queue {
 	atomic_t prod;				/* unbounded producer allocation index */
@@ -62,6 +63,9 @@ struct riscv_iommu_device {
 	unsigned int ddt_mode;
 	dma_addr_t ddt_phys;
 	u64 *ddt_root;
+
+	/* PMU auxiliary device; torn down explicitly before MSI teardown */
+	struct auxiliary_device *pmu_dev;
 };
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu);
-- 
2.43.7

