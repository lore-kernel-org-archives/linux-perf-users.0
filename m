Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F733148A7
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787279942; cv=none; b=pZ2B9TlrqI/DE5VPLJX2jdjJkKiZagFPMuB1W2EIPRSiIyWozeWCYJEhLOSwW9zCcS0H7JmBWjG0W5LPUK/q9qk06okDaJQWVb9EiWodc4cFyuSoOuxsB58me2YFFegqXUHfWt1cX1vIxA1qmYDuBOEGaZlaNW3edPVwWTUMRGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787279942; c=relaxed/simple;
	bh=pTsBIp44Zh1FrmMiQvMfehgKLSU0k4F1puuNVXnvO9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJgDQjmScnbut3sooL6TA9ETGbWzySI1TPSEB3oqCJRAnSlIqQsDjf7thtHSmzB6n+VT1MyIr5cfKRBXhs30b7ibs8mTt+7j4+9z5goItWYT9cc/NwohwHvAwEnS05XnZ7ajc44RSQrC1HkDmNOz1pH8QLRewii9bVH1+Pu5CuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Mq5Udoah; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Mq5Udoah"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2caea3f742bso9413535ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 19:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787279941; x=1787884741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DMnbX9WNAYiy2tqr9slp35Bxhckluu2H+cH7KyGNMlE=;
        b=Mq5Udoah+xk6+GYgRl+/avOR1Y9tcAG+WRXiiHSIeFdWLQG7NbAxmcSfPXuHSmxEkJ
         db+kC9tTfCfcP82Pjkl5zOWNgG3gfPdpUWbS7rV4TdNkIpfS+lKEYOkC2egZjAaV8ofL
         XOdQJUhQ/BN2JjwW5jbsthKu1MC5kZ/nqk3RUlUKctUW5LcsRuVoPMv3WbojTAHCjbac
         3VKa81+yDp/PnHCMET4K4ML8elDf3tPObMSN+WYkvGDZwYHG83SH9yTdnbH/BRfcMdyb
         a5JT55LBXbWMxA2HMGWzZv7ekX0qKn2ZwyN7M5/qrJrAPELOu6jYlUgcNv5mTQQtWekc
         Gpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787279941; x=1787884741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DMnbX9WNAYiy2tqr9slp35Bxhckluu2H+cH7KyGNMlE=;
        b=OhIOMAlVv8dzXkoKTc7ySlSgD3wBygbggBjcM1oqFio51inZzPZ60u1ATewR9vPWiP
         9TrLXLIN7MXCbQMBVxNlWHg/THgRZT8HYX9t6191SJZbdXGuJu02S2g+XToOjc9HOSPI
         K1TTc2WlGuEvD+RZaIR4HY6qSJOioedeoxHWbGFoOCq9jNeVyNIvv7U7YbSFHR6kVDQK
         iy/QgNXcxopAdxsdzZTYSy4FctdiSQM0HetOVGiBKm82RPQaFBJ+Mvgl3nBOnoe25hDc
         /HQarludagrSlYqqdg0E9NH7nSMF3NEOMMxGcVKh7K4yGBHhXtsAlkVd1OEgU81oG7UK
         Bv8w==
X-Forwarded-Encrypted: i=1; AHgh+RorT2SoOjtBwPnXVKeb+A4R1d+CcjBgtfT2Nqrrur/Ltktbtaw1TYGgri+cK1YH4WRffpxhSURvDkZ6UG4gG3xh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0MUjHNnFJhnyKCS8P24VqCQTyeiCX8c5wkpXsTCU/VfGrj3sk
	Mee6sqrc33r8P3jd5tHZbcGRihKWKRLwRg78Teocmufw105Ni37xzj88rWjJVGDZK/0=
X-Gm-Gg: AR+sD11lAyDxvfofw9IwYLNdIxT0cQBW1RKMW/b0fxkUgsKzelKFNL2OFGOQoRtHGET
	YaI8I0BoEGAbI6PoNlFdy2Yh2Dc2/IM8KDFixNp/qgu2Ja0r/JwNuOl0wUWoPXHjTvxGGLB7A/O
	YbL82f2n+vnQPY9+MOU5Jq6PdfPIPh0OaYQxMzQuJF2V+t0undby/hUFIHDIuDVMepNsVtuWySZ
	Frf32gDxbYRRJW6dIg4j//mzkWRGidSKLbj9OthFOk9zaRuN32RTbjYPVsqzlVsIeASfyFqns88
	wgsoclhbrUOjk2OP/nYAQPYi+7fwxuzve/7aIjt6ACm1NsP0z2lyooB6vOK40HXRadQnnaNeSrr
	huPa/I16Lxgdve4/XvcVO53GonnEwfuj9G8MBYGij6DPDLVM+HTcfvslIrAZN+6AfjIy27Igmjv
	pXEWaZaQd+y19Ss8iSLuxvM1BnrWLAqUqzoC/rxVBcqbSo+RA78cZgP1mhHplT4LppAdEYY+vg
X-Received: by 2002:a05:6a20:c705:b0:3bf:a7d5:df38 with SMTP id adf61e73a8af0-3cd300613dbmr6157868637.9.1787279940750;
        Thu, 20 Aug 2026 19:39:00 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf10b584sm35370427eec.16.2026.08.20.19.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 19:39:00 -0700 (PDT)
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
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Thu, 20 Aug 2026 19:38:53 -0700
Message-ID: <20260821023854.2746349-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260821023854.2746349-1-zong.li@sifive.com>
References: <20260821023854.2746349-1-zong.li@sifive.com>
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
Reviewed-by: Guo Ren <guoren@kernel.org>
Suggested-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/Kconfig |  1 +
 drivers/iommu/riscv/iommu.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

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
index cec3ddd7ab10..7f619971bb70 100644
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
@@ -565,6 +569,36 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
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
+	auxdev = __devm_auxiliary_device_create(iommu->dev, "riscv-iommu",
+						"pmu", iommu, id);
+	if (!auxdev)
+		return -ENODEV;
+
+	return 0;
+}
+
 /* Lookup and initialize device context info structure. */
 static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
 						 unsigned int devid)
@@ -1613,6 +1647,9 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_remove_sysfs;
 	}
 
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
+		riscv_iommu_hpm_enable(iommu);
+
 	return 0;
 
 err_remove_sysfs:
-- 
2.43.7

