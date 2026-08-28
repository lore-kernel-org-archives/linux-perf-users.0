Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350503EC2E6
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Aug 2026 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787907507; cv=none; b=rYf1F/ey9VEgc+lnhfF/p+ohDo06aYFJC0nwYCZauTwNRsLJaEMZmW2uAiUsbf7TdHjx4Aj33O1qjJCJHJ5mq8I3BZT15eX4Aq8K4Qk5+EEuVCAP/tUKSC5DlKv64YCiY211NvCyDQF5LjNvptsiUNEHKGmKaLO4hpxiqqvXHmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787907507; c=relaxed/simple;
	bh=0OuilxAE+ThUNxpU1Gxpqy4nbLhkHMBngSRff/ONKc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqmZZ//sgCYUxvjvBxYRNPKp3xr4CO1sysquK4ZN4hMGOhWng1F8wMXwCNhOBFjgskFBO6fc+UPtCfmWvU6fQLX9ZWw8Yfge0RndcZGU66MT+H1Pa2FeWqI3O7JqCLWGnw2PlW9IN4J/ya5QwJZlocTTrWz0RzzOwh+s80JnvC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Rh2n3wLC; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Rh2n3wLC"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbee846deecso998688a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Aug 2026 01:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787907504; x=1788512304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0jwxUNr7N+2l26FeCwq48z6QyCIJefuKV/bUVltiLUA=;
        b=Rh2n3wLC1ayEEzDkd5DUTAVtd3gI3JotUY987ulVOT7WP07stpb8lZqbkv5lzpjyum
         7yT3SZmUiYS58rRle0FzyxhUJFtAMtFCYtNa6IseXHeJIs7ifKn/4K1t3PvxwUpZSKFs
         MEYwJ9rXQ6SJuReMDgXNahBRcQx14BxmzqnP23c91ldb+Ks/rA3exJjVwE6GjMw8dlEe
         9x0tCxUxIGjowHocrseQUsPQKOwQJ684bY1rupoJmyDfL8nMQIGtcKWBua3rV/qYJoW6
         3KujAe+MXMaW59pnEEFWTUZLuZOKMHBer49zfRpFtnPe+TpWCMj/ziznKmuWCR0YrrHF
         mItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787907504; x=1788512304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0jwxUNr7N+2l26FeCwq48z6QyCIJefuKV/bUVltiLUA=;
        b=JtPa5Tl0TbUCdtnlBAkMGrkg6s9k/mG/p39t8/jHafDZ71M2etLGu8EGfLT+eADwPr
         Y3+Gegt/3qb60Wf7nXndZRA4e7yeZ1WJBT3oBwXMxH5wBjxBmPwuYd9R05fmAMZivCSD
         fi04nvUxQBs8etPaV00jM5C87JRJlWdpsmgY68GjixVzNOQmKuDlQq/rx0RNcD3/bwtE
         So6Os3YaP44GgCwuk9GxVotshkVJvRwlvOfFNY9+0yJuJxFmjonOJnhZgVQHc1xryIoU
         Rlzn+vjykFtPqxVd3iwY5LFugRBjkf8BQbiPI5sOnDm3/+3H/7UGlxn4RG3SE5k079ze
         9kUw==
X-Forwarded-Encrypted: i=1; AHgh+RrSvc8IjnSx40PpNqZ+TcZsdC1njWqvS4KsKg0rlKf7vQDXAg8newWVBc+etdvnZTaAbKwaEMAX4sWq2/Boja1f@vger.kernel.org
X-Gm-Message-State: AFuF++kBlrpIU7Wc0zc1LM+nr9nYS3FPCql+CYUdQpw1SW2XaH7OUgS4
	6GRiqmY6ObGl+apjqx071Ckx6Pzq8Kd54ViX9wbAU9XVnqIKIX/VYDGBeJ+Ril8mJiU=
X-Gm-Gg: AR+sD11UGU8RIfPwguZwYN4IQ1TYd9/YjC31kU5oFRavTuBZ6nz2hfGdsSfyDYOaPMi
	2OwY44BRVXf5tv9pvg43owNRhPwVkV/Wb1QFRWRq3XcKQNM7lmhVp+6j6YQId0elqUQuQIZPvOn
	7rHtSW0NB9tQgntU9PBSj3vArutvb3UASKwL0734UtmvbVZRIXbDM8SVugcjfiBg6w+52J699Bg
	sxyTmw1j7JDAp2tDNohbwnVsJHD9yyRW+KQJYrNbX6fC7WpAPJPmVqtSNoS6tPmE0kvLLs/rdAi
	lEnQAz1wp7e9MUR6wzG8aVFgYIHwfz8vNHapmEQgNRMpBZQHvdxZCcfejSi6eq2ZscvV5VzEowi
	XCdyBc5zeR4/dGfYXA62nL/gicCrEiW9q4zvqxJBfDKhH3DiMxlnCut3CEersiUKLqPldbomkpe
	H+7iBMFJPi+FdmKW60EeZIj41SS870JQZFT4AUJHlHkNDC1RyMzJOQj7iz5RcIut74SM/ZivSR
X-Received: by 2002:a05:6a20:7345:b0:3d1:7238:33d9 with SMTP id adf61e73a8af0-3d26532756amr10426288637.3.1787907504506;
        Fri, 28 Aug 2026 01:58:24 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9ecaa9sm3838814eec.26.2026.08.28.01.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:58:24 -0700 (PDT)
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
Subject: [PATCH RESEND v7 2/3] iommu/riscv: create a auxiliary device for HPM
Date: Fri, 28 Aug 2026 01:58:16 -0700
Message-ID: <20260828085819.4076449-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260828085819.4076449-1-zong.li@sifive.com>
References: <20260828085819.4076449-1-zong.li@sifive.com>
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

