Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5494156E8
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 06:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789108258; cv=none; b=NfZ8YYCYP14Rp1vFWgF1obAFh7SU9HV2pyXx3T2nTsSoE0i4i/NFmALx0NWmzYMm5VQF0LC0gBLA5mfOmEj3MK+8rdteJ/97NCsv9A/PNOHUYRqvUEwl1c1+V2eIR++K9+ygJ8h1y92Ygvfi1lNTOyjkqwBEvR8WuomBN6krci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789108258; c=relaxed/simple;
	bh=1N0u4QGDF0E8zTrVUubLP7yatSB6NAmP0HgLOmukhmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkrFFHzcoY5p9k/05slf+gXEV0oZzi41Qc3NoovndXzNGHbHcMHwWyk4VXQjc9evYONdR0KzoJFX1z0bSpBlTwDWUMoykDj0d10ENprGS79rtQhu5kAs3X3oFjfjLqgd8e5xKpHmYKe+fcEF6gPKHzLOfmyrXwytfgWzwbI36Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=N4O2o4bS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="N4O2o4bS"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-869ac301739so399150b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 23:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1789108248; x=1789713048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Db3wlFQ7tWb65H2cUA6T2ug5PcDOcaldDbKEP2DhiPU=;
        b=N4O2o4bSLOGWLtAymfDl8F53G7y4TkMlldWKW+zCbS+Z8Z66LpNEpIyvmsMEbn5sb+
         LW/GLABu/kJfyAUdKGcxEBuRHYHkhyFWzl7Vp7wzMqJbkQvHHpCTyz2JoXScKYe+RHBa
         6p8MEfXizig/14rwAzH6LVt0f8VBdc9LgDtgidQcQTtM5e3PKLC7HdoPDwKwejGMwkHa
         Ds6Zll7F5ox1UrSNbedP4a48BRahV5PKDHeMDxtmsvPXAIRkTdpHeP0l8xWKQwbt/bI1
         QfCOdmsle3Sq019GooVNm0BdDuxzUdH+Y85VyHIWXu4Phikjt6O9rUGnm5T1wMOvQK7d
         qc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789108248; x=1789713048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Db3wlFQ7tWb65H2cUA6T2ug5PcDOcaldDbKEP2DhiPU=;
        b=lqy8yy2wugaeK7luo7f2ZHJL5sqthOAWVco1UatKBQ1iEXO52c6jAbethpyIRVwoWy
         Fgdf4wc7Hi+ii936St98SF1/ZL0AtnZj2H+Vd2Eizdjgv99eNxIVMlvA9pXswb01pIVN
         d4blu0iy8bFawyWFti0/2Q66Na6DCsM1TssBH7lZ73Net3C9uevWl2ZiB0GLwKKdrikd
         Iae0uoBKXifOL8bawHWtmCZQhjAPQU2O/y4Ktc5MwQ2nYfLof2fU7T2SR3WmpSOUP45d
         NSgBbNDgBSf3Lobmklppm9BOvhEm5CF4lXKNH5CdYvwiKznt5i4oRsFbFx+kP41G2oM8
         pG7g==
X-Forwarded-Encrypted: i=1; AKwUvBwlTzvCZHKGNnaCgwAQLjxJvpMoOxqx9HznREEACQW2ELFAv5MEVph8HDqEho8G0faKNzIvhnOQhOpzUdIBmBEX@vger.kernel.org
X-Gm-Message-State: AFuF++nh81pLtAMGcdilRZomoVKJZjVbNWZVD+9LhSVCI3KIryeyZAPv
	ZRdi8TF7k9Mnc1/lz0eyuNSfjjxnM1yVqIKhqG8GyOMKWWEQkOnZ1Mr6buOTXe+6vxA=
X-Gm-Gg: AYBFou1nkU+IY3g4XKYXeYaAP+U1UKFFi9Q4jgL+PAO26mdrYotKchhvNU0K4RmgvkV
	bJe3nG6U4Ua6nv8cjqeYvJmv+aGoaA33jalEGpriDg7WA5BnVjC7cbupnPeM3lPt6zMtWw8G0nG
	6KlrkvnMiooJ90noA5EAdCE8TbBxeRB6sM5NrcDVbL2edzY3joNa9Wqi9+pnQRcXvwbn9pmHxmU
	+Uvdtvq1E3Y3lOGlIA8nL6ho7IajaPie8XOC9vW+w31DhDDHGKBra2qvIlt6DT9lIjLMoVZ2vsu
	6AA+nwpDhosAXuznvu5RHrr8TFvgDtGRjSIX4QU1L6WNhwvK35C6+wEFboxnmGu7cZb2fiOvtR2
	uncwYnWlrJh94AtMn0K0b+BlSzjs8/SW3izQpq60tmXNpENuWjc1PbOjz30TFC5GoLp0wgccu1G
	Pk4gCx9Md9qHMfhuobPwlRZhxe4PuT3hR+a9nQVcYRLIrDmQ6Z4q3aj6G/EpBaRSJXhO4oC8rf8
	nBliyvTLiY=
X-Received: by 2002:a05:6a20:3c8d:b0:3d4:52bd:b89d with SMTP id adf61e73a8af0-3daed3c168emr5513943637.23.1789108248408;
        Thu, 10 Sep 2026 23:30:48 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33baf0ea9a1sm331152eec.8.2026.09.10.23.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 23:30:48 -0700 (PDT)
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
Subject: [PATCH v10 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Thu, 10 Sep 2026 23:30:42 -0700
Message-ID: <20260911063043.916844-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260911063043.916844-1-zong.li@sifive.com>
References: <20260911063043.916844-1-zong.li@sifive.com>
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

