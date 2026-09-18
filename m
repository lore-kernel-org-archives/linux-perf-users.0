Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FA649D591
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716043; cv=none; b=sp7MBLT1aUzjdtpgXOBj6RgoYPqRPYZDI7W/C+RqlYMMsXwCQVl5tU50fSXCi8HJ8yG+JchVVHoxUAqoUaRO0G3zr3/hJHxge9Cdjm5SF4IKaH+emBYzshf7QrzNIS3hOnuLQzZ0Q1nOsZ7BUhY7xqO+IQZjBLkfgEltodpPGVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716043; c=relaxed/simple;
	bh=yYqekLJ/G1t+rbxU0H1jBCLzz7cJv7e+IWYJeGIMiGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sE0CfK2wqeIv5ot6KuSYW5DtPUzIb0PRq2V3dcL8wRCS8YCQMgokp4LyOMB6k9AxNdvL0uw6P0qQ4VAI42Ox4mfURUNx41yd2GgvWb7Fq7Yl0dBS5LojHXk1a1cmlUJHYd4aDcJBxqKftxSK4kOOLT5MX6Li7C21xypaaSy+RII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XMufxBHz; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XMufxBHz"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396cccbba92so391756a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 00:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1789716040; x=1790320840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QtF+hEd4zxaSXZ54y5RlnY99ygpvKaq026DcmobuPXU=;
        b=XMufxBHzQYXM9PKET1RBAQ1Rc2FDwivih+fUmbjhtjp0KmnRQ/AeYK9/Pqq76R5S/w
         HspBH7r/okHUxZcChYXLJdS1Dx+3aZCNcgmsDwAyiYHMCYLo+JT4wAU4RoR6N0A43/BL
         RVg6Gmw+xmgYVdWD2+20q2v3etU5M+srr0a2Eeuu9aQmeIK+vxELxDGtMU/usr79DmRP
         +fEjUKRkrAywQjwOF8Q/c1qTIiaCNsrw53yMVqncamA29yizTudKKcif1UsbkKu6JDvO
         in+jy80Xs0vqKbluGkaNfMDEprGn1yDcvSSDalM1UEdZ1FosKHpkmMM2/ccAeaphiN9a
         8K0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789716040; x=1790320840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QtF+hEd4zxaSXZ54y5RlnY99ygpvKaq026DcmobuPXU=;
        b=T86npX2HWIgQN15TtdzJSQpByiJUGC3p601v/MBingt72q42FKszVzjHO50Hzfy6os
         SX3bqiDSvtbaiPfQ2iZWqt5W+b6RB0zPlvdE4ZfZww/vFjk7w2F5NxD88K8WCAL9mSDH
         oDHtxgHYc+jTYwewLxbwOoU+C1cRo4nO4ebqeJ7yOyf6FI+oNV+Ejd+Z+D75TT/NUWnQ
         +mP6MCWcATbTj4cCgPSOf/5qhFbeAZPhlLjsVYm0Ex3OJs7DQD13rG87Q3vw9k5Sj836
         SnWc1rvBpO3FBzoeqUl/Uv9HwN2uF4W5JeTjXw5gxgXGSbpQRpAPxPm5K6fq5xh8p80Y
         2FeQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3rmKrWArGIb109m2BrxDWwiyOQdFlJbF/dBMNiCgVEE/lQM8iZQXKQZSU6crtjnUPEKcrxIKuY+/Nheilkrfw@vger.kernel.org
X-Gm-Message-State: AFuF++kRN080CPZAL+jMPsGpCgzpy0KE3MA6DackueRtuTc1vlxPni5b
	RlZXhjtmBkT8AUeF9gsQDbEAHoHooBoDv6K/kOj92cvopNo8heBSP7oH4bHh2FYomJI=
X-Gm-Gg: AYBFou3L2VMTUlIm2eJmBdHhGbDHv1ZBU5QHQQezLWfi1dyVAQRtx20I09SF7E8JfOT
	fQni4wSkTWMXb/bdg//SoaQTlndnUcb2qlv1aG2K2jueWVAuhHCFZiKkLWWMu/nNWcVoGGDX+zO
	sMCARzi8MUYA0+mtbDuIBftTSoFohZWCXTyUdxOyMk28U0q32/7q+1VjtWkd09sln/f7zvkslk3
	krgQmmdAuLaJ/Hd7vxCcXGfRfop0aV0mjERjQKPmbuijzTdLREsA9alczY2XGD7Qb6ER2dlAPzY
	B98MJpwxILtnFOHEfUPg7KYTQ13RY9iWaDhJ202X5jOP0Dm2EQ2xEY4OeCVKctD0vrWlOKT5OhV
	surWeRcb6EoOt8i/jV7c1rH31mxkO5m/8fstzB9MAT2CJgC76S93piZg+H5Um8cKjNk6RQveq4V
	pqFWHtq69UL4zhFjzxR9gYl2axY4/fTqKw/J/Y+6ieGZQCQM7Anc8Q5onEd+PMQ+5yoXmjHrvkG
	qeai/RiGvY=
X-Received: by 2002:a17:90b:17cc:b0:39e:135e:130e with SMTP id 98e67ed59e1d1-39e54af6a0emr3710326a91.3.1789716040219;
        Fri, 18 Sep 2026 00:20:40 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144ce03c682sm4416046c88.10.2026.09.18.00.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 00:20:39 -0700 (PDT)
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
Subject: [PATCH v12 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Fri, 18 Sep 2026 00:20:26 -0700
Message-ID: <20260918072027.639239-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260918072027.639239-1-zong.li@sifive.com>
References: <20260918072027.639239-1-zong.li@sifive.com>
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

