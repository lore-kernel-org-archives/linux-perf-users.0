Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096BD3F44CE
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018203; cv=none; b=f1yTdbZ/Gd08HRGBcyEvaISe6kf4X15/aE93G//k1o1v6SQmiQ5FsBsJAfihyowTbXp6KGaLlpmIRew1f+LD5HhX8R1tDNODJDxpAnGo1dWrw8NSPRBojj1gtMHPqhulnwjNXZmo9tT2E3BFNHGg4sMTMV6cpSdAY5ejdcL7Vyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018203; c=relaxed/simple;
	bh=NQOBvsBZy+DfNF/ir0u60/1P4/x/thiv2MfnshEydEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDjpmgG63iOgITM/TEHvBcA6ZmdXVH5gCoTs/Dr/e8bvt6C2TGJy7oAwS5s8U6pHe930BkFMCuegkta2AuhHYuqjZvyPXTarQzI7NJhrz32Jc9vNNEOs0+1+vW3ObVU+sAbY3UyKBbOCOvrLO+4+zEldZb0MJ6Tex+QstEcsP3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JO9bniXT; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JO9bniXT"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca80d708489so515808a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 01:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1784018191; x=1784622991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wk16cXvhCfpgFzGrnK8+fTVVUodSt/9s9ecoWwXHbTE=;
        b=JO9bniXT42olQJBdED1FaHLj4PcFDwIiPUvfzXRo532an6/cwWY1gQyc/hr8l4Dr+N
         64O7Fq5JZhJGNDQJQC0UyZqn1jILfyLB2T/4CMVFOVei5px54ppuq5FKXtRltFPuMBfu
         R/7kWElHZcbOh0l6qC6U7HZoqtChrXBFd/iQrdh0OIwZQ6IpjyFyK86I3tkQrQYTZAH7
         oDGUg+lUFF9gAhh9bzSHR4dJfNvud1Id2qxMWBSLWEdjWQczy6BBGzplr0fRssrxf5LD
         5tvxgra33aIggXLoJbeMxuYZCt+lF7IwFG62K3tWrf14U7qHkKfaEU1hBWx1hwOKYLaT
         dT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784018191; x=1784622991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wk16cXvhCfpgFzGrnK8+fTVVUodSt/9s9ecoWwXHbTE=;
        b=ZodxAN95toYvIU4ALGqKlq/rPmqh1hSvDAGVq4Z7PunbsrBzqR5JVlkeSL0FPu9l13
         70CgOm9+6c4XJKnzD7DYMou8rmD/6ZhVHI0uvw5CuCSIDnBpQq9F9O8HH2lXW+LvqHpt
         CZBBGOm8uLWXFdRhVEYGHwcIEUeo4Ntih34iT6J4Lpo3Jk7Cauzlk0ZnBaR2e5ec4laM
         CQnR7q/3VWy9L96gnt1O1JEQqZ1pTBPyFknFr+1jNOhfgzGGfZHEekuNA+6dIwdynhji
         nv9swf7PPWE+azyM61R+sSrxwmZ6XWF+IjkROl3duYmcHnC9nYSFhpmn9EE+5a2t5zK3
         3YNQ==
X-Forwarded-Encrypted: i=1; AHgh+RpeaQKHb5NOCw7Ues6SC2KgKGIZMtE+jrU+0b1Ir9/CLCit6wsSmLCB4W2TPLZt5JS8rGaxX+QQUG3DaiF8vL5G@vger.kernel.org
X-Gm-Message-State: AOJu0YyVfF3TWKTKXloppwZTEp0JKXhTF2Ch0iE4Z9XYq3fvUTQfRZ+k
	B/clX+4fFnUjAdZdyZQnq3YLGJS31XVomkOtEcEq7OSD+TU0OsSYysvDIcCBtwwcGjI=
X-Gm-Gg: AfdE7cm37Y1P3uCeAjl8gWOXP1LdHKciA2Fk3b5eDKw/bJ0NJiwzw+yoQWKBlE2UpT4
	SqesUoERK7Z+HmkslCMEg7EB81QOJ4lGP4jb80fnC8DFU/xnBCjzgm4Qc3bkFO4dYHbYVnoMzhN
	8gSm2++4VH0MVy1hkJAsJvIIRF8uC8Ku5tVD49gRgoPpQdPrhBKu7heLuAdym6eCS6fgRQA5MAx
	uqjsUIAWQ9yOmnMLfsQZ+droMwBo1EzY+nVbdr47Y1YymA0KtfcR7DaJRMoAqIdIPqbQH4InXkt
	usftAIWOvjlvEsVvyG61te4yIip7ojVZPTf6fSsfGgdNAVladEofXkPwZdcYGyEMRHh7rHYT+cR
	h4h5EA26dyDJ0dmKH9t4ap5yLhILbXOQisinK7EYlIsCwDogiOnB3a90vgbOdv3dyYC2Db68H5f
	+5ejtCdIpucg5vF6upPF8WgQpC
X-Received: by 2002:a05:6a21:511:b0:3b3:3852:6663 with SMTP id adf61e73a8af0-3c0f0ae8f4amr19643932637.24.1784018191116;
        Tue, 14 Jul 2026 01:36:31 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311950eb930sm55932938eec.8.2026.07.14.01.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:36:30 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: tjeznach@rivosinc.com,
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
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Tue, 14 Jul 2026 01:36:22 -0700
Message-ID: <20260714083625.1083606-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260714083625.1083606-1-zong.li@sifive.com>
References: <20260714083625.1083606-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create an auxiliary device for HPM when the IOMMU supports a
hardware performance monitor.

Use the physical address of the device directory table as the
unique ID for auxiliary device in each IOMMU instance

Reviewed-by: Guo Ren <guoren@kernel.org>
Suggested-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/Kconfig |  1 +
 drivers/iommu/riscv/iommu.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

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
index cec3ddd7ab10..186c22c3ea6c 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -14,6 +14,7 @@
 
 #include <linux/acpi.h>
 #include <linux/acpi_rimt.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/compiler.h>
 #include <linux/crash_dump.h>
 #include <linux/init.h>
@@ -565,6 +566,21 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/*
+ * IOMMU Hardware performance monitor
+ */
+static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
+{
+	struct auxiliary_device *auxdev;
+
+	auxdev = __devm_auxiliary_device_create(iommu->dev, KBUILD_MODNAME,
+						"pmu", iommu, iommu->ddt_phys);
+	if (!auxdev)
+		return -ENODEV;
+
+	return 0;
+}
+
 /* Lookup and initialize device context info structure. */
 static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
 						 unsigned int devid)
@@ -1613,6 +1629,9 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_remove_sysfs;
 	}
 
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
+		riscv_iommu_hpm_enable(iommu);
+
 	return 0;
 
 err_remove_sysfs:
-- 
2.43.7

