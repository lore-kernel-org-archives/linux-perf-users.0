Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B343370D79
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 03:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789358251; cv=none; b=ifKqlPY0ylNNXC0ha21B/mb9fzg0BNZRECJW5TDT6I4jR93iAdw4KztEeN/x4pM35kFeQQnNCY/oXaDSMTt3TikEPQyTuqXuamymyckKvzropooaVFoc3bQBm6cqcSUpeOVK0RrvINR1/9ptVrKgqmw5rQWfUsVaZ5CchcNJSJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789358251; c=relaxed/simple;
	bh=+mUVJVoWTcwSihXFsPS/Aaf+9RE6k59au5BpO9JogMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCiP0axw5F8SjjBqU9YqNteqtCxMEC6WiPqBnynJZjQQ6PnWmGfCRHTgX9PA47IcmznODAcz0SSLFfQlge+a2HayzJ7XGqSv3eiOVLj5NaJuDfGpyIZ/p4a7Zuig0+T7VgFYqGFoMRzHEsxgGBaL0nwcbsxteR5myNghByIgu1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bwyGroqA; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bwyGroqA"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4d64bcea5so1437231a12.1
        for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 20:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1789358249; x=1789963049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yrvUvXmaXknLZjg6fXvk/ZHbd24dkX4SY4AyuffyclQ=;
        b=bwyGroqARlXAb5TGCVpgcO2lbSLgnPxPw+0cim+hR5DoqmdEtxobzdAtt5feucA/2O
         X6fX2W4zYtjFdJoCaOd0fmlvd9pXGpv1RMCVdwObgqy2jDCCAqVjyBXJKPePNo1lpbGC
         Mf2SiOOpDHVNKwAz8XOWh9hSf33vhx857FawMpEljWYMrQToYuF+v1iZlZBMmNm7qBZI
         L5J64TuZ0b42BEFnsf3uhy3PF/WSU0iOLG+8XC5Ua2SSMKi10+sWoqvK+ksdi42Qgsea
         puUN0z6Ch6jIEYRbJwQNznzhLNUmuutiP142opBmytd22OhDnCW2JiCkrp57pIfIHOqd
         o2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789358249; x=1789963049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yrvUvXmaXknLZjg6fXvk/ZHbd24dkX4SY4AyuffyclQ=;
        b=M/yRcoyxameuhpGCh7QrjmdWUS/jVqb/8ze9J3QCEtxerf7AEhz51yqDllTSAHUF1y
         3aTDJyKrWq/FDIDSSgm9Cw2dONYCs7RTkJu4aFVyzTSHajjPc7OPnunUvzXQedinc4Fc
         rEF4HMwgrjGSCQX1zIBgLl6wSJp+dGNezc/dm+hyimU6TlG0FAMX30cZcxnD+Crdsufj
         M4Hag6E9z/Ru5vqPxP0/oCUjROvJFx/xnPHBZczUSjMXyfcgGR9EMaNEryHN/SWjp/ip
         HukAxx5ylXWJzRnERskV/W2AZi4PNAD0d5ru5dx1K2t2rGm4r0FpuTUFjWYXVXu1tpZ2
         PpXQ==
X-Forwarded-Encrypted: i=1; AKwUvBzj1DQil5V3gxchWjdagbv83BYPYcbRVl3fkEklCbZ5wgU4nFgznyXvcQRlY70yKWY7HxJR8G6QbdxgSDIryl7c@vger.kernel.org
X-Gm-Message-State: AFuF++mPjXKwDxuOkoP1BFcTgO0C4PxLVQkDMUUbCbJOtK9IKdHPCib+
	90/4z58BWiGckcRBFDi47qvPYiypKv5IGd0/bV8CteDL8zJPFbgm+UJm6aJKK8JkqDM=
X-Gm-Gg: AYBFou39Cz1l16oKyGZ0xf/NDEo1u70vpcK+x4I0W0xJXk4CSL49QgQ6LzEobStIMUj
	DPBM5bVkfwX2WDRzfTJcbvhBedU2n6zTvbkPDV95lVvIqm1Bo+wgwAAv+UzE8hOWvrW79qI55XX
	V0FEH9rGz+SW83xMmKdMZXdvfwwBa9fqp8cihdAvtJGwS9OpHs+QHblmX1WIkyoN7E54ZnH7ckx
	DzB8YPqPCPDXTnW3RPiRYCwgEqxZmwg0Uka+LKZ5hD6T16GRqOXwOF6bGMrh3tOr/8vecNThVug
	8DbwuzTV0n8cuBe4wLUqTzIiJW202D0mqSFvZSrlGSTNs6lLWSx6OHbp5C3AXJoiWQEjv54/8kD
	p9M0vs8EEfYwCCfqbaQrzYysB0OVMHAt5n/E6NWE4B7rvAJXVeGkpAxWFad6tcxUTxW2NHHOITR
	sI/GDNcfG7QISt9paTUoKBgcnSgF5HADEZIeQ+/HHHF6kWaWLa+Tatr8s9zOnqlygsIVtKz/sdM
	5wZC3DTIh84
X-Received: by 2002:a17:90b:5827:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-39dec0bbe04mr2006194a91.18.1789358249365;
        Sun, 13 Sep 2026 20:57:29 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9a3casm22862554eec.12.2026.09.13.20.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 20:57:28 -0700 (PDT)
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
Subject: [PATCH v11 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Sun, 13 Sep 2026 20:57:22 -0700
Message-ID: <20260914035723.2922057-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260914035723.2922057-1-zong.li@sifive.com>
References: <20260914035723.2922057-1-zong.li@sifive.com>
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
index fe8e6d0f8a23..c7495cc57720 100644
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
@@ -587,6 +591,36 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
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
@@ -1636,6 +1670,9 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_remove_sysfs;
 	}
 
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
+		riscv_iommu_hpm_enable(iommu);
+
 	return 0;
 
 err_remove_sysfs:
-- 
2.43.7

